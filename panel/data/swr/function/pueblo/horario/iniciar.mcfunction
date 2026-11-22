# Enciende el horario del pueblo (por defecto va encendido desde load).
execute unless entity @e[tag=swr_plaza,limit=1] run tellraw @s [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Primero funda la plaza (tres despetrificados).","color":"red"}]
execute unless entity @e[tag=swr_plaza,limit=1] run return fail
scoreboard players set HORARIO swr 1
scoreboard players set HORA_TURNO swr 0
schedule function swr:pueblo/horario/reloj 100t replace
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Horario encendido: trabajo, comida a mediodia, reunion al atardecer y noche en casa.","color":"green"}]
