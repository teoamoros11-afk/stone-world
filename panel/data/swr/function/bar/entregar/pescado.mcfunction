# Entrega 8 bacalaos a la despensa del bar (se gastan del inventario).
# Uso: /function swr:bar/entregar/pescado
execute store result score TIENE swr run clear @s minecraft:cod 0
execute if score TIENE swr matches ..7 run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hacen falta 8 bacalaos: llevas ","color":"red"},{"score":{"name":"TIENE","objective":"swr"},"color":"aqua"}]
execute if score TIENE swr matches ..7 run return 0
clear @s minecraft:cod 8
scoreboard players add PESCADO despensa 8
execute if score PESCADO despensa matches 65.. run scoreboard players set PESCADO despensa 64
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"8 bacalaos a la despensa.","color":"green"}]
