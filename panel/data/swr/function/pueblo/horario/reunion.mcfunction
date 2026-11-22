# Atardecer: la campana llama a la plaza. Se habla del dia y se reparte el trabajo de manana.
execute unless entity @e[tag=swr_plaza,limit=1] run return 0
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Atardecer: la campana llama a la plaza.","color":"yellow"}]
execute at @e[tag=swr_plaza,limit=1] run spreadplayers ~ ~ 1 4 false @e[tag=swr_vecino,tag=swr_casa_hecha]
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] run data merge entity @s {NoAI:1b}
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] run item replace entity @s weapon.mainhand with minecraft:air
execute at @e[tag=swr_plaza,limit=1] run playsound minecraft:block.bell.use master @a ~ ~ ~ 1 0.9
execute at @e[tag=swr_plaza,limit=1] run particle minecraft:happy_villager ~ ~1 ~ 2 1 2 0.02 25 normal
