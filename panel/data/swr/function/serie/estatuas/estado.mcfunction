# A30 - Cuantas estatuas se han repartido por el mundo.
# Uso: /function swr:serie/estatuas/estado
tellraw @s [{"text":"[Estatuas] ","color":"gold","bold":true},{"text":"Repartidas por el mundo: ","color":"gray"},{"score":{"name":"MUNDO_ESTATUAS","objective":"serie"},"color":"white"}]
execute if entity @e[tag=swr_mundo,limit=1] run tellraw @s [{"text":"  Hay estatuas del reparto en pie.","color":"green"}]
execute unless entity @e[tag=swr_mundo,limit=1] run tellraw @s [{"text":"  Ninguna en pie: /function swr:serie/estatuas/mundo","color":"red"}]
