# A11 - Que orden esta en vigor y cuanto queda.
# Uso: /function swr:serie/consejo/estado
tellraw @s [{"text":"[Consejo] ","color":"gold","bold":true},{"text":"Orden: ","color":"gray"},{"score":{"name":"CONSEJO_ORDEN","objective":"serie"},"color":"white"},{"text":"   |   Quedan: ","color":"gray"},{"score":{"name":"CONSEJO_T","objective":"serie"},"color":"white"},{"text":" s","color":"gray"}]
execute if entity @e[tag=swr_consejo,limit=1] run tellraw @s [{"text":"  Mesa montada.","color":"green"}]
execute unless entity @e[tag=swr_consejo,limit=1] run tellraw @s [{"text":"  Sin mesa: /function swr:serie/consejo/montar","color":"red"}]
