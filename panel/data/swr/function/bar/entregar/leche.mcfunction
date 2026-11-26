# Entrega 8 cubos de leche a la despensa del bar (se gastan del inventario).
# Uso: /function swr:bar/entregar/leche
execute store result score TIENE swr run clear @s minecraft:milk_bucket 0
execute if score TIENE swr matches ..7 run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hacen falta 8 cubos de leche: llevas ","color":"red"},{"score":{"name":"TIENE","objective":"swr"},"color":"aqua"}]
execute if score TIENE swr matches ..7 run return 0
clear @s minecraft:milk_bucket 8
scoreboard players add LECHE despensa 8
execute if score LECHE despensa matches 65.. run scoreboard players set LECHE despensa 64
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"8 cubos de leche a la despensa.","color":"green"}]
