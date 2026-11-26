# Un paso de la bola, una vez por tick mientras hay tirada (lo llama swr:tick).
# Uso: interno
execute unless entity @e[tag=swr_bola] run function swr:bar/bolos/puntuar
execute unless entity @e[tag=swr_bola] run return 0
execute as @e[tag=swr_bola] at @s run particle minecraft:crit ~ ~0.3 ~ 0.15 0.15 0.15 0 4 normal
execute as @e[tag=swr_bola] at @s run playsound minecraft:block.wood.step block @a ~ ~ ~ 0.6 1.4
execute as @e[tag=swr_bola] at @s run tp @s ~ ~ ~0.7
execute as @e[tag=swr_bola] at @s run function swr:bar/bolos/tumbar
scoreboard players add BOLOS_PASO swr 1
execute if score BOLOS_PASO swr matches 16.. run function swr:bar/bolos/puntuar
