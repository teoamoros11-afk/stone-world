"""El mod del casco de sandia: ids, assets y texturas cuadran entre si."""

import json
import struct
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
MOD = RAIZ / "suika-mod"
ASSETS = MOD / "src/main/resources/assets/suikacasco"
MODID = "suikacasco"
ITEM = "watermelon_helmet"


def _tamano_png(ruta: Path) -> tuple[int, int]:
    b = ruta.read_bytes()
    assert b[:8] == b"\x89PNG\r\n\x1a\n", f"{ruta} no es un PNG"
    return struct.unpack(">II", b[16:24])


def test_modid_y_paquete():
    toml = (MOD / "src/main/resources/META-INF/neoforge.mods.toml").read_text(encoding="utf-8")
    assert f'modId = "{MODID}"' in toml
    assert (MOD / f"src/main/java/com/teo/{MODID}").is_dir()


def test_el_item_esta_registrado():
    codigo = (MOD / f"src/main/java/com/teo/{MODID}/item/ModItems.java").read_text(encoding="utf-8")
    assert f'"{ITEM}"' in codigo
    assert "ArmorItem.Type.HELMET" in codigo


def test_modelo_e_icono():
    modelo = json.loads((ASSETS / f"models/item/{ITEM}.json").read_text(encoding="utf-8"))
    assert modelo["textures"]["layer0"] == f"{MODID}:item/{ITEM}"
    assert _tamano_png(ASSETS / f"textures/item/{ITEM}.png") == (16, 16)


def test_textura_de_armadura_coincide_con_el_material():
    codigo = (MOD / f"src/main/java/com/teo/{MODID}/item/ModItems.java").read_text(encoding="utf-8")
    assert '"suika"' in codigo  # id del ArmorMaterial.Layer
    assert _tamano_png(ASSETS / "textures/models/armor/suika_layer_1.png") == (64, 32)


def test_receta_y_nombre_traducido():
    receta = json.loads((MOD / f"src/main/resources/data/{MODID}/recipe/{ITEM}.json").read_text(encoding="utf-8"))
    assert receta["result"]["id"] == f"{MODID}:{ITEM}"
    for idioma in ("es_es", "en_us"):
        lang = json.loads((ASSETS / f"lang/{idioma}.json").read_text(encoding="utf-8"))
        assert f"item.{MODID}.{ITEM}" in lang


PACK = RAIZ / "panel"
MUSICA = RAIZ / "musica-mod"


def test_el_sonido_del_disco_lo_registra_un_mod():
    """El jukebox_song resuelve contra el registro del servidor, no contra el resource pack."""
    codigo = (MUSICA / "src/main/java/com/teo/swrmusica/SwrMusica.java").read_text(encoding="utf-8")
    assert "Registries.SOUND_EVENT" in codigo
    assert '"lilian"' in codigo
    sonidos = json.loads((MUSICA / "src/main/resources/assets/swrmusica/sounds.json").read_text(encoding="utf-8"))
    assert sonidos["lilian"]["sounds"][0]["name"] == "swrmusica:lilian"
    assert (MUSICA / "src/main/resources/assets/swrmusica/sounds/lilian.ogg").stat().st_size > 0
    cancion = json.loads((PACK / "data/swr/jukebox_song/lilian.json").read_text(encoding="utf-8"))
    assert cancion["sound_event"] == "swrmusica:lilian"
    # El disco es un item del mod: en una funcion el componente no se puede parsear.
    assert '"disco_lilian"' in codigo
    assert "JUKEBOX_PLAYABLE" in codigo
    assert "EitherHolder" in codigo
    modelo = json.loads((MUSICA / "src/main/resources/assets/swrmusica/models/item/disco_lilian.json").read_text(encoding="utf-8"))
    assert modelo["textures"]["layer0"] == "swrmusica:item/disco_lilian"
