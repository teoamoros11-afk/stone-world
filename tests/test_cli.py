"""Pruebas del CLI: códigos de salida y salida en JSON."""

from __future__ import annotations

import json

from validador.cli import main


def test_pack_limpio_devuelve_cero(pack, capsys):
    pack.funcion("tick", "say hola\n")
    assert main([str(pack.raiz)]) == 0
    assert "TODO OK" in capsys.readouterr().out


def test_pack_roto_devuelve_uno(pack, capsys):
    pack.funcion("tick", "/say hola\n")
    assert main([str(pack.raiz)]) == 1
    assert "No empaquetar así" in capsys.readouterr().out


def test_solo_errores_esconde_los_avisos(pack, capsys):
    pack.funcion("tick", "comando_de_mod @s\n")
    assert main(["--solo-errores", str(pack.raiz)]) == 0
    assert "no es un comando de vainilla" not in capsys.readouterr().out


def test_salida_json(pack, capsys):
    pack.funcion("tick", "/say hola\n")
    assert main(["--json", str(pack.raiz)]) == 1
    datos = json.loads(capsys.readouterr().out)
    entrada = datos[str(pack.raiz)]
    assert entrada["errores"] == 1
    assert entrada["problemas"][0]["nivel"] == "error"
    assert entrada["archivos"] == 1


def test_ruta_inexistente_devuelve_dos(tmp_path, capsys):
    assert main([str(tmp_path / "no_existe")]) == 2
    assert "no existe" in capsys.readouterr().err
