# Ginro, el guardia vago. Aspecto fijo: aldeano de desierto, pescador (siempre encuentra
# la excusa de estar en el rio), nivel 1, con un bacalao en la mano.
data merge entity @s {CustomName:'{"text":"Ginro","color":"yellow"}',VillagerData:{type:"minecraft:desert",profession:"minecraft:fisherman",level:1}}
tag @s add swr_canon
tag @s add swr_es_ginro
tag @s add swr_oficio_3
item replace entity @s weapon.mainhand with minecraft:cod
