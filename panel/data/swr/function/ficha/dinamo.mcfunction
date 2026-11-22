# Ficha Dinamo de manivela (era 2): se anota al llevar stoneindustry:crank_dynamo en el inventario.
execute if score f_dinamo swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "Dinamo de manivela", "color": "aqua", "bold": true}, {"text": " -- Faraday: e = -N*dPhi/dt. Potencia P = V*I. Una manivela da para una bombilla, no para una aldea.", "color": "white"}]
execute if score f_dinamo swr matches 0 run scoreboard players set f_dinamo swr 1
function swr:libro/contar
