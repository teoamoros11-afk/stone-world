# Ficha Telescopio de fluorita (era 5): se anota al llevar minecraft:spyglass en el inventario.
execute if score f_optica swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "Telescopio de fluorita", "color": "aqua", "bold": true}, {"text": " -- Refraccion: n1*sen(t1) = n2*sen(t2). Aumento = f_objetivo / f_ocular.", "color": "white"}]
execute if score f_optica swr matches 0 run scoreboard players set f_optica swr 1
function swr:libro/contar
