# Cimientos de todas las casas de la tanda: solar despejado, suelo de piedra y zapata.
# La zapata es lo que evita el pueblo deforme en ladera: rellena de piedra lo que hay bajo
# el suelo (donde habia aire), asi la casa ni flota ni queda cortada contra el terreno. Se
# queda dentro del 5x5 de la casa a proposito: un zocalo mas ancho tocaba al vecino en la
# esquina (lo comprueba tests/test_pueblo_geometria.py).
execute as @e[tag=swr_casa] at @s run fill ~-3 ~ ~-3 ~3 ~4 ~3 minecraft:air
execute as @e[tag=swr_casa] at @s run fill ~-2 ~-10 ~-2 ~2 ~-2 ~2 minecraft:stone_bricks replace minecraft:air
execute as @e[tag=swr_casa] at @s run fill ~-2 ~-1 ~-2 ~2 ~-1 ~2 minecraft:stone_bricks
execute as @e[tag=swr_casa] at @s run particle minecraft:block{block_state:"minecraft:stone_bricks"} ~ ~ ~ 2.5 0.2 2.5 0.05 20 normal
execute as @e[tag=swr_casa] at @s run playsound minecraft:block.stone.place master @a ~ ~ ~ 0.8 0.9
execute as @e[tag=swr_casa] at @s run data merge entity @e[tag=swr_texto,distance=..7,sort=nearest,limit=1] {CustomName:'{"text":"[##--------]","color":"green"}'}
