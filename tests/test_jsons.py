"""Pruebas de los JSON: pack.mcmeta, tags, advancements, loot tables y predicates."""

from __future__ import annotations

from validador.jsons import comprobar
from validador.modelo import cargar


def _errores(pack):
    return [p for p in comprobar(cargar(pack.raiz)) if p.nivel == "error"]


def _avisos(pack):
    return [p for p in comprobar(cargar(pack.raiz)) if p.nivel == "aviso"]


def test_pack_mcmeta_correcto_no_da_nada(pack):
    assert not _errores(pack)


def test_pack_mcmeta_sin_objeto_pack(pack):
    pack.json("pack.mcmeta", {"pack_format": 48})
    assert any("objeto «pack»" in p.mensaje for p in _errores(pack))


def test_pack_format_debe_ser_entero(pack):
    pack.json("pack.mcmeta", {"pack": {"pack_format": "48", "description": "x"}})
    assert any("pack_format" in p.mensaje for p in _errores(pack))


def test_pack_mcmeta_sin_descripcion_es_aviso(pack):
    pack.json("pack.mcmeta", {"pack": {"pack_format": 48}})
    assert any("description" in p.mensaje for p in _avisos(pack))


def test_json_roto_dice_la_linea(pack):
    pack.escribir("data/prueba/predicate/roto.json", '{\n  "a": 1,\n}\n')
    errores = _errores(pack)
    assert any("JSON inválido" in p.mensaje and "roto.json:2" in p.sitio for p in errores)


def test_tag_sin_values(pack):
    pack.json("data/prueba/tags/function/vacio.json", {"replace": False})
    assert any("no tiene «values»" in p.mensaje for p in _errores(pack))


def test_tag_con_valor_sin_namespace(pack):
    pack.json("data/prueba/tags/function/uno.json", {"values": ["sin_namespace"]})
    assert any("no lleva namespace" in p.mensaje for p in _errores(pack))


def test_tag_con_objeto_sin_id(pack):
    pack.json("data/prueba/tags/function/uno.json", {"values": [{"required": True}]})
    assert any("falta «id»" in p.mensaje for p in _errores(pack))


def test_tag_correcto(pack):
    pack.json(
        "data/prueba/tags/function/arranque.json",
        {"values": ["prueba:panel/ver", {"id": "minecraft:load", "required": False}]},
    )
    pack.funcion("panel/ver", "say hola\n")
    assert not _errores(pack)


def test_advancement_sin_criteria(pack):
    pack.json("data/prueba/advancement/era.json", {"display": {"title": "x", "description": "y"}})
    assert any("criteria" in p.mensaje for p in _errores(pack))


def test_advancement_con_display_incompleto(pack):
    pack.json(
        "data/prueba/advancement/era.json",
        {"criteria": {"hecho": {"trigger": "minecraft:tick"}}, "display": {"title": "x"}},
    )
    mensajes = [p.mensaje for p in _errores(pack)]
    assert any("description" in m for m in mensajes)


def test_loot_table_sin_pools(pack):
    pack.json("data/prueba/loot_table/cosa.json", {"rolls": 1})
    assert any("pools" in p.mensaje for p in _errores(pack))


def test_predicate_vacio_es_aviso(pack):
    pack.json("data/prueba/predicate/libro.json", {})
    assert any("predicate vacío" in p.mensaje for p in _avisos(pack))


def test_recurso_generico_solo_tiene_que_leerse(pack):
    pack.json("data/prueba/recipe/piedra.json", {"type": "minecraft:crafting_shaped"})
    assert not _errores(pack)
