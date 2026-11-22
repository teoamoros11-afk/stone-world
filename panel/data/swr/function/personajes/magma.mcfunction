# Magma, el bruto. Aspecto fijo: aldeano de sabana, carnicero, nivel 2, con un hacha de
# piedra en la mano. Feo, fuerte y util: corta leña y despieza lo que cazan los demas.
data merge entity @s {CustomName:'{"text":"Magma","color":"red"}',VillagerData:{type:"minecraft:savanna",profession:"minecraft:butcher",level:2}}
tag @s add swr_canon
tag @s add swr_es_magma
item replace entity @s weapon.mainhand with minecraft:stone_axe
