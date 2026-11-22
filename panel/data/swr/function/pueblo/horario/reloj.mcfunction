# Horario del pueblo: cada 5 s mira la hora del mundo y cambia de turno si toca.
# Turnos: 1 amanecer, 2 manana, 3 comida, 4 tarde, 5 reunion, 6 noche.
# Uso: /function swr:pueblo/horario/iniciar | parar
# se reprograma solo: schedule es de un solo uso
execute if score HORARIO swr matches 1 run schedule function swr:pueblo/horario/reloj 100t replace
execute if score HORARIO swr matches 0 run return 0
execute unless entity @e[tag=swr_plaza,limit=1] run return 0
execute store result score HORA swr run time query daytime
scoreboard players set TURNO swr 6
execute if score HORA swr matches 0..999 run scoreboard players set TURNO swr 1
execute if score HORA swr matches 1000..5999 run scoreboard players set TURNO swr 2
execute if score HORA swr matches 6000..6999 run scoreboard players set TURNO swr 3
execute if score HORA swr matches 7000..10999 run scoreboard players set TURNO swr 4
execute if score HORA swr matches 11000..11999 run scoreboard players set TURNO swr 5
execute unless score TURNO swr = HORA_TURNO swr run function swr:pueblo/horario/cambiar
# produccion de los puestos: una vez por minuto de trabajo
execute unless score TURNO swr matches 2 run execute unless score TURNO swr matches 4 run scoreboard players set PROD_T swr 0
execute if score TURNO swr matches 2 run scoreboard players add PROD_T swr 1
execute if score TURNO swr matches 4 run scoreboard players add PROD_T swr 1
execute if score PROD_T swr matches 12.. run function swr:pueblo/produccion
execute if score PROD_T swr matches 12.. run scoreboard players set PROD_T swr 0
