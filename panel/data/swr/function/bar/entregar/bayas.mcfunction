# Entrega 8 bayas a la despensa del bar (se gastan del inventario).
# Uso: /function swr:bar/entregar/bayas
execute store result score TIENE swr run clear @s minecraft:sweet_berries 0
execute if score TIENE swr matches ..7 run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hacen falta 8 bayas: llevas ","color":"red"},{"score":{"name":"TIENE","objective":"swr"},"color":"aqua"}]
execute if score TIENE swr matches ..7 run return 0
clear @s minecraft:sweet_berries 8
scoreboard players add BAYAS despensa 8
execute if score BAYAS despensa matches 65.. run scoreboard players set BAYAS despensa 64
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"8 bayas a la despensa.","color":"green"}]
