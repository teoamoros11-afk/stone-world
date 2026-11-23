# 9 - Agua de miel: 1 botella de miel.
# Uso: /function swr:bar/pedir/9
execute unless score MIEL despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay miel suficiente para agua de miel.","color":"red"}]
execute unless score MIEL despensa matches 1.. run return 0
scoreboard players remove MIEL despensa 1
give @s minecraft:honey_bottle 1
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Agua de miel, de la cocina de Francois.","color":"green"}]
