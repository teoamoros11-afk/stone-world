# Coloca una persona petrificada donde estas, con nombre de la aldea de Ishigami.
# La estatua es un aldeano de verdad con el efecto de petrificacion del mod Dr. Stone KoS.
# Uso: /function swr:pueblo/estatua
scoreboard players add ESTATUAS swr 1
summon minecraft:villager ~ ~ ~ {NoAI:1b,Silent:1b,Invulnerable:1b,PersistenceRequired:1b,Tags:["swr_estatua","swr_nueva"],CustomNameVisible:1b,CustomName:'{"text":"Petrificado"}',VillagerData:{profession:"minecraft:none",level:1,type:"minecraft:plains"}}
execute as @e[tag=swr_nueva,limit=1] run function swr:pueblo/nombre
execute as @e[tag=swr_nueva,limit=1] run drstonekos petrify @s
tag @e[tag=swr_nueva] remove swr_nueva
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 0.5 0.8 0.5 0.1 30 normal
playsound minecraft:block.stone.place master @a ~ ~ ~ 0.8 0.6
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Una estatua mas en el campo. Con fluido milagroso puedes devolverla a la vida: /function swr:pueblo/despetrificar","color":"gray"}]
