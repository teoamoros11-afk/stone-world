#!/usr/bin/env python3
"""Genera mapa-isla.png desde isla.json y reempaqueta el datapack.

Uso:  python3 minecraft/stone-world/herramientas/generar_mapa.py
Sin dependencias: solo stdlib (zlib, struct, json, zipfile).
"""
import json
import struct
import sys
import zipfile
import zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
S, MIN, MAX = 1024, -1200, 1200
SEA = (18, 46, 78)
SAND = (199, 181, 131)
GRASS = (74, 110, 58)
RIVER = (52, 116, 178)
WATERFALL = (120, 200, 240)

FONT = {
    "0": ("###", "# #", "# #", "# #", "###"), "1": (" # ", "## ", " # ", " # ", "###"),
    "2": ("###", "  #", "###", "#  ", "###"), "3": ("###", "  #", "###", "  #", "###"),
    "4": ("# #", "# #", "###", "  #", "  #"), "5": ("###", "#  ", "###", "  #", "###"),
    "6": ("###", "#  ", "###", "# #", "###"), "7": ("###", "  #", "  #", "  #", "  #"),
    "8": ("###", "# #", "###", "# #", "###"), "9": ("###", "# #", "###", "  #", "###"),
}


def to_px(v):
    return int((v - MIN) / (MAX - MIN) * S)


def main():
    data = json.loads((ROOT / "isla.json").read_text(encoding="utf-8"))
    zones = data["zonas"]

    img = [bytearray(bytes(SEA + (255,)) * S) for _ in range(S)]

    def setp(x, y, c):
        if 0 <= x < S and 0 <= y < S:
            img[y][x * 4:x * 4 + 4] = bytes(c + (255,))

    def fill_poly(poly, col):
        edges = list(zip(poly, poly[1:] + poly[:1]))
        for y in range(S):
            z = MIN + (y + 0.5) / S * (MAX - MIN)
            xs = []
            for (x1, z1), (x2, z2) in edges:
                if (z1 > z) != (z2 > z):
                    xs.append(x1 + (z - z1) * (x2 - x1) / (z2 - z1))
            xs.sort()
            for i in range(0, len(xs) - 1, 2):
                for x in range(max(0, to_px(xs[i])), min(S, to_px(xs[i + 1]) + 1)):
                    setp(x, y, col)

    poly = data["isla"]["poligono_xz"]
    fill_poly(poly, SAND)
    cx = sum(p[0] for p in poly) / len(poly)
    cz = sum(p[1] for p in poly) / len(poly)
    fill_poly([(cx + (x - cx) * 0.955, cz + (z - cz) * 0.955) for x, z in poly], GRASS)

    pts = data["rio"]["puntos_xz"]
    for (x1, z1), (x2, z2) in zip(pts, pts[1:]):
        steps = int(max(abs(x2 - x1), abs(z2 - z1)) / 4) + 1
        for s in range(steps + 1):
            t = s / steps
            bx, bz = to_px(x1 + (x2 - x1) * t), to_px(z1 + (z2 - z1) * t)
            for dx in (-1, 0, 1):
                for dz in (-1, 0, 1):
                    setp(bx + dx, bz + dz, RIVER)

    cs = data["rio"]["cascada"]
    for dx in range(-3, 4):
        for dz in range(-3, 4):
            if dx * dx + dz * dz <= 9:
                setp(to_px(cs["x"]) + dx, to_px(cs["z"]) + dz, WATERFALL)

    for zo in zones:
        x0, z0 = to_px(zo["x"]), to_px(zo["z"])
        x1, z1 = to_px(zo["x"] + zo["ancho"]), to_px(zo["z"] + zo["profundo"])
        for y in range(max(0, z0), min(S, z1)):
            for x in range(max(0, x0), min(S, x1)):
                o = img[y][x * 4:x * 4 + 4]
                img[y][x * 4:x * 4 + 4] = bytes(
                    int(zo["color"][i] * 0.72 + o[i] * 0.28) for i in range(3)
                ) + b"\xff"

    def draw_digit(n, x, y, sc=7):
        for row, line in enumerate(FONT[str(n)]):
            for col, ch in enumerate(line):
                if ch != "#":
                    continue
                for dy in range(sc):
                    for dx in range(sc):
                        setp(x + col * sc + dx, y + row * sc + dy, (20, 20, 20))
        for row, line in enumerate(FONT[str(n)]):
            for col, ch in enumerate(line):
                if ch != "#":
                    continue
                for dy in range(1, sc - 1):
                    for dx in range(1, sc - 1):
                        setp(x + col * sc + dx, y + row * sc + dy, (255, 255, 255))

    drawn = 0
    for zo in zones:
        cxp = to_px(zo["x"] + zo["ancho"] / 2)
        czp = to_px(zo["z"] + zo["profundo"] / 2)
        draw_digit(zo["n"], cxp - 10, czp - 17)
        drawn += 1

    bar = int(500 / (MAX - MIN) * S)
    by = S - 50
    for x in range(40, 40 + bar):
        for y in range(by, by + 5):
            setp(x, y, (255, 255, 255))
    for x in (40, 40 + bar):
        for y in range(by - 5, by + 10):
            setp(x, y, (255, 255, 255))

    for i in range(18):
        for w in range(i):
            setp(S - 60 - w, 40 + i, (255, 255, 255))
            setp(S - 60 + w, 40 + i, (255, 255, 255))

    def chunk(tag, payload):
        body = tag + payload
        return struct.pack(">I", len(payload)) + body + struct.pack(">I", zlib.crc32(body) & 0xFFFFFFFF)

    raw = b"".join(b"\x00" + bytes(row) for row in img)
    png = (
        b"\x89PNG\r\n\x1a\n"
        + chunk(b"IHDR", struct.pack(">IIBBBBB", S, S, 8, 6, 0, 0, 0))
        + chunk(b"IDAT", zlib.compress(raw, 9))
        + chunk(b"IEND", b"")
    )
    (ROOT / "mapa-isla.png").write_bytes(png)

    base = ROOT / "panel"
    out = ROOT / "panel-del-reino.zip"
    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
        for f in sorted(base.rglob("*")):
            if f.is_file():
                z.write(f, f.relative_to(base).as_posix())

    ok = True
    for zo in zones:
        if not (base / "data/swr/function/viaje" / (zo["id"] + ".mcfunction")).exists():
            print("FALTA funcion de viaje:", zo["id"])
            ok = False
    names = zipfile.ZipFile(out).namelist()
    if "pack.mcmeta" not in names:
        print("FALTA pack.mcmeta en la raiz del zip")
        ok = False
    if "pack.mcmeta" in names:
        json.loads(zipfile.ZipFile(out).read("pack.mcmeta"))
    print(f"mapa: {S}x{S} | marcadores: {drawn}/{len(zones)} | png: {len(png)} bytes")
    print(f"zip: {len(names)} entradas | mcfunctions: {sum(n.endswith('.mcfunction') for n in names)}")
    print("RESULTADO:", "TODO OK" if ok else "REVISAR")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
