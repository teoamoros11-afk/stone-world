"""Comprueba el resourcepack: modelos de ítem, texturas y overrides.

Minecraft no avisa de un modelo que apunta a una textura que falta: el ítem se
queda con el cuadro rojo y negro, y desde la consola no se ve. Tampoco avisa de
dos overrides con el mismo `custom_model_data`: gana el primero y el otro no se
ve nunca. Las dos cosas se saben sin abrir el juego, así que se comprueban aquí.
"""

from __future__ import annotations

import json
import struct

from .modelo import Archivo, Pack, Problema

FIRMA_PNG = b"\x89PNG\r\n\x1a\n"
LADO_ITEM = 16  # una textura de ítem de Minecraft mide 16x16


def _leer_json(archivo: Archivo) -> tuple[object | None, list[Problema]]:
    try:
        return json.loads(archivo.ruta.read_text(encoding="utf-8")), []
    except UnicodeDecodeError:
        return None, [Problema("error", "no está en UTF-8", archivo.relativa)]
    except json.JSONDecodeError as fallo:
        return None, [
            Problema(
                "error",
                f"JSON inválido: {fallo.msg} (línea {fallo.lineno}, columna {fallo.colno})",
                archivo.relativa,
            )
        ]


def _tamano_png(ruta) -> tuple[int, int] | None:
    """Ancho y alto leídos de la cabecera IHDR, sin dependencias."""
    with ruta.open("rb") as f:
        cabecera = f.read(24)
    if len(cabecera) < 24 or cabecera[:8] != FIRMA_PNG:
        return None
    return struct.unpack(">II", cabecera[16:24])


def _es_propio(ref: str, namespaces: set[str]) -> bool:
    """Solo se comprueban los recursos del pack; los de vanilla no están aquí."""
    if ":" not in ref:
        return False
    namespace = ref.split(":", 1)[0]
    return namespace in namespaces and namespace != "minecraft"


def comprobar(pack: Pack) -> list[Problema]:
    """Revisa PNG de ítem y JSON de modelo de ítem del resourcepack."""
    if not (pack.raiz / "assets").is_dir():
        return []

    problemas: list[Problema] = []
    assets = set(pack.ids("asset"))
    namespaces = {a.namespace for a in pack.archivos if a.tipo == "asset"}

    for archivo in pack.archivos:
        if archivo.tipo != "asset":
            continue

        if archivo.extension == ".png" and archivo.nombre.startswith("textures/item/"):
            tamano = _tamano_png(archivo.ruta)
            if tamano is None:
                problemas.append(Problema("error", "no es un PNG válido", archivo.relativa))
            elif tamano != (LADO_ITEM, LADO_ITEM):
                problemas.append(
                    Problema(
                        "error",
                        f"mide {tamano[0]}x{tamano[1]}; una textura de ítem va a "
                        f"{LADO_ITEM}x{LADO_ITEM}",
                        archivo.relativa,
                    )
                )
            continue

        if archivo.extension != ".json" or not archivo.nombre.startswith("models/item/"):
            continue

        datos, fallos = _leer_json(archivo)
        problemas.extend(fallos)
        if not isinstance(datos, dict):
            continue

        texturas = datos.get("textures")
        if texturas is not None:
            if not isinstance(texturas, dict):
                problemas.append(Problema("error", "«textures» debe ser un objeto", archivo.relativa))
            else:
                for capa, ref in texturas.items():
                    if not isinstance(ref, str) or ":" not in ref:
                        problemas.append(
                            Problema(
                                "error",
                                f"textures.{capa} debe ser un id con namespace",
                                archivo.relativa,
                            )
                        )
                    elif _es_propio(ref, namespaces) and f"{ref.split(':', 1)[0]}:textures/{ref.split(':', 1)[1]}" not in assets:
                        problemas.append(
                            Problema("error", f"la textura {ref} no existe en el pack", archivo.relativa)
                        )

        overrides = datos.get("overrides")
        if overrides is None:
            continue
        if not isinstance(overrides, list):
            problemas.append(Problema("error", "«overrides» debe ser una lista", archivo.relativa))
            continue

        vistos: set[int] = set()
        for i, override in enumerate(overrides):
            if not isinstance(override, dict):
                problemas.append(Problema("error", f"overrides[{i}] debe ser un objeto", archivo.relativa))
                continue

            modelo = override.get("model")
            if not isinstance(modelo, str) or ":" not in modelo:
                problemas.append(
                    Problema("error", f"overrides[{i}]: falta «model» con namespace", archivo.relativa)
                )
            elif _es_propio(modelo, namespaces) and f"{modelo.split(':', 1)[0]}:models/{modelo.split(':', 1)[1]}" not in assets:
                problemas.append(
                    Problema(
                        "error",
                        f"overrides[{i}]: el modelo {modelo} no existe en el pack",
                        archivo.relativa,
                    )
                )

            predicate = override.get("predicate")
            if not isinstance(predicate, dict) or "custom_model_data" not in predicate:
                problemas.append(
                    Problema(
                        "error",
                        f"overrides[{i}]: sin «predicate.custom_model_data»",
                        archivo.relativa,
                    )
                )
                continue
            cmd = predicate["custom_model_data"]
            if isinstance(cmd, bool) or not isinstance(cmd, int):
                problemas.append(
                    Problema(
                        "error",
                        f"overrides[{i}]: custom_model_data debe ser un entero",
                        archivo.relativa,
                    )
                )
            elif cmd in vistos:
                problemas.append(
                    Problema(
                        "error",
                        f"custom_model_data {cmd} repetido: el segundo override no se verá",
                        archivo.relativa,
                    )
                )
            else:
                vistos.add(cmd)

    return problemas
