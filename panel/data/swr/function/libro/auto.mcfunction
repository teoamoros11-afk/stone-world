# Mira el inventario de los dos jugadores y anota las fichas cuyo objeto ya tienen.
# Lo llama el reloj de load.mcfunction cada 100 ticks y se reprograma solo.
execute as @a if items entity @s container.* minecraft:flint_and_steel run function swr:ficha/fuego
execute as @a if items entity @s container.* minecraft:glass run function swr:ficha/vidrio
execute as @a if items entity @s container.* stoneindustry:crank_dynamo run function swr:ficha/dinamo
execute as @a if items entity @s container.* stonepharmacy:sulfamida run function swr:ficha/sulfa
execute as @a if items entity @s container.* minecraft:red_bed run function swr:ficha/casas
execute as @a if items entity @s container.* minecraft:bread run function swr:ficha/horario
execute as @a if items entity @s container.* minecraft:stonecutter run function swr:ficha/oficios
execute as @a if items entity @s container.* minecraft:iron_ingot run function swr:ficha/tatara
execute as @a if items entity @s container.* minecraft:compass run function swr:ficha/brujula
execute as @a if items entity @s container.* minecraft:heart_of_the_sea run function swr:ficha/medusa
execute as @a if items entity @s container.* minecraft:spyglass run function swr:ficha/optica
execute as @a if items entity @s container.* minecraft:firework_rocket run function swr:ficha/cohete
# reinicio del reloj: 5 segundos
schedule function swr:libro/auto 100t replace
