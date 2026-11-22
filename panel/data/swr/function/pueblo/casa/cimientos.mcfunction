# Cimientos de todas las casas de la tanda: solar despejado y suelo de piedra.
execute as @e[tag=swr_casa] at @s run fill ~-3 ~ ~-3 ~3 ~4 ~3 minecraft:air
execute as @e[tag=swr_casa] at @s run fill ~-2 ~-1 ~-2 ~2 ~-1 ~2 minecraft:stone_bricks
execute as @e[tag=swr_casa] at @s run particle minecraft:block{block_state:"minecraft:stone_bricks"} ~ ~ ~ 2.5 0.2 2.5 0.05 20 normal
execute as @e[tag=swr_casa] at @s run playsound minecraft:block.stone.place master @a ~ ~ ~ 0.8 0.9
execute as @e[tag=swr_casa] at @s run data merge entity @e[tag=swr_texto,distance=..7,sort=nearest,limit=1] {CustomName:'{"text":"[##--------]","color":"green"}'}
