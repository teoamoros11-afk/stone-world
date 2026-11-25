# A25 - El cementerio y la tumba de Byakuya (T1 ep. 1, T3 ep. 55).
# Byakuya murio antes de que el mundo despertara; su tumba guarda el disco de Lillian.
# Uso: /function swr:serie/cementerio/montar
execute at @s run fill ~-3 ~ ~-3 ~3 ~ ~3 minecraft:grass_block
execute at @s run fill ~-3 ~ ~-3 ~3 ~ ~-3 minecraft:stone_brick_wall
execute at @s run setblock ~ ~ ~ minecraft:jukebox
execute at @s run setblock ~-2 ~ ~2 minecraft:stone_brick_slab
execute at @s run setblock ~-2 ~1 ~2 minecraft:oak_sign{front_text:{messages:['"BYAKUYA"','"EL QUE TRAJO"','"LA MUSICA"','""']}}
execute at @s run setblock ~2 ~ ~2 minecraft:stone_brick_slab
execute at @s run setblock ~2 ~1 ~2 minecraft:oak_sign{front_text:{messages:['"LILLIAN"','"SU VOZ"','"SIGUE AQUI"','""']}}
execute at @s run setblock ~ ~2 ~ minecraft:lantern
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["swr_cementerio"]}
tellraw @a [{"text":"[Cementerio] ","color":"gold","bold":true},{"text":"Dos lapidas y un tocadiscos: Byakuya y Lillian. En la serie, la musica fue lo unico que cruzo los 3.700 anos.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Visitar","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/cementerio/visitar"},"hoverEvent":{"action":"show_text","value":"Poner el disco y recordar"}}]
