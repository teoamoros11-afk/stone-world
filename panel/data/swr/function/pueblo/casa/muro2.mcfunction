# Muro 3 de todas las casas: la banda de cristal.
execute as @e[tag=swr_casa] at @s run fill ~-2 ~2 ~-2 ~2 ~2 ~2 minecraft:glass outline
execute as @e[tag=swr_casa] at @s run particle minecraft:block{block_state:"minecraft:glass"} ~ ~2 ~ 2.5 0.3 2.5 0.05 20 normal
execute as @e[tag=swr_casa] at @s run playsound minecraft:block.glass.place master @a ~ ~ ~ 0.9 1
execute as @e[tag=swr_casa] at @s run data merge entity @e[tag=swr_texto,distance=..7,sort=nearest,limit=1] {CustomName:'{"text":"[#####-----]","color":"green"}'}
