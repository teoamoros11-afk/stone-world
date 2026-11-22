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
scoreboard objectives setdisplay sidebar swr
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Panel activo. Parte: /function swr:panel/informe | Viajes: /function swr:viaje/aldea (cueva, estatuas, cascada, puerto, bambu, rival, spawn)","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Serie: /function swr:serie/historias (libro de Ruri) | /function swr:serie/cuaderno (cadena tecnologica) | /function swr:serie/medusa (era 4) | /function swr:serie/destello (el 1 de abril) | /function swr:serie/terraforming/iniciar (epilogo, tras cerrar la era 5)","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Eras con candado: cierra la actual con /function swr:era/cerrar. Reino: /function swr:reino/estado | revivir (gasta fluido). Reglas: /function swr:reglas/duras","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Cuaderno de campo: /function swr:libro/indice (mapa por eras, con detalle al pasar el raton)","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Progreso compartido: era y fichas son de los dos.  /function swr:reino/juntos avisa si falta alguien; /function swr:reino/modo alterna solo/equipo.","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Perseus: /function swr:tripulacion/lista | botadura | reclutar/navegante | zarpar (sin los tres a bordo no se zarpa)","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Pueblo: estatua (petrifica a alguien) | despetrificar (gasta fluido) | estado | obra/iniciar | obra/cancelar | horario/iniciar | horario/parar","color":"gray"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Panel del pueblo: pulsa la tecla de su hueco en la barra rapida (1..9), o lleva en la mano el libro de instrucciones, y sale todo lo que hace el pueblo. Si lo pierdes: /function swr:panel/dar","color":"gold"}]
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Vida del pueblo: cada vecino levanta su casa y cumple horario (trabajo, comida, reunion y noche). Detalle en /function swr:libro/era/2.","color":"gray"}]
