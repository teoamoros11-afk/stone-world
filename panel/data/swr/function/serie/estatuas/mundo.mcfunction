# A30 - Estatuas de todo el mundo (T4, ep. 79-81). Ocho estatuas alrededor de donde estas.
# En la serie, el reparto de estatuas es el mapa de quienes faltan por volver.
# Uso: /function swr:serie/estatuas/mundo
execute at @s run summon minecraft:villager ~8 ~ ~ {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_mundo","swr_mundo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Senku","color":"aqua"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:plains"}}
execute at @s run summon minecraft:villager ~6 ~ ~6 {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_mundo","swr_mundo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Chrome","color":"gold"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:plains"}}
execute at @s run summon minecraft:villager ~ ~ ~8 {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_mundo","swr_mundo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Kohaku","color":"yellow"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:plains"}}
execute at @s run summon minecraft:villager ~-6 ~ ~6 {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_mundo","swr_mundo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Ruri","color":"light_purple"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:plains"}}
execute at @s run summon minecraft:villager ~-8 ~ ~ {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_mundo","swr_mundo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Kaseki","color":"gray"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:savanna"}}
execute at @s run summon minecraft:villager ~-6 ~ ~-6 {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_mundo","swr_mundo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Ryusui","color":"gold"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:desert"}}
execute at @s run summon minecraft:villager ~ ~ ~-8 {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_mundo","swr_mundo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Tsukasa","color":"dark_red"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:plains"}}
execute at @s run summon minecraft:villager ~6 ~ ~-6 {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_mundo","swr_mundo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Gen","color":"light_purple"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:desert"}}
execute as @e[tag=swr_mundo_nueva] run drstonekos petrify @s
tag @e[tag=swr_mundo_nueva] remove swr_mundo_nueva
scoreboard players add ESTATUAS swr 8
scoreboard players add MUNDO_ESTATUAS serie 8
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 8 1 8 0.1 120 normal
tellraw @a [{"text":"[Estatuas] ","color":"gold","bold":true},{"text":"Ocho estatuas repartidas en circulo. Cada una lleva su nombre: el mapa de los que faltan por volver.","color":"gray"}]
