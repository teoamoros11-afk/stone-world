# Carga inicial del panel. Objetivo swr = panel de la barra lateral.
scoreboard objectives add swr dummy {"text":"Reino de la Ciencia"}
scoreboard objectives add aldeas dummy {"text":"Aldeas registradas"}
scoreboard players set ERA swr 1
scoreboard players set CIUDADANOS swr 0
scoreboard players set ALDEANOS swr 0
scoreboard players set ALDEA swr 0
scoreboard players set TICK swr 0
# eras cerradas: solo se crean si faltan (add 0), para no borrar el progreso en cada /reload
scoreboard players add CERRADA1 swr 0
scoreboard players add CERRADA2 swr 0
scoreboard players add CERRADA3 swr 0
scoreboard players add CERRADA4 swr 0
scoreboard players add CERRADA5 swr 0
# epilogo TERRAFORMING: en que escena vas (0 = sin empezar)
scoreboard players add TERRAFORM swr 0
# cupo de revividos: el campo de estatuas no es infinito (se inicializa una sola vez)
execute unless score INICIADO swr matches 1 run scoreboard players set CUPO swr 60
execute unless score INICIADO swr matches 1 run scoreboard players set REVIDOS swr 0
execute unless score INICIADO swr matches 1 run scoreboard players set INICIADO swr 1
# progreso COMPARTIDO: una sola era y un solo contador de fichas para los dos jugadores
scoreboard players set JUGADORES swr 0
scoreboard players set CERCA swr 0
execute unless score MODO swr matches 1..2 run scoreboard players set MODO swr 2
# fichas de formulas anotadas en el cuaderno de campo (una marca f_<id> por ficha)
scoreboard players add DESCUBRIMIENTOS swr 0
# el cuaderno mira el inventario de los dos jugadores cada 5 segundos
schedule function swr:libro/auto 100t replace
# tripulacion del Perseus (era 4): la botadura y el zarpe se guardan en el mundo
execute unless score BOTADO swr matches 0..1 run scoreboard players set BOTADO swr 0
execute unless score ZARPE swr matches 0..1 run scoreboard players set ZARPE swr 0
scoreboard players set TRIPULANTES swr 0
# pueblo de los agradecidos: estatuas, vecinos despetrificados y obra
scoreboard players add VECINOS swr 0
scoreboard players add PUEBLO swr 0
scoreboard players add OBRA swr 0
scoreboard players add ESTATUAS swr 0
scoreboard players add SUERTE swr 0
scoreboard players add OFICIO swr 0
scoreboard players add PRESENTES swr 0
scoreboard players add CASAS swr 0
scoreboard players add CASAS_OBRA swr 0
scoreboard players add SOLAR swr 0
scoreboard players add DIR swr 0
scoreboard players set CUATRO swr 4
scoreboard players set DIECISEIS swr 16
scoreboard players add CASA_T swr 0
# si el servidor se reinicio con casas a medio hacer, su reloj vuelve a andar
execute if score CASA_T swr matches 1.. run schedule function swr:pueblo/casa/reloj 20t replace
scoreboard players set DOCE swr 12
scoreboard players set TREINTA_Y_OCHO swr 38
# fluido milagroso como frasco: la botella con nombre vale por una dosis (si no, se gasta el cupo)
scoreboard players add FRASCO swr 0
# medusa de la isla del tesoro: carga, cuenta atras y radio
scoreboard players add MEDUSA_CARGA swr 0
scoreboard players add MEDUSA_T swr 0
scoreboard players add MEDUSA_R swr 0
scoreboard players add MEDUSA_INIT swr 0
execute unless score MEDUSA_INIT swr matches 1 run scoreboard players set MEDUSA_CARGA swr 3
execute unless score MEDUSA_INIT swr matches 1 run scoreboard players set MEDUSA_R swr 12
execute unless score MEDUSA_INIT swr matches 1 run scoreboard players set MEDUSA_INIT swr 1
# produccion y oficios del pueblo
scoreboard players add PROD swr 0
scoreboard players add PROD_T swr 0
scoreboard players set TRES swr 3
scoreboard players add MIN swr 0
scoreboard players add MINID swr 0
scoreboard players add LIMITE swr 0
scoreboard players add MOVIDO swr 0
scoreboard players add MOVED swr 0
scoreboard players add C0 swr 0
scoreboard players add C1 swr 0
scoreboard players add C2 swr 0
scoreboard players add C3 swr 0
scoreboard players add C4 swr 0
scoreboard players add C5 swr 0
scoreboard players set SEIS swr 6
# horario del pueblo: amanecer, manana, comida, tarde, reunion y noche
# encendido la primera vez; si lo apagas con horario/parar, el /reload no lo vuelve a encender
execute unless score HORARIO_INIT swr matches 1 run scoreboard players set HORARIO swr 1
execute unless score HORARIO_INIT swr matches 1 run scoreboard players set HORARIO_INIT swr 1
scoreboard players add TURNO swr 0
scoreboard players add HORA swr 0
scoreboard players add HORA_TURNO swr 0
execute if score HORARIO swr matches 1 run schedule function swr:pueblo/horario/reloj 100t replace
# puestos de oficio: si la plaza ya existe y no hay puestos (mundo viejo), se colocan
execute if entity @e[tag=swr_plaza,limit=1] run function swr:pueblo/puestos
# si el servidor se reinicio a mitad de obra, el reloj arranca otra vez
execute if score OBRA swr matches 1.. run schedule function swr:pueblo/obra/tick 20t replace
# el Panel del pueblo: se entrega a quien no lo tenga (al entrar o tras un /reload)
execute as @a unless items entity @s container.* minecraft:recovery_compass run function swr:panel/dar

# --- Campo del pueblo: parcelas, rotacion y rendimiento ---
scoreboard objectives add campo dummy {"text":"Campo del pueblo"}
scoreboard players add CULTIVO campo 0
scoreboard players add MADURO campo 0
scoreboard players add REND campo 0
scoreboard players add COSECHAS campo 0
scoreboard players add ULTIMA_COSECHA campo 0
scoreboard players set DOS swr 2
scoreboard players set CUATRO swr 4
execute unless score P1 campo matches 0.. run scoreboard players set P1 campo 0
execute unless score P2 campo matches 0.. run scoreboard players set P2 campo 0
execute unless score P3 campo matches 0.. run scoreboard players set P3 campo 0
execute unless score P4 campo matches 0.. run scoreboard players set P4 campo 0
execute unless score R1 campo matches 1..3 run scoreboard players set R1 campo 3
execute unless score R2 campo matches 1..3 run scoreboard players set R2 campo 3
execute unless score R3 campo matches 1..3 run scoreboard players set R3 campo 3
execute unless score R4 campo matches 1..3 run scoreboard players set R4 campo 3
schedule function swr:campo/ciclo 200t replace

# --- Bar del Perseus: despensa, fichas, poker y bolos ---
scoreboard objectives add despensa dummy {"text":"Despensa del bar"}
scoreboard objectives add fichas dummy {"text":"Fichas de poker"}
scoreboard objectives add bolos dummy {"text":"Bolos"}
scoreboard objectives add poker dummy {"text":"Poker"}
scoreboard objectives add manoA dummy {"text":"Mano del jugador"}
scoreboard objectives add manoB dummy {"text":"Mano de la banca"}
scoreboard objectives add cs dummy {"text":"Cartas usadas"}
scoreboard players set TRECE swr 13
scoreboard players set CIEN swr 100
scoreboard players add BOTE fichas 0
scoreboard players add BOLOS_ACTIVO swr 0
scoreboard players add BOLOS_PASO swr 0
scoreboard players add BOLOS_TIRADOS swr 0
scoreboard players add BOLOS_ULTIMA swr 0
scoreboard players add MANO_A swr 0
scoreboard players add MANO_B swr 0
scoreboard players add INTENTOS swr 0
scoreboard players add CARTA swr 0
scoreboard players add RANGO swr 0
scoreboard players add PALO swr 0
scoreboard players add PAN despensa 0
scoreboard players add PESCADO despensa 0
scoreboard players add PATATA despensa 0
scoreboard players add ZANAHORIA despensa 0
scoreboard players add BAYAS despensa 0
scoreboard players add LECHE despensa 0
scoreboard players add MIEL despensa 0
scoreboard players add HUEVO despensa 0
scoreboard players add TRIGO despensa 0
scoreboard players add CARNE despensa 0
function swr:bar/poker/baraja
# --- Tramo A: los sistemas de la serie que solo necesitan datapack ---
scoreboard objectives add serie dummy {"text":"Serie"}
scoreboard objectives add moneda dummy {"text":"Denarios"}
scoreboard objectives add bout dummy {"text":"Grand Bout"}
scoreboard players add DIAS serie 0
scoreboard players add ARRANQUE serie 0
scoreboard players add CUEVA_ACTIVA serie 0
scoreboard players add REVIDOS_TOTAL serie 0
scoreboard players add BOUT_RONDA serie 0
scoreboard players add BOUT_ACTIVO serie 0
scoreboard players add JUICIO_SI serie 0
scoreboard players add JUICIO_NO serie 0
scoreboard players add VOTOS_RURI serie 0
scoreboard players add VOTOS_KOKUYO serie 0
scoreboard players add GOBIERNO serie 0
scoreboard players add DECRETO serie 0
scoreboard players add CONSEJO_ORDEN serie 0
scoreboard players add CONSEJO_T serie 0
scoreboard players add RADIO_CANAL serie 0
scoreboard players add TELEFONO_BATERIA serie 0
scoreboard players add FAX_ENVIADOS serie 0
scoreboard players add PRENSA_TIRADA serie 0
scoreboard players add CAMARA_ACTIVA serie 0
scoreboard players add CAMARA_N serie 0
scoreboard players add RULETA serie 0
scoreboard players add CASINO_ACTIVO serie 0
scoreboard players add MANO_JUGADOR serie 0
scoreboard players add MANO_BANCA serie 0
scoreboard players add CARTA_TMP serie 0
scoreboard players add MERCADO_TRIGO serie 0
scoreboard players add MERCADO_PAN serie 0
scoreboard players add EXAMEN_ACTIVO serie 0
scoreboard players add EXAMEN_ACIERTOS serie 0
scoreboard players add EXAMEN_PREG serie 0
scoreboard players add HOSPITAL_N serie 0
scoreboard players add FOTOS serie 0
scoreboard players add MUNDO_ESTATUAS serie 0
scoreboard players add ONDA_ACTIVA serie 0
scoreboard players add ONDA_T serie 0
scoreboard players add FRASE_ACTIVA serie 0
scoreboard players add SATELITE_INTENTOS serie 0
scoreboard players add SATELITE_FALLO serie 0
scoreboard players add TRIGO_TMP serie 0
scoreboard players add PAPEL_TMP serie 0
scoreboard players add TINTA_TMP serie 0
scoreboard players add LLAMADA_N serie 0
scoreboard players add FAX_N serie 0
scoreboard objectives setdisplay sidebar swr
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Panel activo. Parte: /function swr:panel/informe | Viajes: /function swr:viaje/aldea (cueva, estatuas, cascada, puerto, bambu, rival, spawn)","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Serie: /function swr:serie/historias (libro de Ruri) | /function swr:serie/cuaderno (cadena tecnologica) | /function swr:serie/medusa (era 4) | /function swr:serie/destello (el 1 de abril) | /function swr:serie/terraforming/iniciar (epilogo, tras cerrar la era 5)","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Eras con candado: cierra la actual con /function swr:era/cerrar. Reino: /function swr:reino/estado | revivir (gasta fluido). Reglas: /function swr:reglas/duras","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Cuaderno de campo: /function swr:libro/indice (mapa por eras, con detalle al pasar el raton)","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Progreso compartido: era y fichas son de los dos.  /function swr:reino/juntos avisa si falta alguien; /function swr:reino/modo alterna solo/equipo.","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Perseus: /function swr:tripulacion/lista | botadura | reclutar/navegante | zarpar (sin los tres a bordo no se zarpa)","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Bar del Perseus: /function swr:bar/montar (barra, mesas de poker y Francois) | bolos/montar | bar/carta | despensa","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Pueblo: estatua (petrifica a alguien) | despetrificar (gasta fluido) | estado | obra/iniciar | obra/cancelar | horario/iniciar | horario/parar | casa/cancelar","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Panel del pueblo: pulsa la tecla de su hueco en la barra rapida (1..9), o lleva en la mano el libro de instrucciones, y sale todo lo que hace el pueblo. Si lo pierdes: /function swr:panel/dar","color":"gold"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Vida del pueblo: cada vecino levanta su casa y cumple horario (trabajo, comida, reunion y noche). Detalle en /function swr:libro/era/2.","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Tramo A de la serie: /function swr:serie/tramo_a (cueva, prologo, Grand Bout, juicio, politica, radio, telefono, fax, prensa, casino, moneda, mercado, escuela, hospital, fotos, carteles, cementerio, Superalloy City, onda, petrificar jugador, valle lunar y Senku-1)","color":"gray"}]
