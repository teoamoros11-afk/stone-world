# A31 - La onda petrificadora desde Sudamerica (T4, ep. 69-78).
# Marca el origen y da cinco segundos antes de que el destello cubra 40 bloques.
# Uso: /function swr:serie/onda/iniciar
execute if entity @e[tag=swr_onda,limit=1] run return run tellraw @s [{"text":"[Onda] ","color":"dark_purple","bold":true},{"text":"Ya hay una onda activa. /function swr:serie/onda/parar","color":"red"}]
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["swr_onda"]}
scoreboard players set ONDA_ACTIVA serie 1
scoreboard players set ONDA_T serie 5
schedule function swr:serie/onda/ciclo 20t replace
title @a title [{"text":"LA ONDA","color":"dark_purple","bold":true}]
title @a subtitle [{"text":"Cinco segundos","color":"gray"}]
tellraw @a [{"text":"[Onda] ","color":"dark_purple","bold":true},{"text":"El origen esta marcado. Lo que este a 40 bloques cuando llegue el destello se queda en piedra.","color":"gray"}]
