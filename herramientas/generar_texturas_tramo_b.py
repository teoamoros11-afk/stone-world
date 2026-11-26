#!/usr/bin/env python3
"""Genera las texturas 2D del tramo B y sus modelos de ítem.

Piezas que cubre, de FALTAN.md:

    B1   medusa con textura propia (corazon del mar, custom_model_data 7101)
    B2   52 cartas, el dorso y cinco fichas (papel 100-152 y 7211-7215)
    B7   un icono por cada uno de los 14 avances (papel 7401-7414)
    B11  el denario y el billete (oro 7201 y papel 7301)

Todo se dibuja a 16x16, que es lo que mide un ítem. No es arte de la serie: son
piezas legibles, con la paleta del pack. Las cartas llevan rango y palo para que
se distingan en la mano sin leer el nombre.

Escribe en pack-inmersion/ y rehace ReinoDeLaCiencia.zip.

Uso: python3 herramientas/generar_texturas_tramo_b.py
"""
from __future__ import annotations

import json
import pathlib
import sys

from PIL import Image, ImageDraw

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from generar_pack_inmersion import BASE, empaquetar  # noqa: E402

ASSETS = BASE / "assets"
ITEMS = ASSETS / "swr" / "textures" / "item"
MODELOS = ASSETS / "swr" / "models" / "item"
MODELOS_VANILLA = ASSETS / "minecraft" / "models" / "item"

CREMA = "#f7f3e6"
NEGRO = "#1b1b1b"
ROJO = "#c0392b"
VERDE = "#5fd35a"
VERDE_CLARO = "#d6ffc4"
ORO = "#e0b23c"
ORO_CLARO = "#f2d27a"
MADERA = "#8a5a2f"
TINTA = "#2b3238"
PIEDRA = "#8a8f8a"
PIEDRA_OSCURA = "#5f665f"
FUEGO = "#e8722f"

# Fuente de 3x5: lo justo para que un rango se lea dentro de una carta de 16 px.
FUENTE = {
    "0": ["111", "101", "101", "101", "111"],
    "1": ["010", "110", "010", "010", "111"],
    "2": ["111", "001", "111", "100", "111"],
    "3": ["111", "001", "111", "001", "111"],
    "4": ["101", "101", "111", "001", "001"],
    "5": ["111", "100", "111", "001", "111"],
    "6": ["111", "100", "111", "101", "111"],
    "7": ["111", "001", "010", "010", "010"],
    "8": ["111", "101", "111", "101", "111"],
    "9": ["111", "101", "111", "001", "111"],
    "A": ["010", "101", "111", "101", "101"],
    "J": ["001", "001", "001", "101", "111"],
    "Q": ["111", "101", "101", "111", "001"],
    "K": ["101", "110", "100", "110", "101"],
    "D": ["110", "101", "101", "101", "110"],
}

# Los cuatro palos, a 5x5. A este tamaño manda la silueta, no el detalle.
PALOS = {
    "picas": ["00100", "01110", "11111", "11111", "00100"],
    "corazones": ["01010", "11111", "11111", "01110", "00100"],
    "diamantes": ["00100", "01110", "11111", "01110", "00100"],
    "treboles": ["00100", "00100", "01110", "11111", "01110"],
}

PALOS_ORDEN = ["picas", "corazones", "diamantes", "treboles"]
RANGOS = {1: "A", 11: "J", 12: "Q", 13: "K"}


def lienzo() -> tuple[Image.Image, ImageDraw.ImageDraw]:
    im = Image.new("RGBA", (16, 16), (0, 0, 0, 0))
    return im, ImageDraw.Draw(im)


def guardar(nombre: str, im: Image.Image) -> None:
    ITEMS.mkdir(parents=True, exist_ok=True)
    im.save(ITEMS / f"{nombre}.png")


def texto(d: ImageDraw.ImageDraw, x: int, y: int, cadena: str, color: str) -> None:
    for caracter in cadena:
        for fila, patron in enumerate(FUENTE[caracter]):
            for columna, punto in enumerate(patron):
                if punto == "1":
                    d.point((x + columna, y + fila), fill=color)
        x += 4


def palo(d: ImageDraw.ImageDraw, x: int, y: int, nombre: str, color: str) -> None:
    for fila, patron in enumerate(PALOS[nombre]):
        for columna, punto in enumerate(patron):
            if punto == "1":
                d.point((x + columna, y + fila), fill=color)


# --- B1: la medusa -----------------------------------------------------------


def medusa() -> Image.Image:
    """El dispositivo: piedra morada, ojo verde y grietas. Fondo transparente."""
    im, d = lienzo()
    d.polygon([(7, 0), (9, 0), (9, 4), (7, 4)], fill="#9a86b8")   # antena
    d.ellipse([1, 4, 14, 15], fill="#4a2f6b", outline="#241335")
    d.ellipse([3, 6, 8, 10], fill="#6b4696")                      # luz de la piedra
    d.line([(2, 12), (5, 10), (4, 7)], fill="#241335")            # grietas
    d.line([(13, 11), (10, 9)], fill="#241335")
    d.line([(9, 14), (11, 12)], fill="#241335")
    d.ellipse([5, 7, 10, 12], fill=VERDE)                         # ojo
    d.ellipse([6, 8, 9, 11], fill=VERDE_CLARO)
    d.point((7, 9), fill="#ffffff")
    for x, y in ((3, 5), (12, 7), (8, 13)):
        d.point((x, y), fill="#8f6fbd")
    return im


# --- B2: la baraja y las fichas ---------------------------------------------


def naipe(numero: int) -> Image.Image:
    """Carta 1..52: picas, corazones, diamantes y treboles, en ese orden."""
    rango = (numero - 1) % 13 + 1
    nombre_palo = PALOS_ORDEN[(numero - 1) // 13]
    color = ROJO if nombre_palo in {"corazones", "diamantes"} else NEGRO
    letra = RANGOS.get(rango, str(rango))

    im, d = lienzo()
    d.rectangle([1, 0, 14, 15], fill=CREMA, outline="#2b2b2b")
    texto(d, 2, 1, letra, color)
    palo(d, 9, 1, nombre_palo, color)
    palo(d, 6, 8, nombre_palo, color)
    d.point((2, 14), fill="#b9b3a2")
    d.point((13, 14), fill="#b9b3a2")
    return im


def dorso() -> Image.Image:
    im, d = lienzo()
    d.rectangle([1, 0, 14, 15], fill="#1c2b4a", outline="#0d1524")
    d.rectangle([3, 2, 12, 13], outline="#2f8f5b")
    d.ellipse([4, 4, 11, 11], fill="#2f8f5b")
    d.ellipse([6, 6, 9, 9], fill="#1c2b4a")
    d.point((7, 7), fill=VERDE_CLARO)
    for x, y in ((7, 1), (7, 14), (2, 7), (13, 7)):
        d.point((x, y), fill="#2f8f5b")
    return im


def ficha(valor: int, color: str, interior: str, tinta: str) -> Image.Image:
    im, d = lienzo()
    d.ellipse([1, 1, 14, 14], fill=color, outline="#171a1d")
    d.ellipse([3, 3, 12, 12], fill=interior)
    for x in (6, 9):
        d.point((x, 1), fill=CREMA)
        d.point((x, 14), fill=CREMA)
    for y in (6, 9):
        d.point((1, y), fill=CREMA)
        d.point((14, y), fill=CREMA)
    cadena = str(valor)
    ancho = len(cadena) * 3 + (len(cadena) - 1)
    texto(d, (16 - ancho) // 2, 6, cadena, tinta)
    return im


# --- B11: el denario y el billete -------------------------------------------


def denario() -> Image.Image:
    im, d = lienzo()
    d.ellipse([1, 1, 14, 14], fill=ORO, outline="#7a5310")
    d.ellipse([2, 2, 13, 13], outline=ORO_CLARO)
    d.ellipse([4, 4, 11, 11], fill="#c99a2b")
    texto(d, 6, 6, "D", "#3a2a08")
    for x, y in ((3, 6), (12, 9), (6, 12), (9, 3)):
        d.point((x, y), fill="#f7e6a8")
    return im


def billete() -> Image.Image:
    im, d = lienzo()
    d.rectangle([0, 3, 15, 12], fill="#e8e2c8", outline="#3a5a40")
    d.rectangle([2, 5, 13, 10], outline="#2e6b4a")
    texto(d, 3, 6, "10", "#1f4a34")
    d.ellipse([10, 6, 13, 9], outline="#2e6b4a")
    d.point((11, 7), fill="#2e6b4a")
    return im


# --- B7: los catorce iconos de avance ---------------------------------------


def avance_campana() -> Image.Image:
    im, d = lienzo()
    d.rectangle([7, 1, 8, 2], fill="#6b4423")
    d.polygon([(3, 12), (12, 12), (11, 5), (4, 5)], fill=ORO)
    d.line([(3, 12), (12, 12)], fill="#b8892a")
    d.rectangle([5, 13, 10, 14], fill="#b8892a")
    d.point((7, 14), fill="#6b4423")
    d.line([(5, 6), (10, 6)], fill="#f7e6a8")
    return im


def avance_hoguera() -> Image.Image:
    im, d = lienzo()
    d.line([(2, 13), (13, 13)], fill="#6b4423", width=2)
    d.line([(3, 13), (12, 12)], fill=MADERA)
    d.polygon([(6, 12), (5, 7), (8, 9), (7, 4), (10, 8), (11, 12)], fill=FUEGO)
    d.polygon([(7, 12), (7, 8), (9, 11)], fill="#f7d34a")
    d.point((8, 12), fill="#fff3b0")
    return im


def avance_matraz() -> Image.Image:
    im, d = lienzo()
    d.rectangle([7, 1, 9, 3], fill="#c9d6d8")
    d.polygon([(6, 3), (10, 3), (12, 12), (4, 12)], fill="#c9d6d8")
    d.ellipse([5, 7, 11, 13], fill=VERDE)
    d.ellipse([6, 8, 10, 11], fill=VERDE_CLARO)
    d.point((6, 6), fill="#ffffff")
    for x, y in ((7, 12), (9, 13)):
        d.point((x, y), fill="#9bf58a")
    return im


def avance_gafas() -> Image.Image:
    im, d = lienzo()
    for centro in (4, 11):
        d.ellipse([centro - 3, 5, centro + 3, 11], outline=TINTA)
        d.ellipse([centro - 2, 6, centro + 2, 10], fill="#a8d8ea")
        d.point((centro - 1, 7), fill="#ffffff")
    d.line([(7, 8), (9, 8)], fill=TINTA)
    d.line([(1, 7), (2, 7)], fill=TINTA)
    d.line([(14, 7), (15, 7)], fill=TINTA)
    return im


def avance_libro() -> Image.Image:
    im, d = lienzo()
    d.polygon([(1, 3), (7, 4), (7, 13), (1, 12)], fill=CREMA, outline="#6b4423")
    d.polygon([(8, 4), (15, 3), (15, 12), (8, 13)], fill="#fffdf5", outline="#6b4423")
    d.line([(7, 4), (7, 13)], fill="#6b4423")
    for y in (6, 8, 10):
        d.line([(3, y), (6, y)], fill="#8a8f8a")
        d.line([(9, y), (13, y)], fill="#8a8f8a")
    return im


def avance_barca() -> Image.Image:
    im, d = lienzo()
    d.polygon([(1, 10), (14, 10), (12, 13), (3, 13)], fill=MADERA)
    d.line([(1, 10), (14, 10)], fill="#5f3d1d")
    d.line([(4, 3), (4, 10)], fill="#6b4423")
    d.polygon([(4, 3), (9, 6), (4, 9)], fill=CREMA)
    d.line([(9, 5), (9, 10)], fill="#6b4423")
    d.polygon([(9, 5), (13, 7), (9, 9)], fill=CREMA)
    d.line([(1, 14), (15, 14)], fill="#3f76a8")
    return im


def avance_casas() -> Image.Image:
    im, d = lienzo()
    for x, alto in ((1, 8), (6, 6), (11, 8)):
        d.polygon([(x - 1, 8), (x + 2, alto), (x + 5, 8)], fill="#a9743f")
        d.rectangle([x, 8, x + 4, 14], fill=CREMA, outline="#8a7a5a")
        d.rectangle([x + 1, 11, x + 2, 14], fill="#3a2a20")
    d.point((8, 3), fill=FUEGO)
    return im


def avance_piedra() -> Image.Image:
    im, d = lienzo()
    d.rectangle([1, 2, 14, 14], fill=PIEDRA, outline="#4a514a")
    d.polygon([(1, 2), (6, 2), (4, 6), (6, 9), (3, 14), (1, 14)], fill="#9aa09a")
    d.line([(8, 2), (7, 6), (10, 8), (8, 12), (10, 14)], fill="#2f7a3a")
    d.line([(9, 2), (8, 6), (11, 8)], fill=VERDE)
    for x, y in ((4, 4), (12, 12)):
        d.point((x, y), fill=PIEDRA_OSCURA)
    return im


def avance_lingote() -> Image.Image:
    im, d = lienzo()
    d.polygon([(2, 8), (13, 8), (11, 12), (4, 12)], fill=PIEDRA)
    d.line([(2, 8), (13, 8)], fill="#c9d0c9")
    d.rectangle([4, 12, 11, 13], fill=PIEDRA_OSCURA)
    for x, y in ((3, 4), (8, 2), (12, 5)):
        d.point((x, y), fill=FUEGO)
        d.point((x + 1, y + 1), fill="#f7d34a")
    return im


def avance_planeta() -> Image.Image:
    im, d = lienzo()
    d.ellipse([0, 7, 15, 10], outline="#d9c48a")
    d.ellipse([3, 2, 12, 11], fill="#2e6b4a", outline="#1f4a34")
    d.ellipse([5, 4, 8, 7], fill="#3f8f5b")
    d.point((6, 6), fill="#9bf58a")
    d.point((10, 8), fill="#1f4a34")
    d.point((8, 9), fill="#1f4a34")
    return im


def avance_timon() -> Image.Image:
    im, d = lienzo()
    d.ellipse([4, 4, 11, 11], outline=MADERA)
    d.ellipse([6, 6, 9, 9], fill="#6b4423")
    for x, y in ((7, 1), (7, 14), (1, 7), (14, 7)):
        d.line([(7, 7), (x, y)], fill=MADERA)
    for x, y in ((2, 2), (13, 2), (2, 13), (13, 13)):
        d.line([(7, 7), (x, y)], fill="#a9743f")
    d.point((7, 7), fill=ORO)
    return im


def avance_ojo() -> Image.Image:
    im, d = lienzo()
    d.ellipse([1, 4, 14, 11], fill="#dff2c9", outline=TINTA)
    d.ellipse([5, 5, 10, 10], fill="#2e8b57")
    d.ellipse([6, 6, 9, 9], fill="#0f1417")
    d.point((7, 7), fill=VERDE_CLARO)
    d.point((8, 8), fill="#2e8b57")
    return im


def avance_ancla() -> Image.Image:
    im, d = lienzo()
    d.ellipse([6, 1, 9, 4], outline=TINTA)
    d.line([(8, 4), (8, 12)], fill=TINTA)
    d.line([(5, 5), (11, 5)], fill=TINTA)
    d.arc([2, 7, 13, 14], 0, 180, fill=TINTA)
    d.line([(2, 8), (2, 11)], fill=TINTA)
    d.line([(13, 8), (13, 11)], fill=TINTA)
    d.point((5, 12), fill=TINTA)
    d.point((10, 12), fill=TINTA)
    return im


ICONOS = [
    ("avance_01", avance_campana),      # aldea
    ("avance_02", avance_hoguera),      # despertar
    ("avance_03", avance_matraz),       # fluido
    ("avance_04", avance_gafas),        # gafas
    ("avance_05", avance_libro),        # historias
    ("avance_06", medusa),              # medusa
    ("avance_07", avance_barca),        # perseus
    ("avance_08", avance_casas),        # pueblo
    ("avance_09", avance_piedra),       # raiz
    ("avance_10", avance_lingote),      # stone-wars
    ("avance_11", avance_planeta),      # terraforming
    ("avance_12", avance_timon),        # tripulacion
    ("avance_13", avance_ojo),          # why
    ("avance_14", avance_ancla),        # zarpe
]

# Nombres de archivo de los avances, en el orden de ICONOS: el cmd es 7400 + n.
AVANCES = [
    "aldea", "despertar", "fluido", "gafas", "historias", "medusa", "perseus",
    "pueblo", "raiz", "stone-wars", "terraforming", "tripulacion", "why", "zarpe",
]

CARTAS = [
    "As de picas", "Dos de picas", "Tres de picas", "Cuatro de picas", "Cinco de picas",
    "Seis de picas", "Siete de picas", "Ocho de picas", "Nueve de picas", "Diez de picas",
    "Jota de picas", "Reina de picas", "Rey de picas",
    "As de corazones", "Dos de corazones", "Tres de corazones", "Cuatro de corazones",
    "Cinco de corazones", "Seis de corazones", "Siete de corazones", "Ocho de corazones",
    "Nueve de corazones", "Diez de corazones", "Jota de corazones", "Reina de corazones",
    "Rey de corazones",
    "As de diamantes", "Dos de diamantes", "Tres de diamantes", "Cuatro de diamantes",
    "Cinco de diamantes", "Seis de diamantes", "Siete de diamantes", "Ocho de diamantes",
    "Nueve de diamantes", "Diez de diamantes", "Jota de diamantes", "Reina de diamantes",
    "Rey de diamantes",
    "As de treboles", "Dos de treboles", "Tres de treboles", "Cuatro de treboles",
    "Cinco de treboles", "Seis de treboles", "Siete de treboles", "Ocho de treboles",
    "Nueve de treboles", "Diez de treboles", "Jota de treboles", "Reina de treboles",
    "Rey de treboles",
]

FICHAS = [
    (1, "#d8d8d8", "#f0f0f0", "#20242a"),
    (5, "#b03a2e", "#d9534f", "#ffffff"),
    (10, "#2e6fd8", "#5b93ea", "#ffffff"),
    (25, "#2e8b57", "#4cb374", "#ffffff"),
    (100, "#1b1b1b", "#3a3a3a", ORO_CLARO),
]


def escribir_modelo(nombre: str) -> None:
    """Un modelo de ítem plano: la textura y nada más."""
    MODELOS.mkdir(parents=True, exist_ok=True)
    datos = {
        "parent": "minecraft:item/generated",
        "textures": {"layer0": f"swr:item/{nombre}"},
    }
    (MODELOS / f"{nombre}.json").write_text(
        json.dumps(datos, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )


def escribir_base(item: str, textura: str, overrides: list[tuple[int, str]]) -> None:
    """Modelo del ítem de vainilla, con sus overrides por custom_model_data."""
    MODELOS_VANILLA.mkdir(parents=True, exist_ok=True)
    datos = {
        "parent": "minecraft:item/generated",
        "textures": {"layer0": textura},
        "overrides": [
            {"predicate": {"custom_model_data": cmd}, "model": f"swr:item/{nombre}"}
            for cmd, nombre in overrides
        ],
    }
    (MODELOS_VANILLA / f"{item}.json").write_text(
        json.dumps(datos, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )


def main() -> None:
    # B1
    guardar("medusa", medusa())
    escribir_modelo("medusa")
    escribir_base("heart_of_the_sea", "minecraft:item/heart_of_the_sea", [(7101, "medusa")])

    # B2: 52 caras, el dorso y cinco fichas
    for numero, nombre in enumerate(CARTAS, start=1):
        clave = f"carta_{numero:02d}"
        guardar(clave, naipe(numero))
        escribir_modelo(clave)
    guardar("carta_dorso", dorso())
    escribir_modelo("carta_dorso")

    for numero, color, interior, tinta in FICHAS:
        clave = f"ficha_{numero}"
        guardar(clave, ficha(numero, color, interior, tinta))
        escribir_modelo(clave)

    # B11
    guardar("denario", denario())
    guardar("billete", billete())
    escribir_modelo("denario")
    escribir_modelo("billete")

    # B7
    for clave, dibujo in ICONOS:
        guardar(clave, dibujo())
        escribir_modelo(clave)

    papel = [(100, "carta_dorso")]
    papel += [(100 + n, f"carta_{n:02d}") for n in range(1, 53)]
    papel += [(7301, "billete")]
    papel += [(7400 + n, clave) for n, (clave, _) in enumerate(ICONOS, start=1)]
    escribir_base("paper", "minecraft:item/paper", papel)

    oro = [(7201, "denario")]
    oro += [(7210 + n, f"ficha_{numero}") for n, (numero, *_ ) in enumerate(FICHAS, start=1)]
    escribir_base("gold_nugget", "minecraft:item/gold_nugget", oro)

    destino = empaquetar()
    print(
        f"tramo B: {53 + len(FICHAS) + 3 + len(ICONOS)} texturas, "
        f"{len(papel) + len(oro) + 1} modelos con override, {destino.name}"
    )


if __name__ == "__main__":
    main()
