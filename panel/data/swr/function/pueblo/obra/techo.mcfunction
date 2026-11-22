# Techo: una capa de tablon con vuelo por los cuatro lados.
execute at @e[tag=swr_obra,limit=1] run fill ~-5 ~4 ~-1 ~4 ~4 ~3 minecraft:dark_oak_planks
execute at @e[tag=swr_obra,limit=1] run fill ~-5 ~5 ~-1 ~4 ~5 ~-1 minecraft:dark_oak_slab
execute at @e[tag=swr_obra,limit=1] run fill ~-5 ~5 ~3 ~4 ~5 ~3 minecraft:dark_oak_slab
execute at @e[tag=swr_obra,limit=1] run particle minecraft:block{block_state:"minecraft:dark_oak_planks"} ~ ~4 ~1 4 0.4 2 0.05 40 normal
playsound minecraft:block.wood.place master @a ~ ~ ~ 1 0.9
