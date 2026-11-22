"""Comprueba archivos .mcfunction y saca de ellos las referencias.

No es un intérprete de Minecraft: no conoce las coordenadas ni los NBT. Lo que
hace es cazar los fallos que el juego se calla o cuesta encontrar:

- líneas que empiezan por «/» (dentro de una función no van);
- comillas, llaves, corchetes o paréntesis descuadrados;
- JSON inválido en tellraw y title (el error típico de las comillas dobles);
- comandos que no existen (aviso, porque los mods añaden los suyos);
- y, de paso, las referencias a funciones, predicates, tags, loot tables,
  advancements y estructuras, que luego se comprueban contra el pack.
"""

from __future__ import annotations

import json
import re
from dataclasses import dataclass

from .modelo import Archivo, Pack, Problema

# Comandos que entiende Minecraft 1.21.1 sin ningún mod. Si aparece otro en la
# lista de palabras, no es error: puede venir de un mod (thirst, create...) o
# de un datapack con /execute. Se avisa y se sigue.
COMANDOS = {
    "advancement", "attribute", "ban", "ban-ip", "banlist", "bossbar", "clear",
    "clone", "damage", "data", "datapack", "debug", "defaultgamemode", "deop",
    "difficulty", "effect", "enchant", "execute", "experience", "fill",
    "fillbiome", "forceload", "function", "gamemode", "gamerule", "give", "help",
    "item", "jfr", "kick", "kill", "list", "locate", "loot", "me", "msg", "op",
    "pardon", "particle", "place", "playsound", "publish", "random", "recipe",
    "reload", "return", "ride", "save-all", "save-off", "save-on", "say",
    "schedule", "scoreboard", "seed", "setblock", "setidletimeout",
    "setworldspawn", "spawnpoint", "spectate", "spreadplayers", "stop",
    "stopsound", "summon", "tag", "team", "teammsg", "tell", "tellraw",
    "teleport", "tick", "time", "title", "tm", "tp", "transfer", "trigger",
    "weather", "whitelist", "worldborder", "xp",
}

# Comandos cuyo último argumento es un componente de texto JSON.
CON_JSON = {"tellraw", "title"}


@dataclass(frozen=True)
class Referencia:
    """Un id de recurso nombrado dentro de una función."""

    tipo: str  # function, predicate, loot_table, advancement, structure
    id: str
    sitio: str  # archivo:línea, para el mensaje
    tag: bool = False  # venía como #namespace:tag


def palabras(linea: str) -> tuple[list[str], bool]:
    """Parte la línea en palabras respetando las comillas dobles.

    Devuelve también si la línea termina dentro de unas comillas sin cerrar,
    que es el fallo más común al escribir componentes de texto.
    """
    salida: list[str] = []
    actual: list[str] = []
    dentro = False
    i = 0
    while i < len(linea):
        c = linea[i]
        if dentro:
            actual.append(c)
            if c == "\\" and i + 1 < len(linea):
                actual.append(linea[i + 1])
                i += 2
                continue
            if c == '"':
                dentro = False
        elif c == '"':
            dentro = True
            actual.append(c)
        elif c in " \t":
            if actual:
                salida.append("".join(actual))
                actual = []
        else:
            actual.append(c)
        i += 1
    if actual:
        salida.append("".join(actual))
    return salida, dentro


def _descuadre(texto: str) -> str | None:
    """Mira si hay comillas, llaves, corchetes o paréntesis sin cerrar.

    Lo que va entre comillas no cuenta: un componente de texto puede llevar
    «[» o «{» dentro sin que eso descuadre nada.
    """
    parejas = {'"': '"', "{": "}", "[": "]", "(": ")"}
    cierres = {"}", "]", ")"}
    pila: list[str] = []
    dentro = False
    i = 0
    while i < len(texto):
        c = texto[i]
        if c == "\\":
            i += 2
            continue
        if c == '"':
            dentro = not dentro
        elif dentro:
            pass
        elif c in parejas:
            pila.append(parejas[c])
        elif c in cierres:
            if not pila or pila.pop() != c:
                return f"«{c}» sin abrir"
        i += 1
    if dentro:
        return "comillas sin cerrar"
    if pila:
        return f"falta cerrar «{pila[-1]}»"
    return None


def sin_comillas(linea: str) -> str:
    """Sustituye lo que va entre comillas por espacios.

    Sirve para no confundir el texto de un libro o de un tellraw —que puede
    nombrar /function swr:lo_que_sea— con una llamada de verdad.
    """
    salida: list[str] = []
    dentro = False
    i = 0
    while i < len(linea):
        c = linea[i]
        if c == "\\" and dentro and i + 1 < len(linea):
            salida.extend((" ", " "))
            i += 2
            continue
        if c == '"':
            dentro = not dentro
            salida.append(" ")
        else:
            salida.append(" " if dentro else c)
        i += 1
    return "".join(salida)


def _json_en(args: list[str], desde: int) -> str | None:
    """Devuelve el error de JSON del componente de texto, o None si está bien."""
    if len(args) <= desde:
        return "falta el componente de texto"
    crudo = " ".join(args[desde:])
    try:
        json.loads(crudo)
    except json.JSONDecodeError as fallo:
        return f"JSON inválido ({fallo.msg}, columna {fallo.colno})"
    return None


def comprobar(archivo: Archivo) -> list[Problema]:
    """Revisa un .mcfunction línea a línea."""
    problemas: list[Problema] = []
    try:
        texto = archivo.ruta.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return [Problema("error", "no está en UTF-8", archivo.relativa)]

    if texto.startswith("\ufeff"):
        problemas.append(Problema("aviso", "empieza con BOM; Minecraft lo lee como parte del comando", archivo.relativa))

    for numero, linea in enumerate(texto.splitlines(), start=1):
        sitio = f"{archivo.relativa}:{numero}"
        limpia = linea.strip()
        if not limpia or limpia.startswith("#"):
            continue

        if limpia.startswith("/"):
            problemas.append(Problema("error", "las funciones no llevan «/» al principio", sitio))
            limpia = limpia.lstrip("/")

        if "\t" in linea:
            problemas.append(Problema("error", "tabulador dentro del comando (Minecraft solo parte por espacios)", sitio))

        descuadre = _descuadre(limpia)
        if descuadre:
            problemas.append(Problema("error", f"descuadre: {descuadre}", sitio))
            continue

        trozos, abierto = palabras(limpia)
        if abierto:
            problemas.append(Problema("error", "comillas sin cerrar", sitio))
            continue
        problemas.extend(_comprobar_comando(trozos, sitio))

    return problemas


def _comprobar_comando(trozos: list[str], sitio: str) -> list[Problema]:
    problemas: list[Problema] = []
    if not trozos:
        return problemas

    comando = trozos[0]
    if comando not in COMANDOS:
        problemas.append(
            Problema("aviso", f"«{comando}» no es un comando de vainilla (¿de un mod?)", sitio)
        )

    if comando == "tellraw":
        # tellraw <objetivos> <componente>
        error = _json_en(trozos, 2)
        if error:
            problemas.append(Problema("error", error, sitio))
    elif comando == "title":
        # title <objetivos> title|subtitle|actionbar <componente>
        # times|clear|reset no llevan componente, así que no se miran.
        accion = trozos[2] if len(trozos) > 2 else ""
        if accion in {"title", "subtitle", "actionbar"}:
            error = _json_en(trozos, 3)
            if error:
                problemas.append(Problema("error", error, sitio))

    # execute ... run <otro comando>: se valida también lo de detrás del run.
    # Sin run también es legal (execute if ... como condición), así que no se exige.
    if comando == "execute":
        for i, trozo in enumerate(trozos):
            if trozo == "run":
                resto = trozos[i + 1 :]
                if not resto:
                    problemas.append(Problema("error", "execute sin nada detrás de run", sitio))
                else:
                    problemas.extend(_comprobar_comando(resto, sitio))
                break

    return problemas


# --- Referencias a otros recursos del pack ---------------------------------

REFERENCIAS: list[tuple[str, re.Pattern[str]]] = [
    ("function", re.compile(r"(?<![\w:.])function\s+(#[a-z0-9_.\-]+:[a-z0-9_./\-]+|[a-z0-9_.\-]+:[a-z0-9_./\-]+)")),
    ("predicate", re.compile(r"(?<![\w:.])predicate\s+(#[a-z0-9_.\-]+:[a-z0-9_./\-]+|[a-z0-9_.\-]+:[a-z0-9_./\-]+)")),
    ("structure", re.compile(r"(?<![\w:.])place\s+structure\s+([a-z0-9_.\-]+:[a-z0-9_./\-]+)")),
    ("advancement", re.compile(r"(?<![\w:.])advancement\s+(?:grant|revoke)\s+\S+\s+(?:only|until|from|through)\s+([a-z0-9_.\-]+:[a-z0-9_./\-]+)")),
    ("loot_table", re.compile(r"(?<![\w:.])loot\s+(?:give|spawn|insert|replace|fish)\s+.*?\bloot\s+([a-z0-9_.\-]+:[a-z0-9_./\-]+)")),
]


def referencias(archivo: Archivo) -> list[Referencia]:
    """Saca los ids de recursos que nombra una función, con su línea."""
    salida: list[Referencia] = []
    try:
        texto = archivo.ruta.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError):
        return salida

    for numero, linea in enumerate(texto.splitlines(), start=1):
        limpia = linea.strip()
        if not limpia or limpia.startswith("#"):
            continue
        util = sin_comillas(limpia)
        for tipo, patron in REFERENCIAS:
            for encontrado in patron.finditer(util):
                crudo = encontrado.group(1)
                es_tag = crudo.startswith("#")
                salida.append(
                    Referencia(
                        tipo=tipo,
                        id=crudo.lstrip("#"),
                        sitio=f"{archivo.relativa}:{numero}",
                        tag=es_tag,
                    )
                )
    return salida


def comprobar_referencias(pack: Pack) -> list[Problema]:
    """Comprueba que cada id nombrado en una función existe en el pack.

    Solo se miran los ids con namespace propio del pack: los de `minecraft:` y
    los de otros datapacks/mods se dan por buenos, que aquí no se pueden ver.
    """
    problemas: list[Problema] = []
    namespaces = {a.namespace for a in pack.archivos}

    for archivo in pack.de_tipo("function"):
        for ref in referencias(archivo):
            namespace = ref.id.split(":", 1)[0]
            if namespace not in namespaces:
                continue
            if ref.tag:
                if ref.id not in pack.ids("tag", subtipo=ref.tipo):
                    problemas.append(
                        Problema("error", f"el tag #{ref.id} de {ref.tipo} no existe", ref.sitio)
                    )
            elif ref.id not in pack.ids(ref.tipo):
                problemas.append(
                    Problema("error", f"la {ref.tipo} {ref.id} no existe", ref.sitio)
                )

    problemas.extend(_comprobar_objetivos(pack))
    return problemas


OBJETIVO_ADD = re.compile(r"(?<![\w:.])scoreboard\s+objectives\s+add\s+(\S+)")
OBJETIVO_USO = [
    # scoreboard players get|set|add|remove|reset|enable <objetivo> ...
    re.compile(r"(?<![\w:.])scoreboard\s+players\s+(?:get|set|add|remove|reset|enable)\s+\S+\s+(\S+)"),
    # scoreboard players operation <a> <obj_a> <op> <b> <obj_b>
    re.compile(r"(?<![\w:.])scoreboard\s+players\s+operation\s+\S+\s+(\S+)\s+\S+\s+\S+\s+(\S+)"),
    # execute if|unless score <a> <obj> ...
    re.compile(r"(?<![\w.])if\s+score\s+\S+\s+(\S+)"),
    re.compile(r"(?<![\w.])unless\s+score\s+\S+\s+(\S+)"),
    # scoreboard objectives setdisplay <slot> [objetivo]
    re.compile(r"(?<![\w:.])scoreboard\s+objectives\s+setdisplay\s+\S+\s+(\S+)"),
]


def _comprobar_objetivos(pack: Pack) -> list[Problema]:
    """Avisa de objetivos de scoreboard usados pero nunca creados con /add."""
    declarados: set[str] = set()
    usos: list[tuple[str, str]] = []  # (objetivo, sitio)

    for archivo in pack.de_tipo("function"):
        try:
            lineas = archivo.ruta.read_text(encoding="utf-8").splitlines()
        except (OSError, UnicodeDecodeError):
            continue
        for numero, linea in enumerate(lineas, start=1):
            limpia = linea.strip()
            if not limpia or limpia.startswith("#"):
                continue
            sitio = f"{archivo.relativa}:{numero}"
            limpia = sin_comillas(limpia)
            for encontrado in OBJETIVO_ADD.finditer(limpia):
                declarados.add(encontrado.group(1))
            for patron in OBJETIVO_USO:
                for encontrado in patron.finditer(limpia):
                    for grupo in encontrado.groups():
                        if grupo and not grupo.startswith(("@", "~", "^")):
                            usos.append((grupo, sitio))

    problemas: list[Problema] = []
    vistos: set[tuple[str, str]] = set()
    for objetivo, sitio in usos:
        if objetivo in declarados or (objetivo, sitio) in vistos:
            continue
        vistos.add((objetivo, sitio))
        problemas.append(
            Problema(
                "error",
                f"el objetivo «{objetivo}» se usa pero no hay ningún scoreboard objectives add",
                sitio,
            )
        )
    return problemas
