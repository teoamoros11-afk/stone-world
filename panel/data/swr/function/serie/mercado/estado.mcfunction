# A19 - Puestos y ventas del mercado.
# Uso: /function swr:serie/mercado/estado
tellraw @s [{"text":"[Mercado] ","color":"gold","bold":true},{"text":"Trigos vendidos: ","color":"gray"},{"score":{"name":"MERCADO_TRIGO","objective":"serie"},"color":"white"},{"text":"   |   Panes vendidos: ","color":"gray"},{"score":{"name":"MERCADO_PAN","objective":"serie"},"color":"white"}]
execute if entity @e[tag=swr_mercado,limit=1] run tellraw @s [{"text":"  Puestos montados.","color":"green"}]
execute unless entity @e[tag=swr_mercado,limit=1] run tellraw @s [{"text":"  Sin montar: /function swr:serie/mercado/montar","color":"red"}]
