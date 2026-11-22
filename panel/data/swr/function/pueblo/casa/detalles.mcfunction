# Detalles de todas las casas: cama, cofre dentro y dos faroles en el techo.
execute as @e[tag=swr_casa] at @s run setblock ~-1 ~ ~-1 minecraft:red_bed[part=foot,facing=west]
execute as @e[tag=swr_casa] at @s run setblock ~-2 ~ ~-1 minecraft:red_bed[part=head,facing=west]
execute as @e[tag=swr_casa] at @s run setblock ~1 ~ ~1 minecraft:chest[facing=north]
execute as @e[tag=swr_casa] at @s run setblock ~-3 ~5 ~ minecraft:lantern
execute as @e[tag=swr_casa] at @s run setblock ~3 ~5 ~ minecraft:lantern
execute as @e[tag=swr_casa] at @s run particle minecraft:happy_villager ~ ~1 ~ 2 1 2 0.05 15 normal
execute as @e[tag=swr_casa] at @s run playsound minecraft:block.lantern.place master @a ~ ~ ~ 1 1
execute as @e[tag=swr_casa] at @s run data merge entity @e[tag=swr_texto,distance=..7,sort=nearest,limit=1] {CustomName:'{"text":"[##########]","color":"green"}'}
