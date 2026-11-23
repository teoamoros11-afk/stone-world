# Entrega 8 patatas a la despensa del bar (se gastan del inventario).
# Uso: /function swr:bar/entregar/patata
execute store result score TIENE swr run clear @s minecraft:potato 0
execute if score TIENE swr matches ..7 run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hacen falta 8 patatas: llevas ","color":"red"},{"score":{"name":"TIENE","objective":"swr"},"color":"aqua"}]
execute if score TIENE swr matches ..7 run return 0
clear @s minecraft:potato 8
scoreboard players add PATATA despensa 8
execute if score PATATA despensa matches 65.. run scoreboard players set PATATA despensa 64
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"8 patatas a la despensa.","color":"green"}]
