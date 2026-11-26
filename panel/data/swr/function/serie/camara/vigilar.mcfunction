# A16 - Una pasada de la camara: cuenta entidades en ocho bloques.
# Uso: /function swr:serie/camara/vigilar
execute unless entity @e[tag=swr_camara,limit=1] run return run tellraw @a [{"text":"[Camara] ","color":"gold","bold":true},{"text":"No hay camara. /function swr:serie/camara/montar","color":"red"}]
scoreboard players set CAMARA_N serie 0
execute at @e[tag=swr_camara,limit=1] as @e[distance=..8,type=!marker,type=!item,type=!experience_orb] run scoreboard players add CAMARA_N serie 1
tellraw @s [{"text":"[Camara] ","color":"gold","bold":true},{"text":"En el radio de ocho bloques hay ","color":"gray"},{"score":{"name":"CAMARA_N","objective":"serie"},"color":"white"},{"text":" entidades.","color":"gray"}]
