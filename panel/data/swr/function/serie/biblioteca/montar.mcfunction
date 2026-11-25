# A7 - La biblioteca de las cien historias (T1, ep. 17).
# Monta la estanteria donde Ruri guarda la memoria del mundo: cuatro baldas, el atril
# y el cartel. Los cien tomos se cuentan de veinticinco en veinticinco.
# Uso: /function swr:serie/biblioteca/montar
execute at @s run setblock ~ ~ ~ minecraft:lectern
execute at @s run setblock ~-1 ~ ~ minecraft:bookshelf
execute at @s run setblock ~-1 ~1 ~ minecraft:bookshelf
execute at @s run setblock ~-1 ~2 ~ minecraft:bookshelf
execute at @s run setblock ~1 ~ ~ minecraft:bookshelf
execute at @s run setblock ~1 ~1 ~ minecraft:bookshelf
execute at @s run setblock ~1 ~2 ~ minecraft:bookshelf
execute at @s run setblock ~ ~2 ~ minecraft:oak_sign{front_text:{messages:['"CIEN HISTORIAS"','"RURI"','""','""']}}
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["swr_biblioteca"]}
tellraw @a [{"text":"[Biblioteca] ","color":"gold","bold":true},{"text":"Cuatro baldas y el atril de Ruri. Cada balda son veinticinco tomos: las cien historias que la aldea heredo de la tripulacion que estaba en orbita.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Indice","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/biblioteca/indice"},"hoverEvent":{"action":"show_text","value":"Los diez capitulos y el libro para llevar"}}]
