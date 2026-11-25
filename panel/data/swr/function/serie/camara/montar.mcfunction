# A16 - La camara de seguridad (T4, ep. 88). Monta el puesto de vigilancia.
# La imagen real seria tramo E; lo que si hace es contar lo que pasa por delante.
# Uso: /function swr:serie/camara/montar
execute if entity @e[tag=swr_camara,limit=1] run return run tellraw @s [{"text":"[Camara] ","color":"gold","bold":true},{"text":"Ya hay una camara montada: /function swr:serie/camara/vigilar","color":"red"}]
execute at @s run summon minecraft:marker ~ ~2 ~ {Tags:["swr_camara"]}
execute at @s run setblock ~ ~2 ~ minecraft:observer[facing=north]
execute at @s run setblock ~ ~3 ~ minecraft:lantern
scoreboard players set CAMARA_ACTIVA serie 1
scoreboard players set CAMARA_N serie 0
schedule function swr:serie/camara/ciclo 1200t replace
tellraw @a [{"text":"[Camara] ","color":"gold","bold":true},{"text":"Vigilancia montada sobre un observador. Cuenta lo que se mueve en ocho bloques y avisa cada minuto si hay alguien.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Mirar ahora","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/camara/vigilar"},"hoverEvent":{"action":"show_text","value":"Cuenta las entidades del radio"}}]
