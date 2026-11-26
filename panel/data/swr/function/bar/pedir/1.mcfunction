# 1 - Pan del pueblo: 1 pan de la despensa.
# Uso: /function swr:bar/pedir/1
execute unless score PAN despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay pan suficiente para pan del pueblo.","color":"red"}]
execute unless score PAN despensa matches 1.. run return 0
scoreboard players remove PAN despensa 1
give @s minecraft:bread 2
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Pan del pueblo, de la cocina de Francois.","color":"green"}]
