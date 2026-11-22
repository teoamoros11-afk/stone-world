"""Piezas comunes de las pruebas: un pack de juguete en un directorio temporal.

Nada de fixtures con datos del proyecto real: cada prueba monta el pack mínimo
que necesita, para que un cambio en el pack de verdad no rompa los tests (y al
revés).
"""

from __future__ import annotations

import json
from pathlib import Path

import pytest


class PackFalso:
    """Un pack en un directorio temporal, con atajos para escribir archivos."""

    def __init__(self, raiz: Path):
        self.raiz = raiz

    def escribir(self, relativa: str, contenido: str) -> Path:
        ruta = self.raiz / relativa
        ruta.parent.mkdir(parents=True, exist_ok=True)
        ruta.write_text(contenido, encoding="utf-8")
        return ruta

    def json(self, relativa: str, datos) -> Path:
        return self.escribir(relativa, json.dumps(datos, ensure_ascii=False))

    def funcion(self, nombre: str, cuerpo: str, namespace: str = "prueba") -> Path:
        return self.escribir(f"data/{namespace}/function/{nombre}.mcfunction", cuerpo)


@pytest.fixture
def pack(tmp_path: Path) -> PackFalso:
    """Pack vacío pero válido: con pack.mcmeta y data/."""
    falso = PackFalso(tmp_path / "pack")
    (falso.raiz / "data").mkdir(parents=True)
    falso.json(
        "pack.mcmeta",
        {"pack": {"pack_format": 48, "description": "Pack de prueba"}},
    )
    return falso


@pytest.fixture
def mensajes(pack):
    """Ayuda para leer los problemas como texto y afirmar sobre ellos."""

    def _leer(problemas) -> list[str]:
        return [str(p) for p in problemas]

    return _leer
