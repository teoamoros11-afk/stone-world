# A25 - Visita: suena el disco y se recuerda a Byakuya.
# Uso: /function swr:serie/cementerio/visitar
execute unless entity @e[tag=swr_cementerio,limit=1] run return run tellraw @s [{"text":"[Cementerio] ","color":"gold","bold":true},{"text":"No hay cementerio. /function swr:serie/cementerio/montar","color":"red"}]
playsound minecraft:block.jukebox.play master @a ~ ~ ~ 1 1
title @a title [{"text":"BYAKUYA","color":"gold","bold":true}]
title @a subtitle [{"text":"El que trajo la musica","color":"yellow"}]
tellraw @a [{"text":"[Cementerio] ","color":"gold","bold":true},{"text":"Byakuya no vivio para ver el mundo despertar. Dejo a Lillian y su disco: la prueba de que la civilizacion no se habia perdido del todo.","color":"gray","italic":true}]
