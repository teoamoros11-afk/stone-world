# Una tirada: la bola rueda sola por la mesa y tumba lo que pilla.
# Uso: /function swr:bar/bolos/tirar
execute unless entity @e[tag=swr_bolos_origen,limit=1] run tellraw @s [{"text":"[Bolos] ","color":"gold","bold":true},{"text":"No hay mesa: /function swr:bar/bolos/montar","color":"red"}]
execute unless entity @e[tag=swr_bolos_origen,limit=1] run return 0
execute if score BOLOS_ACTIVO swr matches 1 run tellraw @s [{"text":"[Bolos] ","color":"gold","bold":true},{"text":"Espera a que pare la bola.","color":"red"}]
execute if score BOLOS_ACTIVO swr matches 1 run return 0
function swr:bar/bolos/reset
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:marker ~ ~0.4 ~ {Tags:["swr_bola"]}
scoreboard players set BOLOS_PASO swr 0
scoreboard players set BOLOS_ACTIVO swr 1
tag @a remove swr_bolos_jugador
tag @s add swr_bolos_jugador
playsound minecraft:entity.snowball.throw block @a ~ ~ ~ 1 0.8
tellraw @s [{"text":"[Bolos] ","color":"gold","bold":true},{"text":"Ahi va la bola...","color":"white"}]
