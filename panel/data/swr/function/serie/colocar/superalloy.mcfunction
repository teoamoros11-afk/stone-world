# A27 - Superalloy City (T4, ep. 82-94). La ciudad industrial de la recta final.
# Se construye con fill, no con plano: la esquina cae a tus pies y cabe en 21x21.
# Uso: /function swr:serie/colocar/superalloy
execute at @s run fill ~-10 ~ ~-10 ~10 ~ ~10 minecraft:deepslate_tiles
execute at @s run fill ~-10 ~1 ~-10 ~10 ~6 ~-10 minecraft:iron_block
execute at @s run fill ~-10 ~1 ~10 ~10 ~6 ~10 minecraft:iron_block
execute at @s run fill ~-10 ~1 ~-10 ~-10 ~6 ~10 minecraft:iron_block
execute at @s run fill ~10 ~1 ~-10 ~10 ~6 ~10 minecraft:iron_block
execute at @s run fill ~-9 ~1 ~-9 ~-6 ~10 ~-6 minecraft:iron_block
execute at @s run fill ~6 ~1 ~-9 ~9 ~10 ~-6 minecraft:iron_block
execute at @s run fill ~-9 ~1 ~6 ~-6 ~10 ~9 minecraft:iron_block
execute at @s run fill ~6 ~1 ~6 ~9 ~10 ~9 minecraft:iron_block
execute at @s run fill ~-2 ~1 ~10 ~2 ~3 ~10 minecraft:air
execute at @s run fill ~-3 ~1 ~-3 ~3 ~3 ~3 minecraft:smooth_stone
execute at @s run setblock ~-2 ~1 ~-2 minecraft:blast_furnace[facing=south]
execute at @s run setblock ~0 ~1 ~-2 minecraft:blast_furnace[facing=south]
execute at @s run setblock ~2 ~1 ~-2 minecraft:blast_furnace[facing=south]
execute at @s run setblock ~ ~3 ~ minecraft:beacon
execute at @s run setblock ~ ~5 ~-9 minecraft:oak_sign{front_text:{messages:['"SUPERALLOY CITY"','"ACERO Y ALEACION"','""','""']}}
execute at @s run setblock ~-9 ~7 ~-9 minecraft:end_rod
execute at @s run setblock ~9 ~7 ~-9 minecraft:end_rod
execute at @s run setblock ~-9 ~7 ~9 minecraft:end_rod
execute at @s run setblock ~9 ~7 ~9 minecraft:end_rod
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["swr_superalloy"]}
tellraw @a [{"text":"[Serie] ","color":"gold","bold":true},{"text":"Superalloy City levantada: muralla de hierro, cuatro torres, fundicion y beacon. Con Corn City, las dos ciudades de la temporada 4.","color":"gray"}]
