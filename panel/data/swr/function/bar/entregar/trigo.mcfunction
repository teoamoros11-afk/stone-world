# Entrega 8 trigos a la despensa del bar (se gastan del inventario).
# Uso: /function swr:bar/entregar/trigo
execute store result score TIENE swr run clear @s minecraft:wheat 0
execute if score TIENE swr matches ..7 run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hacen falta 8 trigos: llevas ","color":"red"},{"score":{"name":"TIENE","objective":"swr"},"color":"aqua"}]
execute if score TIENE swr matches ..7 run return 0
clear @s minecraft:wheat 8
scoreboard players add TRIGO despensa 8
execute if score TRIGO despensa matches 65.. run scoreboard players set TRIGO despensa 64
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"8 trigos a la despensa.","color":"green"}]
