# Estado del pueblo de los agradecidos.
# Uso: /function swr:pueblo/estado
tellraw @s [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Los que salieron de la piedra","color":"white"}]
tellraw @s [{"text":" Vecinos: ","color":"gray"},{"score":{"name":"VECINOS","objective":"swr"},"color":"white"},{"text":"  |  Pueblo: ","color":"gray"},{"score":{"name":"PUEBLO","objective":"swr"},"color":"white"},{"text":" (1 = plaza levantada)","color":"dark_gray"}]
tellraw @s [{"text":" Fluido restante: ","color":"gray"},{"score":{"name":"CUPO","objective":"swr"},"color":"white"},{"text":" dosis  |  Estatuas puestas: ","color":"gray"},{"score":{"name":"ESTATUAS","objective":"swr"},"color":"white"}]
execute store result score CASAS_OBRA swr run execute if entity @e[tag=swr_casa]
tellraw @s [{"text":" Casas: ","color":"gray"},{"score":{"name":"CASAS","objective":"swr"},"color":"white"},{"text":" empezadas  |  ","color":"gray"},{"score":{"name":"CASAS_OBRA","objective":"swr"},"color":"white"},{"text":" en obra","color":"gray"}]
tellraw @s [{"text":" Horario: ","color":"gray"},{"score":{"name":"TURNO","objective":"swr"},"color":"white"},{"text":" (1 amanecer, 2 manana, 3 comida, 4 tarde, 5 reunion, 6 noche)  |  ","color":"dark_gray"},{"text":"encendido","color":"green"}]
execute if score HORARIO swr matches 0 run tellraw @s [{"text":" Horario: apagado. /function swr:pueblo/horario/iniciar","color":"yellow"}]
execute store result score PUESTOS swr run execute if entity @e[tag=swr_puesto]
tellraw @s [{"text":" Puestos de oficio: ","color":"gray"},{"score":{"name":"PUESTOS","objective":"swr"},"color":"white"},{"text":" (cortapiedras, compostador, telar, barril, mesa de flechas y atril)","color":"dark_gray"}]
execute if score OBRA swr matches 1.. run tellraw @s [{"text":" Obra en marcha: ","color":"gray"},{"text":"quedan ","color":"yellow"},{"score":{"name":"OBRA","objective":"swr"},"color":"yellow"},{"text":" s","color":"yellow"}]
execute unless score OBRA swr matches 1.. run tellraw @s [{"text":" Obra: ","color":"gray"},{"text":"parada. /function swr:pueblo/obra/iniciar","color":"white"}]
execute if score CASAS_OBRA swr matches 1.. run tellraw @s [{"text":" Si una casa se queda atascada: /function swr:pueblo/casa/cancelar devuelve a los duenos a su vida.","color":"yellow"}]
