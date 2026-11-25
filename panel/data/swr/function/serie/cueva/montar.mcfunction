# A3 - La cueva del milagro como yacimiento vivo (T1, ep. 1).
# Monta el yacimiento donde estas: un barril de guano que se rellena solo y un caldero
# de agua con nitrato. El guano es el nitrato del que sale el fluido milagroso.
# Uso: /function swr:serie/cueva/montar
execute if entity @e[tag=swr_cueva,limit=1] run return run tellraw @s [{"text":"[Cueva] ","color":"gold","bold":true},{"text":"Ya hay un yacimiento montado. Estado: /function swr:serie/cueva/estado","color":"red"}]
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["swr_cueva"]}
execute at @s run setblock ~ ~ ~ minecraft:barrel
execute at @s run item replace block ~ ~ ~ container.0 with minecraft:bone_meal 16
execute at @s run setblock ~1 ~ ~ minecraft:water_cauldron[level=3]
execute at @s run setblock ~-1 ~ ~ minecraft:stone_bricks
scoreboard players set CUEVA_ACTIVA serie 1
schedule function swr:serie/cueva/ciclo 1200t replace
tellraw @a [{"text":"[Cueva] ","color":"gold","bold":true},{"text":"Yacimiento montado: el guano del barril se repone solo cada minuto y el caldero mantiene el agua con nitrato. En la serie, de aqui salio el primer fluido milagroso.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Estado","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/cueva/estado"},"hoverEvent":{"action":"show_text","value":"Cuantas cargas de guano quedan"}}]
