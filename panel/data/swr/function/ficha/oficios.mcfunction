# Ficha Los oficios y sus puestos (era 2): se anota al llevar minecraft:stonecutter en el inventario.
execute if score f_oficios swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "Los oficios y sus puestos", "color": "aqua", "bold": true}, {"text": " -- Cantero (cortapiedras): ladrillos; granjero (compostador): pan; pastor (telar): lana; pescador (barril): bacalao; flechero (mesa de flechas): flechas; bibliotecario (atril): libros. Cada minuto de trabajo el puesto deja su parte en el cofre de al lado.", "color": "white"}]
execute if score f_oficios swr matches 0 run scoreboard players set f_oficios swr 1
function swr:libro/contar
