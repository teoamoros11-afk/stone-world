# Entrega 8 huevos a la despensa del bar (se gastan del inventario).
# Uso: /function swr:bar/entregar/huevo
execute store result score TIENE swr run clear @s minecraft:egg 0
execute if score TIENE swr matches ..7 run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hacen falta 8 huevos: llevas ","color":"red"},{"score":{"name":"TIENE","objective":"swr"},"color":"aqua"}]
execute if score TIENE swr matches ..7 run return 0
clear @s minecraft:egg 8
scoreboard players add HUEVO despensa 8
execute if score HUEVO despensa matches 65.. run scoreboard players set HUEVO despensa 64
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"8 huevos a la despensa.","color":"green"}]
