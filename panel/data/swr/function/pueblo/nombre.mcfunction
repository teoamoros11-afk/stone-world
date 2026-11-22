# Pone nombre a la estatua recien colocada. El indice sale de ESTATUAS mod 12, asi que
# cada estatua nueva de una tanda recibe un nombre distinto (aldea de Ishigami).
# El nombre no lleva adornos: al revivir sigue siendo el mismo y no hay que reescribirlo.
scoreboard players operation SUERTE swr = ESTATUAS swr
scoreboard players operation SUERTE swr %= DOCE swr
execute if score SUERTE swr matches 0 run data merge entity @s {CustomName:'{"text":"Kohaku"}'}
execute if score SUERTE swr matches 1 run data merge entity @s {CustomName:'{"text":"Chrome"}'}
execute if score SUERTE swr matches 2 run data merge entity @s {CustomName:'{"text":"Ruri"}'}
execute if score SUERTE swr matches 3 run data merge entity @s {CustomName:'{"text":"Kaseki"}'}
execute if score SUERTE swr matches 4 run data merge entity @s {CustomName:'{"text":"Suika"}'}
execute if score SUERTE swr matches 5 run data merge entity @s {CustomName:'{"text":"Ginro"}'}
execute if score SUERTE swr matches 6 run data merge entity @s {CustomName:'{"text":"Kinro"}'}
execute if score SUERTE swr matches 7 run data merge entity @s {CustomName:'{"text":"Magma"}'}
execute if score SUERTE swr matches 8 run data merge entity @s {CustomName:'{"text":"Kokuyo"}'}
execute if score SUERTE swr matches 9 run data merge entity @s {CustomName:'{"text":"Jasper"}'}
execute if score SUERTE swr matches 10 run data merge entity @s {CustomName:'{"text":"Turquoise"}'}
execute if score SUERTE swr matches 11 run data merge entity @s {CustomName:'{"text":"Sapphire"}'}
