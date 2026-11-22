#!/usr/bin/env python3
"""Genera el Perseus como ESTRUCTURA de Minecraft (data/swr/structure/perseus.nbt).

El barco del PERSEUS.md se replantea con las mismas cuadernas del modelo fisico,
pero en bloques de 1 m. Asi se construye entero con un comando:

    /place template swr:perseus

Los aldeanos NO construyen: el navegante, el contable y el cocinero son tripulacion
con nombre y profesion (ver panel/data/swr/function/tripulacion/), no obreros.

Uso:
    python3 herramientas/generar_estructura_perseus.py
"""
import gzip
import pathlib
import struct
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import perseus_modelo as M  # noqa: E402

RAIZ = pathlib.Path(__file__).resolve().parent.parent
SALIDA = RAIZ / "panel/data/swr/structure/perseus.nbt"

# caja de la estructura: largo (x), alto (y), ancho (z)
SX, SY, SZ = 32, 24, 9
J0 = 4                      # el barco va centrado en el ancho
DATA_VERSION = 3955         # Minecraft 1.21.1

MADERA = "minecraft:oak_planks"
MADERA_OSCURA = "minecraft:dark_oak_planks"
PINO = "minecraft:spruce_planks"
CRISTAL = "minecraft:glass"
VELA = "minecraft:white_wool"
HIERRO = "minecraft:iron_block"
TABLON = "minecraft:oak_slab"

bloques = {}


def poner(x, y, j, nombre):
    if 0 <= x < SX and 0 <= y < SY and -J0 <= j < SZ - J0:
        bloques[(x, y, j)] = nombre


def casco():
    """Cuatro capas de casco hueco, cubierta en la quinta y regala en la sexta."""
    for x in range(0, 30):
        xc = x + 0.5
        for y in range(0, 4):
            wi = int(round(M.half_breadth(xc, y + 0.5)))
            if wi <= 0:
                continue
            if y == 0:
                for j in range(-wi, wi + 1):
                    poner(x, y, j, MADERA)
            else:
                poner(x, y, wi, MADERA)
                poner(x, y, -wi, MADERA)
        # cubierta
        wd = int(round(M.manga_en_cubierta(xc)))
        if wd > 0:
            for j in range(-wd, wd + 1):
                poner(x, 4, j, MADERA)
            poner(x, 5, wd, MADERA_OSCURA)
            poner(x, 5, -wd, MADERA_OSCURA)
    # escotillas: dos huecos en la cubierta
    for x in (10, 11, 21, 22):
        for j in (-1, 0, 1):
            bloques.pop((x, 4, j), None)
    # nueve portillas por banda
    for k in range(9):
        x = int(round(6.0 + k * 2.2))
        for j, s in ((0, 1), (0, -1)):
            wi = int(round(M.half_breadth(x + 0.5, 3.5)))
            if wi > 0:
                poner(x, 3, s * wi, CRISTAL)


def cubierta_superior():
    # toldilla / sala de comunicaciones (x 2-7), con ventanas
    for x in range(2, 8):
        for j in range(-2, 3):
            if x in (2, 7) or abs(j) == 2:
                poner(x, 5, j, CRISTAL if abs(j) == 2 and x not in (2, 7) else MADERA_OSCURA)
                poner(x, 6, j, CRISTAL if abs(j) == 2 else MADERA_OSCURA)
            poner(x, 7, j, MADERA_OSCURA)
    # invernadero (x 13-18): todo de cristal
    for x in range(13, 19):
        for j in range(-2, 3):
            if x in (13, 18) or abs(j) == 2:
                poner(x, 5, j, CRISTAL)
                poner(x, 6, j, CRISTAL)
            poner(x, 7, j, CRISTAL)
    # tres escalones de proa (x 27-29)
    for x, alto in ((29, 5), (28, 6), (27, 7)):
        for y in range(5, alto + 1):
            for j in range(-1, 2):
                poner(x, y, j, MADERA_OSCURA)
    # timon y caña
    for y in range(1, 4):
        poner(0, y, 0, MADERA_OSCURA)
    for x in (1, 2):
        poner(x, 5, 0, MADERA_OSCURA)
    # helices bajo el espejo de popa
    for j in (-2, 2):
        poner(0, 2, j, HIERRO)


def arboladura():
    for x, alto in ((8, 16), (20, 18)):
        for y in range(5, 5 + alto + 1):
            poner(x, y, 0, "minecraft:oak_log")
        for k, hw in enumerate((3, 3, 3)):
            y = 4 + int(round(alto * (0.45 + 0.19 * k)))
            for j in range(-hw, hw + 1):
                poner(x, y, j, PINO)
            for j in range(-2, 3):
                for dy in range(1, 4):
                    poner(x, y - dy, j, VELA)
    # bauprés y foques
    for x in (30, 31):
        poner(x, 5, 0, PINO)
    for y in range(6, 9):
        poner(30, y, 0, VELA)
        poner(31, y - 1, 0, VELA)


# ------------------------------------------------------------------ NBT
def _nombre(s):
    b = s.encode("utf-8")
    return struct.pack(">H", len(b)) + b


def _payload(tipo, valor):
    if tipo == 1:
        return struct.pack(">b", valor)
    if tipo == 3:
        return struct.pack(">i", valor)
    if tipo == 8:
        return _nombre(valor)
    if tipo == 9:
        hijo, valores = valor
        return struct.pack(">bi", hijo, len(valores)) + b"".join(_payload(hijo, v) for v in valores)
    if tipo == 10:
        out = b""
        for clave, (t, v) in valor.items():
            out += struct.pack(">b", t) + _nombre(clave) + _payload(t, v)
        return out + b"\x00"
    if tipo == 11:
        return struct.pack(">i", len(valor)) + b"".join(struct.pack(">i", v) for v in valor)
    raise ValueError(f"tipo NBT no soportado: {tipo}")


def escribir_nbt(destino, nombre_raiz, compuesto):
    datos = struct.pack(">b", 10) + _nombre(nombre_raiz) + _payload(10, compuesto)
    destino.parent.mkdir(parents=True, exist_ok=True)
    with gzip.open(destino, "wb") as f:
        f.write(datos)


def estructura_nbt():
    paleta = sorted({MADERA, MADERA_OSCURA, PINO, CRISTAL, VELA, HIERRO,
                     "minecraft:oak_log", "minecraft:air"})
    indice = {n: i for i, n in enumerate(paleta)}
    lista_bloques = []
    for x in range(SX):
        for y in range(SY):
            for j in range(-J0, SZ - J0):
                nombre = bloques.get((x, y, j), "minecraft:air")
                lista_bloques.append((x, y, j + J0, indice[nombre]))
    return {
        "DataVersion": (3, DATA_VERSION),
        "size": (9, (3, [SX, SY, SZ])),
        "palette": (9, (10, [{"Name": (8, n)} for n in paleta])),
        "blocks": (9, (10, [{"pos": (9, (3, [x, y, z])), "state": (3, i)}
                            for x, y, z, i in lista_bloques])),
        "entities": (9, (10, [])),
    }, paleta, indice


def main():
    casco()
    cubierta_superior()
    arboladura()
    comp, paleta, indice = estructura_nbt()
    escribir_nbt(SALIDA, "", comp)
    solidos = sum(1 for n in bloques.values())
    print(f"estructura: {SX}x{SY}x{SZ} bloques | solidos: {solidos} | paleta: {len(paleta)}")
    print(f"  cubierta (15,4,4) = {bloques.get((15, 4, 0), 'aire')} en el barco")
    print(f"escrito {SALIDA} ({SALIDA.stat().st_size} bytes)")
    print("colocacion: /place template swr:perseus")


if __name__ == "__main__":
    main()
