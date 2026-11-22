"""Geometria del pueblo: 16 solares en cuadricula, sin solaparse y con su camino.

No se puede abrir Minecraft en cada cambio, pero el plano si se puede comprobar: estas
pruebas leen los marcadores de swr:pueblo/casa/empezar y los caminos de swr:pueblo/caminos
y verifican que las casas no se pisan, que ninguna invade la plaza y que cada puerta tiene
su camino hasta la calle. Si alguien mueve un solar a ojo, esto falla.
"""

from __future__ import annotations

import re
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
PUEBLO = RAIZ / "panel" / "data" / "swr" / "function" / "pueblo"

SOLAR_RE = re.compile(
    r"summon minecraft:marker ~(-?\d+) ~ ~(-?\d+) "
    r'\{Tags:\["swr_casa","swr_casa_nueva","swr_dir_(\d)","swr_solar_(\d+)"\]\}'
)
# solo las capas de superficie (las que no llevan "replace" detras: esas son cimientos)
FILL_RE = re.compile(
    r"run fill ~(-?\d+) ~-1 ~(-?\d+) ~(-?\d+) ~-1 ~(-?\d+) minecraft:(\w+)[ \t]*$",
    re.MULTILINE,
)

# la casa es 5x5 y su zocalo 7x7 (swr:pueblo/casa/cimientos)
MEDIA_CASA = 2
MEDIA_SOLAR = 3  # cada casa limpia un solar de 7x7 con cimientos
# la plaza es 13x13 (swr:pueblo/plaza)
MEDIA_PLAZA = 6


def solares() -> dict[int, dict]:
    texto = (PUEBLO / "casa" / "empezar.mcfunction").read_text(encoding="utf-8")
    encontrados = {}
    for x, z, direccion, numero in SOLAR_RE.findall(texto):
        encontrados[int(numero)] = {
            "x": int(x),
            "z": int(z),
            "dir": int(direccion),
        }
    return encontrados


def caminos() -> list[tuple[int, int, int, int, str]]:
    texto = (PUEBLO / "caminos.mcfunction").read_text(encoding="utf-8")
    return [
        (int(x1), int(z1), int(x2), int(z2), bloque)
        for x1, z1, x2, z2, bloque in FILL_RE.findall(texto)
    ]


def caja(x: int, z: int, media: int) -> tuple[int, int, int, int]:
    return x - media, z - media, x + media, z + media


def se_pisan(a: tuple[int, int, int, int], b: tuple[int, int, int, int]) -> bool:
    return not (a[2] < b[0] or b[2] < a[0] or a[3] < b[1] or b[3] < a[1])


def puerta(solar: dict) -> tuple[int, int]:
    """Bloque de la puerta: pared que mira a la plaza, 2 bloques desde el centro."""
    x, z, direccion = solar["x"], solar["z"], solar["dir"]
    if direccion == 0:  # puerta al oeste, la casa esta al este
        return x - MEDIA_CASA, z
    if direccion == 1:  # puerta al norte
        return x, z - MEDIA_CASA
    if direccion == 2:  # puerta al este
        return x + MEDIA_CASA, z
    return x, z + MEDIA_CASA


def test_hay_dieciseis_solares_numerados_sin_huecos():
    plano = solares()
    assert sorted(plano) == list(range(1, 17))


def test_las_casas_no_se_pisan():
    plano = solares()
    cajas = {numero: caja(s["x"], s["z"], MEDIA_CASA) for numero, s in plano.items()}
    for numero, caja_a in cajas.items():
        for otro, caja_b in cajas.items():
            if otro <= numero:
                continue
            assert not se_pisan(caja_a, caja_b), (
                f"las casas {numero} y {otro} se solapan: {caja_a} contra {caja_b}"
            )


def test_los_solares_no_se_comen_el_tejado_del_vecino():
    plano = solares()
    cajas = {n: caja(s["x"], s["z"], MEDIA_SOLAR) for n, s in plano.items()}
    for numero, caja_a in cajas.items():
        for otro, caja_b in cajas.items():
            if otro <= numero:
                continue
            assert not se_pisan(caja_a, caja_b), (
                f"los solares de {numero} y {otro} se pisan: {caja_a} contra {caja_b}"
            )


def test_ninguna_casa_invade_la_plaza():
    for numero, solar in solares().items():
        izquierda, arriba, derecha, abajo = caja(solar["x"], solar["z"], MEDIA_CASA)
        assert (
            derecha < -MEDIA_PLAZA
            or izquierda > MEDIA_PLAZA
            or abajo < -MEDIA_PLAZA
            or arriba > MEDIA_PLAZA
        ), f"la casa {numero} cae dentro de la plaza: {caja(solar['x'], solar['z'], MEDIA_CASA)}"


def test_la_puerta_mira_a_la_plaza():
    for numero, solar in solares().items():
        x, z, direccion = solar["x"], solar["z"], solar["dir"]
        if direccion == 0:
            assert x > 0, f"la casa {numero} tiene puerta al oeste pero esta al oeste de la plaza"
        elif direccion == 2:
            assert x < 0, f"la casa {numero} tiene puerta al este pero esta al este de la plaza"
        elif direccion == 1:
            assert z > 0, f"la casa {numero} tiene puerta al norte pero esta al norte de la plaza"
        else:
            assert z < 0, f"la casa {numero} tiene puerta al sur pero esta al sur de la plaza"


def test_cada_puerta_tiene_su_camino():
    plano = solares()
    tierras = [c for c in caminos() if c[4] == "coarse_dirt"]
    assert tierras, "no hay caminos de tierra en swr:pueblo/caminos"
    for numero, solar in plano.items():
        px, pz = puerta(solar)
        # el camino tiene que llegar a un bloque pegado a la puerta
        pegado = (px - 1, pz - 1, px + 1, pz + 1)
        assert any(
            se_pisan(pegado, (x1, z1, x2, z2)) for x1, z1, x2, z2, _ in tierras
        ), f"la puerta de la casa {numero} ({px}, {pz}) no tiene camino"


def test_los_caminos_no_entran_en_las_casas():
    for x1, z1, x2, z2, bloque in caminos():
        camino = (min(x1, x2), min(z1, z2), max(x1, x2), max(z1, z2))
        for numero, solar in solares().items():
            casa = caja(solar["x"], solar["z"], MEDIA_CASA)
            assert not se_pisan(camino, casa), (
                f"el camino de {bloque} en {camino} entra en la casa {numero} {casa}"
            )


def test_las_calles_no_pasan_por_la_plaza():
    calles = [
        c
        for c in caminos()
        if c[4] == "stone_bricks"
        and min(abs(c[2] - c[0]), abs(c[3] - c[1])) <= 2
        and max(abs(c[2] - c[0]), abs(c[3] - c[1])) >= 10
    ]
    assert len(calles) >= 4, f"faltan calles: {calles}"
    for x1, z1, x2, z2, _ in calles:
        calle = (min(x1, x2), min(z1, z2), max(x1, x2), max(z1, z2))
        # la calle puede empezar en el borde de la plaza, pero no meterse dentro
        interior = (-MEDIA_PLAZA + 1, -MEDIA_PLAZA + 1, MEDIA_PLAZA - 1, MEDIA_PLAZA - 1)
        assert not se_pisan(calle, interior), f"la calle {calle} se mete en la plaza"
