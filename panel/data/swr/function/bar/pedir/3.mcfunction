# 3 - Tortilla del barco: 1 huevo y 1 patata.
# Uso: /function swr:bar/pedir/3
execute unless score HUEVO despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay huevo suficiente para tortilla del barco.","color":"red"}]
execute unless score HUEVO despensa matches 1.. run return 0
execute unless score PATATA despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay patata suficiente para tortilla del barco.","color":"red"}]
execute unless score PATATA despensa matches 1.. run return 0
scoreboard players remove HUEVO despensa 1
scoreboard players remove PATATA despensa 1
give @s minecraft:pumpkin_pie 1
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Tortilla del barco, de la cocina de Francois.","color":"green"}]
