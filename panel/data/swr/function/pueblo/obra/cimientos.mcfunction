# Cimientos: se despeja el solar y se pone el suelo de piedra.
execute at @e[tag=swr_obra,limit=1] run fill ~-5 ~ ~-1 ~4 ~4 ~3 minecraft:air
execute at @e[tag=swr_obra,limit=1] run fill ~-4 ~-1 ~ ~3 ~-1 ~2 minecraft:stone_bricks
execute at @e[tag=swr_obra,limit=1] run fill ~-1 ~-1 ~-2 ~0 ~-1 ~-1 minecraft:coarse_dirt
execute at @e[tag=swr_obra,limit=1] run particle minecraft:block{block_state:"minecraft:stone_bricks"} ~ ~ ~1 4 0.2 1 0.05 40 normal
playsound minecraft:block.stone.place master @a ~ ~ ~ 0.8 0.8
