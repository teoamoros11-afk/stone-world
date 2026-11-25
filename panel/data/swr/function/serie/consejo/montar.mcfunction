# A11 - Consejo de guerra (T2-T3, ep. 51-53): mesa, mapa y ordenes.
# Uso: /function swr:serie/consejo/montar
execute at @s run setblock ~ ~ ~ minecraft:cartography_table
execute at @s run setblock ~-2 ~ ~ minecraft:dark_oak_stairs[facing=east]
execute at @s run setblock ~2 ~ ~ minecraft:dark_oak_stairs[facing=west]
execute at @s run setblock ~ ~ ~-2 minecraft:dark_oak_stairs[facing=south]
execute at @s run setblock ~ ~ ~2 minecraft:dark_oak_stairs[facing=north]
execute at @s run setblock ~ ~2 ~ minecraft:lantern
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["swr_consejo"]}
tellraw @a [{"text":"[Consejo] ","color":"gold","bold":true},{"text":"Mesa de guerra montada: mapa, cuatro asientos y luz. Las ordenes se dan a mano y la cuenta atras corre sola.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Dar orden","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/consejo/orden"},"hoverEvent":{"action":"show_text","value":"Elige la orden del dia y arranca la cuenta atras"}},{"text":"   • ","color":"gray"},{"text":"Estado","color":"gold","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/consejo/estado"},"hoverEvent":{"action":"show_text","value":"Orden en vigor y tiempo restante"}}]
