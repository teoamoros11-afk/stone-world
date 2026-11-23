# 7 - Zumo de bayas: 2 bayas.
# Uso: /function swr:bar/pedir/7
execute unless score BAYAS despensa matches 2.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay bayas suficiente para zumo de bayas.","color":"red"}]
execute unless score BAYAS despensa matches 2.. run return 0
scoreboard players remove BAYAS despensa 2
give @s minecraft:potion[minecraft:potion_contents={potion:"minecraft:water"},minecraft:custom_name='{"text":"Zumo de bayas","color":"red","italic":false}'] 1
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Zumo de bayas, de la cocina de Francois.","color":"green"}]
