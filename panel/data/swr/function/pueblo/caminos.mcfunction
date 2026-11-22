# Calles y caminos del pueblo. Sin esto las casas quedaban sueltas en cruz; con esto hay
# un pueblo: una calle de 3 de ancho por cada brazo, desde el borde de la plaza (radio 6)
# hasta el final (24), y un camino de tierra desde cada puerta hasta su calle.
# Uso: automatico desde swr:pueblo/fundar (y swr:pueblo/plaza).
execute unless entity @e[tag=swr_plaza,limit=1] run return 0
# las cuatro calles
execute at @e[tag=swr_plaza,limit=1] run fill ~-1 ~-1 ~-26 ~1 ~-1 ~-6 minecraft:stone_bricks
execute at @e[tag=swr_plaza,limit=1] run fill ~-1 ~-1 ~6 ~1 ~-1 ~26 minecraft:stone_bricks
execute at @e[tag=swr_plaza,limit=1] run fill ~-26 ~-1 ~-1 ~-6 ~-1 ~1 minecraft:stone_bricks
execute at @e[tag=swr_plaza,limit=1] run fill ~6 ~-1 ~-1 ~26 ~-1 ~1 minecraft:stone_bricks
# cimiento de las calles: relleno de piedra donde hay aire, para que no floten en ladera
execute at @e[tag=swr_plaza,limit=1] run fill ~-1 ~-7 ~-26 ~1 ~-2 ~-6 minecraft:stone_bricks replace minecraft:air
execute at @e[tag=swr_plaza,limit=1] run fill ~-1 ~-7 ~6 ~1 ~-2 ~26 minecraft:stone_bricks replace minecraft:air
execute at @e[tag=swr_plaza,limit=1] run fill ~-26 ~-7 ~-1 ~-6 ~-2 ~1 minecraft:stone_bricks replace minecraft:air
execute at @e[tag=swr_plaza,limit=1] run fill ~6 ~-7 ~-1 ~26 ~-2 ~1 minecraft:stone_bricks replace minecraft:air
# camino de cada puerta a su calle (brazo norte y sur: la puerta mira al eje X)
execute at @e[tag=swr_plaza,limit=1] run fill ~2 ~-1 ~-17 ~6 ~-1 ~-15 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~-6 ~-1 ~-17 ~-2 ~-1 ~-15 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~2 ~-1 ~-25 ~6 ~-1 ~-23 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~-6 ~-1 ~-25 ~-2 ~-1 ~-23 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~2 ~-1 ~15 ~6 ~-1 ~17 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~-6 ~-1 ~15 ~-2 ~-1 ~17 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~2 ~-1 ~23 ~6 ~-1 ~25 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~-6 ~-1 ~23 ~-2 ~-1 ~25 minecraft:coarse_dirt
# brazos este y oeste: la puerta mira al eje Z
execute at @e[tag=swr_plaza,limit=1] run fill ~15 ~-1 ~2 ~17 ~-1 ~6 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~15 ~-1 ~-6 ~17 ~-1 ~-2 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~23 ~-1 ~2 ~25 ~-1 ~6 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~23 ~-1 ~-6 ~25 ~-1 ~-2 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~-17 ~-1 ~2 ~-15 ~-1 ~6 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~-17 ~-1 ~-6 ~-15 ~-1 ~-2 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~-25 ~-1 ~2 ~-23 ~-1 ~6 minecraft:coarse_dirt
execute at @e[tag=swr_plaza,limit=1] run fill ~-25 ~-1 ~-6 ~-23 ~-1 ~-2 minecraft:coarse_dirt
# una farola al final de cada calle
execute at @e[tag=swr_plaza,limit=1] run setblock ~2 ~ ~-26 minecraft:oak_fence
execute at @e[tag=swr_plaza,limit=1] run setblock ~2 ~1 ~-26 minecraft:lantern
execute at @e[tag=swr_plaza,limit=1] run setblock ~2 ~ ~26 minecraft:oak_fence
execute at @e[tag=swr_plaza,limit=1] run setblock ~2 ~1 ~26 minecraft:lantern
execute at @e[tag=swr_plaza,limit=1] run setblock ~26 ~ ~2 minecraft:oak_fence
execute at @e[tag=swr_plaza,limit=1] run setblock ~26 ~1 ~2 minecraft:lantern
execute at @e[tag=swr_plaza,limit=1] run setblock ~-26 ~ ~2 minecraft:oak_fence
execute at @e[tag=swr_plaza,limit=1] run setblock ~-26 ~1 ~2 minecraft:lantern
