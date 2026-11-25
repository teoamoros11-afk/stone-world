"""Tramo A: los 29 sistemas que se pueden probar sin cliente.

Cada prueba mira lo que el juego no avisa: que el comando exista, que el estado se
guarde, que una puerta no cobre de menos y que el menu lleve a todo. No sustituye a
jugar la escena, pero si algo se rompe al tocar el pack, salta aqui.
"""

from __future__ import annotations

from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
FUNCIONES = RAIZ / "panel" / "data" / "swr" / "function"


def lee(ruta: str) -> str:
    return (FUNCIONES / ruta).read_text(encoding="utf-8")


def lineas(ruta: str) -> list[str]:
    return [l for l in lee(ruta).splitlines() if l.strip() and not l.lstrip().startswith("#")]


def test_el_menu_del_tramo_a_llega_a_todos_los_sistemas():
    menu = lee("serie/tramo_a.mcfunction")
    for ruta in (
        "serie/cueva", "serie/arranque", "serie/prologo", "serie/millon", "serie/biblioteca",
        "serie/bout", "serie/juicio", "serie/politica", "serie/consejo", "serie/radio",
        "serie/telefono", "serie/fax", "serie/prensa", "serie/camara", "serie/casino",
        "serie/moneda", "serie/mercado", "serie/escuela", "serie/hospital", "serie/fotos",
        "serie/carteles", "serie/cementerio", "serie/colocar/superalloy", "serie/estatuas",
        "serie/onda", "serie/petrificar", "serie/frase", "serie/luna", "serie/satelite",
    ):
        assert f"/function swr:{ruta}" in menu, f"el menu no lleva a {ruta}"


def test_load_crea_el_estado_del_tramo_a():
    carga = lee("load.mcfunction")
    for objetivo in ("serie", "moneda", "bout"):
        assert f"scoreboard objectives add {objetivo} " in carga
    for marca in ("REVIDOS_TOTAL", "ONDA_T", "SATELITE_INTENTOS", "TELEFONO_BATERIA", "DECRETO"):
        assert f"scoreboard players add {marca} serie 0" in carga


def test_la_cueva_repone_el_yacimiento_y_se_reprograma():
    ciclo = lineas("serie/cueva/ciclo.mcfunction")
    assert any("bone_meal 16" in l for l in ciclo)
    assert any("water_cauldron" in l for l in ciclo)
    assert any("schedule function swr:serie/cueva/ciclo 1200t replace" in l for l in ciclo)


def test_el_arranque_vacia_y_cuenta_los_dias():
    ini = lee("serie/arranque/iniciar.mcfunction")
    assert "spawnpoint @s" in ini and "clear @s" in ini
    assert "scoreboard players set DIAS serie 0" in ini
    dia = lee("serie/arranque/dia.mcfunction")
    assert "scoreboard players add DIAS serie 1" in dia
    assert "schedule function swr:serie/arranque/dia 24000t replace" in dia


def test_el_prologo_pone_nombre_a_las_cuatro_estatuas():
    pro = lee("serie/prologo/estatuas.mcfunction")
    for nombre in ("Byakuya", "Lillian", "Taiju", "Yuzuriha"):
        assert f'"text":"{nombre}"' in pro
    assert pro.count("drstonekos petrify") == 1
    assert "scoreboard players add ESTATUAS swr 4" in pro


def test_el_millon_cuenta_desde_el_despetrificado_y_tiene_hitos():
    uno = lee("pueblo/despetrificar_uno.mcfunction")
    assert "scoreboard players add REVIDOS_TOTAL serie 1" in uno
    assert "function swr:serie/millon/hito" in uno
    hito = lee("serie/millon/hito.mcfunction")
    for cifra in ("1000", "10000", "100000", "1000000"):
        assert f"REVIDOS_TOTAL serie matches {cifra}" in hito


def test_el_grand_bout_es_mejor_de_tres_y_entrega_premio():
    ini = lee("serie/bout/iniciar.mcfunction")
    assert "scoreboard players set @a bout 0" in ini
    punto = lee("serie/bout/punto.mcfunction")
    assert "scoreboard players add @s bout 1" in punto
    assert "matches 3.." in punto and "serie/bout/ganar" in punto
    assert "gold_ingot" in lee("serie/bout/ganar.mcfunction")


def test_el_juicio_deja_un_voto_por_jugador():
    for voto in ("si", "no"):
        texto = lee(f"serie/juicio/{voto}.mcfunction")
        assert "tag=swr_voto_juicio" in texto
        assert "scoreboard players add JUICIO_" in texto
    resolver = lee("serie/juicio/resolver.mcfunction")
    assert "score JUICIO_SI serie > JUICIO_NO serie" in resolver
    assert "tag @a remove swr_voto_juicio" in resolver


def test_la_politica_tiene_tres_decretos_con_efecto():
    decreto = lee("serie/politica/decreto.mcfunction")
    assert "CUPO swr 5" in decreto
    assert "pueblo/casa/empezar" in decreto
    assert "minecraft:iron_golem" in decreto


def test_el_consejo_cuenta_atras_y_se_para():
    orden = lee("serie/consejo/orden.mcfunction")
    assert "scoreboard players set CONSEJO_T serie 60" in orden
    cuenta = lee("serie/consejo/cuenta.mcfunction")
    assert "scoreboard players remove CONSEJO_T serie 1" in cuenta
    assert "matches 1.." in cuenta


def test_la_radio_corta_con_stanley_y_alcanza_sesenta_y_cuatro():
    decir = lee("serie/radio/decir.mcfunction")
    assert "tag=swr_es_stanley,distance=..24" in decir
    assert "@a[distance=..64]" in decir
    assert "minecraft:clock" in lee("serie/radio/dar.mcfunction")


def test_el_telefono_gasta_bateria_y_no_deja_la_etiqueta_puesta():
    llamar = lee("serie/telefono/llamar.mcfunction")
    assert "scoreboard players remove TELEFONO_BATERIA serie 1" in llamar
    assert "tag @s remove swr_llamando" in llamar
    assert "scoreboard players set LLAMADA_N serie 0" in llamar
    assert "scoreboard players set TELEFONO_BATERIA serie 5" in lee("serie/telefono/recargar.mcfunction")


def test_el_fax_copia_el_mapa_de_verdad_y_gasta_papel():
    fax = lee("serie/fax/enviar.mcfunction")
    assert "item replace entity @s weapon.mainhand from entity" in fax
    assert "clear @s minecraft:paper 1" in fax
    assert fax.index("minecraft:paper") < fax.index("tag @s add swr_fax")


def test_la_imprenta_cobra_tres_papeles_y_un_tinte():
    prensa = lee("serie/prensa/imprimir.mcfunction")
    assert "run clear @s minecraft:paper 0" in prensa
    assert "run clear @s minecraft:ink_sac 0" in prensa
    assert "clear @s minecraft:paper 3" in prensa


def test_la_camara_cuenta_entidades_y_avisa_por_ciclo():
    vigilar = lee("serie/camara/vigilar.mcfunction")
    assert "scoreboard players add CAMARA_N serie 1" in vigilar
    assert "tellraw @a" in vigilar
    ciclo = lee("serie/camara/ciclo.mcfunction")
    assert "function swr:serie/camara/vigilar" in ciclo
    assert "schedule function swr:serie/camara/ciclo 1200t replace" in ciclo


def test_el_casino_usa_fichas_y_solo_paga_lo_que_debe():
    ruleta = lee("serie/casino/ruleta.mcfunction")
    assert "scoreboard players remove @s fichas 5" in ruleta
    assert "random value 1..36" in ruleta
    assert "scoreboard players add @s fichas 10" in ruleta
    blackjack = lee("serie/casino/blackjack.mcfunction")
    assert "random value 2..21" in blackjack and "CASINO_ACTIVO serie 1" in blackjack


def test_la_moneda_y_el_mercado_cuentan_lo_que_de_verdad_hay():
    assert "scoreboard players add @s moneda 9" in lee("serie/moneda/cambiar.mcfunction")
    trueque = lee("serie/mercado/trueque.mcfunction")
    assert "run clear @s minecraft:wheat 0" in trueque
    assert "matches ..7" in trueque
    assert "clear @s minecraft:wheat 8" in trueque


def test_la_escuela_necesita_tres_aciertos_y_cierra():
    pregunta = lee("serie/escuela/pregunta.mcfunction")
    assert "scoreboard players set EXAMEN_PREG serie 1" in pregunta
    assert pregunta.count("serie/escuela/acertar") == 3
    assert "matches 3.." in lee("serie/escuela/acertar.mcfunction")
    assert "EXAMEN_ACTIVO serie 0" in lee("serie/escuela/aprobar.mcfunction")


def test_el_hospital_gasta_una_sulfamida_del_mod():
    curar = lee("serie/hospital/curar.mcfunction")
    assert "stonepharmacy:sulfamida" in curar
    assert "clear @s stonepharmacy:sulfamida 1" in curar
    assert "effect clear @s minecraft:nausea" in curar


def test_las_seis_rutinas_que_faltaban_estan_en_el_horario():
    rutinas = lee("pueblo/horario/rutinas.mcfunction")
    for tag in ("kaseki", "ginro", "jasper", "magma", "turquoise", "sapphire"):
        assert f"swr_es_{tag}" in rutinas
        assert f"swr_es_{tag}] run data merge entity @s {{NoAI:1b}}" in rutinas


def test_fotos_carteles_y_cementerio_tienen_su_objeto():
    assert "minecraft:spyglass" in lee("serie/fotos/revelar.mcfunction")
    assert "minecraft:item_frame" in lee("serie/fotos/montar.mcfunction")
    assert "front_text" in lee("serie/carteles/montar.mcfunction")
    assert "BYAKUYA" in lee("serie/cementerio/montar.mcfunction")
    assert "block.jukebox.play" in lee("serie/cementerio/visitar.mcfunction")


def test_superalloy_city_se_construye_y_esta_en_el_menu_de_planos():
    ciudad = lee("serie/colocar/superalloy.mcfunction")
    assert "fill" in ciudad and "minecraft:iron_block" in ciudad
    assert "SUPERALLOY CITY" in ciudad
    assert "serie/colocar/superalloy" in lee("serie/colocar.mcfunction")


def test_las_estatuas_del_mundo_son_ocho_y_se_cuentan():
    mundo = lee("serie/estatuas/mundo.mcfunction")
    assert mundo.count("summon minecraft:villager") == 8
    assert "scoreboard players add MUNDO_ESTATUAS serie 8" in mundo
    assert "MUNDO_ESTATUAS" in lee("serie/estatuas/estado.mcfunction")


def test_la_onda_cuenta_cinco_segundos_y_cubre_cuarenta_bloques():
    ini = lee("serie/onda/iniciar.mcfunction")
    assert "scoreboard players set ONDA_T serie 5" in ini
    disparo = lee("serie/onda/disparar.mcfunction")
    assert "distance=..40" in disparo
    assert "drstonekos petrify" in disparo


def test_el_jugador_petrificado_guarda_y_recupera_su_inventario():
    pet = lee("serie/petrificar/jugador.mcfunction")
    rev = lee("serie/petrificar/revivir.mcfunction")
    assert "data modify storage swr:petrificado Inventario set from entity @s Inventory" in pet
    assert "clear @s" in pet and "swr_petrificado" in pet
    assert "drstonekos petrify" in pet
    assert "data modify entity @s Inventory set from storage swr:petrificado Inventario" in rev
    assert "tag @s remove swr_petrificado" in rev
    assert "drstonekos depetrify" in rev and "effect clear @s drstonekos:petrified" in rev


def test_la_frase_se_programa_una_vez_al_dia_sin_depender_de_un_jugador():
    ciclo = lee("serie/frase/ciclo.mcfunction")
    assert "function swr:serie/frase/decir" in ciclo
    assert "24000t" in ciclo
    assert '{"selector":"@s"}' not in lee("serie/frase/decir.mcfunction")


def test_el_valle_lunar_tiene_capsula_y_colonia():
    valle = lee("serie/luna/valle.mcfunction")
    assert "TAURUS-LITTROW" in valle
    assert "minecraft:sea_lantern" in valle
    assert "swr_valle" in valle


def test_el_satelite_falla_seis_veces_y_acierta_a_la_septima():
    intento = lee("serie/satelite/intento.mcfunction")
    assert "random value 1..6" in intento
    assert "matches 7 run" in intento
    assert "EN ORBITA" in intento
    assert "SATELITE_INTENTOS" in lee("serie/satelite/estado.mcfunction")
