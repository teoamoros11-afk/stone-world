#!/usr/bin/env python3
"""Genera las texturas PNG 16x16 de los mods propios del pack.

    python3 herramientas/generar_texturas_mod.py

Salidas:
  optics-mod/src/main/resources/assets/stoneoptics/textures/block/polishing_table.png
  optics-mod/src/main/resources/assets/stoneoptics/textures/item/kinro_glasses.png
  crank-dynamo/src/main/resources/assets/stoneindustry/textures/block/crank_dynamo.png

Requiere Pillow. Todo se dibuja por codigo, sin imagenes externas ni derechos de autor.
"""
import pathlib

from PIL import Image, ImageDraw

RAIZ = pathlib.Path(__file__).resolve().parent.parent

MADERA = "#8a5a2f"
MADERA_CLARA = "#a9743f"
METAL = "#9aa3a8"
METAL_OSCURO = "#5f665f"
VIDRIO = "#cfe8f2"
VERDE = "#5fd35a"
ORO = "#e0b23c"
TINTA = "#22262a"


def tabla_pulido():
    """Banco de pulido: tabla de madera, abrasivo y una lente secandose."""
    im = Image.new("RGB", (16, 16), MADERA)
    d = ImageDraw.Draw(im)
    for y in (0, 3, 6, 9):
        d.line([(0, y), (15, y)], fill=MADERA_CLARA)
    d.rectangle([0, 0, 15, 1], fill="#6b4423")
    # reguero de agua y abrasivo
    d.rectangle([2, 4, 13, 11], fill="#6b5424")
    d.point((4, 6), fill="#a3905a")
    d.point((7, 9), fill="#a3905a")
    d.point((10, 5), fill="#a3905a")
    # lente sobre el banco
    d.ellipse([5, 5, 11, 11], fill=VIDRIO)
    d.ellipse([6, 6, 10, 10], fill="#eaf7fb")
    d.point((8, 8), fill=VERDE)
    # soporte metalico
    d.rectangle([12, 12, 14, 15], fill=METAL)
    d.rectangle([2, 12, 4, 15], fill=METAL_OSCURO)
    return im


def gafas():
    """Gafas de Kinro: montura de oro, dos lentes pulidas y una cinta."""
    im = Image.new("RGBA", (16, 16), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([1, 6, 14, 7], fill=ORO)          # puente
    d.ellipse([1, 5, 7, 11], fill=METAL_OSCURO)   # aro izquierdo
    d.ellipse([2, 6, 6, 10], fill=VIDRIO)
    d.ellipse([9, 5, 15, 11], fill=METAL_OSCURO)  # aro derecho
    d.ellipse([10, 6, 14, 10], fill=VIDRIO)
    d.line([(7, 7), (9, 7)], fill=ORO)
    d.line([(1, 5), (0, 3)], fill=ORO)            # patillas
    d.line([(15, 5), (15, 3)], fill=ORO)
    d.rectangle([3, 7, 4, 8], fill="#ffffff")     # brillo
    d.rectangle([11, 7, 12, 8], fill="#ffffff")
    d.line([(5, 12), (11, 12)], fill=TINTA)       # cinta del guardia
    return im


def dinamo():
    """Dinamo de manivela: cuerpo de cobre, bobina y manivela."""
    im = Image.new("RGB", (16, 16), METAL)
    d = ImageDraw.Draw(im)
    d.rectangle([0, 0, 15, 15], fill=METAL)
    d.rectangle([1, 1, 14, 14], fill="#b8562f")   # cuerpo de cobre
    for y in range(3, 13, 2):
        d.line([(2, y), (11, y)], fill="#d2703f")  # bobina
    d.rectangle([2, 3, 11, 12], outline="#7d3a20")
    d.rectangle([12, 6, 15, 9], fill=METAL_OSCURO)  # eje
    d.line([(13, 6), (15, 2)], fill="#3b4145", width=1)  # manivela
    d.rectangle([14, 1, 15, 2], fill=TINTA)
    d.point((4, 4), fill=ORO)
    return im


def sulfamida():
    """Sulfamida: frasquito de vidrio con el polvo blanco y su corcho."""
    im = Image.new("RGBA", (16, 16), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([4, 6, 11, 14], fill="#e6f1f4", outline="#9fb4bb")  # cristal
    d.rectangle([5, 10, 10, 13], fill="#fbfdfe")                    # polvo blanco
    d.point((6, 11), fill="#d7e3e7")
    d.point((9, 12), fill="#d7e3e7")
    d.rectangle([6, 3, 9, 5], fill="#8a6a3f", outline="#5f4726")     # corcho
    d.line([(5, 7), (5, 13)], fill="#ffffff")                        # brillo
    return im


def jeringa():
    """Jeringa: cuerpo de cristal, liquido rojo y aguja metalica."""
    im = Image.new("RGBA", (16, 16), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([6, 5, 9, 12], fill="#dbe8ec", outline="#9fb4bb")  # cuerpo
    d.rectangle([7, 8, 8, 11], fill="#b8323f")                      # sulfamida
    d.rectangle([5, 12, 10, 13], fill="#a7b4b9")                    # base del embolo
    d.line([(7, 2), (7, 4)], fill="#cfd8dc")                        # aguja
    d.point((7, 2), fill="#9aa3a8")
    d.line([(6, 6), (6, 11)], fill="#ffffff")                       # brillo
    return im


def main():
    destinos = [
        (RAIZ / "optics-mod/src/main/resources/assets/stoneoptics/textures/block/polishing_table.png", tabla_pulido(), "RGB"),
        (RAIZ / "optics-mod/src/main/resources/assets/stoneoptics/textures/item/kinro_glasses.png", gafas(), "RGBA"),
        (RAIZ / "crank-dynamo/src/main/resources/assets/stoneindustry/textures/block/crank_dynamo.png", dinamo(), "RGB"),
        (RAIZ / "pharmacy-mod/src/main/resources/assets/stonepharmacy/textures/item/sulfamida.png", sulfamida(), "RGBA"),
        (RAIZ / "pharmacy-mod/src/main/resources/assets/stonepharmacy/textures/item/jeringa.png", jeringa(), "RGBA"),
    ]
    for ruta, im, _ in destinos:
        ruta.parent.mkdir(parents=True, exist_ok=True)
        im.save(ruta)
        print(f"{ruta.relative_to(RAIZ)} {im.size[0]}x{im.size[1]}")


if __name__ == "__main__":
    main()
