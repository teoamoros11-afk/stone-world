"""La línea de comandos del validador."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from . import revisar
from .modelo import cargar

RAIZ = Path(__file__).resolve().parent.parent  # minecraft/stone-world/
PACKS_POR_DEFECTO = ["panel", "pack-inmersion"]


def _resumen(problemas) -> tuple[int, int]:
    errores = sum(1 for p in problemas if p.nivel == "error")
    return errores, len(problemas) - errores


def _construir_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="validador",
        description="Comprueba datapacks y resourcepacks de Minecraft 1.21.1.",
    )
    parser.add_argument(
        "packs",
        nargs="*",
        help="rutas de los packs (por defecto: panel y pack-inmersion)",
    )
    parser.add_argument("--json", action="store_true", help="salida en JSON, para el CI")
    parser.add_argument(
        "--solo-errores", action="store_true", help="no imprimir los avisos"
    )
    parser.add_argument(
        "--raiz", type=Path, default=RAIZ, help="dónde buscar si las rutas son relativas"
    )
    return parser


def _resultado_json(rutas: list[Path]) -> dict:
    salida = {}
    for ruta in rutas:
        pack = cargar(ruta)
        problemas = revisar(ruta)
        archivos = len(pack.archivos)
        errores, avisos = _resumen(problemas)
        salida[str(ruta)] = {
            "archivos": archivos,
            "errores": errores,
            "avisos": avisos,
            "problemas": [
                {"nivel": p.nivel, "sitio": p.sitio, "mensaje": p.mensaje} for p in problemas
            ],
        }
    return salida


def main(argv: list[str] | None = None) -> int:
    args = _construir_parser().parse_args(argv)

    rutas = [args.raiz / p for p in (args.packs or PACKS_POR_DEFECTO)]
    faltan = [r for r in rutas if not r.is_dir()]
    if faltan:
        for ruta in faltan:
            print(f"error: no existe {ruta}", file=sys.stderr)
        return 2

    if args.json:
        resultado = _resultado_json(rutas)
        print(json.dumps(resultado, ensure_ascii=False, indent=2))
        return 1 if any(v["errores"] for v in resultado.values()) else 0

    total_errores = 0
    for ruta in rutas:
        pack = cargar(ruta)
        problemas = revisar(ruta)
        errores, avisos = _resumen(problemas)
        total_errores += errores

        print(f"\n=== {ruta.name} ===")
        print(f"{len(pack.archivos)} archivos · {errores} errores · {avisos} avisos")

        for problema in problemas:
            if args.solo_errores and problema.nivel != "error":
                continue
            print(f"  {problema}")

    print()
    if total_errores:
        print(f"RESULTADO: {total_errores} error(es). No empaquetar así.")
        return 1
    print("RESULTADO: TODO OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
