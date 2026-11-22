# Mediodia: se para la obra y se come en la plaza. Pan en la mano y sobremesa.
execute unless entity @e[tag=swr_plaza,limit=1] run return 0
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Mediodia: se para a comer. Pan, agua y un rato de chismorreo.","color":"yellow"}]
execute at @e[tag=swr_plaza,limit=1] run spreadplayers ~ ~ 1 4 false @e[tag=swr_vecino,tag=swr_casa_hecha]
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] run data merge entity @s {NoAI:1b}
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] run item replace entity @s weapon.mainhand with minecraft:bread 1
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] at @s run playsound minecraft:entity.generic.eat master @a ~ ~ ~ 0.7 1
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] at @s run particle minecraft:happy_villager ~ ~1 ~ 0.4 0.4 0.4 0.02 8 normal
