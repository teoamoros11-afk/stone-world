# Kohaku, la cazadora de la aldea de Ishigami. Aspecto fijo: aldeana de llanura, flechera
# (es la que hace las puntas y las lanzas), nivel alto y su hacha de piedra en la mano.
# El tag swr_canon la protege del reparto de oficios: su oficio es suyo, no el que falte.
data merge entity @s {CustomName:'{"text":"Kohaku","color":"gold"}',VillagerData:{type:"minecraft:plains",profession:"minecraft:fletcher",level:4}}
tag @s add swr_canon
tag @s add swr_es_kohaku
tag @s add swr_oficio_4
item replace entity @s weapon.mainhand with minecraft:stone_axe
