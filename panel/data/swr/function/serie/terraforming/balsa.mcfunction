# Escena 2/4: el Mar de los Sargazos. Restos del avion, pesca de sobra y aceite de pescado;
# con el azucar de coco fermentado sacan el alcohol para mas fluido.
# Uso: automatico (o /function swr:serie/terraforming/balsa)
execute unless score TERRAFORM swr matches 2 run return run tellraw @s [{"text":"[TERRAFORMING] ","color":"aqua","bold":true},{"text":"Antes toca el naufragio: /function swr:serie/terraforming/naufragio","color":"red"}]
scoreboard players set TERRAFORM swr 3
title @a times 10 50 20
title @a subtitle [{"text":"Mar de los Sargazos: la basura del mundo se junta aqui.","color":"gray"}]
title @a title [{"text":"LA BALSA","color":"aqua","bold":true}]
playsound minecraft:entity.fishing_bobber.splash master @a ~ ~ ~ 1 1
playsound minecraft:block.wood.place master @a ~ ~ ~ 1 0.8
particle minecraft:bubble ~ ~1 ~ 2 1 2 0.02 30 normal
particle minecraft:crit ~ ~1 ~ 2 1 2 0.02 20 normal
give @s minecraft:oak_boat
give @s minecraft:fishing_rod
tellraw @a [{"text":"[Escena 2] ","color":"aqua","bold":true},{"text":"Con los restos del avion montan una balsa. Pescan tanto que sacan comida, aceite de pescado y agua dulce, y fermentan azucar de coco para hacer mas fluido.","color":"gray"}]
tellraw @a [{"text":" Siguiente: ","color":"dark_gray"},{"text":"/function swr:serie/terraforming/nitrico","color":"white"}]
