# Muro, capa 4: el remate, ya en madera.
execute at @e[tag=swr_obra,limit=1] run fill ~-4 ~3 ~ ~3 ~3 ~2 minecraft:oak_planks outline
execute at @e[tag=swr_obra,limit=1] run particle minecraft:block{block_state:"minecraft:oak_planks"} ~ ~3 ~1 4 0.3 1 0.05 30 normal
playsound minecraft:block.wood.place master @a ~ ~ ~ 0.9 1
