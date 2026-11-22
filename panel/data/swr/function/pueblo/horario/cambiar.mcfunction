# Cambio de turno: guarda cual es y reparte el trabajo de ese tramo del dia.
scoreboard players operation HORA_TURNO swr = TURNO swr
execute if score TURNO swr matches 1 run function swr:pueblo/horario/despertar
execute if score TURNO swr matches 2 run function swr:pueblo/horario/trabajo
execute if score TURNO swr matches 3 run function swr:pueblo/horario/comida
execute if score TURNO swr matches 4 run function swr:pueblo/horario/trabajo
execute if score TURNO swr matches 5 run function swr:pueblo/horario/reunion
execute if score TURNO swr matches 6 run function swr:pueblo/horario/noche
