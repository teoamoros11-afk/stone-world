# A19 - El mercado y el trueque (T1, ep. 12-14). Puestos con stock y cartel de precios.
# Uso: /function swr:serie/mercado/montar
execute at @s run setblock ~ ~ ~ minecraft:barrel
execute at @s run setblock ~2 ~ ~ minecraft:barrel
execute at @s run setblock ~4 ~ ~ minecraft:barrel
execute at @s run setblock ~-1 ~1 ~ minecraft:oak_sign{front_text:{messages:['"MERCADO"','"DE LA ALDEA"','""','""']}}
execute at @s run setblock ~1 ~1 ~ minecraft:oak_sign{front_text:{messages:['"TRIGO x8"','"1 DENARIO"','""','""']}}
execute at @s run setblock ~3 ~1 ~ minecraft:oak_sign{front_text:{messages:['"PAN x6"','"8 DENARIOS"','""','""']}}
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["swr_mercado"]}
tellraw @a [{"text":"[Mercado] ","color":"gold","bold":true},{"text":"Tres puestos montados. Trueque: ocho trigos por un denario. Compra: ocho denarios por seis panes.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Vender trigo","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/mercado/trueque"},"hoverEvent":{"action":"show_text","value":"Ocho trigos por un denario"}},{"text":"   • ","color":"gray"},{"text":"Comprar pan","color":"gold","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/mercado/compra"},"hoverEvent":{"action":"show_text","value":"Ocho denarios por seis panes"}},{"text":"   • ","color":"gray"},{"text":"Estado","color":"gray","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/mercado/estado"},"hoverEvent":{"action":"show_text","value":"Puestos y ventas"}}]
