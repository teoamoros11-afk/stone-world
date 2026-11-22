# Puerta de cada casa, en la pared que mira a la plaza (tag swr_dir_0..3).
execute as @e[tag=swr_casa,tag=swr_dir_0] at @s run setblock ~-2 ~ ~ minecraft:air
execute as @e[tag=swr_casa,tag=swr_dir_0] at @s run setblock ~-2 ~1 ~ minecraft:air
execute as @e[tag=swr_casa,tag=swr_dir_0] at @s run setblock ~-2 ~ ~ minecraft:oak_door[half=lower,facing=west,hinge=left]
execute as @e[tag=swr_casa,tag=swr_dir_0] at @s run setblock ~-2 ~1 ~ minecraft:oak_door[half=upper,facing=west,hinge=left]
execute as @e[tag=swr_casa,tag=swr_dir_1] at @s run setblock ~ ~ ~-2 minecraft:air
execute as @e[tag=swr_casa,tag=swr_dir_1] at @s run setblock ~ ~1 ~-2 minecraft:air
execute as @e[tag=swr_casa,tag=swr_dir_1] at @s run setblock ~ ~ ~-2 minecraft:oak_door[half=lower,facing=north,hinge=left]
execute as @e[tag=swr_casa,tag=swr_dir_1] at @s run setblock ~ ~1 ~-2 minecraft:oak_door[half=upper,facing=north,hinge=left]
execute as @e[tag=swr_casa,tag=swr_dir_2] at @s run setblock ~2 ~ ~ minecraft:air
execute as @e[tag=swr_casa,tag=swr_dir_2] at @s run setblock ~2 ~1 ~ minecraft:air
execute as @e[tag=swr_casa,tag=swr_dir_2] at @s run setblock ~2 ~ ~ minecraft:oak_door[half=lower,facing=east,hinge=left]
execute as @e[tag=swr_casa,tag=swr_dir_2] at @s run setblock ~2 ~1 ~ minecraft:oak_door[half=upper,facing=east,hinge=left]
execute as @e[tag=swr_casa,tag=swr_dir_3] at @s run setblock ~ ~ ~2 minecraft:air
execute as @e[tag=swr_casa,tag=swr_dir_3] at @s run setblock ~ ~1 ~2 minecraft:air
execute as @e[tag=swr_casa,tag=swr_dir_3] at @s run setblock ~ ~ ~2 minecraft:oak_door[half=lower,facing=south,hinge=left]
execute as @e[tag=swr_casa,tag=swr_dir_3] at @s run setblock ~ ~1 ~2 minecraft:oak_door[half=upper,facing=south,hinge=left]
execute as @e[tag=swr_casa] at @s run playsound minecraft:block.wood.place master @a ~ ~ ~ 1 1.2
execute as @e[tag=swr_casa] at @s run data merge entity @e[tag=swr_texto,distance=..7,sort=nearest,limit=1] {CustomName:'{"text":"[#########-]","color":"green"}'}
