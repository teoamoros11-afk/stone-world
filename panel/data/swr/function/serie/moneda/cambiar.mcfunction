# A18 - Cambia un lingote de oro por nueve denarios.
# Uso: /function swr:serie/moneda/cambiar
execute unless items entity @s container.* minecraft:gold_ingot run return run tellraw @s [{"text":"[Moneda] ","color":"gold","bold":true},{"text":"Hace falta un lingote de oro.","color":"red"}]
clear @s minecraft:gold_ingot 1
scoreboard players add @s moneda 9
playsound minecraft:entity.villager.yes master @s ~ ~ ~ 0.6 1.2
tellraw @s [{"text":"[Moneda] ","color":"gold","bold":true},{"text":"Cambiado. Cartera: ","color":"gray"},{"score":{"name":"@s","objective":"moneda"},"color":"white"},{"text":" denarios.","color":"gray"}]
