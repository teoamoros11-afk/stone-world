# Entrega 8 zanahorias a la despensa del bar (se gastan del inventario).
# Uso: /function swr:bar/entregar/zanahoria
execute store result score TIENE swr run clear @s minecraft:carrot 0
execute if score TIENE swr matches ..7 run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hacen falta 8 zanahorias: llevas ","color":"red"},{"score":{"name":"TIENE","objective":"swr"},"color":"aqua"}]
execute if score TIENE swr matches ..7 run return 0
clear @s minecraft:carrot 8
scoreboard players add ZANAHORIA despensa 8
execute if score ZANAHORIA despensa matches 65.. run scoreboard players set ZANAHORIA despensa 64
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"8 zanahorias a la despensa.","color":"green"}]
