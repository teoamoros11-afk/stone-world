# Suika, la nina del casco de sandia. Aspecto fijo: aldeana de jungla, sin oficio (es una
# nina), nivel 1, y su trozo de sandia en la mano. Sin tag de oficio: no va a ningun puesto.
data merge entity @s {CustomName:'{"text":"Suika","color":"green"}',VillagerData:{type:"minecraft:jungle",profession:"minecraft:none",level:1}}
tag @s add swr_canon
tag @s add swr_es_suika
item replace entity @s weapon.mainhand with minecraft:melon_slice
