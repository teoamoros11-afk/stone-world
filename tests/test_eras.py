"""Las cinco eras: su funcion, su candado, sus avances y que ninguno sea inalcanzable.

Cada era es un archivo pequeno (`swr:era/N`) con tres cosas: se fija en el panel, exige que la
anterior este cerrada y concede su avance. Ademas, cada avance de la pestaña "Dr. Stone" tiene que
poder ganarse: o con un criterio real del juego o con un `advancement grant` en alguna funcion. Un
avance con criterio `impossible` y sin nadie que lo conceda es contenido muerto, y ya paso una vez
(`fluido`).
"""

from __future__ import annotations

import json
import re
from pathlib import Path

import pytest

RAIZ = Path(__file__).resolve().parent.parent
FUNCIONES = RAIZ / "panel" / "data" / "swr" / "function"
AVANCES = RAIZ / "panel" / "data" / "swr" / "advancement" / "serie"

# era -> avance que se concede al abrirla
AL_ABRIR = {1: "despertar", 2: "aldea", 3: "stone-wars", 4: "perseus", 5: "why"}

# era -> todos los avances que le pertenecen (los de abrir y los de la accion)
PROPIOS = {
    1: ["despertar", "fluido"],
    2: ["aldea", "gafas", "pueblo", "historias"],
    3: ["stone-wars"],
    4: ["perseus", "tripulacion", "zarpe", "medusa"],
    5: ["why"],
}
# el epilogo no es era, pero su avance tambien sale en la tabla
EPILOGO = "terraforming"


def era(numero: int) -> str:
    return (FUNCIONES / "era" / f"{numero}.mcfunction").read_text(encoding="utf-8")


def todas_las_funciones() -> str:
    return "\n".join(
        p.read_text(encoding="utf-8") for p in FUNCIONES.rglob("*.mcfunction")
    )


def concedidos() -> dict[str, list[str]]:
    """Avance -> funciones que lo conceden."""
    mapa: dict[str, list[str]] = {}
    for ruta in FUNCIONES.rglob("*.mcfunction"):
        for avance in re.findall(r"advancement grant \S+ only swr:serie/([a-z0-9-]+)", ruta.read_text(encoding="utf-8")):
            mapa.setdefault(avance, []).append(ruta.relative_to(FUNCIONES).as_posix())
    return mapa


def ficha(nombre: str) -> dict:
    return json.loads((AVANCES / f"{nombre}.json").read_text(encoding="utf-8"))


@pytest.mark.parametrize("numero", sorted(AL_ABRIR))
def test_cada_era_tiene_su_funcion(numero):
    assert (FUNCIONES / "era" / f"{numero}.mcfunction").is_file()


@pytest.mark.parametrize("numero", sorted(AL_ABRIR))
def test_cada_era_se_fija_y_concede_su_avance(numero):
    cuerpo = era(numero)
    assert f"scoreboard players set ERA swr {numero}" in cuerpo
    assert f"advancement grant @a only swr:serie/{AL_ABRIR[numero]}" in cuerpo
    assert f"function swr:descubrir/{numero}" in cuerpo, (
        f"la era {numero} no abre sus fichas del cuaderno"
    )


@pytest.mark.parametrize("numero", sorted(AL_ABRIR)[1:])
def test_el_candado_exige_la_era_anterior(numero):
    cuerpo = era(numero)
    assert f"unless score CERRADA{numero - 1} swr matches 1.." in cuerpo, (
        f"la era {numero} se puede abrir sin cerrar la {numero - 1}"
    )
    assert f"cierra primero la era {numero - 1}" in cuerpo


def test_la_era_1_es_la_unica_sin_candado():
    assert "CERRADA" not in era(1)


def test_cerrar_marca_las_cinco_y_desbloquea_la_siguiente():
    cerrar = (FUNCIONES / "era" / "cerrar.mcfunction").read_text(encoding="utf-8")
    for numero in AL_ABRIR:
        assert f"execute if score ERA swr matches {numero} run scoreboard players set CERRADA{numero} swr 1" in cerrar


def test_ningun_avance_es_inalcanzable():
    regalados = concedidos()
    for ruta in sorted(AVANCES.glob("*.json")):
        nombre = ruta.stem
        if nombre == "raiz":
            continue
        criterios = ficha(nombre)["criteria"].values()
        real = any(c["trigger"] != "minecraft:impossible" for c in criterios)
        assert real or nombre in regalados, (
            f"el avance {nombre} tiene criterio impossible y no lo concede ninguna funcion: "
            "no se puede ganar"
        )


def test_la_raiz_se_concede_sola_o_no_hay_arbol():
    tick = (FUNCIONES / "tick.mcfunction").read_text(encoding="utf-8")
    assert "advancement grant @s only swr:serie/raiz" in tick, (
        "sin la raiz ganada, la pestaña Dr. Stone no aparece aunque las eras den sus avances"
    )
    assert "tag @s add swr_raiz" in tick, "la raiz se intentaria conceder en cada tick"


def test_el_fluido_se_concede_al_gastar_una_dosis():
    for ruta in [FUNCIONES / "pueblo" / "despetrificar.mcfunction", FUNCIONES / "reino" / "revivir.mcfunction"]:
        cuerpo = ruta.read_text(encoding="utf-8")
        assert "advancement grant @s only swr:serie/fluido" in cuerpo, (
            f"{ruta.name} gasta fluido y no concede el avance"
        )


def test_todos_los_avances_cuelgan_de_la_raiz():
    for ruta in sorted(AVANCES.glob("*.json")):
        nombre = ruta.stem
        visto = set()
        while True:
            datos = ficha(nombre)
            if "parent" not in datos:
                assert nombre == "raiz", f"{nombre} es una raiz suelta"
                break
            padre = datos["parent"].split("/")[-1]
            assert (AVANCES / f"{padre}.json").is_file(), f"{nombre} cuelga de {padre}, que no existe"
            assert padre not in visto, f"ciclo en los avances: {nombre}"
            visto.add(padre)
            nombre = padre


def test_el_reparto_de_avances_cubre_todos_los_archivos():
    conocidos = {n for lista in PROPIOS.values() for n in lista} | {EPILOGO, "raiz"}
    archivos = {ruta.stem for ruta in AVANCES.glob("*.json")}
    assert archivos == conocidos, (
        f"sobran o faltan avances por asignar a una era: {sorted(archivos ^ conocidos)}"
    )
    for numero, lista in PROPIOS.items():
        assert AL_ABRIR[numero] in lista, f"la era {numero} no concede el suyo al abrirse"


@pytest.mark.parametrize("numero", sorted(PROPIOS))
def test_las_eras_documentan_sus_avances(numero):
    texto = (RAIZ / "ERAS.md").read_text(encoding="utf-8")
    assert texto.count("**Avances de la era:**") == 5, "ERAS.md tiene que decirlo en las cinco"
    for avance in PROPIOS[numero]:
        assert f"`{avance}`" in texto, f"ERAS.md no menciona el avance {avance}"
    assert f"| {numero} |" in texto, f"la tabla de avances no tiene la fila de la era {numero}"
