"""Pruebas de .mcfunction: sintaxis, composición y comandos."""

from __future__ import annotations

from validador.funciones import comprobar
from validador.modelo import Archivo


def _archivo(pack, nombre="rota", cuerpo=""):
    ruta = pack.funcion(nombre, cuerpo)
    return Archivo(
        ruta=ruta,
        relativa=str(ruta.relative_to(pack.raiz)),
        namespace="prueba",
        tipo="function",
        nombre=nombre,
    )


def _errores(pack, cuerpo):
    return [p for p in comprobar(_archivo(pack, cuerpo=cuerpo)) if p.nivel == "error"]


def _avisos(pack, cuerpo):
    return [p for p in comprobar(_archivo(pack, cuerpo=cuerpo)) if p.nivel == "aviso"]


def test_funcion_limpia_no_da_nada(pack):
    cuerpo = (
        "# comentario\n"
        "\n"
        "say hola\n"
        "execute as @a at @s run particle minecraft:flame ~ ~ ~ 0 0 0 0 1\n"
        "scoreboard players add #contador swr_tick 1\n"
    )
    assert not _errores(pack, cuerpo)


def test_barra_al_principio(pack):
    errores = _errores(pack, "/say hola\n")
    assert any("no llevan «/»" in p.mensaje for p in errores)


def test_tabulador(pack):
    assert any("tabulador" in p.mensaje for p in _errores(pack, "say\thola\n"))


def test_comillas_sin_cerrar(pack):
    assert any("comillas" in p.mensaje for p in _errores(pack, 'tellraw @a {"text":"hola}\n'))


def test_llave_sin_cerrar(pack):
    assert any("falta cerrar" in p.mensaje for p in _errores(pack, "tellraw @a {\"text\":\"hola\"\n"))


def test_corchete_de_mas(pack):
    assert any("sin abrir" in p.mensaje for p in _errores(pack, "say hola]\n"))


def test_corchetes_dentro_de_comillas_no_cuentan(pack):
    cuerpo = 'tellraw @a {"text":"usa [esto] y {aquello}"}\n'
    assert not _errores(pack, cuerpo)


def test_tellraw_con_json_valido(pack):
    assert not _errores(pack, 'tellraw @a {"text":"hola","color":"gold"}\n')


def test_tellraw_con_json_invalido(pack):
    errores = _errores(pack, 'tellraw @a {"text":"hola",}\n')
    assert any("JSON inválido" in p.mensaje for p in errores)


def test_title_con_json_invalido(pack):
    errores = _errores(pack, "title @s title notjson\n")
    assert any("JSON inválido" in p.mensaje for p in errores)


def test_title_con_json_valido(pack):
    pack.funcion(
        "ok",
        'title @s title [{"text":"a","color":"red"},{"text":"b"}]\n',
    )
    archivo = Archivo(
        ruta=pack.raiz / "data/prueba/function/ok.mcfunction",
        relativa="data/prueba/function/ok.mcfunction",
        namespace="prueba",
        tipo="function",
        nombre="ok",
    )
    assert not [p for p in comprobar(archivo) if p.nivel == "error"]


def test_execute_sin_run_es_legal(pack):
    """`execute if ...` sin run es una condición válida, no un error."""
    assert not _errores(pack, "execute if entity @a[tag=x]\nexecute as @a at @s If\n")


def test_execute_con_run_vacio(pack):
    assert any("sin nada detrás de run" in p.mensaje for p in _errores(pack, "execute as @a run\n"))


def test_title_times_no_lleva_json(pack):
    assert not _errores(pack, "title @a times 5 50 20\ntitle @a clear\ntitle @a reset\n")


def test_texto_entre_comillas_no_cuenta_como_llamada(pack):
    cuerpo = (
        'tellraw @a {"text":"Otra: /function swr:lo_que_sea"}\n'
        'give @a written_book[minecraft:written_book_content={pages:[\'/function swr:viaje/\']}]\n'
    )
    assert not _errores(pack, cuerpo)


def test_comando_detras_del_run_tambien_se_mira(pack):
    errores = _errores(pack, "execute as @a run tellraw @s {\"text\":\"x\",}\n")
    assert any("JSON inválido" in p.mensaje for p in errores)


def test_comando_desconocido_es_solo_aviso(pack):
    avisos = _avisos(pack, "thirst set @s 10\n")
    assert any("no es un comando de vainilla" in p.mensaje for p in avisos)
    assert not _errores(pack, "thirst set @s 10\n")


def test_comentario_con_comandos_no_se_mira(pack):
    assert not _errores(pack, "# esto es /say y no pasa nada\n")


def test_bom_se_avisa(pack):
    ruta = pack.escribir("data/prueba/function/con_bom.mcfunction", "\ufeffsay hola\n")
    archivo = Archivo(
        ruta=ruta,
        relativa="data/prueba/function/con_bom.mcfunction",
        namespace="prueba",
        tipo="function",
        nombre="con_bom",
    )
    assert any(p.nivel == "aviso" and "BOM" in p.mensaje for p in comprobar(archivo))
