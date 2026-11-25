# A10 - Decretos de la aldea (T1, ep. 9-24). Cada decreto hace algo de verdad.
# Uso: /function swr:serie/politica/decreto
scoreboard players add DECRETO serie 1
execute if score DECRETO serie matches 4.. run scoreboard players set DECRETO serie 1
execute if score DECRETO serie matches 1 run scoreboard players add CUPO swr 5
execute if score DECRETO serie matches 1 run tellraw @a [{"text":"[Decreto] ","color":"gold","bold":true},{"text":"Racionamiento de fluido: cinco dosis mas para el campo de estatuas. En la serie, el fluido es el recurso que decide quien vuelve.","color":"gray"}]
execute if score DECRETO serie matches 2 run tellraw @a [{"text":"[Decreto] ","color":"gold","bold":true},{"text":"Obra publica: empieza una casa nueva si hay plaza y solar libre.","color":"gray"}]
execute if score DECRETO serie matches 2 if entity @e[tag=swr_plaza,limit=1] run function swr:pueblo/casa/empezar
execute if score DECRETO serie matches 3 unless entity @e[tag=swr_guardia,limit=1] run summon minecraft:iron_golem ~ ~ ~ {Tags:["swr_guardia"],CustomName:'{"text":"Guardia del decreto","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b}
execute if score DECRETO serie matches 3 run tellraw @a [{"text":"[Decreto] ","color":"gold","bold":true},{"text":"Guardia de la aldea: un golem patrulla la plaza mientras dure el decreto.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Estado","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/politica/estado"},"hoverEvent":{"action":"show_text","value":"Gobierno y decreto en vigor"}}]
