"""El bar del Perseus: salon, despensa, carta, poker y bolos.

Lo que se prueba aqui es lo que se puede probar sin cliente: que las funciones existan,
que la despensa no cree comida de la nada, que cada plato de la carta cobre exactamente
lo que dice y que los dos juegos tengan las piezas que dicen tener (52 cartas, 10 bolos).
"""

from __future__ import annotations

import json
import re
from pathlib import Path

import pytest

RAIZ = Path(__file__).resolve().parent.parent
F = RAIZ / "panel" / "data" / "swr" / "function"
BAR = F / "bar"


def leer(rel: str) -> str:
    return (BAR / rel).read_text(encoding="utf-8")


def mcfunctions() -> list[Path]:
    return sorted(BAR.rglob("*.mcfunction"))


# ---------------------------------------------------------------- el salon

def test_el_salon_tiene_barra_mesas_y_cocinera():
    montar = leer("montar.mcfunction")
    assert "minecraft:barrel" in montar, "la barra no tiene barriles"
    assert montar.count("function swr:bar/poker/mesa") == 2, "faltan las dos mesas de poker"
    assert "function swr:bar/francois" in montar, "no se coloca a la cocinera"
    assert "swr:bar/bolos/montar" in montar, "no se avisa de la mesa de bolos"


def test_francois_es_la_cocinera_y_se_queda_quieta():
    francois = leer("francois.mcfunction")
    assert "swr_cocinero" in francois, "no busca a la cocinera de la tripulacion"
    assert "swr:tripulacion/reclutar/cocinero" in francois, "no dice como reclutarla"
    assert "NoAI:1b" in francois, "la cocinera se iria a la campana"
    assert "tp @s ~ ~ ~-1" in francois, "no se la coloca detras de la barra"


@pytest.mark.parametrize("ruta", mcfunctions(), ids=lambda p: p.relative_to(BAR).as_posix())
def test_ningun_comando_destructivo_suelto(ruta):
    for linea in ruta.read_text(encoding="utf-8").splitlines():
        limpia = linea.strip()
        if limpia.startswith("#"):
            continue
        assert not re.search(r"\bfill\b[^\n]*\bminecraft:air\b", limpia), f"borra aire en {ruta.name}"
        assert not re.search(r"\bkill @e\[(?!tag=)", limpia), f"mata entidades sin tag en {ruta.name}"
        assert "remove @e" not in limpia


# ---------------------------------------------------------------- despensa

def test_la_despensa_empieza_a_cero_y_no_inventa():
    load = (F / "load.mcfunction").read_text(encoding="utf-8")
    for res in ["PAN", "PESCADO", "PATATA", "ZANAHORIA", "BAYAS",
                "LECHE", "MIEL", "HUEVO", "TRIGO", "CARNE"]:
        assert f"scoreboard players add {res} despensa 0" in load, f"la despensa no declara {res}"
    assert "scoreboard objectives add despensa" in load


def test_el_acopio_solo_trae_lo_que_producen_los_oficios():
    acopio = leer("acopio.mcfunction")
    assert "swr_oficio_1" in acopio, "el granjero (oficio 1) no trae pan"
    assert "swr_oficio_3" in acopio, "el pescador (oficio 3) no trae pescado"
    for otro in ["swr_oficio_0", "swr_oficio_2", "swr_oficio_4", "swr_oficio_5"]:
        assert otro not in acopio, f"{otro} no produce comida: no puede repostar el bar"
    assert acopio.count("matches 65..") == 2, "la despensa no tiene tope"


ENTREGAS = {
    "pan": ("PAN", "minecraft:bread"),
    "pescado": ("PESCADO", "minecraft:cod"),
    "patata": ("PATATA", "minecraft:potato"),
    "zanahoria": ("ZANAHORIA", "minecraft:carrot"),
    "bayas": ("BAYAS", "minecraft:sweet_berries"),
    "leche": ("LECHE", "minecraft:milk_bucket"),
    "miel": ("MIEL", "minecraft:honey_bottle"),
    "huevo": ("HUEVO", "minecraft:egg"),
    "trigo": ("TRIGO", "minecraft:wheat"),
    "carne": ("CARNE", "minecraft:beef"),
}


@pytest.mark.parametrize("archivo", sorted(ENTREGAS))
def test_entregar_gasta_del_inventario(archivo):
    res, item = ENTREGAS[archivo]
    cuerpo = leer(f"entregar/{archivo}.mcfunction")
    assert f"clear @s {item} 0" in cuerpo, "no cuenta lo que llevas"
    assert f"clear @s {item} 8" in cuerpo, "no gasta lo entregado"
    assert f"scoreboard players add {res} despensa 8" in cuerpo
    assert "matches 65.." in cuerpo, "no respeta el tope"


# ---------------------------------------------------------------- la carta

CA = {
    1: [("PAN", 1)],
    2: [("PESCADO", 1)],
    3: [("HUEVO", 1), ("PATATA", 1)],
    4: [("CARNE", 1), ("ZANAHORIA", 1)],
    5: [("TRIGO", 1), ("HUEVO", 1), ("MIEL", 1)],
    6: [],
    7: [("BAYAS", 2)],
    8: [("LECHE", 1)],
    9: [("MIEL", 1)],
}


@pytest.mark.parametrize("numero", sorted(CA))
def test_cada_plato_cobra_lo_que_dice(numero):
    cuerpo = leer(f"pedir/{numero}.mcfunction")
    for res, coste in CA[numero]:
        assert f"unless score {res} despensa matches {coste}.." in cuerpo, (
            f"el plato {numero} no comprueba {res}"
        )
        assert f"scoreboard players remove {res} despensa {coste}" in cuerpo, (
            f"el plato {numero} no cobra {res}"
        )
    assert "give @s" in cuerpo, f"el plato {numero} no da nada"


def test_la_carta_ofrece_todos_los_platos_y_ninguno_de_mas():
    carta = leer("carta.mcfunction")
    for numero in CA:
        assert f"/function swr/bar/pedir/{numero}" in carta
    pedidos = sorted(int(p.stem) for p in (BAR / "pedir").glob("*.mcfunction"))
    assert pedidos == sorted(CA), f"hay platos sin carta o al reves: {pedidos}"


# ---------------------------------------------------------------- poker

def test_la_baraja_tiene_cincuenta_y_dos_cartas_distintas():
    baraja = leer("poker/baraja.mcfunction")
    lista = re.search(r"nombres set value \[(.*)\]", baraja)
    assert lista, "no se carga la baraja"
    nombres = re.findall(r'"([^"]+)"', lista.group(1))
    assert len(nombres) == 52, f"la baraja tiene {len(nombres)} cartas"
    assert len(set(nombres)) == 52, "hay cartas repetidas en la baraja"
    assert nombres[0] == "As de picas" and nombres[-1] == "Rey de treboles"


def test_el_reparto_da_cinco_a_cada_uno_y_no_repite():
    iniciar = leer("poker/iniciar.mcfunction")
    assert iniciar.count("function swr:bar/poker/robar_a") == 5
    assert iniciar.count("function swr:bar/poker/robar_b") == 5
    assert "scoreboard players remove @s fichas 10" in iniciar, "no cobra la mano"
    assert "scoreboard players add BOTE fichas 10" in iniciar, "la apuesta no va al bote"
    assert "scoreboard players reset * cs" in iniciar, "no vacia las cartas usadas"
    for lado in ("a", "b"):
        robar = leer(f"poker/robar_{lado}.mcfunction")
        assert "random value 1..52" in robar
        assert "matches 1.." in robar, "no comprueba si la carta ya salio"


def test_la_evaluacion_cubre_las_nueve_manos():
    for lado in ("a", "b"):
        evaluar = leer(f"poker/evaluar_{lado}.mcfunction")
        for tipo in range(1, 10):
            assert f"set TIPO poker {tipo}" in evaluar, f"falta el tipo {tipo} en evaluar_{lado}"
        assert "ESCALERA poker 1" in evaluar
        assert "COLOR poker 1" in evaluar
        assert "*= CIEN swr" in evaluar, "los puntos no pesan el tipo (CIEN vive en swr)"
        assert "+= ALTA poker" in evaluar


def test_el_poker_paga_el_bote_y_devuelve_el_empate():
    resolver = leer("poker/resolver.mcfunction")
    assert "fichas += BOTE fichas" in resolver, "no paga el bote"
    assert "add @s fichas 10" in resolver, "no devuelve la apuesta en el empate"
    assert "set BOTE fichas 0" in resolver, "el bote se queda sucio"
    assert "nombresB[4]" in resolver, "no ensena la quinta carta de la banca"


def test_las_fichas_se_compran_con_oro():
    comprar = leer("poker/comprar.mcfunction")
    assert "clear @s minecraft:gold_ingot 1" in comprar
    assert "add @s fichas 25" in comprar
    assert "give" not in comprar, "no hay fichas gratis"


# ---------------------------------------------------------------- bolos

def test_la_mesa_de_bolos_es_una_pista_y_diez_bolos():
    montar = leer("bolos/montar.mcfunction")
    assert "fill ~-2 ~-1 ~ ~2 ~-1 ~11" in montar, "la mesa no mide 5x12"
    assert "swr_bolos_origen" in montar
    reset = leer("bolos/reset.mcfunction")
    assert reset.count('Tags:["swr_bolo"]') == 10, "no hay diez bolos"
    assert "kill @e[tag=swr_bolo]" in reset, "los bolos viejos se acumulan"


def test_la_bola_rueda_y_cuenta_los_bolos():
    check = leer("bolos/check.mcfunction")
    assert "tp @s ~ ~ ~0.7" in check, "la bola no avanza"
    assert "matches 16.." in check, "la tirada no termina nunca"
    assert "function swr:bar/bolos/puntuar" in check
    puntuar = leer("bolos/puntuar.mcfunction")
    assert "swr_bolos_jugador" in puntuar, "no sabe a quien apuntar los bolos"
    assert "bolos += BOLOS_TIRADOS swr" in puntuar, "no suma el marcador"
    assert "matches 10" in puntuar, "no canta el pleno"
    assert "function swr:bar/bolos/reset" in puntuar, "deja los bolos tumbados"
    tirar = leer("bolos/tirar.mcfunction")
    assert "BOLOS_ACTIVO swr matches 1" in tirar, "deja tirar dos veces a la vez"


def test_el_bar_esta_enganchado_al_tick_y_a_la_noche():
    tick = (F / "tick.mcfunction").read_text(encoding="utf-8")
    assert "bar/bolos/check" in tick
    noche = (F / "pueblo" / "horario" / "noche.mcfunction").read_text(encoding="utf-8")
    assert "bar/acopio" in noche


def test_la_documentacion_cuenta_los_comandos():
    doc = (RAIZ / "BAR.md").read_text(encoding="utf-8")
    for comando in ["swr:bar/montar", "swr:bar/carta", "swr:bar/despensa",
                    "swr:bar/entregar", "swr:bar/poker/iniciar",
                    "swr:bar/bolos/montar", "swr:bar/bolos/tirar"]:
        assert comando in doc, f"BAR.md no menciona {comando}"
    assert "Playing Cards" in doc, "no deja constancia de la busqueda de mods"


# --- simulacion de la evaluacion: ejecuta el .mcfunction de verdad sobre marcadores ---
#
# Sin cliente no se puede repartir una mano, pero si se puede ejecutar el mismo
# .mcfunction que correra el servidor sobre un marcador simulado. Eso es lo que
# habria cazado el fallo de `*= CIEN poker` (la constante vive en `swr`).

def _rango(texto: str, valor: int) -> bool:
    if ".." in texto:
        bajo, alto = texto.split("..")
        if bajo and valor < int(bajo):
            return False
        if alto and valor > int(alto):
            return False
        return True
    return valor == int(texto)


def _ejecutar(lineas: list[str], scores: dict) -> None:
    for bruto in lineas:
        linea = bruto.strip()
        if not linea or linea.startswith("#"):
            continue
        if linea.startswith("execute "):
            condiciones = re.findall(r"if score (\S+) (\S+) matches (\S+)", linea)
            for quien, objetivo, rango in condiciones:
                valor = scores.get((quien, objetivo))
                if valor is None or not _rango(rango, valor):
                    break
            else:
                linea = linea.rsplit(" run ", 1)[-1] if " run " in linea else ""
        partes = linea.split(" ")
        if partes[:2] != ["scoreboard", "players"]:
            continue
        if partes[2] == "set":
            scores[(partes[3], partes[4])] = int(partes[5])
        elif partes[2] in {"add", "remove"}:
            clave = (partes[3], partes[4])
            delta = int(partes[5]) * (1 if partes[2] == "add" else -1)
            scores[clave] = scores.get(clave, 0) + delta
        elif partes[2] == "operation":
            destino, objd, op, fuente, objf = partes[3:8]
            if (fuente, objf) not in scores:
                continue  # Minecraft no hace la operacion si la fuente no tiene marcador
            a = scores.get((destino, objd), 0)
            b = scores[(fuente, objf)]
            scores[(destino, objd)] = {
                "=": b, "+=": a + b, "-=": a - b, "*=": a * b,
                "/=": (a // b if b else a), "%=": (a % b if b else a),
            }[op]


def puntaje_de_la_mano(ranks: dict[int, int], suits: dict[int, int]) -> int:
    scores = {("TRECE", "swr"): 13, ("CIEN", "swr"): 100}
    for r in range(1, 14):
        scores[(f"r{r}", "manoA")] = 0
    for s in range(1, 5):
        scores[(f"s{s}", "manoA")] = 0
    for r, n in ranks.items():
        scores[(f"r{r}", "manoA")] = n
    for s, n in suits.items():
        scores[(f"s{s}", "manoA")] = n
    _ejecutar(leer("poker/evaluar_a.mcfunction").splitlines(), scores)
    return scores[("MANO_JUGADOR", "poker")]


MANOS = {
    "pareja de cincos": ({5: 2, 9: 1, 11: 1, 12: 1, 13: 1}, {1: 2, 2: 1, 3: 1, 4: 1}, 205),
    "carta alta": ({1: 1, 3: 1, 7: 1, 9: 1, 13: 1}, {1: 1, 2: 2, 3: 1, 4: 1}, 113),
    "color": ({2: 1, 4: 1, 6: 1, 8: 1, 10: 1}, {2: 5}, 610),
    "escalera real": ({1: 1, 10: 1, 11: 1, 12: 1, 13: 1}, {1: 1, 2: 1, 3: 1, 4: 2}, 513),
    "full": ({7: 3, 9: 2}, {1: 2, 2: 2, 3: 1}, 709),
    "escalera de color": ({5: 1, 6: 1, 7: 1, 8: 1, 9: 1}, {1: 5}, 909),
    "poker de reyes": ({13: 4, 4: 1}, {1: 1, 2: 1, 3: 1, 4: 2}, 813),
}


@pytest.mark.parametrize("nombre", sorted(MANOS))
def test_la_evaluacion_da_el_puntaje_que_toca(nombre):
    ranks, suits, esperado = MANOS[nombre]
    assert puntaje_de_la_mano(ranks, suits) == esperado, nombre


def test_rank_y_palo_salen_de_la_carta():
    for carta in range(1, 53):
        scores = {("TRECE", "swr"): 13, ("CARTA", "swr"): carta}
        _ejecutar(leer("poker/rank_palo.mcfunction").splitlines(), scores)
        rango = (carta - 1) % 13 + 1
        palo = (carta - 1) // 13 + 1
        assert scores[("RANGO", "swr")] == rango, f"carta {carta}"
        assert scores[("PALO", "swr")] == palo, f"carta {carta}"
