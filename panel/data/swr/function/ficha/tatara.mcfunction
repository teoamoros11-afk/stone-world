# Ficha Hierro por tatara (era 3): se anota al llevar minecraft:iron_ingot en el inventario.
execute if score f_tatara swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "Hierro por tatara", "color": "aqua", "bold": true}, {"text": " -- Fe2O3 + 3 CO -> 2 Fe + 3 CO2. El carbon no arde: reduce el oxido.", "color": "white"}]
execute if score f_tatara swr matches 0 run scoreboard players set f_tatara swr 1
function swr:libro/contar
