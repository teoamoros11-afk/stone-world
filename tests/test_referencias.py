"""Pruebas de las referencias: ids y objetivos que no existen."""

from __future__ import annotations

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
