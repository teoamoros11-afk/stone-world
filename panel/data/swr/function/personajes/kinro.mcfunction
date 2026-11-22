# Kinro, el guardia serio. Aspecto fijo: aldeano de pantano, armero (forja el armamento),
# nivel 4, con una espada de hierro en la mano. No tiene puesto: su puesto es la puerta.
data merge entity @s {CustomName:'{"text":"Kinro","color":"blue"}',VillagerData:{type:"minecraft:swamp",profession:"minecraft:weaponsmith",level:4}}
tag @s add swr_canon
item replace entity @s weapon.mainhand with minecraft:iron_sword
