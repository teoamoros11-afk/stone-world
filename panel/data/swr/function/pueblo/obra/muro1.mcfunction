# Muro, capa 2: sillares.
execute at @e[tag=swr_obra,limit=1] run fill ~-4 ~1 ~ ~3 ~1 ~2 minecraft:stone_bricks outline
execute at @e[tag=swr_obra,limit=1] run particle minecraft:block{block_state:"minecraft:stone_bricks"} ~ ~1 ~1 4 0.3 1 0.05 30 normal
playsound minecraft:block.stone.place master @a ~ ~ ~ 0.8 1.1
