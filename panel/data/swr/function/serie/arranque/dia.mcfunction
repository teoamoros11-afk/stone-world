# A4 - Un dia mas desde que saliste de la piedra. Se reprograma solo.
scoreboard players add DIAS serie 1
title @a actionbar [{"text":"Dia ","color":"gold"},{"score":{"name":"DIAS","objective":"serie"},"color":"white"},{"text":" desde la piedra","color":"gray"}]
execute if score DIAS serie matches 1 run tellraw @a [{"text":"[Arranque] ","color":"gold","bold":true},{"text":"Primer dia. En la serie, Senku cuenta los dias para no perder la cuenta de los 3.700 anos que estuvo petrificado.","color":"gray"}]
schedule function swr:serie/arranque/dia 24000t replace
