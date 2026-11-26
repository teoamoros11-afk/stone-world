"""El disco de Lilian: la cancion registrada y la funcion que da el disco."""

import json
import struct
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
PACK = RAIZ / "panel"
SONIDOS = RAIZ / "pack-inmersion" / "assets" / "swr" / "sounds.json"
OGG = RAIZ / "pack-inmersion" / "assets" / "swr" / "sounds" / "lilian.ogg"


def test_cancion_registrada():
    datos = json.loads((PACK / "data/swr/jukebox_song/lilian.json").read_text(encoding="utf-8"))
    assert datos["sound_event"] == "swrmusica:lilian"
    assert "description" in datos
    assert 0 < datos["length_in_seconds"] <= 60
    assert 0 <= datos["comparator_output"] <= 15


def test_el_sonido_existe_en_el_resource_pack():
    sonidos = json.loads(SONIDOS.read_text(encoding="utf-8"))
    assert "lilian" in sonidos
    assert "swr:lilian" in [s["name"] for s in sonidos["lilian"]["sounds"]]
    assert OGG.exists() and OGG.stat().st_size > 0


def test_la_duracion_declara_la_del_ogg():
    """El tocadiscos corta a los length_in_seconds: tienen que ser los del archivo."""
    datos = json.loads((PACK / "data/swr/jukebox_song/lilian.json").read_text(encoding="utf-8"))
    b = OGG.read_bytes()
    gran = struct.unpack_from("<q", b, b.rfind(b"OggS") + 6)[0]
    cabecera = b.find(b"\x01vorbis")
    rate = struct.unpack_from("<I", b, cabecera + 12)[0]
    assert abs(gran / rate - datos["length_in_seconds"]) < 0.2


def test_la_funcion_da_un_disco_que_suena():
    cuerpo = (PACK / "data/swr/function/serie/disco.mcfunction").read_text(encoding="utf-8")
    assert "swrmusica:disco_lilian" in cuerpo
    assert "give @s" in cuerpo
