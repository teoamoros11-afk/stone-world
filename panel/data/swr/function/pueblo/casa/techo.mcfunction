# Techo de todas las casas, con vuelo por los cuatro lados.
execute as @e[tag=swr_casa] at @s run fill ~-3 ~4 ~-3 ~3 ~4 ~3 minecraft:dark_oak_planks
execute as @e[tag=swr_casa] at @s run particle minecraft:block{block_state:"minecraft:dark_oak_planks"} ~ ~4 ~ 2.5 0.4 2.5 0.05 25 normal
execute as @e[tag=swr_casa] at @s run playsound minecraft:block.wood.place master @a ~ ~ ~ 1 0.9
execute as @e[tag=swr_casa] at @s run data merge entity @e[tag=swr_texto,distance=..7,sort=nearest,limit=1] {CustomName:'{"text":"[########--]","color":"green"}'}
