# A32 - Petrificar a un jugador (T4 ep. 79, 92). Guarda su inventario aparte y lo deja quieto.
# Solo hay un hueco de guardado: si petrificas a dos a la vez, el segundo pisa al primero.
# Uso: /function swr:serie/petrificar/jugador
execute if entity @s[tag=swr_petrificado] run return run tellraw @s [{"text":"[Petrificar] ","color":"dark_purple","bold":true},{"text":"Ya estas petrificado. /function swr:serie/petrificar/revivir","color":"red"}]
data modify storage swr:petrificado Inventario set from entity @s Inventory
clear @s
effect give @s minecraft:slowness 999999 255 true
effect give @s minecraft:blindness 999999 0 true
effect give @s minecraft:mining_fatigue 999999 255 true
tag @s add swr_petrificado
drstonekos petrify @s
title @a title [{"text":"PETRIFICADO","color":"dark_purple","bold":true}]
title @s subtitle [{"text":"El inventario queda guardado","color":"gray"}]
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 0.5 1 0.5 0.1 80 normal
playsound minecraft:block.stone.place master @a ~ ~ ~ 1 0.5
tellraw @a [{"text":"[Petrificar] ","color":"dark_purple","bold":true},{"selector":"@s"},{"text":" se queda en piedra. Su inventario esta guardado: /function swr:serie/petrificar/revivir lo devuelve.","color":"gray"}]
