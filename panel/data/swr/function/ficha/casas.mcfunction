# Ficha Cada vecino, su casa (era 2): se anota al llevar minecraft:red_bed en el inventario.
execute if score f_casas swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "Cada vecino, su casa", "color": "aqua", "bold": true}, {"text": " -- Suelo de piedra, tres capas de muro, techo con vuelo, cama, cofre y puerta mirando a la plaza; 30 s por casa, una tanda a la vez y cola de espera.", "color": "white"}]
execute if score f_casas swr matches 0 run scoreboard players set f_casas swr 1
function swr:libro/contar
