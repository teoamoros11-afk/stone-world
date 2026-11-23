# Entrega 8 panes a la despensa del bar (se gastan del inventario).
# Uso: /function swr:bar/entregar/pan
execute store result score TIENE swr run clear @s minecraft:bread 0
execute if score TIENE swr matches ..7 run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hacen falta 8 panes: llevas ","color":"red"},{"score":{"name":"TIENE","objective":"swr"},"color":"aqua"}]
execute if score TIENE swr matches ..7 run return 0
clear @s minecraft:bread 8
scoreboard players add PAN despensa 8
execute if score PAN despensa matches 65.. run scoreboard players set PAN despensa 64
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"8 panes a la despensa.","color":"green"}]
