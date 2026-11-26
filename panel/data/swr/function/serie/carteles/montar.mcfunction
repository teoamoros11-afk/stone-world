# A24 - Carteles y nombres de calles (serie entera). La aldea deja de ser un decorado.
# Uso: /function swr:serie/carteles/montar
execute at @s run setblock ~ ~ ~ minecraft:oak_sign{front_text:{messages:['"CALLE MAYOR"','"ALDEA DE ISHIGAMI"','""','""']}}
execute at @s run setblock ~4 ~ ~ minecraft:oak_sign{front_text:{messages:['"CALLE DEL HERRERO"','"TALLERES"','""','""']}}
execute at @s run setblock ~8 ~ ~ minecraft:oak_sign{front_text:{messages:['"PLAZA DE LA CAMPANA"','"REUNION AL ATARDECER"','""','""']}}
execute at @s run setblock ~12 ~ ~ minecraft:oak_sign{front_text:{messages:['"CAMINO DEL PUERTO"','"PERSEUS"','""','""']}}
execute at @s run setblock ~16 ~ ~ minecraft:oak_sign{front_text:{messages:['"CALLE DE LAS CIEN HISTORIAS"','"BIBLIOTECA"','""','""']}}
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["swr_carteles"]}
tellraw @a [{"text":"[Carteles] ","color":"gold","bold":true},{"text":"Cinco rotulos: calle Mayor, del Herrero, plaza de la Campana, camino del Puerto y calle de las Cien Historias.","color":"gray"}]
