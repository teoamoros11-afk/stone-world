# Los puestos de oficio del pueblo: un bloque de trabajo y una mesa por cada oficio.
# Se colocan alrededor de la plaza (radio 6) una sola vez y no se repiten.
# Uso: automatico desde swr:pueblo/fundar y swr:load
execute unless entity @e[tag=swr_plaza,limit=1] run return 0
# cofres de produccion junto a cada puesto (se aseguran siempre, aunque el mundo sea viejo)
execute at @e[tag=swr_plaza,limit=1] run setblock ~8 ~-1 ~0 minecraft:chest[facing=east]
execute at @e[tag=swr_plaza,limit=1] run setblock ~5 ~-1 ~5 minecraft:chest[facing=south]
execute at @e[tag=swr_plaza,limit=1] run setblock ~-5 ~-1 ~5 minecraft:chest[facing=south]
execute at @e[tag=swr_plaza,limit=1] run setblock ~-8 ~-1 ~0 minecraft:chest[facing=west]
execute at @e[tag=swr_plaza,limit=1] run setblock ~-5 ~-1 ~-5 minecraft:chest[facing=north]
execute at @e[tag=swr_plaza,limit=1] run setblock ~5 ~-1 ~-5 minecraft:chest[facing=north]
execute if entity @e[tag=swr_puesto,limit=1] run return 0
# 0: cantero (cortapiedras) - este
execute at @e[tag=swr_plaza,limit=1] run setblock ~6 ~-1 ~0 minecraft:stonecutter
execute at @e[tag=swr_plaza,limit=1] run setblock ~7 ~-1 ~0 minecraft:crafting_table
execute at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~6 ~ ~0 {Tags:["swr_puesto","swr_puesto_0"]}
# 1: granjero (compostador) - sureste
execute at @e[tag=swr_plaza,limit=1] run setblock ~3 ~-1 ~5 minecraft:composter
execute at @e[tag=swr_plaza,limit=1] run setblock ~4 ~-1 ~5 minecraft:crafting_table
execute at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~3 ~ ~5 {Tags:["swr_puesto","swr_puesto_1"]}
# 2: pastor (telar) - suroeste
execute at @e[tag=swr_plaza,limit=1] run setblock ~-3 ~-1 ~5 minecraft:loom
execute at @e[tag=swr_plaza,limit=1] run setblock ~-4 ~-1 ~5 minecraft:crafting_table
execute at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~-3 ~ ~5 {Tags:["swr_puesto","swr_puesto_2"]}
# 3: pescador (barril) - oeste
execute at @e[tag=swr_plaza,limit=1] run setblock ~-6 ~-1 ~0 minecraft:barrel
execute at @e[tag=swr_plaza,limit=1] run setblock ~-7 ~-1 ~0 minecraft:crafting_table
execute at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~-6 ~ ~0 {Tags:["swr_puesto","swr_puesto_3"]}
# 4: flechero (mesa de flechas) - noroeste
execute at @e[tag=swr_plaza,limit=1] run setblock ~-3 ~-1 ~-5 minecraft:fletching_table
execute at @e[tag=swr_plaza,limit=1] run setblock ~-4 ~-1 ~-5 minecraft:crafting_table
execute at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~-3 ~ ~-5 {Tags:["swr_puesto","swr_puesto_4"]}
# 5: bibliotecario (atril) - noreste
execute at @e[tag=swr_plaza,limit=1] run setblock ~3 ~-1 ~-5 minecraft:lectern[facing=south]
execute at @e[tag=swr_plaza,limit=1] run setblock ~4 ~-1 ~-5 minecraft:crafting_table
execute at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~3 ~ ~-5 {Tags:["swr_puesto","swr_puesto_5"]}
execute at @e[tag=swr_plaza,limit=1] run particle minecraft:happy_villager ~ ~1 ~ 5 1 5 0.05 30 normal
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Seis puestos de oficio alrededor de la plaza: cortapiedras, compostador, telar, barril, mesa de flechas y atril, cada uno con su mesa de trabajo.","color":"green"}]
