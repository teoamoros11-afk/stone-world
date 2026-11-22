# Ficha El dia del pueblo (era 2): se anota al llevar minecraft:bread en el inventario.
execute if score f_horario swr matches 0 run tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Ficha nueva: ", "color": "green"}, {"text": "El dia del pueblo", "color": "aqua", "bold": true}, {"text": " -- Amanecer en la plaza, manana y tarde de trabajo en el puesto de su oficio (cortapiedras, compostador, telar, barril, mesa de flechas o atril, cada uno con su mesa y su sonido), comida a mediodia, reunion al atardecer y noche en casa. /function swr:pueblo/horario/iniciar", "color": "white"}]
execute if score f_horario swr matches 0 run scoreboard players set f_horario swr 1
function swr:libro/contar
