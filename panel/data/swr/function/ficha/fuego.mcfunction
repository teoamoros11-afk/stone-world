# Ficha Fuego por friccion (era 1): se anota al llevar minecraft:flint_and_steel en el inventario.
execute if score f_fuego swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "Fuego por friccion", "color": "aqua", "bold": true}, {"text": " -- W = F*d ; 1 J = 0,24 cal. Frotar convierte trabajo en calor y la yesca prende hacia 250 C.", "color": "white"}]
execute if score f_fuego swr matches 0 run scoreboard players set f_fuego swr 1
function swr:libro/contar
