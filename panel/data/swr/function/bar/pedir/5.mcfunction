# 5 - Tarta de miel: 1 trigo, 1 huevo y 1 miel.
# Uso: /function swr:bar/pedir/5
execute unless score TRIGO despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay trigo suficiente para tarta de miel.","color":"red"}]
execute unless score TRIGO despensa matches 1.. run return 0
execute unless score HUEVO despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay huevo suficiente para tarta de miel.","color":"red"}]
execute unless score HUEVO despensa matches 1.. run return 0
execute unless score MIEL despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay miel suficiente para tarta de miel.","color":"red"}]
execute unless score MIEL despensa matches 1.. run return 0
scoreboard players remove TRIGO despensa 1
scoreboard players remove HUEVO despensa 1
scoreboard players remove MIEL despensa 1
give @s minecraft:cake 1
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Tarta de miel, de la cocina de Francois.","color":"green"}]
