# Ficha Vidrio (era 2): se anota al llevar minecraft:glass en el inventario.
execute if score f_vidrio swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "Vidrio", "color": "aqua", "bold": true}, {"text": " -- SiO2 + Na2CO3 + CaCO3 -> silicato fundido + CO2. El Na2O baja el punto de fusion.", "color": "white"}]
execute if score f_vidrio swr matches 0 run scoreboard players set f_vidrio swr 1
function swr:libro/contar
