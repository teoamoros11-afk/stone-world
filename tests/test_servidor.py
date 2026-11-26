"""El arnes de servidor: que exista, que liste sus pruebas y que no toque nada al listar."""

from __future__ import annotations

import pathlib
import subprocess
import sys

RAIZ = pathlib.Path(__file__).resolve().parent.parent


def test_rcon_es_un_cliente_sin_dependencias():
    texto = (RAIZ / "herramientas" / "rcon.py").read_text(encoding="utf-8")
    assert "class Rcon" in texto
    assert "socket" in texto and "struct" in texto
    imports = [l.strip() for l in texto.splitlines() if l.strip().startswith(("import ", "from "))]
    assert imports == [
        "from __future__ import annotations",
        "import socket",
        "import struct",
        "import sys",
    ], f"solo biblioteca estandar, y hay: {imports}"


def test_el_arnes_lista_sus_comprobaciones():
    salida = subprocess.run(
        [sys.executable, str(RAIZ / "herramientas" / "probar_servidor.py"), "--solo-listar"],
        capture_output=True, text=True, check=True,
    )
    for trozo in ("datapack", "CIEN", "poker", "bolos", "bar", "campo"):
        assert trozo in salida.stdout, f"el arnes no comprueba {trozo}"


def test_el_arnes_no_arranca_nada_al_listar():
    salida = subprocess.run(
        [sys.executable, str(RAIZ / "herramientas" / "probar_servidor.py"), "--solo-listar"],
        capture_output=True, text=True, check=True, timeout=30,
    )
    assert "arrancando" not in salida.stdout
    assert "RCON" not in salida.stdout
