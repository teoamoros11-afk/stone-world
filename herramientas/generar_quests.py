#!/usr/bin/env python3
"""Genera el arbol de misiones de FTB Quests (5 eras) en ./quests.

Formato comprobado contra FTB Quests 2101.1.38 (NeoForge 1.21.1):
el servidor debe decir "Loaded 5 chapters, 27 quests".
Uso: python3 herramientas/generar_quests.py
"""
import pathlib

CAPITULOS = [
    (1, "Era 1 - No morir", "minecraft:wooden_pickaxe", [
        ("Sobrevivir la primera noche", "Pico, hacha, horno y refugio cerrado", "minecraft:wooden_pickaxe", 10),
        ("Fuego y cama", "Antorchas, cama y comida cocinada", "minecraft:campfire", 10),
        ("Ceramica y cuero", "Arcilla, horno y ropa de invierno", "minecraft:brick", 15),
        ("La cueva del milagro", "Encuentra el fluido milagroso", "minecraft:glass_bottle", 20),
        ("Primer revivido", "Despetrifica a tu primer aldeano", "minecraft:golden_apple", 30),
    ]),
    (2, "Era 2 - Ganarse la aldea", "minecraft:bell", [
        ("Diez revividos", "Reune 10 aldeanos despetrificados", "minecraft:villager_spawn_egg", 20),
        ("Town Hall", "Funda la colonia en suelo llano", "minecraft:bell", 25),
        ("El pueblo de los agradecidos", "Al tercer despetrificado levantan su plaza; arranca la obra y termina el taller: /function swr:pueblo/obra/iniciar", "minecraft:scaffolding", 30),
        ("Almacen y constructor", "Coloca almacen y choza de constructor", "minecraft:chest", 20),
        ("Granja y lenador", "Comida y madera sin parar", "minecraft:wheat", 20),
        ("Cerrar la era 2", "Sulfamidas: azufre, azucar y frasco (mod Stone Pharmacy)", "minecraft:brewing_stand", 30),
        ("Primera luz electrica", "Dinamo, cable de cobre y bombilla", "minecraft:redstone_lamp", 25),
        ("Las cien historias", "Pide el libro de Ruri: /function swr:serie/historias", "minecraft:written_book", 15),
    ]),
    (3, "Era 3 - Stone Wars", "minecraft:blast_furnace", [
        ("Hierro a escala", "Horno nivel 3 y mina organizada", "minecraft:blast_furnace", 25),
        ("Baterias de plomo-acido", "Almacena energia para la guerra", "minecraft:bucket", 25),
        ("Central hidroelectrica", "Salto de agua, central y tendido a la aldea", "minecraft:water_bucket", 30),
        ("Papel, tinta y polvora", "Municion y libros", "minecraft:paper", 20),
        ("Radio entre colonias", "CC:Tweaked con modems inalambricos", "minecraft:ender_pearl", 30),
    ]),
    (4, "Era 4 - New World", "minecraft:compass", [
        ("Brujula", "Cartografia la isla", "minecraft:compass", 20),
        ("Barco de vapor", "Astillero en el puerto (zona 5): casco y cubierta", "minecraft:oak_boat", 30),
        ("Botadura", "Pon el casco en el agua: /function swr:tripulacion/botadura", "minecraft:water_bucket", 25),
        ("Tripulacion indispensable", "Navegante, contable y cocinero: /function swr:tripulacion/lista", "minecraft:emerald", 35),
        ("Zarpe del Perseus", "Se niega sin los tres a bordo: /function swr:tripulacion/zarpar", "minecraft:written_book", 35),
        ("Globo y taladro", "Create contraptions", "minecraft:white_banner", 25),
        ("Isla del tesoro", "3.000 al este, en bote: platino y la medusa", "minecraft:diamond", 40),
        ("Dron y radar", "Vigila la costa", "minecraft:spyglass", 30),
        ("La medusa", "Encuentra el dispositivo: /function swr:serie/medusa", "minecraft:heart_of_the_sea", 40),
    ]),
    (5, "Era 5 - Science Future", "minecraft:repeater", [
        ("Computadora", "Circuito impreso con CC:Tweaked", "minecraft:repeater", 35),
        ("Telescopio de fluorita", "Mod de optica del pack", "minecraft:spyglass", 30),
        ("Pan de larga duracion", "Comida para expediciones largas", "minecraft:bread", 20),
        ("Cohete Dr.1", "Ad Astra: cohete de nivel 1 y plataforma de lanzamiento", "minecraft:firework_rocket", 40),
        ("Satelite en orbita", "Ad Astra: pon el satelite en orbita", "minecraft:ender_eye", 40),
        ("Base lunar", "Ad Astra: Luna, oxigeno, traje y base presurizada", "minecraft:white_bed", 50),
        ("Cierre del reino", "Cinco eras cerradas y la humanidad fuera de la Tierra", "minecraft:nether_star", 60),
    ]),
]

def qid(kind, era, seq):
    return f"{kind}{era}{seq:014x}"

def capitulo(era, titulo, icono, quests, dependencia_externa):
    lineas = [
        "{",
        f'\tid: "{qid(1, era, 0)}"',
        f'\tfilename: "era{era}"',
        '\tgroup: ""',
        f'\torder_index: {era - 1}',
        f'\ttitle: "{titulo}"',
        f'\ticon: "{icono}"',
        "\tquest_links: [ ]",
        "\tquests: [",
    ]
    for i, (t, sub, ic, xp) in enumerate(quests):
        deps = []
        if i > 0:
            deps = [qid(2, era, i - 1)]
        elif dependencia_externa:
            deps = [dependencia_externa]
        lineas += [
            "\t\t{",
            f'\t\t\tid: "{qid(2, era, i)}"',
            f"\t\t\tx: {i * 2}.0d",
            "\t\t\ty: 0.0d",
            f'\t\t\ttitle: "{t}"',
            f'\t\t\tsubtitle: "{sub}"',
            f'\t\t\ticon: "{ic}"',
            f'\t\t\ttasks: [ {{ id: "{qid(3, era, i)}", type: "checkmark", title: "{t}" }} ]',
            f'\t\t\trewards: [ {{ id: "{qid(4, era, i)}", type: "xp", xp: {xp} }} ]',
        ]
        if deps:
            lineas.append(f"\t\t\tdependencies: [ {' '.join(chr(34) + d + chr(34) for d in deps)} ]")
        lineas.append("\t\t}")
    lineas += ["\t]", "}", ""]
    return "\n".join(lineas)

base = pathlib.Path("quests")
(base / "chapters").mkdir(parents=True, exist_ok=True)
(base / "data.snbt").write_text(
    '{\n\tversion: 1\n\ttitle: "Reino de la Ciencia"\n\tdefault_quest_shape: "circle"\n'
    "\tdefault_consume_items: false\n\tdefault_autoclaim_rewards: false\n"
    "\tdisable_gui: false\n\tdrop_book_on_death: false\n\tgrid_scale: 0.5\n}\n", encoding="utf-8")
(base / "chapter_groups.snbt").write_text("{\n\tversion: 1\n\tchapter_groups: [ ]\n}\n", encoding="utf-8")

anterior = None
total = 0
for era, titulo, icono, quests in CAPITULOS:
    (base / "chapters" / f"era{era}.snbt").write_text(
        capitulo(era, titulo, icono, quests, anterior), encoding="utf-8")
    anterior = qid(2, era, len(quests) - 1)
    total += len(quests)
print(f"generado: {len(CAPITULOS)} capitulos, {total} misiones")
