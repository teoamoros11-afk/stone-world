# Kokuyo, el jefe de la aldea. Aspecto fijo: aldeano de taiga, cartografo (guarda los mapas,
# las cuentas y los linderos), nivel 4, con un mapa en la mano.
data merge entity @s {CustomName:'{"text":"Kokuyo","color":"white"}',VillagerData:{type:"minecraft:taiga",profession:"minecraft:cartographer",level:4}}
tag @s add swr_canon
item replace entity @s weapon.mainhand with minecraft:map
