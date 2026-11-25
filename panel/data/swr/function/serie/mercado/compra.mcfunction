# A19 - Compra seis panes por ocho denarios.
# Uso: /function swr:serie/mercado/compra
execute unless score @s moneda matches 8.. run return run tellraw @s [{"text":"[Mercado] ","color":"gold","bold":true},{"text":"Hacen falta ocho denarios.","color":"red"}]
scoreboard players remove @s moneda 8
give @s minecraft:bread 6
scoreboard players add MERCADO_PAN serie 1
playsound minecraft:entity.villager.trade master @s ~ ~ ~ 0.7 1.1
tellraw @s [{"text":"[Mercado] ","color":"green","bold":true},{"text":"Seis panes. Cartera: ","color":"gray"},{"score":{"name":"@s","objective":"moneda"},"color":"white"},{"text":" denarios.","color":"gray"}]
