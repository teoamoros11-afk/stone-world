"""Tramo B: texturas de medusa, baraja, fichas, moneda e iconos de avances.

Lo que se comprueba aquí es el dato: que cada PNG existe y mide 16x16, que cada
override apunta a un modelo que existe, que no hay dos mandos con el mismo
`custom_model_data` y que los 14 avances llevan su icono. El aspecto —si la
carta se lee en la mano— necesita cliente y no se puede afirmar desde aquí.
"""

from __future__ import annotations

import json
import struct
import zipfile
from pathlib import Path

from validador import revisar

RAIZ = Path(__file__).resolve().parent.parent
PACK = RAIZ / "pack-inmersion"
ASSETS = PACK / "assets"
ITEMS = ASSETS / "swr" / "textures" / "item"
MODELOS = ASSETS / "swr" / "models" / "item"
VANILLA = ASSETS / "minecraft" / "models" / "item"
ZIP = PACK / "ReinoDeLaCiencia.zip"
PANEL = RAIZ / "panel" / "data" / "swr"
AVANCES = PANEL / "advancement" / "serie"


def _tamano(png: Path) -> tuple[int, int]:
    datos = png.read_bytes()
    assert datos[:8] == b"\x89PNG\r\n\x1a\n", f"{png.name} no es un PNG"
    return struct.unpack(">II", datos[16:24])


def _modelo(ruta: Path) -> dict:
    return json.loads(ruta.read_text(encoding="utf-8"))


def _overrides(item: str) -> dict[int, str]:
    return {
        o["predicate"]["custom_model_data"]: o["model"]
        for o in _modelo(VANILLA / f"{item}.json")["overrides"]
    }


def test_las_texturas_de_item_son_todas_de_16x16():
    pngs = sorted(ITEMS.glob("*.png"))
    assert len(pngs) == 75, f"hay {len(pngs)} texturas de ítem, no 75"
    malas = {p.name: _tamano(p) for p in pngs if _tamano(p) != (16, 16)}
    assert not malas, f"texturas que no miden 16x16: {malas}"


def test_estan_las_52_caras_y_el_dorso():
    caras = sorted(ITEMS.glob("carta_*.png"))
    assert len(caras) == 53  # 52 caras + carta_dorso
    assert (ITEMS / "carta_dorso.png").is_file()


def test_cada_carta_tiene_modelo_y_override():
    overrides = _overrides("paper")
    for numero in range(1, 53):
        clave = f"carta_{numero:02d}"
        assert (MODELOS / f"{clave}.json").is_file()
        assert overrides[100 + numero] == f"swr:item/{clave}"
    assert overrides[100] == "swr:item/carta_dorso"


def test_la_medusa_es_el_corazon_del_mar_con_su_modelo():
    assert _overrides("heart_of_the_sea")[7101] == "swr:item/medusa"
    assert (MODELOS / "medusa.json").is_file()
    assert (ITEMS / "medusa.png").is_file()


def test_el_denario_el_billete_y_las_fichas():
    assert _overrides("gold_nugget")[7201] == "swr:item/denario"
    assert _overrides("paper")[7301] == "swr:item/billete"
    overrides = _overrides("gold_nugget")
    for numero, cmd in zip((1, 5, 10, 25, 100), range(7211, 7216)):
        assert overrides[cmd] == f"swr:item/ficha_{numero}"
        assert (ITEMS / f"ficha_{numero}.png").is_file()


def test_no_hay_custom_model_data_repetido():
    for item in ("paper", "gold_nugget", "heart_of_the_sea"):
        cmds = [o["predicate"]["custom_model_data"] for o in _modelo(VANILLA / f"{item}.json")["overrides"]]
        assert len(cmds) == len(set(cmds)), f"{item} repite un custom_model_data"


def test_los_14_avances_llevan_su_icono():
    iconos = {}
    for ruta in sorted(AVANCES.glob("*.json")):
        icono = json.loads(ruta.read_text(encoding="utf-8"))["display"]["icon"]
        assert icono["id"] == "minecraft:paper", f"{ruta.stem} no usa el papel de iconos"
        iconos[ruta.stem] = icono["components"]["minecraft:custom_model_data"]
    assert len(iconos) == 14
    assert sorted(iconos.values()) == list(range(7401, 7415))


def test_cada_icono_apunta_a_un_modelo_que_existe():
    overrides = _overrides("paper")
    for cmd in range(7401, 7415):
        modelo = overrides[cmd]
        ruta = MODELOS / f"{modelo.split('item/', 1)[1]}.json"
        assert ruta.is_file(), f"falta {ruta.name}"
        textura = _modelo(ruta)["textures"]["layer0"].split(":", 1)[1]
        assert (ASSETS / "swr" / "textures" / f"{textura}.png").is_file()


def test_el_pack_da_la_medusa_con_su_textura():
    cuerpo = (PANEL / "function" / "serie" / "medusa.mcfunction").read_text(encoding="utf-8")
    assert "custom_model_data=7101" in cuerpo
    assert "heart_of_the_sea" in cuerpo


def test_las_piezas_de_la_moneda_y_la_baraja_se_pueden_ver():
    objetos = (PANEL / "function" / "serie" / "moneda" / "objetos.mcfunction").read_text(encoding="utf-8")
    assert "custom_model_data=7201" in objetos
    assert "custom_model_data=7301" in objetos

    muestra = (PANEL / "function" / "bar" / "poker" / "muestra.mcfunction").read_text(encoding="utf-8")
    for cmd in (101, 126, 138, 150, 110, 100):
        assert f"custom_model_data={cmd}" in muestra

    fichas = (PANEL / "function" / "bar" / "poker" / "fichas_objeto.mcfunction").read_text(encoding="utf-8")
    for cmd in range(7211, 7216):
        assert f"custom_model_data={cmd}" in fichas


def test_el_validador_acepta_el_resource_pack():
    errores = [p for p in revisar(PACK) if p.nivel == "error"]
    assert not errores, "\n".join(str(p) for p in errores)


def test_el_zip_lleva_las_texturas_y_los_modelos():
    with zipfile.ZipFile(ZIP) as z:
        nombres = set(z.namelist())
    assert "assets/swr/textures/item/medusa.png" in nombres
    assert "assets/swr/textures/item/carta_01.png" in nombres
    assert "assets/swr/textures/item/carta_52.png" in nombres
    assert "assets/swr/textures/item/avance_14.png" in nombres
    assert "assets/minecraft/models/item/paper.json" in nombres
    assert "assets/swr/models/item/carta_52.json" in nombres


def test_faltan_marca_las_cuatro_piezas_del_tramo_b():
    texto = (RAIZ / "FALTAN.md").read_text(encoding="utf-8")
    for pieza in ("B1", "B2", "B7", "B11"):
        fila = next((l for l in texto.splitlines() if l.startswith(f"| {pieza} |")), None)
        assert fila is not None, f"falta la fila {pieza} en FALTAN.md"
        assert "**Hecho**" in fila, f"{pieza} no está marcada como hecha"


def test_el_validador_caza_un_modelo_sin_textura(pack):
    pack.json(
        "assets/swr/models/item/roto.json",
        {"parent": "minecraft:item/generated", "textures": {"layer0": "swr:item/no_existe"}},
    )
    errores = [p for p in revisar(pack.raiz) if p.nivel == "error"]
    assert any("no existe en el pack" in p.mensaje for p in errores)


def test_el_validador_caza_un_custom_model_data_repetido(pack):
    pack.json(
        "assets/minecraft/models/item/paper.json",
        {
            "parent": "minecraft:item/generated",
            "textures": {"layer0": "minecraft:item/paper"},
            "overrides": [
                {"predicate": {"custom_model_data": 7}, "model": "minecraft:item/paper"},
                {"predicate": {"custom_model_data": 7}, "model": "minecraft:item/paper"},
            ],
        },
    )
    errores = [p for p in revisar(pack.raiz) if p.nivel == "error"]
    assert any("repetido" in p.mensaje for p in errores)
