# Se ejecuta COMO el vecino: se le quita el oficio viejo y se le pone el que falta (MINID),
# con su profesion de verdad y su etiqueta para el puesto.
tag @s remove swr_oficio_0
tag @s remove swr_oficio_1
tag @s remove swr_oficio_2
tag @s remove swr_oficio_3
tag @s remove swr_oficio_4
tag @s remove swr_oficio_5
execute if score MINID swr matches 0 run tag @s add swr_oficio_0
execute if score MINID swr matches 0 run data merge entity @s {VillagerData:{profession:"minecraft:mason",level:2}}
execute if score MINID swr matches 1 run tag @s add swr_oficio_1
execute if score MINID swr matches 1 run data merge entity @s {VillagerData:{profession:"minecraft:farmer",level:2}}
execute if score MINID swr matches 2 run tag @s add swr_oficio_2
execute if score MINID swr matches 2 run data merge entity @s {VillagerData:{profession:"minecraft:shepherd",level:2}}
execute if score MINID swr matches 3 run tag @s add swr_oficio_3
execute if score MINID swr matches 3 run data merge entity @s {VillagerData:{profession:"minecraft:fisherman",level:2}}
execute if score MINID swr matches 4 run tag @s add swr_oficio_4
execute if score MINID swr matches 4 run data merge entity @s {VillagerData:{profession:"minecraft:fletcher",level:2}}
execute if score MINID swr matches 5 run tag @s add swr_oficio_5
execute if score MINID swr matches 5 run data merge entity @s {VillagerData:{profession:"minecraft:librarian",level:2}}
scoreboard players operation OFICIO swr = MINID swr
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"selector":"@s"},{"text":" coge el oficio que faltaba en el pueblo.","color":"yellow"}]
scoreboard players set MOVIDO swr 1
