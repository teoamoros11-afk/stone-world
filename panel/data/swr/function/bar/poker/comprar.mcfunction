# La banca cambia oro por fichas: 1 lingote de oro = 25 fichas. No hay fichas gratis.
# Uso: /function swr:bar/poker/comprar
execute store result score TIENE swr run clear @s minecraft:gold_ingot 0
execute if score TIENE swr matches ..0 run tellraw @s [{"text":"[Poker] ","color":"gold","bold":true},{"text":"Hace falta 1 lingote de oro.","color":"red"}]
execute if score TIENE swr matches ..0 run return 0
clear @s minecraft:gold_ingot 1
scoreboard players add @s fichas 25
tellraw @s [{"text":"[Poker] ","color":"gold","bold":true},{"text":"25 fichas. Llevas ","color":"green"},{"score":{"name":"@s","objective":"fichas"},"color":"aqua"}]
