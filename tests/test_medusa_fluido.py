"""A1 y A2 del tramo A: la medusa con cuenta atras y el fluido como frasco.

Lo que se puede comprobar sin cliente: que la cuenta atras exista, que dispare una
sola vez y contra lo que este cerca, que no mate a nadie, que avise antes de gastar
una carga, y que el frasco se gaste antes que el cupo del campo.
"""

from __future__ import annotations

from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
FUNCIONES = RAIZ / "panel" / "data" / "swr" / "function"


def lee(ruta: str) -> str:
    return (FUNCIONES / ruta).read_text(encoding="utf-8")


def lineas(texto: str) -> list[str]:
    return [l for l in texto.splitlines() if l.strip() and not l.lstrip().startswith("#")]


def test_la_medusa_arma_cuenta_atras_de_treinta_segundos():
    ini = lee("serie/medusa/iniciar.mcfunction")
    assert "summon minecraft:marker" in ini and "swr_medusa" in ini
    assert "scoreboard players set MEDUSA_T swr 30" in ini
    assert "schedule function swr:serie/medusa/ciclo 20t replace" in ini


def test_la_cuenta_atras_baja_y_dispara_una_vez():
    ciclo = lineas(lee("serie/medusa/ciclo.mcfunction"))
    assert "scoreboard players remove MEDUSA_T swr 1" in ciclo
    assert any("function swr:serie/medusa/disparar" in l for l in ciclo)
    # solo se reprograma mientras quede tiempo
    reprograma = [l for l in ciclo if "schedule function swr:serie/medusa/ciclo" in l]
    assert reprograma and all("matches 1.." in l for l in reprograma)


def test_el_disparo_petrifica_solo_lo_que_esta_cerca_y_no_mata():
    dis = lee("serie/medusa/disparar.mcfunction")
    assert "drstonekos petrify @s" in dis
    assert "distance=..12" in dis
    assert "kill @e[tag=swr_medusa]" in dis
    assert "schedule clear swr:serie/medusa/ciclo" in dis
    for linea in lineas(dis):
        if linea.startswith("kill"):
            assert "tag=swr_medusa" in linea, f"mata algo que no es la medusa: {linea}"
    assert "kill @a" not in dis


def test_desactivar_deja_de_contar():
    des = lee("serie/medusa/desactivar.mcfunction")
    assert "schedule clear swr:serie/medusa/ciclo" in des
    assert "kill @e[tag=swr_medusa]" in des
    assert "scoreboard players set MEDUSA_T swr 0" in des


def test_la_medusa_avisa_antes_de_gastar_una_carga():
    ini = lineas(lee("serie/medusa/iniciar.mcfunction"))
    i_aviso = next(i for i, l in enumerate(ini) if "Ya hay una medusa activa" in ini[i])
    i_carga = next(i for i, l in enumerate(ini) if "remove MEDUSA_CARGA" in l)
    assert i_aviso < i_carga, "gasta la carga antes de comprobar si ya habia una activa"


def test_el_fluido_se_entrega_como_frasco():
    texto = lee("reino/fluido.mcfunction")
    assert "minecraft:experience_bottle" in texto
    assert "Fluido milagroso" in texto


def test_revivir_gasta_el_frasco_antes_que_el_cupo():
    texto = lee("reino/revivir.mcfunction")
    assert "items entity @s container.* minecraft:experience_bottle" in texto
    assert "clear @s minecraft:experience_bottle 1" in texto
    assert texto.index("clear @s minecraft:experience_bottle 1") < texto.index(
        "scoreboard players remove CUPO swr 1"
    )
    assert "unless score CUPO swr matches 1.." in texto, "se perdio el aviso de cupo agotado"


def test_despetrificar_gasta_el_frasco_antes_que_el_cupo():
    texto = lee("pueblo/despetrificar.mcfunction")
    assert "items entity @s container.* minecraft:experience_bottle" in texto
    assert "clear @s minecraft:experience_bottle 1" in texto
    assert texto.index("clear @s minecraft:experience_bottle 1") < texto.index(
        "scoreboard players remove CUPO swr 1"
    )
