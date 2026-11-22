# Ficha Cohete (era 5): se anota al llevar minecraft:firework_rocket en el inventario.
execute if score f_cohete swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "Cohete", "color": "aqua", "bold": true}, {"text": " -- Tsiolkovski: dv = ve*ln(m0/m1). Para orbita baja hacen falta unos 9,4 km/s.", "color": "white"}]
execute if score f_cohete swr matches 0 run scoreboard players set f_cohete swr 1
function swr:libro/contar
