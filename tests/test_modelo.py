"""Pruebas del descubrimiento: qué archivos hay y cómo se llaman."""

from __future__ import annotations

from validador import revisar
from validador.modelo import cargar, tipo_canonico


def _niveles(problemas, nivel="error"):
    return [p for p in problemas if p.nivel == nivel]


def test_descubre_funciones_y_tags(pack):
    pack.funcion("panel/ver", "say hola\n")
    pack.json("data/prueba/tags/function/arranque.json", {"values": ["prueba:panel/ver"]})

    modelo = cargar(pack.raiz)
    funciones = modelo.de_tipo("function")
    tags = modelo.de_tipo("tag", subtipo="function")

    assert [f.id for f in funciones] == ["prueba:panel/ver"]
    assert [t.id for t in tags] == ["prueba:arranque"]
    assert not _niveles(modelo.problemas)


def test_acepta_plural_de_versiones_anteriores(pack):
    pack.escribir("data/prueba/functions/vieja.mcfunction", "say hola\n")
    modelo = cargar(pack.raiz)
    assert "prueba:vieja" in modelo.ids("function")
    assert tipo_canonico("functions") == "function"


def test_carpeta_de_tipo_desconocida_es_error(pack):
    pack.escribir("data/prueba/funciones/rara.mcfunction", "say hola\n")
    modelo = cargar(pack.raiz)
    errores = _niveles(modelo.problemas)
    assert any("desconocida" in p.mensaje for p in errores)


def test_extension_que_no_toca_es_error(pack):
    pack.escribir("data/prueba/function/no_soy_funcion.json", "{}")
    modelo = cargar(pack.raiz)
    assert any("solo van archivos .mcfunction" in p.mensaje for p in _niveles(modelo.problemas))


def test_falta_pack_mcmeta(pack):
    (pack.raiz / "pack.mcmeta").unlink()
    modelo = cargar(pack.raiz)
    assert any("pack.mcmeta" in p.mensaje for p in _niveles(modelo.problemas))


def test_namespace_con_mayusculas(pack):
    pack.escribir("data/Prueba/function/x.mcfunction", "say hola\n")
    modelo = cargar(pack.raiz)
    assert any("namespace inválido" in p.mensaje for p in _niveles(modelo.problemas))


def test_identificador_repetido_solo_cambiando_mayusculas(pack):
    pack.funcion("ver", "say hola\n")
    pack.escribir("data/prueba/function/Ver.mcfunction", "say hola\n")
    modelo = cargar(pack.raiz)
    assert any("repetido" in p.mensaje for p in _niveles(modelo.problemas))


def test_archivo_suelto_en_data(pack):
    pack.escribir("data/suelto.txt", "hola")
    modelo = cargar(pack.raiz)
    assert any("suelto en data/" in p.mensaje for p in _niveles(modelo.problemas))


def test_pack_vacio_del_todo_no_es_un_pack(tmp_path):
    (tmp_path / "vacio").mkdir()
    modelo = cargar(tmp_path / "vacio")
    assert any("no parece un pack" in p.mensaje for p in _niveles(modelo.problemas))


def test_revisar_junta_todas_las_comprobaciones(pack):
    pack.funcion("rota", "/say hola\n")
    problemas = revisar(pack.raiz)
    assert any("no llevan" in p.mensaje for p in problemas)
