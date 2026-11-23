# 4 - Estofado de la bodega: 1 carne y 1 zanahoria.
# Uso: /function swr:bar/pedir/4
execute unless score CARNE despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay carne suficiente para estofado de la bodega.","color":"red"}]
execute unless score CARNE despensa matches 1.. run return 0
execute unless score ZANAHORIA despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay zanahoria suficiente para estofado de la bodega.","color":"red"}]
execute unless score ZANAHORIA despensa matches 1.. run return 0
scoreboard players remove CARNE despensa 1
scoreboard players remove ZANAHORIA despensa 1
give @s minecraft:rabbit_stew 1
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Estofado de la bodega, de la cocina de Francois.","color":"green"}]
