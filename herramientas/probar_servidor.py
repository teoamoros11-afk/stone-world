#!/usr/bin/env python3
"""Prueba el datapack en un servidor de verdad, sin cliente y sin manos.

Arranca el servidor si hace falta, espera a RCON, ejecuta una lista cerrada de
comprobaciones y sale con 0 solo si todas pasan. Es el complemento de pytest:
pytest mira los archivos, esto mira lo que hace el juego.

    python3 herramientas/probar_servidor.py --servidor /var/tmp/sw3
    python3 herramientas/probar_servidor.py --servidor /var/tmp/sw3 --dejar
    python3 herramientas/probar_servidor.py --solo-listar

No sustituye a jugar: `/give`, `playsound`, `title` y `advancement grant`
necesitan un jugador de verdad y aqui no lo hay.
"""
from __future__ import annotations

import argparse
import pathlib
import socket
import subprocess
import sys
import time

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from rcon import Rcon  # noqa: E402

COMPROBACIONES = [
    "datapack cargado (panel-del-reino aparece en datapack list)",
    "load cargo las constantes (CIEN = 100 en swr)",
    "poker: poker de reyes suma 813 (evaluar_a sobre la mano puesta a mano)",
    "bolos: montar deja los diez bolos en la mesa",
    "bar: swr:bar/estado existe y responde",
]


def propiedades(servidor: pathlib.Path) -> dict[str, str]:
    archivo = servidor / "server.properties"
    if not archivo.is_file():
        raise SystemExit(f"no encuentro {archivo}")
    datos: dict[str, str] = {}
    for linea in archivo.read_text(encoding="utf-8", errors="replace").splitlines():
        if linea and not linea.startswith("#") and "=" in linea:
            clave, valor = linea.split("=", 1)
            datos[clave.strip()] = valor.strip()
    return datos


def esperar(host: str, puerto: int, segundos: int) -> bool:
    fin = time.time() + segundos
    while time.time() < fin:
        try:
            socket.create_connection((host, puerto), timeout=2).close()
            return True
        except OSError:
            time.sleep(2)
    return False


def arrancar(servidor: pathlib.Path, log: pathlib.Path) -> subprocess.Popen | None:
    args = sorted(servidor.glob("libraries/net/neoforged/neoforge/*/unix_args.txt"))
    if not args:
        return None
    orden = ["java", "@user_jvm_args.txt", f"@{args[-1].relative_to(servidor)}", "nogui"]
    with log.open("wb") as salida:
        return subprocess.Popen(orden, cwd=servidor, stdout=salida, stderr=subprocess.STDOUT)


def _pone_mano(r: Rcon, cartas: dict[int, int], palos: dict[int, int]) -> None:
    r.cmd("function swr:bar/poker/limpiar_a")
    for rango, cuantas in cartas.items():
        r.cmd(f"scoreboard players set r{rango} manoA {cuantas}")
    for palo, cuantas in palos.items():
        r.cmd(f"scoreboard players set s{palo} manoA {cuantas}")


def comprobar(r: Rcon, nombre: str) -> tuple[bool, str]:
    if nombre.startswith("datapack"):
        salida = r.cmd("datapack list")
        return ("panel-del-reino" in salida, salida.splitlines()[0] if salida else "")
    if nombre.startswith("load"):
        salida = r.cmd("scoreboard players get CIEN swr")
        return ("CIEN has 100" in salida, salida)
    if nombre.startswith("poker"):
        _pone_mano(r, {13: 4, 4: 1}, {1: 1, 2: 1, 3: 1, 4: 2})
        r.cmd("function swr:bar/poker/evaluar_a")
        salida = r.cmd("scoreboard players get MANO_JUGADOR poker")
        return ("has 813" in salida, salida)
    if nombre.startswith("bolos"):
        r.cmd("function swr:bar/bolos/montar")
        r.cmd("scoreboard players set CUENTA swr 0")
        r.cmd("execute as @e[tag=swr_bolo] run scoreboard players add CUENTA swr 1")
        salida = r.cmd("scoreboard players get CUENTA swr")
        return ("has 10" in salida, salida)
    if nombre.startswith("bar"):
        salida = r.cmd("function swr:bar/estado")
        return ("Unknown function" not in salida, salida.splitlines()[0] if salida else "")
    return (False, "comprobacion desconocida")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--servidor", type=pathlib.Path, default=pathlib.Path("/var/tmp/sw3"))
    ap.add_argument("--espera", type=int, default=300, help="segundos maximos esperando a RCON")
    ap.add_argument("--no-arrancar", action="store_true", help="usa un servidor ya encendido")
    ap.add_argument("--dejar", action="store_true", help="no apaga el servidor al terminar")
    ap.add_argument("--solo-listar", action="store_true", help="no toca el servidor: lista las pruebas")
    args = ap.parse_args()

    if args.solo_listar:
        print("Comprobaciones que hace este arnes:")
        for i, nombre in enumerate(COMPROBACIONES, start=1):
            print(f"  {i}. {nombre}")
        return 0

    props = propiedades(args.servidor)
    host = props.get("rcon.host", "127.0.0.1") or "127.0.0.1"
    puerto = int(props.get("rcon.port", "25575"))
    clave = props.get("rcon.password", "")

    proceso = None
    log = args.servidor / "prueba-servidor.log"
    if not args.no_arrancar and not esperar(host, puerto, 1):
        print(f"arrancando el servidor ({args.servidor})...")
        proceso = arrancar(args.servidor, log)
        if proceso is None:
            print("no encuentro libraries/net/neoforged/neoforge/*/unix_args.txt")
            return 2
    if not esperar(host, puerto, args.espera):
        print(f"RCON no responde en {host}:{puerto} tras {args.espera}s (mira {log})")
        return 2

    r = Rcon(host, puerto, clave)
    r.cmd("reload")
    time.sleep(4)

    fallos = 0
    for nombre in COMPROBACIONES:
        try:
            ok, detalle = comprobar(r, nombre)
        except OSError as error:
            ok, detalle = False, f"error de RCON: {error}"
        print(f"[{'OK' if ok else 'FALLO'}] {nombre}")
        if not ok:
            print(f"        {detalle.strip()[:200]}")
            fallos += 1

    r.cmd("kill @e[tag=swr_bolo]")
    r.cmd("kill @e[tag=swr_bola]")
    r.cmd("kill @e[tag=swr_bolos_origen]")
    r.cmd("scoreboard players set CUENTA swr 0")
    if proceso is not None and not args.dejar:
        r.cmd("stop")
        try:
            proceso.wait(timeout=120)
        except subprocess.TimeoutExpired:
            proceso.kill()
    r.cerrar()
    print(f"{len(COMPROBACIONES) - fallos}/{len(COMPROBACIONES)} comprobaciones OK")
    return 0 if fallos == 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
