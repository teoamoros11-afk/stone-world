# Ficha La medusa (era 4): se anota al llevar minecraft:heart_of_the_sea en el inventario.
execute if score f_medusa swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "La medusa", "color": "aqua", "bold": true}, {"text": " -- No tiene formula: es la licencia fantastica del manga. Lo que si es real es el miedo como tecnologia.", "color": "white"}]
execute if score f_medusa swr matches 0 run scoreboard players set f_medusa swr 1
function swr:libro/contar
