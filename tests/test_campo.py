"""El campo con rotacion: parcelas, regla de rendimiento y reloj conectado al load."""

import pathlib
import re

RAIZ = pathlib.Path(__file__).resolve().parent.parent
CAMPO = RAIZ / "panel" / "data" / "swr" / "function" / "campo"
LOAD = RAIZ / "panel" / "data" / "swr" / "function" / "load.mcfunction"


def test_existen_las_cuatro_parcelas_y_el_reloj():
    for nombre in ("montar", "reset", "revisar", "ciclo", "estado", "reglas",
                   "parcela1", "parcela2", "parcela3", "parcela4"):
        assert (CAMPO / f"{nombre}.mcfunction").is_file(), f"falta campo/{nombre}.mcfunction"
    assert (CAMPO / "revisar.mcfunction").read_text(encoding="utf-8").count("function swr:campo/parcela") == 4


def test_cada_parcela_lleva_su_cuenta():
    for n in range(1, 5):
        texto = (CAMPO / f"parcela{n}.mcfunction").read_text(encoding="utf-8")
        assert f"R{n} campo" in texto and f"P{n} campo" in texto
        assert "minecraft:wheat[age=7]" in texto
        assert "minecraft:beetroots[age=3]" in texto


def test_la_rotacion_resta_al_repetir_y_suma_al_cambiar():
    texto = (CAMPO / "parcela1.mcfunction").read_text(encoding="utf-8")
    resta = [l for l in texto.splitlines() if "remove R1 campo 1" in l]
    suma = [l for l in texto.splitlines() if "add R1 campo 1" in l]
    assert resta, "no hay resta de rendimiento al repetir cultivo"
    assert suma, "no hay suma de rendimiento al cambiar de cultivo"
    assert "unless score R1 campo matches 1.. run scoreboard players set R1 campo 1" in texto
    assert "unless score R1 campo matches ..3 run scoreboard players set R1 campo 3" in texto


def test_el_load_crea_el_objetivo_y_arranca_el_reloj():
    texto = LOAD.read_text(encoding="utf-8")
    assert 'scoreboard objectives add campo dummy' in texto
    assert "schedule function swr:campo/ciclo 200t replace" in texto
    for n in range(1, 5):
        assert f"R{n} campo 3" in texto, f"el load no inicializa R{n}"


def test_el_ciclo_se_reprograma_y_cosecha_los_cuatro_cultivos():
    texto = (CAMPO / "parcela1.mcfunction").read_text(encoding="utf-8")
    for item in ("minecraft:wheat", "minecraft:potato", "minecraft:carrot", "minecraft:beetroot"):
        assert f"give @s {item}" in texto, f"la cosecha no reparte {item}"
    assert "schedule function swr:campo/ciclo 200t replace" in (CAMPO / "ciclo.mcfunction").read_text(encoding="utf-8")


def test_el_arnes_comprueba_la_rotacion():
    texto = (RAIZ / "herramientas" / "probar_servidor.py").read_text(encoding="utf-8")
    assert "campo: trigo maduro da 3" in texto
    assert "function swr:campo/parcela1" in texto
