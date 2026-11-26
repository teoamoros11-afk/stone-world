"""El validador de datapacks de Stone World.

Uso rápido:

    python3 -m validador panel pack-inmersion
    python3 -m validador --json panel

Cada comprobación vive en su módulo (estructura, jsons, funciones) y todos
devuelven la misma lista de `Problema`. El CLI los junta y decide el código de
salida: 1 si hay algún error, 0 si solo hay avisos.
"""

from __future__ import annotations

from .jsons import comprobar as comprobar_jsons
from .modelo import Pack, Problema, cargar
from .recursos import comprobar as comprobar_recursos
from .funciones import (
    comprobar as comprobar_funciones,
    comprobar_referencias,
)

__all__ = [
    "Pack",
    "Problema",
    "cargar",
    "revisar",
]


def revisar(raiz) -> list[Problema]:
    """Carga un pack y le pasa todas las comprobaciones, ordenadas."""
    pack = cargar(raiz)
    problemas = list(pack.problemas)
    problemas.extend(comprobar_jsons(pack))
    problemas.extend(comprobar_recursos(pack))
    for archivo in pack.de_tipo("function"):
        problemas.extend(comprobar_funciones(archivo))
    problemas.extend(comprobar_referencias(pack))
    # Los errores primero, y dentro por archivo y línea: así se lee de arriba
    # abajo sin saltar.
    problemas.sort(key=lambda p: (p.nivel != "error", p.sitio, p.mensaje))
    return problemas
