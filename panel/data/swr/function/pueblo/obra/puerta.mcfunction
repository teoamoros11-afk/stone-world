# Puerta: se abre el hueco en la pared delantera y se cuelga la puerta.
execute at @e[tag=swr_obra,limit=1] run fill ~-1 ~ ~ ~0 ~1 ~ minecraft:air
execute at @e[tag=swr_obra,limit=1] run setblock ~-1 ~ ~ minecraft:oak_door[half=lower,facing=north,hinge=left]
execute at @e[tag=swr_obra,limit=1] run setblock ~-1 ~1 ~ minecraft:oak_door[half=upper,facing=north,hinge=left]
execute at @e[tag=swr_obra,limit=1] run setblock ~ ~ ~ minecraft:oak_door[half=lower,facing=north,hinge=right]
execute at @e[tag=swr_obra,limit=1] run setblock ~ ~1 ~ minecraft:oak_door[half=upper,facing=north,hinge=right]
playsound minecraft:block.wood.place master @a ~ ~ ~ 1 1.2
