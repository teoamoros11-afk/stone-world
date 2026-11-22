#!/usr/bin/env python3
"""Genera el Cuaderno de campo del reino (datapack panel/).

Que sale:

    panel/data/swr/function/libro/indice.mcfunction        indice: eras con tooltip y clic
    panel/data/swr/function/libro/era/N.mcfunction         que hacer en la era, con formulas al hover
    panel/data/swr/function/libro/cuaderno.mcfunction      reparte el libro segun lo descubierto
    panel/data/swr/function/libro/cuaderno/N.mcfunction    libro con las paginas ya anotadas
    panel/data/swr/function/descubrir/N.mcfunction         anota las formulas de una era

El hover dentro de un libro escrito no lo dibuja el juego: por eso el mapa con tooltips
va por chat (indice y fichas), y el libro es el cuaderno que se va llenando de paginas.

Uso: python3 herramientas/generar_libro.py
"""
import json
import pathlib

BASE = pathlib.Path(__file__).resolve().parent.parent / "panel/data/swr/function"

# (era, titulo, donde, que_hacer, [(id, titulo, materiales, formula, nota)])
ERAS = [
    (1, "No morir", "Cueva del milagro (110, -490) y campo de estatuas (290, 10)",
     "Fuego, cuerda, ceramica y el fluido milagroso; despues, revivir a los primeros aldeanos.",
     [
         ("fuego", "Fuego por friccion", "Madera, cuerda, piedra seca y yesca",
          "W = F*d ; 1 J = 0,24 cal. Frotar convierte trabajo en calor y la yesca prende hacia 250 C.",
          "Es lo primero que construye Senku al salir de la piedra (cap. 1)."),
         ("carbon", "Carbon vegetal", "Lena apilada y tapada con tierra",
          "Pirolisis: C6H10O5 -> 6 C + 5 H2O + volatiles. Rinde cerca del 25 % del peso seco.",
          "Sin carbon no hay hierro: es la llave de toda la metalurgia."),
         ("ceramica", "Ceramica y crisoles", "Arcilla, agua y horno de tiro natural",
          "Caolinita Al2Si2O5(OH)4 -> metacaolin + 2 H2O entre 500 y 600 C; aguanta 900 C.",
          "Crisoles y moldes: sin ceramica no se puede fundir nada."),
         ("fluido", "Fluido milagroso (nitalo)", "Nitrato (salitre o guano), acido sulfurico y alcohol",
          "NaNO3 + H2SO4 -> NaHSO4 + HNO3 (destilando). Nitalo = HNO3 + C2H5OH.",
          "Solo deshace la piedra de un cuerpo intacto: las estatuas rotas no vuelven."),
     ]),
    (2, "Ganarse la aldea", "Aldea de Ishigami (-370, -300), junto al Town Hall",
     "Ceramica, vidrio, lentes y electricidad basica; que la colonia crezca sola y pague la era. Al tercer despetrificado, plaza, una casa por vecino y un horario de pueblo que se cumple solo.",
     [
         ("vidrio", "Vidrio", "Arena, sosa (ceniza) y caliza a 1200-1400 C",
          "SiO2 + Na2CO3 + CaCO3 -> silicato fundido + CO2. El Na2O baja el punto de fusion.",
          "El vidrio multiplica la quimica: recipientes, tubos y lentes."),
         ("lentes", "Lentes y microscopio", "Vidrio, abrasivo cada vez mas fino, paciencia",
          "Lente delgada: 1/f = 1/s + 1/s prima. Microscopio: M = (L/f_obj)*(D/f_oc).",
          "Sin instrumentos no hay ciencia fina, solo observacion a ojo."),
         ("dinamo", "Dinamo de manivela", "Cobre, imanes, madera y dos pares de manos",
          "Faraday: e = -N*dPhi/dt. Potencia P = V*I. Una manivela da para una bombilla, no para una aldea.",
          "Aqui la pone el mod crank-dynamo del pack: 8 FE por tick girando."),
         ("bombilla", "Bombilla", "Filamento de bambu carbonizado y vidrio en vacio",
          "P = V cuadrado / R. El filamento se pone incandescente y el vacio evita que se queme.",
          "Es la bombilla de Edison, y la serie la reproduce con fidelidad."),
         ("sulfa", "Sulfamidas", "Azufre, azucar y frasco (mod Stone Pharmacy)",
          "Sulfanilamida C6H8N2O2S: el grupo -SO2NH2 corta la sintesis de acido folico de la bacteria y la deja sin multiplicarse.",
          "Es el invento que salva a Ruri y el que separa la medicina de la supersticion."),
         ("pueblo", "El pueblo de los agradecidos", "Tres despetrificados y un solar llano",
          "3 vecinos -> plaza de 9x9 con campana; 1 casa de 5x5 por vecino en 16 solares; obra general: 45 s y 6 etapas.",
          "La gratitud como mano de obra: nadie pide permiso para levantar su casa. Mision: /function swr:pueblo/obra/iniciar."),
         ("casas", "Cada vecino, su casa", "16 solares alrededor de la plaza",
          "Suelo de piedra, tres capas de muro, techo con vuelo, cama, cofre y puerta mirando a la plaza; 30 s por casa, una tanda a la vez y cola de espera.",
          "Una casa por vecino, 16 como maximo: el que llega tarde espera turno. Todo el detalle en PUEBLO.md."),
         ("horario", "El dia del pueblo", "Pan, campana y una cama por casa",
          "Amanecer en la plaza, manana y tarde de trabajo en el puesto de su oficio (cortapiedras, compostador, telar, barril, mesa de flechas o atril, cada uno con su mesa y su sonido), comida a mediodia, reunion al atardecer y noche en casa. /function swr:pueblo/horario/iniciar",
          "Minecraft no le da hambre ni sueño a un aldeano: la rutina la pone el datapack y el jugador la ve pasar. Los puestos si son bloques de trabajo reales."),
         ("oficios", "Los oficios y sus puestos", "Seis puestos con su cofre de produccion",
          "Cantero (cortapiedras): ladrillos; granjero (compostador): pan; pastor (telar): lana; pescador (barril): bacalao; flechero (mesa de flechas): flechas; bibliotecario (atril): libros. Cada minuto de trabajo el puesto deja su parte en el cofre de al lado.",
          "El que sale de la piedra coge el oficio que falta y al amanecer se reparte: si uno va cargado, sus vecinos se pasan al que esta vacio (hasta tres por dia)."),
     ]),
    (3, "Stone Wars", "Cascada y central (-120, -10), tendido hasta la aldea",
     "Hierro a escala, baterias, central hidroelectrica y telefono: la guerra se gana con logistica.",
     [
         ("tatara", "Hierro por tatara", "Arena de hierro, carbon y aire forzado",
          "Fe2O3 + 3 CO -> 2 Fe + 3 CO2. El carbon no arde: reduce el oxido.",
          "La tatara historica trabaja dias; el manga lo comprime a una sesion."),
         ("bateria", "Bateria de plomo-acido", "Placas de plomo, acido sulfurico y caja estanca",
          "Pb + PbO2 + 2 H2SO4 <-> 2 PbSO4 + 2 H2O; unos 2,1 V por celda.",
          "Almacenar energia es lo que permite pelear de noche."),
         ("acidos", "Acidos y polvora", "Azufre, nitratos, carbon vegetal y salitre",
          "S + O2 -> SO2 ; SO2 + H2O -> H2SO3 -> H2SO4. Polvora: 75 KNO3 / 15 C / 10 S.",
          "Es la parte mas peligrosa del proyecto; la serie no muestra los humos."),
         ("central", "Central hidroelectrica", "Salto de 18 bloques, turbina y generador",
          "P = rho*g*Q*h*eta. Con 18 m de salto y 1 m3/s salen unos 130 kW teoricos.",
          "La cascada de la isla es la que hace posible el tendido electrico."),
     ]),
    (4, "New World", "Puerto y astillero (-50, 450); isla del tesoro a 3000 al este",
     "Brujula, barco, globo, radar y petroleo: salir de la isla y competir por el dispositivo.",
     [
         ("brujula", "Brujula", "Aguja de hierro y magnetita",
          "Magnetita Fe3O4. La aguja se alinea con el campo terrestre, de 25 a 65 microteslas.",
          "Sin brujula no hay navegacion oceanica fiable."),
         ("barco", "El Perseus", "Roble curado, clavos, brea, velas cosidas y timon",
          "Arquimedes: E = rho*g*V. Un casco de 40 t desplaza 40 m3 de agua.",
          "El barco es un proyecto, no un objeto: meses de carpinteria de ribera."),
         ("petroleo", "Petroleo y refino", "Pozo, alambique y columnas de destilacion",
          "Separar por punto de ebullicion: gases bajo 0 C, gasolina 40-200, queroseno 175-325, gasoleo 250-400.",
          "El petroleo cambia la escala: de taller a industria."),
         ("medusa", "La medusa", "El dispositivo de la isla del tesoro",
          "No tiene formula: es la licencia fantastica del manga. Lo que si es real es el miedo como tecnologia.",
          "Ibara no gobernaba con la medusa, gobernaba con el relato."),
     ]),
    (5, "Science Future", "Aldea alta y taller: telescopio, computadora y cohete pendiente",
     "Computadora, telescopio de fluorita y todo lo que hace falta para contestar a why.",
     [
         ("computadora", "Computadora", "Circuito impreso, logica binaria y memoria",
          "Puertas AND, OR y NOT; reloj f = 1/T. Todo lo digital sale de ahi.",
          "Sin computadora no hay control de vuelo ni calculo de trayectoria."),
         ("optica", "Telescopio de fluorita", "Lentes de fluorita, tubo y tripode",
          "Refraccion: n1*sen(t1) = n2*sen(t2). Aumento = f_objetivo / f_ocular.",
          "La fluorita reduce la aberracion cromatica: se ve mas lejos y mas limpio."),
         ("cohete", "Cohete", "Etapas, propergoles, tobera y guiado",
          "Tsiolkovski: dv = ve*ln(m0/m1). Para orbita baja hacen falta unos 9,4 km/s.",
          "El manga lo resuelve con una civilizacion entera: es la unica respuesta honesta."),
         ("espacio", "Base y traje", "Soporte vital: aire, agua, presion y temperatura",
          "PV = nRT. A 1 atm y 20 C, un metro cubico son unos 41 mol de aire.",
          "El final no es una pelea: es una pregunta contestada."),
         ("vivo", "Lo que antes no se podia", "Fluido, gente de verdad y un pueblo que anda solo",
          "Antes las aldeas eran decorado. Ahora se despetrifica con el efecto del mod, al tercer vecino nace la plaza, cada uno levanta su casa, el pueblo cumple horario y la tripulacion del Perseus zarpa de verdad.",
          "La isla deja de ser un escenario: la gente que revives vive, come, duerme y construye. Es el cambio de fondo del pack."),
     ]),
]

# Punto de reunion de cada era para el clic "(ir)": x, z. Se conserva la altura del jugador.
# Son los CENTROS de zona, los mismos a los que apunta /function swr:viaje/* (isla.json da las esquinas).
DESTINOS = {1: (200, -420), 2: (-260, -200), 3: (-60, 60), 4: (60, 520)}

# Fichas que se anotan solas al tener el objeto en el inventario: el resto se anota al abrir la era.
OBJETOS = {
    "fuego": "minecraft:flint_and_steel",
    "vidrio": "minecraft:glass",
    "dinamo": "stoneindustry:crank_dynamo",
    "tatara": "minecraft:iron_ingot",
    "brujula": "minecraft:compass",
    "optica": "minecraft:spyglass",
    "medusa": "minecraft:heart_of_the_sea",
    "cohete": "minecraft:firework_rocket",
    "sulfa": "stonepharmacy:sulfamida",
    "casas": "minecraft:red_bed",
    "horario": "minecraft:bread",
    "oficios": "minecraft:stonecutter",
}

DESCUBRIMIENTOS = sum(len(era[4]) for era in ERAS)
ACUMULADO = []
total = 0
for era in ERAS:
    total += len(era[4])
    ACUMULADO.append(total)


def comp(texto, color=None, negrita=False, extra=None):
    c = {"text": texto}
    if color:
        c["color"] = color
    if negrita:
        c["bold"] = True
    if extra:
        c["extra"] = extra
    return c


def hover(*componentes):
    """El valor de un hoverEvent es UN componente: la lista de lineas va en su extra."""
    return {"text": "", "extra": list(componentes)}


def linea(*componentes):
    return json.dumps(list(componentes), ensure_ascii=False)


def pagina(*componentes):
    return json.dumps(list(componentes), ensure_ascii=False)


def escribir(ruta, texto):
    ruta.parent.mkdir(parents=True, exist_ok=True)
    ruta.write_text(texto, encoding="utf-8")


def indice():
    lineas = [
        "tellraw @a " + linea(
            comp("[Cuaderno] ", "gold", True),
            comp("Mapa por eras. Pasa el raton por encima para ver el detalle, haz clic para abrirla y usa (ir) para ir al sitio.", "gray"),
            comp(" El progreso es de los dos: una era y un cuaderno para la partida entera.", "dark_gray"),
        )
    ]
    for era, titulo, donde, hacer, fichas in ERAS:
        x, z = DESTINOS.get(era, (0, 0))
        tooltip = [comp(f"Era {era} - {titulo}", "yellow", True), comp(" "), comp(hacer, "white")]
        tooltip += [comp(" ")]
        tooltip += [comp(donde, "gray", extra=[comp(" ")])]
        for _, titulo_ficha, materiales, _, _ in fichas:
            tooltip += [comp(" "), comp(f"- {titulo_ficha}: ", "aqua"), comp(materiales, "dark_gray")]
        lineas.append(
            "tellraw @a " + linea(
                comp(f"  Era {era} - {titulo}", "yellow", extra=[
                    {
                        "text": "",
                        "clickEvent": {"action": "run_command", "value": f"/function swr:libro/era/{era}"},
                        "hoverEvent": {"action": "show_text", "value": hover(*tooltip)},
                    }
                ]),
                comp("   (clic)", "dark_gray"),
                comp("  (ir)", "dark_aqua", extra=[
                    {
                        "text": "",
                        "clickEvent": {"action": "run_command", "value": f"/tp @s {x} ~ {z}"},
                        "hoverEvent": {"action": "show_text", "value": hover(comp(f"Te deja encima de {donde}", "white"))},
                    }
                ]) if era in DESTINOS else comp(" "),
            )
        )
    lineas.append(
        "tellraw @a " + linea(
            comp("  Cuaderno de campo: ", "gold"),
            comp("abrelo con /function swr:libro/cuaderno", "white", extra=[
                {
                    "text": "",
                    "clickEvent": {"action": "run_command", "value": "/function swr:libro/cuaderno"},
                    "hoverEvent": {"action": "show_text", "value": hover(
                        comp("Te da el libro con las paginas de las eras que ya abriste."),
                        comp(" "),
                        comp("Los libros escritos no se pueden editar despues: pide uno nuevo cuando cierres una era.", "gray"),
                    )},
                }
            ]),
            comp(f"   ({DESCUBRIMIENTOS} fichas en total)", "dark_gray"),
        )
    )
    escribir(BASE / "libro/indice.mcfunction", "\n".join(lineas) + "\n")


def ficha_era(era, titulo, donde, hacer, fichas):
    lineas = [
        f"# Era {era} - {titulo}: que hacer y por que. Generado por herramientas/generar_libro.py",
        "tellraw @a " + linea(
            comp(f"[Era {era}] ", "gold", True),
            comp(titulo, "yellow", True),
            comp("  " + donde, "dark_gray"),
        ),
        "tellraw @a " + linea(comp(hacer, "white")),
    ]
    for _, titulo_ficha, materiales, formula, nota in fichas:
        tooltip = [
            comp(titulo_ficha, "aqua", True), comp(" "),
            comp("Formula: ", "yellow"), comp(formula, "white"), comp(" "),
            comp("Para que: ", "yellow"), comp(nota, "gray"),
        ]
        lineas.append(
            "tellraw @a " + linea(
                comp("  " + titulo_ficha, "aqua", extra=[
                    {"text": "", "hoverEvent": {"action": "show_text", "value": hover(*tooltip)}}
                ]),
                comp("  " + materiales, "dark_gray"),
            )
        )
    if era == 4:
        lineas += [
            "tellraw @a " + linea(comp("  CADENA DEL PERSEUS (lo que hay hoy):", "gold", True)),
            "tellraw @a " + linea(comp("   1) Astillero en el puerto (zona 5): casco, cubierta, palo y velas.", "white")),
            "tellraw @a " + linea(comp("   2) Botadura: /function swr:tripulacion/botadura (solo dentro del puerto).", "white")),
            "tellraw @a " + linea(comp("   3) Tripulacion: /function swr:tripulacion/reclutar/navegante | contable | cocinero", "white")),
            "tellraw @a " + linea(comp("   4) Zarpe: /function swr:tripulacion/zarpar (se niega sin los tres a menos de 48 bloques).", "white")),
            "tellraw @a " + linea(comp("   5) Viaje: isla del tesoro a 3.000 al este, en bote. El casco no navega solo.", "white")),
            "tellraw @a " + linea(comp("   6) Vuelta con platino y la medusa; cierra la era con /function swr:era/cerrar.", "white")),
        ]
    lineas.append(
        "tellraw @a " + linea(
            comp("  Para anotar estas formulas en el cuaderno: ", "gray"),
            comp("/function swr:descubrir/" + str(era), "white", extra=[
                {
                    "text": "",
                    "clickEvent": {"action": "run_command", "value": f"/function swr:descubrir/{era}"},
                    "hoverEvent": {"action": "show_text", "value": hover(comp(f"Anota las {len(fichas)} fichas de la era {era}"))},
                }
            ]),
        )
    )
    escribir(BASE / f"libro/era/{era}.mcfunction", "\n".join(lineas) + "\n")


def descubrir(era, titulo, fichas):
    lineas = [
        f"# Anota las formulas de la era {era} en el cuaderno (no borra lo ya anotado).",
        "# Cada ficha es un marcador f_<id>: el progreso es UNO solo para los dos jugadores.",
    ]
    for ident, _, _, _, _ in fichas:
        lineas.append(f"scoreboard players set f_{ident} swr 1")
    lineas += [
        "function swr:libro/contar",
        "tellraw @a " + linea(
            comp("[Cuaderno] ", "gold", True),
            comp(f"Anotadas las {len(fichas)} fichas de la era {era} - {titulo}.", "green"),
        ),
    ]
    for _, titulo_ficha, _, formula, _ in fichas:
        lineas.append(
            "tellraw @a " + linea(
                comp("  + " + titulo_ficha, "aqua", extra=[
                    {"text": "", "hoverEvent": {"action": "show_text", "value": hover(
                        comp(formula, "white"), comp(" "),
                        comp("Copia nueva: /function swr:libro/cuaderno", "gray"),
                    )}}
                ]),
            )
        )
    escribir(BASE / f"descubrir/{era}.mcfunction", "\n".join(lineas) + "\n")


def ficha_suelta(era, ficha):
    """Ficha que se anota sola al llevar el objeto encima: avisa a los dos jugadores y suma."""
    ident, titulo, materiales, formula, nota = ficha
    item = OBJETOS[ident]
    lineas = [
        f"# Ficha {titulo} (era {era}): se anota al llevar {item} en el inventario.",
        f"execute if score f_{ident} swr matches 0 run tellraw @a " + linea(
            comp("[Cuaderno] ", "gold", True),
            comp("Ficha nueva: ", "green"),
            comp(titulo, "aqua", True),
            comp(" -- " + formula, "white"),
        ),
        f"execute if score f_{ident} swr matches 0 run scoreboard players set f_{ident} swr 1",
        "function swr:libro/contar",
    ]
    escribir(BASE / f"ficha/{ident}.mcfunction", "\n".join(lineas) + "\n")


def contar():
    fichas = [f[0] for era in ERAS for f in era[4]]
    lineas = [
        "# DESCUBRIMIENTOS = fichas anotadas. Un solo contador: el libro que reciben los dos es el mismo.",
        "scoreboard players set DESCUBRIMIENTOS swr 0",
    ]
    for ident in fichas:
        lineas.append(f"scoreboard players add f_{ident} swr 0")
    for ident in fichas:
        lineas.append(f"scoreboard players operation DESCUBRIMIENTOS swr += f_{ident} swr")
    escribir(BASE / "libro/contar.mcfunction", "\n".join(lineas) + "\n")


def auto():
    lineas = [
        "# Mira el inventario de los dos jugadores y anota las fichas cuyo objeto ya tienen.",
        "# Lo llama el reloj de load.mcfunction cada 100 ticks y se reprograma solo.",
    ]
    for era, _, _, _, fichas in ERAS:
        for ficha in fichas:
            if ficha[0] in OBJETOS:
                lineas.append(
                    f"execute as @a if items entity @s container.* {OBJETOS[ficha[0]]} run function swr:ficha/{ficha[0]}"
                )
    lineas.append("# reinicio del reloj: 5 segundos")
    lineas.append("schedule function swr:libro/auto 100t replace")
    escribir(BASE / "libro/auto.mcfunction", "\n".join(lineas) + "\n")


def cuaderno_reparto():
    lineas = [
        "# Reparte el cuaderno segun lo anotado. Un libro escrito no se edita: se da uno nuevo.",
        "scoreboard players add DESCUBRIMIENTOS swr 0",
    ]
    # Cadena excluyente: cada etapa solo salta si no se alcanzo ya la siguiente,
    # si no un jugador con 20 fichas recibiria cinco libros de golpe.
    for i in range(len(ERAS), 0, -1):
        minimo = ACUMULADO[i - 2] + 1 if i > 1 else 0
        guarda = (
            f"unless score DESCUBRIMIENTOS swr matches {ACUMULADO[i - 1] + 1}.. "
            if i < len(ERAS) else ""
        )
        lineas.append(
            f"execute {guarda}if score DESCUBRIMIENTOS swr matches {minimo}.. run function swr:libro/cuaderno/{i}"
        )
    escribir(BASE / "libro/cuaderno.mcfunction", "\n".join(lineas) + "\n")


def cuaderno_etapa(etapa):
    """Libro con portada, mapa y las fichas anotadas hasta la era `etapa`."""
    paginas = [
        pagina(
            comp("CUADERNO DE CAMPO", "gold", True), comp(" - "),
            comp("Reino de la Ciencia", "yellow"), comp("  -  "),
            comp(f"Fichas anotadas: {ACUMULADO[etapa - 1]} de {DESCUBRIMIENTOS}", "white"), comp(" "),
            comp("Cada era anade formulas. Las que faltan no salen hasta que las descubras.", "gray"),
        ),
        pagina(
            comp("MAPA DEL REINO", "gold", True), comp("  -  "),
            comp("Los ocho sitios estan en ISLA.md y en /function swr:viaje/*", "gray"), comp(" "),
            comp("Cueva del milagro, campo de estatuas, aldea, cascada, puerto, bambu, rival y playa.", "white"),
        ),
    ]
    for era, titulo, donde, _, fichas in ERAS[:etapa]:
        paginas.append(pagina(
            comp(f"ERA {era} - {titulo}", "yellow", True), comp(" "),
            comp(donde, "gray"), comp("  -  "),
            comp("Fichas: " + ", ".join(f[1] for f in fichas), "white"),
        ))
        for _, titulo_ficha, materiales, formula, nota in fichas:
            paginas.append(pagina(
                comp(titulo_ficha, "aqua", True), comp("  -  "),
                comp(materiales, "gray"), comp("  -  "),
                comp(formula, "white"), comp("  -  "),
                comp(nota, "dark_gray"),
            ))
        if era == 4:
            paginas.append(pagina(
                comp("CADENA DEL PERSEUS", "gold", True), comp("  -  "),
                comp("1) Astillero en el puerto, zona 5. 2) Casco y cubierta. 3) Botadura: /function swr:tripulacion/botadura. 4) Tripulacion: navegante, contable y cocinero. 5) Zarpe: /function swr:tripulacion/zarpar. 6) Isla del tesoro, 3.000 al este, en bote. 7) Vuelta con platino y la medusa.", "white"),
            ))
    pendientes = DESCUBRIMIENTOS - ACUMULADO[etapa - 1]
    if pendientes:
        paginas.append(pagina(
            comp("SIN ANOTAR", "dark_red", True), comp("  -  "),
            comp(f"Quedan {pendientes} fichas de las eras siguientes. Se anotan al abrirlas o con /function swr:descubrir/N.", "gray"),
        ))
    paginas_snbt = ",".join("'" + p.replace("'", "") + "'" for p in paginas)
    titulo_libro = f"Cuaderno de campo ({ACUMULADO[etapa - 1]}/{DESCUBRIMIENTOS})"
    escribir(BASE / f"libro/cuaderno/{etapa}.mcfunction",
             "# Cuaderno de campo, etapa " + str(etapa) + ". Generado por herramientas/generar_libro.py\n"
             f'give @a written_book[minecraft:written_book_content={{title:"{titulo_libro}",author:"Reino de la Ciencia",pages:[{paginas_snbt}]}}]\n'
             "tellraw @a " + linea(
                 comp("[Cuaderno] ", "gold", True),
                 comp(f"Libro entregado a los dos: {ACUMULADO[etapa - 1]} fichas anotadas de {DESCUBRIMIENTOS}.", "green"),
             ) + "\n")


def main():
    indice()
    for era, titulo, donde, hacer, fichas in ERAS:
        ficha_era(era, titulo, donde, hacer, fichas)
        descubrir(era, titulo, fichas)
        for ficha in fichas:
            if ficha[0] in OBJETOS:
                ficha_suelta(era, ficha)
    contar()
    auto()
    cuaderno_reparto()
    for etapa in range(1, len(ERAS) + 1):
        cuaderno_etapa(etapa)
    print(f"libro: {len(ERAS)} eras, {DESCUBRIMIENTOS} fichas, {len(ERAS)} etapas de cuaderno")


if __name__ == "__main__":
    main()
