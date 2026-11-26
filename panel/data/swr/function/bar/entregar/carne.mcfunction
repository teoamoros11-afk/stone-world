# Entrega 8 filetes a la despensa del bar (se gastan del inventario).
# Uso: /function swr:bar/entregar/carne
execute store result score TIENE swr run clear @s minecraft:beef 0
execute if score TIENE swr matches ..7 run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hacen falta 8 filetes: llevas ","color":"red"},{"score":{"name":"TIENE","objective":"swr"},"color":"aqua"}]
execute if score TIENE swr matches ..7 run return 0
clear @s minecraft:beef 8
scoreboard players add CARNE despensa 8
execute if score CARNE despensa matches 65.. run scoreboard players set CARNE despensa 64
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"8 filetes a la despensa.","color":"green"}]
