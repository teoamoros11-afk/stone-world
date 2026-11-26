# A5 - Estatuas del prologo con nombre (T1 ep. 24, T3 ep. 55).
# Coloca delante de ti las cuatro estatuas que Senku encuentra al despertar: Byakuya,
# Lillian, Taiju y Yuzuriha. Son aldeanos petrificados de verdad, no decorado.
# Uso: /function swr:serie/prologo/estatuas
execute at @s run summon minecraft:villager ~2 ~ ~2 {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_prologo","swr_prologo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Byakuya","color":"gold"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:plains"}}
execute at @s run summon minecraft:villager ~4 ~ ~2 {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_prologo","swr_prologo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Lillian","color":"light_purple"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:plains"}}
execute at @s run summon minecraft:villager ~2 ~ ~4 {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_prologo","swr_prologo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Taiju","color":"dark_green"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:plains"}}
execute at @s run summon minecraft:villager ~4 ~ ~4 {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_prologo","swr_prologo_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Yuzuriha","color":"light_purple"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:savanna"}}
execute as @e[tag=swr_prologo_nueva] run drstonekos petrify @s
tag @e[tag=swr_prologo_nueva] remove swr_prologo_nueva
scoreboard players add ESTATUAS swr 4
particle minecraft:block{block_state:"minecraft:stone"} ~3 ~1 ~3 1.5 1 1.5 0.1 60 normal
playsound minecraft:block.stone.place master @a ~ ~ ~ 0.8 0.6
tellraw @a [{"text":"[Prologo] ","color":"gold","bold":true},{"text":"Cuatro estatuas con nombre: Byakuya, Lillian, Taiju y Yuzuriha. Con fluido milagroso vuelven a la vida como cualquier vecino.","color":"gray"}]
