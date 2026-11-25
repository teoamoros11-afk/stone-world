"""Pruebas de las referencias: ids y objetivos que no existen.

Además de lo que comprueba el validador con un pack de mentira, aquí se recorre el
pack real: ninguna llamada `function swr:x/y` puede apuntar a un archivo ausente, y
los recuentos de la documentación tienen que cuadrar con lo que hay en disco.
"""

from __future__ import annotations

import re
from pathlib import Path

from validador import revisar


def _errores(pack):
    return [p for p in revisar(pack.raiz) if p.nivel == "error"]


def _hay(problemas, texto):
    return any(texto in p.mensaje for p in problemas)


def test_llamada_a_funcion_inexistente(pack):
    pack.funcion("tick", "function prueba:no_existe\n")
    assert _hay(_errores(pack), "la function prueba:no_existe no existe")


def test_llamada_a_funcion_existente(pack):
    pack.funcion("tick", "function prueba:panel/ver\n")
    pack.funcion("panel/ver", "say hola\n")
    assert not _errores(pack)


def test_llamada_detras_de_execute(pack):
    pack.funcion("tick", "execute as @a run function prueba:no_existe\n")
    assert _hay(_errores(pack), "no existe")


def test_namespace_ajeno_no_se_comprueba(pack):
    pack.funcion("tick", "function otro_pack:lo_que_sea\n")
    assert not _errores(pack)


def test_tag_de_funcion_inexistente(pack):
    pack.funcion("tick", "function #prueba:arranque\n")
    assert _hay(_errores(pack), "el tag #prueba:arranque")


def test_tag_de_funcion_existente(pack):
    pack.json("data/prueba/tags/function/arranque.json", {"values": ["prueba:tick"]})
    pack.funcion("tick", "function #prueba:arranque\n")
    assert not _errores(pack)


def test_predicate_inexistente(pack):
    pack.funcion("tick", "execute if predicate prueba:libro run say hola\n")
    assert _hay(_errores(pack), "la predicate prueba:libro no existe")


def test_advancement_inexistente(pack):
    pack.funcion("tick", "advancement grant @a only prueba:era/uno\n")
    assert _hay(_errores(pack), "la advancement prueba:era/uno no existe")


def test_objetivo_usado_sin_crear(pack):
    pack.funcion("tick", "scoreboard players add #contador swr_tick 1\n")
    assert _hay(_errores(pack), "«swr_tick» se usa pero no hay ningún")


def test_objetivo_declarado(pack):
    pack.funcion("load", "scoreboard objectives add swr_tick dummy\n")
    pack.funcion("tick", "scoreboard players add #contador swr_tick 1\n")
    assert not _errores(pack)


def test_objetivo_en_operation(pack):
    pack.funcion("load", "scoreboard objectives add swr_a dummy\n")
    pack.funcion(
        "tick",
        "scoreboard players operation #x swr_a = #y swr_b\n",
    )
    assert _hay(_errores(pack), "«swr_b»")


def test_objetivo_en_if_score(pack):
    pack.funcion("tick", "execute if score #x swr_nada matches 1.. run say hola\n")
    assert _hay(_errores(pack), "«swr_nada»")


def test_objetivo_de_otro_namespace_no_se_puede_comprobar(pack):
    """Los objetivos no llevan namespace, así que lo único que se exige es que
    alguien lo cree en el pack; los que crea un mod se verán como error y por eso
    el mensaje dice exactamente qué falta."""
    pack.funcion("load", "scoreboard objectives add sed_thirst dummy\n")
    pack.funcion("tick", "execute if score @s sed_thirst matches 1.. run say hola\n")
    assert not _errores(pack)


RAIZ = Path(__file__).resolve().parent.parent
PANEL = RAIZ / "panel" / "data"
FUNCIONES = PANEL / "swr" / "function"
PATRON = re.compile(r'(?:^|\s)(?:function|schedule\s+\S+\s+function)\s+([a-z0-9_]+:[a-z0-9_/]+)')


def test_todas_las_llamadas_del_pack_real_existen():
    rotas = []
    for archivo in sorted(PANEL.rglob("*.mcfunction")):
        for numero, linea in enumerate(archivo.read_text(encoding="utf-8").splitlines(), 1):
            if linea.lstrip().startswith("#"):
                continue
            for encontrado in PATRON.finditer(linea):
                espacio, ruta = encontrado.group(1).split(":", 1)
                if not (PANEL / espacio / "function" / f"{ruta}.mcfunction").exists():
                    rotas.append(f"{encontrado.group(1)} ({archivo.relative_to(PANEL)}:{numero})")
    assert not rotas, "llamadas a funciones inexistentes:\n" + "\n".join(rotas)


def test_el_recuento_de_funciones_de_faltan_cuadra():
    total = len(list(FUNCIONES.rglob("*.mcfunction")))
    texto = (RAIZ / "FALTAN.md").read_text(encoding="utf-8")
    assert f"({total} funciones)" in texto, f"FALTAN.md no dice que hay {total} funciones"


def test_faltan_nombra_las_38_fichas():
    texto = (RAIZ / "FALTAN.md").read_text(encoding="utf-8")
    assert "38 personajes con ficha" in texto


def test_cancelar_casa_se_puede_descubrir():
    """Una función útil que nadie nombra es una función que no existe para el jugador."""
    estado = (FUNCIONES / "pueblo" / "estado.mcfunction").read_text(encoding="utf-8")
    carga = (FUNCIONES / "load.mcfunction").read_text(encoding="utf-8")
    assert "pueblo/casa/cancelar" in estado
    assert "casa/cancelar" in carga
