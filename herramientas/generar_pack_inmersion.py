#!/usr/bin/env python3
"""Genera el pack de recursos 'Reino de la Ciencia' en ./pack-inmersion.

Dibuja 8 cuadros (sustituyen a los cuadros vanilla, mismo tamano en bloques) y
reescribe los textos del menu principal. Salida lista para resourcepacks/:

    pack-inmersion/                  <- fuente, editable
    pack-inmersion/ReinoDeLaCiencia.zip

Uso: python3 herramientas/generar_pack_inmersion.py
Requiere Pillow (python3 -m pip install --user pillow).
"""
import pathlib
import zipfile

from PIL import Image, ImageDraw

BASE = pathlib.Path(__file__).resolve().parent.parent / "pack-inmersion"
ASSETS = BASE / "assets" / "minecraft"
CUADROS = ASSETS / "textures" / "painting"

PACK_FORMAT = 34  # Minecraft 1.21 / 1.21.1

# paleta de la serie: piedra, liquido milagroso, madera, cielo, crema, oro
PIEDRA = "#8a8f8a"
PIEDRA_OSCURA = "#5f665f"
NEGRO = "#151a1d"
VERDE = "#5fd35a"
VERDE_CLARO = "#9bf58a"
CIELO = "#a8d8ea"
MADERA = "#a9743f"
CREMA = "#efe6cf"
ORO = "#e0b23c"
FUEGO = "#e8722f"
TINTA = "#22262a"


def lienzo(w, h, fondo=NEGRO):
    im = Image.new("RGB", (w, h), fondo)
    return im, ImageDraw.Draw(im)


def guardar(nombre, im):
    CUADROS.mkdir(parents=True, exist_ok=True)
    im.save(CUADROS / f"{nombre}.png")


def matraz():
    """1x1: el matraz de Senku con liquido milagroso."""
    im, d = lienzo(16, 16)
    d.rectangle([0, 13, 15, 15], fill="#2b3238")          # mesa
    d.rectangle([6, 1, 10, 2], fill="#e6f2f4")            # boca
    d.rectangle([7, 2, 9, 7], fill="#c9d6d8")             # cuello
    d.ellipse([3, 6, 13, 15], fill="#c9d6d8")             # cuerpo
    d.ellipse([4, 9, 12, 14], fill=VERDE)                 # liquido
    d.ellipse([4, 9, 12, 11], fill=VERDE_CLARO)
    d.line([6, 8, 6, 10], fill="#ffffff")                 # brillo del vidrio
    for x, y in ((7, 12), (9, 13), (10, 11)):
        d.point((x, y), fill="#d6ffc4")                   # burbujas
    return im


def engranaje():
    """1x1: la rueda dentada, el simbolo del reino."""
    im, d = lienzo(16, 16, "#14181b")
    for x in (6, 9):
        d.rectangle([x, 0, x + 1, 15], fill=ORO)
    for y in (6, 9):
        d.rectangle([0, y, 15, y + 1], fill=ORO)
    d.ellipse([3, 3, 12, 12], fill="#b8892a")
    d.ellipse([5, 5, 10, 10], fill="#14181b")
    d.point((7, 7), fill=CREMA)
    return im


def aldea():
    """2x2: la aldea Ishigami con el puente y la hoguera."""
    im, d = lienzo(32, 32)
    d.rectangle([0, 0, 31, 13], fill=CIELO)
    d.rectangle([0, 10, 31, 13], fill="#cfe8f2")
    d.polygon([(0, 22), (11, 6), (22, 22)], fill=PIEDRA)
    d.polygon([(11, 6), (15, 11), (8, 11)], fill="#b9c0b9")  # nieve de la cima
    d.rectangle([0, 18, 31, 31], fill="#5d7a45")
    d.polygon([(4, 19), (13, 19), (8, 14)], fill=MADERA)     # tejado 1
    d.rectangle([5, 19, 12, 26], fill=CREMA)
    d.polygon([(18, 21), (27, 21), (22, 16)], fill=MADERA)  # tejado 2
    d.rectangle([19, 21, 26, 27], fill=CREMA)
    d.rectangle([7, 23, 9, 26], fill=TINTA)                 # puertas
    d.rectangle([21, 24, 23, 27], fill=TINTA)
    d.rectangle([13, 28, 19, 29], fill=MADERA)              # puente
    for x, y in ((14, 27), (16, 26), (18, 27)):
        d.point((x, y), fill="#c9d6d8")                     # humo
    d.rectangle([15, 29, 17, 31], fill=FUEGO)               # hoguera
    return im


def petrificado():
    """4x4: la cara que se vuelve piedra, con las grietas verdes."""
    im, d = lienzo(64, 64, "#1a1f22")
    d.ellipse([12, 6, 52, 48], fill=PIEDRA)                 # cabeza
    d.ellipse([10, 10, 20, 26], fill=PIEDRA_OSCURA)         # sombra lateral
    d.polygon([(4, 64), (16, 50), (48, 50), (60, 64)], fill=PIEDRA_OSCURA)
    d.ellipse([22, 22, 28, 27], fill=TINTA)                 # ojos
    d.ellipse([38, 22, 44, 27], fill=TINTA)
    d.rectangle([24, 38, 42, 40], fill=TINTA)               # boca
    grietas = [
        [(16, 12), (22, 20), (19, 28), (25, 34)],
        [(46, 10), (41, 18), (45, 26), (39, 33)],
        [(30, 4), (32, 12), (29, 16)],
        [(20, 44), (26, 52), (24, 60)],
        [(44, 46), (38, 54), (40, 62)],
    ]
    for linea in grietas:
        d.line(linea, fill=VERDE_CLARO, width=1)
        d.line([(x + 1, y) for x, y in linea], fill="#2f7a3a", width=1)
    for x, y in ((34, 12), (30, 46), (24, 18)):
        d.point((x, y), fill="#d6ffc4")
    return im


def telescopio():
    """1x2: el telescopio de fluorita apuntando al cielo."""
    im, d = lienzo(16, 32)
    for i, color in enumerate(("#101a2a", "#16243a", "#1d2f4a", "#263a58")):
        d.rectangle([0, i * 5, 15, i * 5 + 4], fill=color)
    for x, y in ((2, 3), (12, 6), (6, 12), (14, 15), (3, 20), (9, 24)):
        d.point((x, y), fill=CREMA)                          # estrellas
    d.polygon([(4, 8), (12, 4), (14, 8), (6, 12)], fill=ORO)  # tubo
    d.polygon([(12, 4), (14, 8), (15, 7), (13, 3)], fill="#b8892a")
    d.line([(9, 10), (6, 26)], fill=MADERA, width=1)        # tripode
    d.line([(9, 10), (13, 26)], fill=MADERA, width=1)
    d.line([(9, 10), (9, 27)], fill="#8a5a2f", width=1)
    d.rectangle([0, 27, 15, 31], fill="#2f3a2a")            # suelo
    return im


def retrato():
    """2x4: retrato de Senku, bata y pelo de punta."""
    im, d = lienzo(32, 64, CREMA)
    d.rectangle([0, 0, 31, 63], outline="#c9bda0", width=1)
    d.polygon([(4, 64), (6, 44), (26, 44), (28, 64)], fill="#f4f7f7")  # bata
    d.polygon([(14, 44), (18, 44), (16, 56)], fill="#d9e3e3")          # cuello
    d.rectangle([13, 50, 19, 52], fill="#8a8f8a")                      # peto
    d.ellipse([9, 24, 23, 46], fill="#f0c9a0")                         # cara
    d.polygon([  # pelo en pico
        (7, 26), (9, 14), (12, 22), (14, 10), (17, 20), (20, 12),
        (22, 22), (25, 18), (23, 28), (8, 28),
    ], fill="#dff2c9")
    d.line([(10, 30), (13, 30)], fill=TINTA)                # cejas
    d.line([(19, 30), (22, 30)], fill=TINTA)
    d.rectangle([11, 33, 12, 34], fill=TINTA)               # ojos
    d.rectangle([20, 33, 21, 34], fill=TINTA)
    d.line([(14, 40), (18, 40)], fill="#b0705a")            # boca
    d.rectangle([24, 52, 26, 56], fill=VERDE)               # matraz en el bolsillo
    return im


def brote():
    """1x1: la vida que vuelve entre la piedra."""
    im, d = lienzo(16, 16, PIEDRA_OSCURA)
    for x in range(0, 16, 4):
        d.line([(x, 12), (x + 3, 15)], fill="#4a514a")
    d.rectangle([0, 12, 15, 15], fill="#3f453f")
    d.line([(7, 12), (7, 5)], fill="#3f7a3a", width=1)      # tallo
    d.polygon([(7, 6), (2, 3), (3, 8)], fill=VERDE)         # hojas
    d.polygon([(8, 7), (13, 4), (12, 9)], fill=VERDE_CLARO)
    return im


def grietas():
    """1x1: el mundo después de la petrificación."""
    im, d = lienzo(16, 16, PIEDRA)
    d.rectangle([0, 0, 15, 15], fill=PIEDRA)
    for linea in (
        [(0, 4), (5, 6), (4, 11), (9, 13), (15, 12)],
        [(8, 0), (9, 5), (13, 7), (12, 14)],
        [(2, 14), (2, 9), (6, 8)],
    ):
        d.line(linea, fill=PIEDRA_OSCURA, width=1)
    d.rectangle([10, 2, 11, 3], fill="#4f7a45")             # liquen
    d.rectangle([5, 12, 6, 13], fill="#4f7a45")
    return im


def perseus():
    """3x2: el barco de Ryusui, velas desplegadas rumbo a la isla del tesoro."""
    im, d = lienzo(48, 32)
    d.rectangle([0, 0, 47, 18], fill=CIELO)
    d.rectangle([0, 15, 47, 18], fill="#cfe8f2")
    d.ellipse([36, 2, 44, 10], fill=ORO)                     # sol
    d.rectangle([0, 22, 47, 31], fill="#204a72")             # mar
    for x in range(0, 48, 6):
        d.line([(x, 25), (x + 4, 25)], fill="#3f76a8")
        d.line([(x + 2, 29), (x + 6, 29)], fill="#3f76a8")
    d.rectangle([10, 17, 38, 22], fill="#8a5a2f")            # borda
    d.polygon([(6, 22), (42, 22), (36, 27), (12, 27)], fill=MADERA)
    for x in (16, 24, 32):                                   # mastiles y velas
        d.line([(x, 5), (x, 19)], fill="#6b4423")
        d.polygon([(x, 6), (x + 7, 11), (x, 17)], fill=CREMA)
    d.polygon([(2, 19), (9, 15), (9, 21)], fill=CREMA)        # bauprés
    d.rectangle([0, 30, 47, 31], fill="#16324f")
    return im


def medusa():
    """1x1: el dispositivo de petrificacion, con su brillo verde."""
    im, d = lienzo(16, 16, "#120a1a")
    d.ellipse([2, 3, 13, 14], fill="#3a2352")
    d.ellipse([3, 4, 12, 13], fill="#55307a")
    d.ellipse([5, 6, 10, 11], fill=VERDE)
    d.ellipse([6, 7, 9, 10], fill=VERDE_CLARO)
    d.line([(8, 0), (8, 3)], fill="#9a86b8")
    d.point((7, 8), fill="#ffffff")
    for x, y in ((3, 5), (12, 9), (6, 13)):
        d.point((x, y), fill="#8f6fbd")
    return im


def destello():
    """2x2: el 1 de abril. La luz verde cae sobre las siluetas y las deja quietas."""
    im, d = lienzo(32, 32, "#0f1417")
    for y in range(0, 32, 4):
        color = "#1c3b26" if (y // 4) % 2 else "#17301f"
        d.rectangle([0, y, 31, y + 3], fill=color)
    d.ellipse([4, -6, 28, 14], fill="#7bf58a")
    d.ellipse([8, -2, 24, 10], fill="#d6ffc4")
    for x, alto in ((6, 10), (12, 13), (18, 9), (24, 12)):
        d.rectangle([x, 32 - alto, x + 3, 31], fill="#6f7671")      # siluetas de piedra
        d.rectangle([x, 32 - alto - 3, x + 3, 32 - alto], fill="#8a8f8a")
    for x in (3, 15, 21, 27):
        d.line([(x, 18), (x + 2, 24)], fill="#9bf58a")              # grietas verdes
    return im


CUADROS_VANILLA = [
    ("kebab", 1, 1, matraz),        # 16x16
    ("aztec", 1, 1, engranaje),     # 16x16
    ("plants", 1, 1, brote),        # 16x16
    ("wasteland", 1, 1, grietas),   # 16x16
    ("scene", 2, 2, aldea),         # 32x32
    ("wanderer", 1, 2, telescopio), # 16x32
    ("bust", 2, 4, retrato),        # 32x64
    ("skull", 4, 4, petrificado),   # 64x64
]

CUADROS_PROPIOS = [
    ("perseus", 3, 2, perseus),     # 48x32
    ("medusa", 1, 1, medusa),       # 16x16
    ("destello", 2, 2, destello),   # 32x32
]

SPLASHES = """¡10 mil millones por ciento!
Senku aprobaría esta partida
No es magia, es química
La ciencia no se detiene
Hecho a mano, sin mods de magia
Sulfamidas para todos
Un paso cada vez
Chrome estaría emocionado
Kaseki lo haría mejor
Ryusui dice: zarpa ya
Ruri te leería el futuro
¡Despetrifícate!
Piedra, vidrio, hierro: civilización
La isla no se va a explorar sola
Fuego, arcilla, horno
Nada de teletransportes
Cada bloque es un experimento
¿Ya cerraste la era 1?
Millones de años de historia
Taiju lo haría corriendo
Yuzuriha lo cosería
Gen está mirando
El reino empieza con una antorcha
Cuidado con el agua sucia
Aguanta la primera noche
Tsukasa no entraría aquí
Ciencia para todos
Motor, cable y vapor
Huele a progreso
Modo supervivencia, siempre
Chromium, no Chrome
¡Al puerto! ¡Al mundo!
Construye, no destruyas
Un invento por sesión
La aldea necesita leña
Tu colonia te espera
Pon el belcro, digo el cable
La petrificación no detiene el amor
Steam, ciclo Rankine
La rueda también cuenta
Diez mil millones de gracias
What a beautiful world
3700 anos contando
Ruri ya te lo conto
La medusa no se toca
Kinro necesita gafas
La aldea viene de la ISS
El Perseus es un proyecto, no un barco
El platino paga el barco
Gen gana con la radio
Hyoga no se convierte
why
Un paso cada vez, pero todos a la vez
"""


def empaquetar():
    """Rehace ReinoDeLaCiencia.zip con lo que hay ahora en pack-inmersion/.

    Lo llaman este generador y el del tramo B: el zip es lo que se copia a
    resourcepacks/, así que siempre tiene que salir del árbol de fuentes.
    """
    destino = BASE / "ReinoDeLaCiencia.zip"
    with zipfile.ZipFile(destino, "w", zipfile.ZIP_DEFLATED) as z:
        for archivo in sorted(BASE.rglob("*")):
            if archivo.is_dir() or archivo.resolve() == destino.resolve():
                continue
            if archivo.suffix in {".zip", ".md"}:
                continue
            z.write(archivo, archivo.relative_to(BASE).as_posix())
    print(f"zip {destino.name}: {destino.stat().st_size} B")
    return destino


def main():
    for nombre, ancho, alto, dibujo in CUADROS_VANILLA:
        im = dibujo()
        esperado = (ancho * 16, alto * 16)
        if im.size != esperado:
            raise SystemExit(f"{nombre}: {im.size} != {esperado}")
        guardar(nombre, im)
        print(f"cuadro {nombre}.png {im.size[0]}x{im.size[1]} ({ancho}x{alto} bloques)")

    for nombre, ancho, alto, dibujo in CUADROS_PROPIOS:
        im = dibujo()
        esperado = (ancho * 16, alto * 16)
        if im.size != esperado:
            raise SystemExit(f"{nombre}: {im.size} != {esperado}")
        guardar(nombre, im)
        print(f"cuadro propio {nombre}.png {im.size[0]}x{im.size[1]} ({ancho}x{alto} bloques)")

    (ASSETS / "texts").mkdir(parents=True, exist_ok=True)
    (ASSETS / "texts" / "splashes.txt").write_text(SPLASHES, encoding="utf-8")

    (BASE / "pack.mcmeta").write_text(
        '{\n  "pack": {\n'
        f'    "pack_format": {PACK_FORMAT},\n'
        '    "description": "Reino de la Ciencia - cuadros, textos e iconos del pack Stone World Reborn"\n'
        "  }\n}\n",
        encoding="utf-8",
    )

    empaquetar()


if __name__ == "__main__":
    main()
