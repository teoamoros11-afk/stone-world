# A19 - Vende ocho trigos por un denario.
# Uso: /function swr:serie/mercado/trueque
execute store result score TRIGO_TMP serie run clear @s minecraft:wheat 0
execute if score TRIGO_TMP serie matches ..7 run return run tellraw @s [{"text":"[Mercado] ","color":"gold","bold":true},{"text":"Hacen falta ocho trigos.","color":"red"}]
clear @s minecraft:wheat 8
scoreboard players add @s moneda 1
scoreboard players add MERCADO_TRIGO serie 1
playsound minecraft:entity.villager.trade master @s ~ ~ ~ 0.7 1.1
tellraw @s [{"text":"[Mercado] ","color":"green","bold":true},{"text":"Vendidos ocho trigos. Cartera: ","color":"gray"},{"score":{"name":"@s","objective":"moneda"},"color":"white"},{"text":" denarios.","color":"gray"}]
