"""Epilogo TERRAFORMING: la cadena de escenas tiene que estar encadenada de verdad.

Cuatro escenas en orden, cada una abierta por la anterior y la ultima la que da el avance. Si
alguien cambia un numero, la cadena se queda en un paso muerto y el jugador no sabe por que; esto
lo detecta sin abrir Minecraft.
"""

from __future__ import annotations

import json
import re
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
FUNCIONES = RAIZ / "panel" / "data" / "swr" / "function"
EPILOGO = FUNCIONES / "serie" / "terraforming"
AVANCE = RAIZ / "panel" / "data" / "swr" / "advancement" / "serie" / "terraforming.json"

# escena -> (paso que exige, paso que deja)
CADENA = [
    ("naufragio", 1, 2),
    ("balsa", 2, 3),
    ("nitrico", 3, 4),
    ("silicio", 4, 5),
]


def texto(nombre: str) -> str:
    return (EPILOGO / f"{nombre}.mcfunction").read_text(encoding="utf-8")


def lineas(nombre: str) -> list[str]:
    return [l for l in texto(nombre).splitlines() if l.strip() and not l.lstrip().startswith("#")]


def test_estan_las_seis_funciones():
    for nombre in ["iniciar", "estado", *[c[0] for c in CADENA]]:
        assert (EPILOGO / f"{nombre}.mcfunction").is_file(), f"falta swr:serie/terraforming/{nombre}"


def test_la_cadena_va_en_orden():
    for nombre, exige, deja in CADENA:
        cuerpo = texto(nombre)
        assert f"unless score TERRAFORM swr matches {exige}" in cuerpo, (
            f"{nombre} deberia exigir el paso {exige}"
        )
        assert f"scoreboard players set TERRAFORM swr {deja}" in cuerpo, (
            f"{nombre} deberia dejar el paso en {deja}"
        )


def test_el_ultimo_paso_da_el_avance():
    assert "advancement grant @s only swr:serie/terraforming" in texto("silicio")
    for nombre, _, _ in CADENA[:-1]:
        assert "advancement grant" not in texto(nombre), f"{nombre} no deberia dar el avance"


def test_iniciar_exige_la_era_5_cerrada_y_encadena_la_primera_escena():
    cuerpo = texto("iniciar")
    assert "unless score CERRADA5 swr matches 1.." in cuerpo
    assert "scoreboard players set TERRAFORM swr 1" in cuerpo
    assert "function swr:serie/terraforming/naufragio" in cuerpo


def test_el_contador_existe_desde_la_carga():
    load = (FUNCIONES / "load.mcfunction").read_text(encoding="utf-8")
    assert "scoreboard players add TERRAFORM swr 0" in load, (
        "sin inicializar TERRAFORM, el estado del epilogo no se puede leer"
    )


def test_cerrar_la_era_5_anuncia_el_epilogo():
    cerrar = (FUNCIONES / "era" / "cerrar.mcfunction").read_text(encoding="utf-8")
    assert "matches 5" in cerrar and "terraforming" in cerrar, (
        "al cerrar la era 5 hay que abrir el epilogo"
    )


def test_el_avance_es_valido_y_cuelga_de_why():
    datos = json.loads(AVANCE.read_text(encoding="utf-8"))
    assert datos["parent"] == "swr:serie/why"
    assert (RAIZ / "panel" / "data" / "swr" / "advancement" / "serie" / "why.json").is_file()
    assert datos["criteria"]["hecho"]["trigger"] == "minecraft:impossible"
    assert datos["display"]["icon"]["id"] == "minecraft:quartz"


def test_el_epilogo_no_rompe_nada():
    prohibidos = ("kill ", " fill ", " setblock ", " summon minecraft:tnt", "clear ")
    for nombre in ["iniciar", "estado", *[c[0] for c in CADENA]]:
        for linea in lineas(nombre):
            assert not any(p in f" {linea} " for p in prohibidos), (
                f"{nombre} lleva un comando destructivo: {linea}"
            )


def test_las_escenas_tienen_titulo_sonido_y_texto():
    for nombre, _, _ in CADENA:
        cuerpo = texto(nombre)
        assert "title @a title" in cuerpo, f"{nombre} no tiene titulo"
        assert "playsound" in cuerpo, f"{nombre} no suena"
        assert "tellraw" in cuerpo, f"{nombre} no cuenta nada"
        assert "give @s" in cuerpo, f"{nombre} no da recuerdo"


def test_la_documentacion_lista_los_comandos():
    eras = (RAIZ / "ERAS.md").read_text(encoding="utf-8")
    for nombre in ["iniciar", "naufragio", "balsa", "nitrico", "silicio", "estado"]:
        assert f"swr:serie/terraforming/{nombre}" in eras, f"ERAS.md no menciona {nombre}"
    leeme = (RAIZ / "LEEME.md").read_text(encoding="utf-8")
    assert "swr:serie/terraforming/iniciar" in leeme, "LEEME.md no lista el epilogo"
