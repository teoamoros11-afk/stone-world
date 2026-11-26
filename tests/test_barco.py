"""El bar y la mesa de poker van dentro del propio barco (NBT), no solo por comando."""

from __future__ import annotations

import importlib.util
import pathlib

RAIZ = pathlib.Path(__file__).resolve().parent.parent
GENERADOR = RAIZ / "herramientas" / "generar_estructura_perseus.py"


def _generador():
    spec = importlib.util.spec_from_file_location("generar_perseus", GENERADOR)
    modulo = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(modulo)
    modulo.bloques.clear()
    modulo.casco()
    modulo.cubierta_superior()
    modulo.arboladura()
    modulo.salon()
    return modulo


def test_la_barra_va_en_la_cubierta_del_barco():
    gen = _generador()
    for j in range(-2, 3):
        assert gen.bloques[(26, 5, j)] == "minecraft:barrel", f"falta el barril {j}"
        assert gen.bloques[(26, 6, j)] == "minecraft:smooth_stone_slab", f"falta la tapa {j}"
        assert gen.bloques[(25, 5, j)].startswith("minecraft:oak_stairs"), f"falta el taburete {j}"


def test_la_mesa_de_poker_va_en_el_barco():
    gen = _generador()
    for x in range(19, 22):
        for j in range(-1, 2):
            assert gen.bloques[(x, 5, j)] == "minecraft:dark_oak_planks", f"falta la mesa en {x},{j}"
    assert gen.bloques[(22, 5, -1)].startswith("minecraft:oak_stairs")
    assert gen.bloques[(22, 5, 1)].startswith("minecraft:oak_stairs")


def test_el_salon_no_se_come_el_invernadero_ni_los_escalones():
    gen = _generador()
    # invernadero x 13-18 y escalones x 27-29: el salon vive entre medias
    for x in range(13, 19):
        for j in range(-2, 3):
            assert "barrel" not in gen.bloques.get((x, 5, j), "")
    for x in range(27, 30):
        for j in range(-1, 2):
            assert "barrel" not in gen.bloques.get((x, 5, j), ""), "la barra pisa los escalones"


def test_el_nbt_se_regenera_y_lleva_el_salon():
    nbt = RAIZ / "panel" / "data" / "swr" / "structure" / "perseus.nbt"
    assert nbt.is_file() and nbt.stat().st_size > 10_000
    datos = nbt.read_bytes()
    # los nombres de bloque viajan en la paleta del NBT, sin comprimir dentro del gzip: se lee
    import gzip
    crudo = gzip.decompress(datos)
    for nombre in (b"minecraft:barrel", b"minecraft:smooth_stone_slab", b"minecraft:oak_stairs"):
        assert nombre in crudo, f"el NBT no lleva {nombre.decode()}"
