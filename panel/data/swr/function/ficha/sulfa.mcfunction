# Ficha Sulfamidas (era 2): se anota al llevar stonepharmacy:sulfamida en el inventario.
execute if score f_sulfa swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "Sulfamidas", "color": "aqua", "bold": true}, {"text": " -- Sulfanilamida C6H8N2O2S: el grupo -SO2NH2 corta la sintesis de acido folico de la bacteria y la deja sin multiplicarse.", "color": "white"}]
execute if score f_sulfa swr matches 0 run scoreboard players set f_sulfa swr 1
function swr:libro/contar
