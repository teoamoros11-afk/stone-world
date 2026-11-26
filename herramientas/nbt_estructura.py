"""Escritor NBT minimo para estructuras de Minecraft (formato de structure block).

Solo lo que hace falta: compuestos, listas, enteros, cadenas. Sirve para generar
`.nbt` sin abrir Minecraft y sin dependencias. El gzip va con mtime 0, asi que dos
ejecuciones dan el mismo archivo byte a byte y se puede comprobar en una prueba.
"""
from __future__ import annotations

import gzip
import struct
from pathlib import Path

DATA_VERSION = 3955  # Minecraft 1.21.1


def _nombre(s: str) -> bytes:
    b = s.encode("utf-8")
    return struct.pack(">H", len(b)) + b


def _payload(tipo: int, valor):
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


def normalizar(bloque):
    """Un bloque es 'minecraft:x' o ('minecraft:x', {'age': '7'})."""
    if isinstance(bloque, tuple):
        nombre, props = bloque
        return nombre, tuple(sorted(props.items()))
    return bloque, ()


def compuesto_estructura(bloques: dict, tam: tuple[int, int, int]) -> bytes:
    sx, sy, sz = tam
    paleta = sorted({normalizar(b) for b in bloques.values()} | {("minecraft:air", ())})
    indice = {n: i for i, n in enumerate(paleta)}
    entradas = []
    for nombre, props in paleta:
        entrada = {"Name": (8, nombre)}
        if props:
            entrada["Properties"] = (10, {k: (8, v) for k, v in props})
        entradas.append(entrada)
    lista = []
    for x in range(sx):
        for y in range(sy):
            for z in range(sz):
                nombre, props = normalizar(bloques.get((x, y, z), "minecraft:air"))
                lista.append({"pos": (9, (3, [x, y, z])), "state": (3, indice[(nombre, props)])})
    comp = {
        "DataVersion": (3, DATA_VERSION),
        "size": (9, (3, [sx, sy, sz])),
        "palette": (9, (10, entradas)),
        "blocks": (9, (10, lista)),
        "entities": (9, (10, [])),
    }
    return struct.pack(">b", 10) + _nombre("") + _payload(10, comp)


def escribir(destino: Path, datos: bytes) -> None:
    destino.parent.mkdir(parents=True, exist_ok=True)
    with open(destino, "wb") as f:
        with gzip.GzipFile(fileobj=f, mode="wb", mtime=0) as g:
            g.write(datos)
