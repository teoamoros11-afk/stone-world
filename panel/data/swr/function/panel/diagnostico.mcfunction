execute store result score TEMP swr run execute if entity @e[type=minecolonies:citizen]
tellraw @s [{"text":"Ciudadanos detectados: ","color":"gray"},{"score":{"name":"TEMP","objective":"swr"},"color":"white"}]
tellraw @s [{"text":"Si sale 0 y tienes colonia, el id de entidad no es minecolonies:citizen:","color":"dark_gray"}]
tellraw @s [{"text":"prueba /execute if entity @e[type=minecolonies:citizen] y mira el error.","color":"dark_gray"}]
