"""Los cuatro planos del tramo A: NBT valido, colocable y reproducible."""

from __future__ import annotations

import gzip
import struct
import subprocess
import sys
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
ESTRUCTURAS = RAIZ / "panel" / "data" / "swr" / "structure"
COLOCAR = RAIZ / "panel" / "data" / "swr" / "function" / "serie" / "colocar"
FUNCIONES = RAIZ / "panel" / "data" / "swr" / "function"
PLANOS = ("isla_tesoro", "corn_city", "haber_bosch", "araxa")


def datos(nombre: str) -> bytes:
    return gzip.decompress((ESTRUCTURAS / f"{nombre}.nbt").read_bytes())


def test_los_cuatro_planos_existen_y_son_nbt():
    for nombre in PLANOS:
        ruta = ESTRUCTURAS / f"{nombre}.nbt"
        assert ruta.is_file(), f"falta el plano {nombre}"
        crudo = datos(nombre)
        assert crudo[0] == 10, f"{nombre} no empieza con un compuesto NBT"
        for clave in (b"DataVersion", b"size", b"palette", b"blocks", b"entities"):
            assert clave in crudo, f"{nombre} no tiene {clave.decode()}"


def test_dataversion_y_tamano_razonable():
    for nombre in PLANOS:
        crudo = datos(nombre)
        assert struct.pack(">i", 3955) in crudo, f"{nombre} no es de 1.21.1"
        assert len(crudo) > 50_000, f"{nombre} parece vacio"


def test_cada_plano_tiene_su_funcion_de_colocacion():
    for nombre in PLANOS:
        texto = (COLOCAR / f"{nombre}.mcfunction").read_text(encoding="utf-8")
        assert f"place template swr:{nombre}" in texto, f"{nombre} no se coloca"
        assert "execute at @s" in texto, f"{nombre} no se coloca donde esta el jugador"


def test_el_generador_reproduce_los_archivos():
    resultado = subprocess.run(
        [sys.executable, str(RAIZ / "herramientas" / "generar_estructuras.py"), "--comprobar"],
        capture_output=True,
        text=True,
    )
    assert resultado.returncode == 0, resultado.stdout + resultado.stderr


def test_hay_un_menu_para_los_cuatro_planos():
    texto = (FUNCIONES / "serie" / "colocar.mcfunction").read_text(encoding="utf-8")
    for nombre in PLANOS:
        assert f"swr:serie/colocar/{nombre}" in texto, f"el menu no ofrece {nombre}"
