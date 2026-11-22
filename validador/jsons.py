"""Valida los JSON del pack: que se leen, y que tienen la forma que pide Minecraft.

Un JSON mal escrito en un datapack no rompe el mundo: Minecraft lo ignora con
un aviso en el log y el pack sigue a medias. Por eso conviene cazarlo aquí,
antes de empaquetar. Además de «¿es JSON válido?» se miran las cuatro cosas
que suelen faltar: pack.mcmeta, los tags, los advancements y las loot tables.
"""

from __future__ import annotations

import json
from typing import Any

from .modelo import Archivo, Pack, Problema

FORMAS = {
    "advancement": "advancement",
    "predicate": "predicate",
    "loot_table": "loot_table",
    "recipe": "recipe",
}


def _leer(archivo: Archivo) -> tuple[Any, list[Problema]]:
    try:
        texto = archivo.ruta.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return None, [Problema("error", "no está en UTF-8", archivo.relativa)]
    try:
        return json.loads(texto), []
    except json.JSONDecodeError as fallo:
        return None, [
            Problema(
                "error",
                f"JSON inválido: {fallo.msg} (línea {fallo.lineno}, columna {fallo.colno})",
                f"{archivo.relativa}:{fallo.lineno}",
            )
        ]


def comprobar_pack_mcmeta(pack: Pack) -> list[Problema]:
    """Mira pack.mcmeta: es lo único obligatorio de verdad."""
    ruta = pack.raiz / "pack.mcmeta"
    if not ruta.is_file():
        return []  # ya lo avisa el modelo

    archivo = Archivo(ruta=ruta, relativa="pack.mcmeta", namespace="", tipo="mcmeta", nombre="pack")
    datos, problemas = _leer(archivo)
    if datos is None:
        return problemas

    if not isinstance(datos, dict) or not isinstance(datos.get("pack"), dict):
        return [Problema("error", "falta el objeto «pack»", "pack.mcmeta")]

    bloque = datos["pack"]
    formato = bloque.get("pack_format")
    if not isinstance(formato, int):
        problemas.append(Problema("error", "«pack_format» tiene que ser un número entero", "pack.mcmeta"))
    elif formato < 1:
        problemas.append(Problema("error", f"«pack_format» no puede ser {formato}", "pack.mcmeta"))

    if "supported_formats" in bloque:
        soportado = bloque["supported_formats"]
        if not isinstance(soportado, (int, list, dict)):
            problemas.append(
                Problema("error", "«supported_formats» debe ser un número, una lista o un objeto", "pack.mcmeta")
            )

    descripcion = bloque.get("description")
    if descripcion is None:
        problemas.append(Problema("aviso", "sin «description»; el jugador ve un pack sin nombre", "pack.mcmeta"))
    elif not isinstance(descripcion, (str, dict, list)):
        problemas.append(Problema("error", "«description» debe ser texto o un componente", "pack.mcmeta"))

    return problemas


def comprobar_tag(archivo: Archivo) -> list[Problema]:
    datos, problemas = _leer(archivo)
    if datos is None:
        return problemas

    if not isinstance(datos, dict):
        return [Problema("error", "un tag es un objeto con «values»", archivo.relativa)]

    if "values" not in datos:
        problemas.append(Problema("error", "el tag no tiene «values»", archivo.relativa))
        return problemas

    valores = datos["values"]
    if not isinstance(valores, list):
        problemas.append(Problema("error", "«values» tiene que ser una lista", archivo.relativa))
        return problemas

    if not valores:
        problemas.append(Problema("aviso", "tag vacío", archivo.relativa))

    for i, valor in enumerate(valores):
        if isinstance(valor, str):
            if ":" not in valor:
                problemas.append(
                    Problema("error", f"values[{i}]: «{valor}» no lleva namespace", archivo.relativa)
                )
        elif isinstance(valor, dict):
            if "id" not in valor:
                problemas.append(Problema("error", f"values[{i}]: falta «id»", archivo.relativa))
            elif not isinstance(valor["id"], str):
                problemas.append(Problema("error", f"values[{i}]: «id» debe ser texto", archivo.relativa))
            sobra = set(valor) - {"id", "required"}
            if sobra:
                problemas.append(
                    Problema("aviso", f"values[{i}]: claves que Minecraft ignora: {', '.join(sorted(sobra))}", archivo.relativa)
                )
        else:
            problemas.append(
                Problema("error", f"values[{i}]: cada valor es texto u objeto, no {type(valor).__name__}", archivo.relativa)
            )

    sobra = set(datos) - {"values", "replace"}
    if sobra:
        problemas.append(
            Problema("aviso", f"claves que Minecraft ignora en un tag: {', '.join(sorted(sobra))}", archivo.relativa)
        )
    return problemas


def comprobar_advancement(archivo: Archivo) -> list[Problema]:
    datos, problemas = _leer(archivo)
    if datos is None:
        return problemas

    if not isinstance(datos, dict):
        return [Problema("error", "un advancement es un objeto", archivo.relativa)]

    criterios = datos.get("criteria")
    if not isinstance(criterios, dict) or not criterios:
        problemas.append(
            Problema("error", "sin «criteria»: un advancement vacío no se puede completar", archivo.relativa)
        )

    if "display" in datos:
        display = datos["display"]
        if not isinstance(display, dict):
            problemas.append(Problema("error", "«display» debe ser un objeto", archivo.relativa))
        else:
            for clave in ("title", "description"):
                if clave not in display:
                    problemas.append(Problema("error", f"«display» sin «{clave}»", archivo.relativa))
            if "icon" not in display:
                problemas.append(Problema("aviso", "«display» sin «icon»: se ve un icono de piedra", archivo.relativa))

    return problemas


def comprobar_loot_table(archivo: Archivo) -> list[Problema]:
    datos, problemas = _leer(archivo)
    if datos is None:
        return problemas

    if not isinstance(datos, dict):
        return [Problema("error", "una loot table es un objeto", archivo.relativa)]

    if "pools" not in datos and "type" not in datos:
        problemas.append(Problema("error", "sin «pools» ni «type»", archivo.relativa))

    if "pools" in datos and not isinstance(datos["pools"], list):
        problemas.append(Problema("error", "«pools» tiene que ser una lista", archivo.relativa))

    return problemas


def comprobar_predicate(archivo: Archivo) -> list[Problema]:
    datos, problemas = _leer(archivo)
    if datos is None:
        return problemas
    if not isinstance(datos, dict):
        return [Problema("error", "un predicate es un objeto", archivo.relativa)]
    if not datos:
        problemas.append(Problema("aviso", "predicate vacío: siempre se cumple", archivo.relativa))
    return problemas


def comprobar_asset(archivo: Archivo) -> list[Problema]:
    """JSON de resourcepack: basta con que se lea, salvo los idiomas."""
    datos, problemas = _leer(archivo)
    if datos is None:
        return problemas

    if archivo.nombre.startswith("lang/") and isinstance(datos, dict):
        for clave, valor in datos.items():
            if not isinstance(valor, str):
                problemas.append(
                    Problema("error", f"la traducción «{clave}» no es texto", archivo.relativa)
                )
                break
    return problemas


def comprobar(pack: Pack) -> list[Problema]:
    """Pasa por todos los JSON del pack y devuelve lo que no cuadra."""
    problemas = list(comprobar_pack_mcmeta(pack))

    for archivo in pack.archivos:
        if archivo.tipo == "tag":
            problemas.extend(comprobar_tag(archivo))
        elif archivo.tipo == "advancement":
            problemas.extend(comprobar_advancement(archivo))
        elif archivo.tipo == "loot_table":
            problemas.extend(comprobar_loot_table(archivo))
        elif archivo.tipo == "predicate":
            problemas.extend(comprobar_predicate(archivo))
        elif archivo.extension == ".json" and archivo.tipo != "function":
            # Recetas, modificadores, variantes y demás: solo que se lean bien.
            base = archivo.relativa
            if archivo.tipo == "asset":
                problemas.extend(comprobar_asset(archivo))
            else:
                _, fallos = _leer(archivo)
                for fallo in fallos:
                    problemas.append(Problema(fallo.nivel, fallo.mensaje, base))

    return problemas
