# Entrega 8 botellas de miel a la despensa del bar (se gastan del inventario).
# Uso: /function swr:bar/entregar/miel
execute store result score TIENE swr run clear @s minecraft:honey_bottle 0
execute if score TIENE swr matches ..7 run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hacen falta 8 botellas de miel: llevas ","color":"red"},{"score":{"name":"TIENE","objective":"swr"},"color":"aqua"}]
execute if score TIENE swr matches ..7 run return 0
clear @s minecraft:honey_bottle 8
scoreboard players add MIEL despensa 8
execute if score MIEL despensa matches 65.. run scoreboard players set MIEL despensa 64
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"8 botellas de miel a la despensa.","color":"green"}]
