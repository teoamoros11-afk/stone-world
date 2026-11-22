# Muro 2 de todas las casas.
execute as @e[tag=swr_casa] at @s run fill ~-2 ~1 ~-2 ~2 ~1 ~2 minecraft:stone_bricks outline
execute as @e[tag=swr_casa] at @s run particle minecraft:block{block_state:"minecraft:stone_bricks"} ~ ~1 ~ 2.5 0.3 2.5 0.05 20 normal
execute as @e[tag=swr_casa] at @s run playsound minecraft:block.stone.place master @a ~ ~ ~ 0.8 1.1
execute as @e[tag=swr_casa] at @s run data merge entity @e[tag=swr_texto,distance=..7,sort=nearest,limit=1] {CustomName:'{"text":"[####------]","color":"green"}'}
