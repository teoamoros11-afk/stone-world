# 2 - Pescado a la brasa: 1 bacalao de la despensa.
# Uso: /function swr:bar/pedir/2
execute unless score PESCADO despensa matches 1.. run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"No hay pescado suficiente para pescado a la brasa.","color":"red"}]
execute unless score PESCADO despensa matches 1.. run return 0
scoreboard players remove PESCADO despensa 1
give @s minecraft:cooked_cod 1
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Pescado a la brasa, de la cocina de Francois.","color":"green"}]
