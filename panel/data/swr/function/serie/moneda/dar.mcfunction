# A18 - La moneda del reino (T4, ep. 58). Nueve denarios por lingote de oro.
# Uso: /function swr:serie/moneda/dar
scoreboard players add @s moneda 9
tellraw @s [{"text":"[Moneda] ","color":"gold","bold":true},{"text":"Nueve denarios. Cartera: ","color":"gray"},{"score":{"name":"@s","objective":"moneda"},"color":"white"},{"text":" denarios.","color":"gray"}]
