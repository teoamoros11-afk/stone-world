# A34 - El valle Taurus-Littrow y la colonia de medusas (T4, ep. 92-93).
# Ad Astra da la Luna; esto marca el yacimiento donde esta la colonia.
# Uso: /function swr:serie/luna/valle
execute at @s run fill ~-7 ~ ~-7 ~7 ~ ~7 minecraft:gray_concrete
execute at @s run fill ~-4 ~1 ~-4 ~4 ~3 ~4 minecraft:white_concrete
execute at @s run fill ~-3 ~2 ~-2 ~3 ~3 ~2 minecraft:glass
execute at @s run fill ~-1 ~1 ~-4 ~1 ~2 ~-4 minecraft:air
execute at @s run setblock ~ ~4 ~ minecraft:beacon
execute at @s run setblock ~5 ~1 ~5 minecraft:oak_sign{front_text:{messages:['"TAURUS-LITTROW"','"COLONIA DE MEDUSAS"','""','""']}}
execute at @s run setblock ~-5 ~1 ~5 minecraft:sea_lantern
execute at @s run setblock ~-5 ~2 ~5 minecraft:sea_lantern
execute at @s run setblock ~-5 ~1 ~6 minecraft:sea_lantern
execute at @s run setblock ~-6 ~1 ~5 minecraft:sea_lantern
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["swr_valle"]}
tellraw @a [{"text":"[Luna] ","color":"gray","bold":true},{"text":"Valle Taurus-Littrow: capsula, beacon y la colonia de medusas marcada. En la serie, aqui esta la respuesta a por que el mundo se petrifico.","color":"gray"}]
