# 8 - Leche de la granja: 1 cubo de leche.
# Uso: /function swr:bar/pedir/8
execute unless score LECHE despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay leche suficiente para leche de la granja.","color":"red"}]
execute unless score LECHE despensa matches 1.. run return 0
scoreboard players remove LECHE despensa 1
give @s minecraft:milk_bucket 1
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Leche de la granja, de la cocina de Francois.","color":"green"}]
