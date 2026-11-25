# A23 - Cuelga la foto en un marco delante de ti.
# Uso: /function swr:serie/fotos/montar
execute at @s run summon minecraft:item_frame ~ ~1 ~ {Item:{id:"minecraft:paper",count:1},Facing:2b}
playsound minecraft:entity.item_frame.add_item master @s ~ ~ ~ 0.6 1.2
tellraw @s [{"text":"[Fotos] ","color":"gold","bold":true},{"text":"Marco colocado. En la serie, las fotos son la prueba de que el mundo anterior existio.","color":"gray"}]
