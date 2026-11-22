# Muro 4 de todas las casas: el remate de madera.
execute as @e[tag=swr_casa] at @s run fill ~-2 ~3 ~-2 ~2 ~3 ~2 minecraft:oak_planks outline
execute as @e[tag=swr_casa] at @s run particle minecraft:block{block_state:"minecraft:oak_planks"} ~ ~3 ~ 2.5 0.3 2.5 0.05 20 normal
execute as @e[tag=swr_casa] at @s run playsound minecraft:block.wood.place master @a ~ ~ ~ 0.9 1
execute as @e[tag=swr_casa] at @s run data merge entity @e[tag=swr_texto,distance=..7,sort=nearest,limit=1] {CustomName:'{"text":"[######----]","color":"green"}'}
