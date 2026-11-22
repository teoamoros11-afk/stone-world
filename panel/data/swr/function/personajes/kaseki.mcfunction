# Kaseki, el artesano viejo. Aspecto fijo: aldeano de sabana, cantero, nivel 5 (maestro),
# con su pico de hierro. Es el que levanta el pueblo, asi que su oficio no se toca nunca.
data merge entity @s {CustomName:'{"text":"Kaseki","color":"gray"}',VillagerData:{type:"minecraft:savanna",profession:"minecraft:mason",level:5}}
tag @s add swr_canon
tag @s add swr_oficio_0
item replace entity @s weapon.mainhand with minecraft:iron_pickaxe
