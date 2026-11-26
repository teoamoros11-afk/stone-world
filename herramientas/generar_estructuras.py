#!/usr/bin/env python3
"""Genera los cuatro planos colocables del tramo A de FALTAN.md.

    /place template swr:isla_tesoro     (temporada 3, cap. 101-140)
    /place template swr:corn_city       (temporada 4, cap. 82-94)
    /place template swr:haber_bosch     (temporada 4, cap. 62-65)
    /place template swr:araxa           (temporada 4, cap. 76)

Son planos esquematicos: lo que hace falta para reconocer el sitio y jugar una
escena, no una reconstruccion del manga. Todo se genera con bucles, sin abrir
Minecraft y sin dependencias.

Uso:
    python3 herramientas/generar_estructuras.py             # escribe los .nbt
    python3 herramientas/generar_estructuras.py --comprobar # falla si no cuadran
"""
from __future__ import annotations

import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import nbt_estructura as N  # noqa: E402

RAIZ = pathlib.Path(__file__).resolve().parent.parent
SALIDA = RAIZ / "panel/data/swr/structure"

PIEDRA = "minecraft:stone_bricks"
PIEDRA_LISA = "minecraft:smooth_stone"
MADERA = "minecraft:oak_planks"
MADERA_OSCURA = "minecraft:dark_oak_planks"
CRISTAL = "minecraft:glass"
HIERRO = "minecraft:iron_block"
BARROTES = "minecraft:iron_bars"
LINTERNA = "minecraft:lantern"
FAROL = "minecraft:sea_lantern"
AMATISTA = "minecraft:amethyst_block"
AGUA = "minecraft:water"
CAMINO = "minecraft:dirt_path"
TIERRA = "minecraft:grass_block"
FARMLAND = ("minecraft:farmland", {"moisture": "7"})
TRIGO = ("minecraft:wheat", {"age": "7"})
MAIZ = ("minecraft:wheat", {"age": "7"})


class Plano:
    def __init__(self, sx: int, sy: int, sz: int):
        self.tam = (sx, sy, sz)
        self.b: dict[tuple[int, int, int], object] = {}

    def poner(self, x: int, y: int, z: int, bloque) -> None:
        sx, sy, sz = self.tam
        if 0 <= x < sx and 0 <= y < sy and 0 <= z < sz:
            self.b[(x, y, z)] = bloque

    def caja(self, x0, y0, z0, x1, y1, z1, bloque) -> None:
        for x in range(min(x0, x1), max(x0, x1) + 1):
            for y in range(min(y0, y1), max(y0, y1) + 1):
                for z in range(min(z0, z1), max(z0, z1) + 1):
                    self.poner(x, y, z, bloque)

    def muro(self, x0, z0, x1, z1, y0, y1, bloque) -> None:
        for x in range(min(x0, x1), max(x0, x1) + 1):
            for z in range(min(z0, z1), max(z0, z1) + 1):
                if x in (min(x0, x1), max(x0, x1)) or z in (min(z0, z1), max(z0, z1)):
                    for y in range(y0, y1 + 1):
                        self.poner(x, y, z, bloque)

    def columna(self, x, z, y0, y1, bloque) -> None:
        for y in range(y0, y1 + 1):
            self.poner(x, y, z, bloque)

    def almenas(self, x0, z0, x1, z1, y, bloque) -> None:
        for x in range(min(x0, x1), max(x0, x1) + 1):
            for z in range(min(z0, z1), max(z0, z1) + 1):
                if (x in (min(x0, x1), max(x0, x1)) or z in (min(z0, z1), max(z0, z1))) and (x + z) % 2 == 0:
                    self.poner(x, y, z, bloque)

    def campo(self, x0, z0, x1, z1, y) -> None:
        for x in range(min(x0, x1), max(x0, x1) + 1):
            for z in range(min(z0, z1), max(z0, z1) + 1):
                if x in (x0, x1) or z in (z0, z1):
                    self.poner(x, y, z, CAMINO)
                elif (x + z) % 4 == 0:
                    self.poner(x, y, z, AGUA)
                else:
                    self.poner(x, y, z, FARMLAND)
                    self.poner(x, y + 1, z, TRIGO)


def isla_tesoro() -> Plano:
    p = Plano(25, 14, 25)
    p.caja(0, 0, 0, 24, 0, 24, PIEDRA)
    p.muro(0, 0, 24, 24, 1, 3, PIEDRA)
    p.almenas(0, 0, 24, 24, 4, PIEDRA)
    for x, z in ((0, 0), (24, 0), (0, 24), (24, 24)):
        p.columna(x, z, 1, 6, PIEDRA)
        p.poner(x, 7, z, FAROL)
    # puerta al sur
    p.caja(11, 1, 0, 13, 3, 0, "minecraft:air")
    p.caja(11, 1, 1, 13, 2, 8, MADERA)
    # torre central con el altar
    p.caja(9, 1, 9, 15, 7, 15, PIEDRA)
    p.caja(10, 1, 10, 14, 6, 14, "minecraft:air")
    p.caja(11, 1, 9, 13, 2, 9, "minecraft:air")
    p.caja(9, 8, 9, 15, 8, 15, "minecraft:deepslate_tiles")
    for x in (10, 12, 14):
        p.poner(x, 4, 9, CRISTAL)
    p.caja(11, 1, 13, 13, 1, 13, "minecraft:polished_blackstone")
    p.columna(12, 13, 2, 3, AMATISTA)
    p.poner(12, 4, 13, FAROL)
    # celda
    p.muro(2, 18, 6, 22, 1, 3, PIEDRA)
    p.caja(3, 1, 19, 5, 2, 21, BARROTES)
    p.caja(4, 1, 18, 4, 2, 18, "minecraft:air")
    # muelle
    p.caja(0, 1, 11, 3, 1, 13, MADERA_OSCURA)
    for x, z in ((0, 11), (0, 13), (3, 11), (3, 13)):
        p.poner(x, 2, z, LINTERNA)
    # antorchas del camino
    for z in (3, 7, 17, 21):
        for x in (8, 16):
            p.poner(x, 1, z, LINTERNA)
    return p


def corn_city() -> Plano:
    p = Plano(21, 12, 21)
    p.caja(0, 0, 0, 20, 0, 20, TIERRA)
    p.caja(9, 0, 0, 11, 0, 20, CAMINO)
    p.caja(0, 0, 9, 20, 0, 11, CAMINO)
    p.campo(2, 2, 7, 7, 1)
    p.campo(13, 2, 18, 7, 1)
    p.campo(2, 13, 7, 18, 1)
    p.campo(13, 13, 18, 18, 1)
    # silo
    p.caja(14, 1, 14, 18, 6, 18, PIEDRA_LISA)
    p.caja(15, 1, 15, 17, 5, 17, "minecraft:hay_block")
    p.caja(14, 7, 14, 18, 7, 18, MADERA_OSCURA)
    p.poner(16, 2, 18, "minecraft:barrel")
    # dos casas
    for x0, z0 in ((2, 15), (15, 2)):
        p.caja(x0, 1, z0, x0 + 3, 3, z0 + 3, MADERA)
        p.caja(x0 + 1, 1, z0, x0 + 2, 2, z0, "minecraft:air")
        p.caja(x0, 4, z0, x0 + 3, 4, z0 + 3, MADERA_OSCURA)
        p.poner(x0 + 1, 5, z0 + 1, LINTERNA)
    # torre de radio
    p.columna(10, 1, 1, 11, BARROTES)
    p.poner(10, 12, 1, FAROL)
    p.poner(10, 6, 1, "minecraft:lantern")
    return p


def haber_bosch() -> Plano:
    p = Plano(19, 18, 19)
    p.caja(0, 0, 0, 18, 0, 18, PIEDRA_LISA)
    p.caja(0, 1, 0, 18, 1, 1, "minecraft:polished_andesite")  # pista
    # torre principal
    p.caja(6, 1, 6, 13, 12, 13, "minecraft:deepslate_bricks")
    p.caja(7, 1, 7, 12, 11, 12, "minecraft:air")
    p.caja(9, 1, 6, 10, 2, 6, "minecraft:air")
    for y in (4, 7, 10):
        for x in (8, 10, 12):
            p.poner(x, y, 6, CRISTAL)
            p.poner(x, y, 13, CRISTAL)
    p.caja(6, 13, 6, 13, 13, 13, "minecraft:deepslate_tiles")
    # chimeneas
    for x, z in ((7, 7), (12, 7), (7, 12)):
        p.caja(x, 13, z, x + 1, 16, z + 1, "minecraft:deepslate_bricks")
        p.poner(x, 17, z, "minecraft:campfire")
    # tanques
    for cz in (4, 15):
        p.caja(2, 1, cz - 1, 4, 5, cz + 1, HIERRO)
        p.caja(3, 2, cz, 3, 4, cz, AGUA)
        p.poner(3, 6, cz, LINTERNA)
    # maizal
    p.campo(13, 15, 17, 17, 1)
    # valla
    for x in range(0, 19, 2):
        p.poner(x, 1, 18, "minecraft:oak_fence")
    return p


def araxa() -> Plano:
    p = Plano(21, 12, 21)
    p.caja(0, 0, 0, 20, 0, 20, PIEDRA)
    p.muro(0, 0, 20, 20, 1, 4, PIEDRA)
    p.almenas(0, 0, 20, 20, 5, PIEDRA)
    p.caja(9, 1, 0, 11, 3, 0, "minecraft:air")
    p.caja(9, 1, 1, 11, 1, 3, PIEDRA_LISA)
    p.caja(1, 1, 1, 19, 1, 19, "minecraft:polished_deepslate")
    # torre de la medusa
    p.caja(8, 1, 8, 12, 10, 12, "minecraft:calcite")
    p.caja(9, 1, 9, 11, 9, 11, "minecraft:air")
    p.caja(9, 1, 8, 11, 2, 8, "minecraft:air")
    p.caja(8, 11, 8, 12, 11, 12, "minecraft:deepslate_tiles")
    p.columna(10, 10, 2, 6, AMATISTA)
    p.poner(10, 7, 10, FAROL)
    for x in (2, 18):
        for z in (2, 18):
            p.columna(x, z, 1, 2, PIEDRA)
            p.poner(x, 3, z, "minecraft:campfire")
    for x in (5, 15):
        p.poner(x, 1, 10, LINTERNA)
    return p


PLANOS = {
    "isla_tesoro": isla_tesoro,
    "corn_city": corn_city,
    "haber_bosch": haber_bosch,
    "araxa": araxa,
}


def construir(nombre: str) -> tuple[dict, bytes]:
    p = PLANOS[nombre]()
    return p.b, N.compuesto_estructura(p.b, p.tam)


def main(comprobar: bool = False) -> int:
    fallos = 0
    for nombre in PLANOS:
        bloques, datos = construir(nombre)
        destino = SALIDA / f"{nombre}.nbt"
        if comprobar:
            actual = destino.read_bytes() if destino.exists() else b""
            import gzip
            igual = bool(actual) and gzip.decompress(actual) == datos
            fallos += 0 if igual else 1
            print(f"{nombre}: {'ok' if igual else 'NO CUADRA'} ({len(datos)} bytes sin comprimir)")
        else:
            N.escribir(destino, datos)
            solidos = len([b for b in bloques.values() if N.normalizar(b)[0] != 'minecraft:air'])
            print(f"{nombre}: {destino.stat().st_size} bytes | solidos: {solidos} | {len(datos)} sin comprimir")
    return 1 if fallos else 0


if __name__ == "__main__":
    raise SystemExit(main(comprobar="--comprobar" in sys.argv))
