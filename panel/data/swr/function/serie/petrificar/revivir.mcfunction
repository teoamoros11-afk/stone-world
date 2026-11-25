# A32 - Revivir al jugador petrificado: vuelve su inventario y se le quitan los efectos.
# Uso: /function swr:serie/petrificar/revivir
execute unless entity @s[tag=swr_petrificado] run return run tellraw @s [{"text":"[Petrificar] ","color":"dark_purple","bold":true},{"text":"No estas petrificado.","color":"red"}]
effect clear @s minecraft:slowness
effect clear @s minecraft:blindness
effect clear @s minecraft:mining_fatigue
tag @s remove swr_petrificado
execute if data storage swr:petrificado Inventario run data modify entity @s Inventory set from storage swr:petrificado Inventario
title @a title [{"text":"DEVUELTO","color":"green","bold":true}]
particle minecraft:happy_villager ~ ~1 ~ 0.5 1 0.5 0.05 30 normal
playsound minecraft:block.stone.break master @a ~ ~ ~ 1 0.8
tellraw @a [{"text":"[Petrificar] ","color":"green","bold":true},{"selector":"@s"},{"text":" vuelve de la piedra con todo lo que llevaba.","color":"gray"}]
