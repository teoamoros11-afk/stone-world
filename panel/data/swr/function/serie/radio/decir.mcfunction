# A12 - Habla por la radio. Sin radio en la mano no hay mensaje.
# Stanley cerca mete ruido: en la serie, la guerra electronica empieza por la radio.
# Uso: /function swr:serie/radio/decir
execute unless items entity @s weapon.mainhand minecraft:clock unless items entity @s weapon.offhand minecraft:clock run return run tellraw @s [{"text":"[Radio] ","color":"aqua","bold":true},{"text":"Necesitas la radio en la mano. /function swr:serie/radio/dar","color":"red"}]
execute if entity @e[tag=swr_es_stanley,distance=..24] run tellraw @a [{"text":"[Radio] ","color":"aqua","bold":true},{"text":"[ruido] ...stanley... no... escucho... [ruido]","color":"dark_gray","italic":true}]
execute if entity @e[tag=swr_es_stanley,distance=..24] run return 0
tellraw @a[distance=..64] [{"text":"[Radio] ","color":"aqua","bold":true},{"selector":"@s"},{"text":": ","color":"gray"},{"text":"cambio y corto. La aldea escucha.","color":"white"}]
tellraw @s [{"text":"[Radio] ","color":"gray"},{"text":"Mensaje enviado por el canal ","color":"gray"},{"score":{"name":"RADIO_CANAL","objective":"serie"},"color":"aqua"},{"text":".","color":"gray"}]
playsound minecraft:block.note_block.bit master @a ~ ~ ~ 0.5 1.4
