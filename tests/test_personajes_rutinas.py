"""Fichas de personaje y rutinas propias: que nadie se quede sin ficha ni sin turno.

Las fichas son texto y se pueden leer sin abrir Minecraft: estas pruebas comprueban que
cada personaje de swr:personajes/asignar tiene su archivo con su tag swr_es_<nombre>, que
las rutinas solo usan personajes y anclas que existen, y que el horario las llama despues
del turno comun (si se llamaran antes, el reparto general pisaria la rutina).
"""

from __future__ import annotations

import re
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
FUNCIONES = RAIZ / "panel" / "data" / "swr" / "function"
PERSONAJES = FUNCIONES / "personajes"
HORARIO = FUNCIONES / "pueblo" / "horario"
ANCLAS = FUNCIONES / "pueblo"

ASIGNAR_RE = re.compile(r"function swr:personajes/([a-z]+)\s*$", re.MULTILINE)
TAG_RE = re.compile(r'swr_es_([a-z]+)')
TURNO_RE = re.compile(r"score TURNO swr matches ([0-9]+)(?:\.\.([0-9]+))?")


def personajes() -> list[str]:
    return ASIGNAR_RE.findall((PERSONAJES / "asignar.mcfunction").read_text(encoding="utf-8"))


def rutinas() -> str:
    return (HORARIO / "rutinas.mcfunction").read_text(encoding="utf-8")


def lineas_utiles(texto: str) -> list[str]:
    return [l for l in texto.splitlines() if l.strip() and not l.lstrip().startswith("#")]


def test_cada_personaje_tiene_su_ficha_y_su_tag():
    nombres = personajes()
    assert len(nombres) == 12, f"asignar reparte {len(nombres)} personajes, se esperan 12"
    for nombre in nombres:
        ruta = PERSONAJES / f"{nombre}.mcfunction"
        assert ruta.is_file(), f"falta la ficha de {nombre}"
        texto = ruta.read_text(encoding="utf-8")
        assert f"swr_es_{nombre}" in texto, f"la ficha de {nombre} no lleva el tag swr_es_{nombre}"
        assert "swr_canon" in texto, f"la ficha de {nombre} no protege su oficio con swr_canon"
        assert "item replace entity @s weapon.mainhand" in texto, (
            f"la ficha de {nombre} no le pone nada en la mano"
        )


def test_las_rutinas_solo_hablan_de_personajes_que_existen():
    nombres = set(personajes())
    usados = set(TAG_RE.findall(rutinas()))
    assert usados, "swr:pueblo/horario/rutinas no menciona a ningun personaje"
    desconocidos = usados - nombres
    assert not desconocidos, f"las rutinas usan personajes sin ficha: {sorted(desconocidos)}"


def test_las_rutinas_van_despues_del_turno_comun():
    cambiar = (HORARIO / "cambiar.mcfunction").read_text(encoding="utf-8")
    lineas = lineas_utiles(cambiar)
    assert "function swr:pueblo/horario/rutinas" in lineas, (
        "swr:pueblo/horario/cambiar no llama a rutinas"
    )
    # despues de elegir turno: si fuera antes, el reparto general pisaria la rutina
    assert lineas.index("function swr:pueblo/horario/rutinas") == len(lineas) - 1, (
        "rutinas tiene que ser lo ultimo de cambiar.mcfunction"
    )


def test_los_turnos_de_las_rutinas_existen():
    for desde, hasta in TURNO_RE.findall(rutinas()):
        assert 1 <= int(desde) <= 6, f"turno {desde} fuera de 1..6"
        assert not hasta or int(desde) <= int(hasta) <= 6, f"rango {desde}..{hasta} fuera de 1..6"


def test_las_anclas_que_usan_las_rutinas_existen():
    # un puesto se crea en swr:pueblo/puestos; la plaza en swr:pueblo/fundar
    fuentes = "\n".join(
        r.read_text(encoding="utf-8")
        for r in [ANCLAS / "puestos.mcfunction", ANCLAS / "fundar.mcfunction"]
    )
    for ancla in set(re.findall(r"tag=(swr_puesto_\d+|swr_plaza)", rutinas())):
        assert f'"{ancla}"' in fuentes, f"las rutinas usan {ancla}, que nadie crea"


def test_ninguna_rutina_deja_el_cuerpo_sin_mirar():
    # tp con facing a la misma posicion es un comando invalido en Minecraft
    for linea in lineas_utiles(rutinas()):
        coincide = re.search(r"tp @e\[[^\]]+\] (~[0-9.+-]* ~[0-9.+-]* ~[0-9.+-]*) facing (~[0-9.+-]* ~[0-9.+-]* ~[0-9.+-]*)", linea)
        if coincide:
            assert coincide.group(1) != coincide.group(2), f"facing degenerado: {linea}"
