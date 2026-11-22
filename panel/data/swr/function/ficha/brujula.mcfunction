# Ficha Brujula (era 4): se anota al llevar minecraft:compass en el inventario.
execute if score f_brujula swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "Brujula", "color": "aqua", "bold": true}, {"text": " -- Magnetita Fe3O4. La aguja se alinea con el campo terrestre, de 25 a 65 microteslas.", "color": "white"}]
execute if score f_brujula swr matches 0 run scoreboard players set f_brujula swr 1
function swr:libro/contar
