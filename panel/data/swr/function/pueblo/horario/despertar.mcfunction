# Amanecer: se levantan y salen a la plaza antes de ir a trabajar.
execute unless entity @e[tag=swr_plaza,limit=1] run return 0
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Amanece: los vecinos salen de casa y se reunen en la plaza.","color":"yellow"}]
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] run item replace entity @s weapon.mainhand with minecraft:air
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] run data merge entity @s {NoAI:0b}
execute at @e[tag=swr_plaza,limit=1] run spreadplayers ~ ~ 1 4 false @e[tag=swr_vecino,tag=swr_casa_hecha]
function swr:pueblo/oficios/reparto
execute at @e[tag=swr_plaza,limit=1] run playsound minecraft:block.bell.use master @a ~ ~ ~ 1 1.2
execute at @e[tag=swr_plaza,limit=1] run particle minecraft:happy_villager ~ ~1 ~ 2 1 2 0.02 20 normal
