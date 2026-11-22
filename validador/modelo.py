"""Descubre lo que hay en un datapack o resourcepack.

El validador trabaja sobre este modelo: recorre `data/<namespace>/<tipo>/...`
(y `assets/...` cuando es un resourcepack), traduce cada archivo a su
identificador de recurso y apunta los problemas de estructura que encuentra
por el camino (carpetas desconocidas, extensiones que no tocan, nombres
inválidos, identificadores repetidos).

Solo usa la biblioteca estándar.
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from pathlib import Path

# Un nombre de recurso (namespace o ruta) solo admite estas letras: es lo que
# acepta Minecraft, y una mayúscula suelta es un fallo silencioso de los caros
# (el pack carga y la función no aparece).
NOMBRE_VALIDO = re.compile(r"^[a-z0-9_.\-]+$")
NAMESPACE_VALIDO = re.compile(r"^[a-z0-9_.\-]+$")

# Tipo de recurso -> extensión que le corresponde. Las claves son los nombres
# de carpeta de 1.21 (singulares); ALIAS recoge los plurales de versiones
# anteriores para poder validar packs viejos sin gritar.
TIPOS: dict[str, str] = {
    "advancement": ".json",
    "banner_pattern": ".json",
    "cat_variant": ".json",
    "chat_type": ".json",
    "damage_type": ".json",
    "dialog": ".json",
    "dimension": ".json",
    "dimension_type": ".json",
    "enchantment": ".json",
    "frog_variant": ".json",
    "function": ".mcfunction",
    "instrument": ".json",
    "item_modifier": ".json",
    "jukebox_song": ".json",
    "loot_table": ".json",
    "painting_variant": ".json",
    "predicate": ".json",
    "recipe": ".json",
    "structure": ".nbt",
    "trim_material": ".json",
    "trim_pattern": ".json",
    "wolf_variant": ".json",
    "worldgen": ".json",
}

ALIAS: dict[str, str] = {
    "advancements": "advancement",
    "banner_patterns": "banner_pattern",
    "cat_variants": "cat_variant",
    "chat_types": "chat_type",
    "damage_types": "damage_type",
    "dialogs": "dialog",
    "dimensions": "dimension",
    "dimension_types": "dimension_type",
    "enchantments": "enchantment",
    "frog_variants": "frog_variant",
    "functions": "function",
    "instruments": "instrument",
    "item_modifiers": "item_modifier",
    "jukebox_songs": "jukebox_song",
    "loot_tables": "loot_table",
    "painting_variants": "painting_variant",
    "predicates": "predicate",
    "recipes": "recipe",
    "structures": "structure",
    "trim_materials": "trim_material",
    "trim_patterns": "trim_pattern",
    "wolf_variants": "wolf_variant",
}


@dataclass(frozen=True)
class Problema:
    """Una cosa que está mal (error) o que huele mal (aviso).

    Los avisos no hacen fallar la comprobación: son para mirarlos, no para
    bloquear una release. Los errores sí.
    """

    nivel: str  # "error" o "aviso"
    mensaje: str
    sitio: str = ""  # archivo relativo a la raíz del pack, con :línea si toca

    def __str__(self) -> str:
        return f"{self.sitio}: {self.nivel}: {self.mensaje}" if self.sitio else f"{self.nivel}: {self.mensaje}"


@dataclass
class Archivo:
    """Un archivo del pack, ya traducido a identificador de recurso."""

    ruta: Path
    relativa: str  # ruta bonita para los mensajes, relativa a la raíz
    namespace: str
    tipo: str  # canónico: "function", "tag", "asset"...
    nombre: str  # ruta sin extensión: "panel/ver"
    subtipo: str | None = None  # en los tags, el tipo que etiquetan

    @property
    def id(self) -> str:
        return f"{self.namespace}:{self.nombre}"

    @property
    def extension(self) -> str:
        return self.ruta.suffix


@dataclass
class Pack:
    """El pack entero, con lo que se ha podido leer y lo que no cuadra."""

    raiz: Path
    archivos: list[Archivo] = field(default_factory=list)
    problemas: list[Problema] = field(default_factory=list)

    def ids(self, tipo: str, subtipo: str | None = None) -> set[str]:
        return {
            a.id
            for a in self.archivos
            if a.tipo == tipo and (subtipo is None or a.subtipo == subtipo)
        }

    def de_tipo(self, tipo: str, subtipo: str | None = None) -> list[Archivo]:
        return [
            a
            for a in self.archivos
            if a.tipo == tipo and (subtipo is None or a.subtipo == subtipo)
        ]


def tipo_canonico(nombre: str) -> str | None:
    """Devuelve el tipo canónico de una carpeta, o None si no es un tipo conocido."""
    if nombre in TIPOS:
        return nombre
    return ALIAS.get(nombre)


def _recorrer(base: Path) -> list[Path]:
    return sorted(p for p in base.rglob("*") if p.is_file())


def cargar(raiz: Path | str) -> Pack:
    """Lee la estructura de un pack sin interpretar el contenido de los archivos."""
    raiz = Path(raiz)
    pack = Pack(raiz=raiz)

    def problema(nivel: str, mensaje: str, ruta: Path | None = None) -> None:
        sitio = str(ruta.relative_to(raiz)) if ruta is not None else ""
        pack.problemas.append(Problema(nivel, mensaje, sitio))

    if not raiz.is_dir():
        pack.problemas.append(Problema("error", f"no existe la ruta {raiz}"))
        return pack

    if not (raiz / "pack.mcmeta").is_file():
        pack.problemas.append(
            Problema("error", "falta pack.mcmeta en la raíz del pack")
        )

    data = raiz / "data"
    if not data.is_dir() and not (raiz / "assets").is_dir():
        pack.problemas.append(
            Problema("error", "no hay ni data/ ni assets/: esto no parece un pack")
        )

    if data.is_dir():
        for ns_dir in sorted(p for p in data.iterdir() if p.is_dir()):
            _leer_namespace(pack, ns_dir)
        # Archivos sueltos dentro de data/ no los lee Minecraft.
        for suelto in sorted(p for p in data.iterdir() if p.is_file()):
            problema("error", "archivo suelto en data/; debería estar en data/<namespace>/", suelto)

    assets = raiz / "assets"
    if assets.is_dir():
        for ns_dir in sorted(p for p in assets.iterdir() if p.is_dir()):
            for ruta in _recorrer(ns_dir):
                rel = ruta.relative_to(ns_dir)
                pack.archivos.append(
                    Archivo(
                        ruta=ruta,
                        relativa=str(ruta.relative_to(raiz)),
                        namespace=ns_dir.name,
                        tipo="asset",
                        nombre=str(rel.with_suffix("")).replace("\\", "/"),
                    )
                )

    _comprobar_duplicados(pack)
    return pack


def _leer_namespace(pack: Pack, ns_dir: Path) -> None:
    raiz = pack.raiz

    def problema(nivel: str, mensaje: str, ruta: Path | None = None) -> None:
        sitio = str(ruta.relative_to(raiz)) if ruta is not None else ""
        pack.problemas.append(Problema(nivel, mensaje, sitio))

    if not NAMESPACE_VALIDO.match(ns_dir.name):
        problema("error", f"namespace inválido «{ns_dir.name}»: solo minúsculas, números, _ . y -")

    tipos = sorted(p for p in ns_dir.iterdir() if p.is_dir())
    if not tipos:
        problema("aviso", f"el namespace «{ns_dir.name}» está vacío", ns_dir)

    for tipo_dir in tipos:
        if tipo_dir.name == "tags":
            _leer_tags(pack, ns_dir.name, tipo_dir)
            continue
        tipo = tipo_canonico(tipo_dir.name)
        if tipo is None:
            problema(
                "error",
                f"carpeta «{tipo_dir.name}» desconocida en data/{ns_dir.name}/ "
                f"(se esperaba una de: {', '.join(sorted(TIPOS))})",
                tipo_dir,
            )
            continue
        esperada = TIPOS[tipo]
        for ruta in _recorrer(tipo_dir):
            if ruta.suffix != esperada:
                problema(
                    "error",
                    f"en {tipo}/ solo van archivos {esperada}, y este es {ruta.suffix or 'sin extensión'}",
                    ruta,
                )
                continue
            nombre = ruta.relative_to(tipo_dir).with_suffix("").as_posix()
            for trozo in nombre.split("/"):
                if not NOMBRE_VALIDO.match(trozo):
                    problema("error", f"nombre inválido «{trozo}» en {nombre}", ruta)
            pack.archivos.append(
                Archivo(
                    ruta=ruta,
                    relativa=str(ruta.relative_to(raiz)),
                    namespace=ns_dir.name,
                    tipo=tipo,
                    nombre=nombre,
                )
            )


def _leer_tags(pack: Pack, namespace: str, tags_dir: Path) -> None:
    raiz = pack.raiz
    for sub in sorted(p for p in tags_dir.iterdir() if p.is_dir()):
        for ruta in _recorrer(sub):
            if ruta.suffix != ".json":
                pack.problemas.append(
                    Problema(
                        "error",
                        "los tags son .json",
                        str(ruta.relative_to(raiz)),
                    )
                )
                continue
            nombre = ruta.relative_to(sub).with_suffix("").as_posix()
            pack.archivos.append(
                Archivo(
                    ruta=ruta,
                    relativa=str(ruta.relative_to(raiz)),
                    namespace=namespace,
                    tipo="tag",
                    nombre=nombre,
                    subtipo=sub.name,
                )
            )
    for suelto in sorted(p for p in tags_dir.iterdir() if p.is_file()):
        pack.problemas.append(
            Problema(
                "error",
                "archivo suelto en tags/: falta la carpeta del tipo (function/, predicate/...)",
                str(suelto.relative_to(raiz)),
            )
        )


def _comprobar_duplicados(pack: Pack) -> None:
    vistos: dict[tuple[str, str, str | None], Archivo] = {}
    for archivo in pack.archivos:
        clave = (archivo.tipo, archivo.id.lower(), archivo.subtipo)
        if clave in vistos:
            otro = vistos[clave]
            pack.problemas.append(
                Problema(
                    "error",
                    f"«{archivo.id}» está repetido (también en {otro.relativa})",
                    archivo.relativa,
                )
            )
        else:
            vistos[clave] = archivo
