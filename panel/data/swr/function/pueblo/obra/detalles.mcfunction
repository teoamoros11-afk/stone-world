# Detalles del taller: mesa de trabajo, cofre y faroles en el techo.
execute at @e[tag=swr_obra,limit=1] run setblock ~2 ~ ~1 minecraft:crafting_table
execute at @e[tag=swr_obra,limit=1] run setblock ~-3 ~ ~1 minecraft:chest[facing=north]
execute at @e[tag=swr_obra,limit=1] run setblock ~-3 ~5 ~ minecraft:lantern
execute at @e[tag=swr_obra,limit=1] run setblock ~2 ~5 ~ minecraft:lantern
execute at @e[tag=swr_obra,limit=1] run particle minecraft:happy_villager ~ ~1 ~ 3 1 2 0.05 20 normal
playsound minecraft:block.lantern.place master @a ~ ~ ~ 1 1
