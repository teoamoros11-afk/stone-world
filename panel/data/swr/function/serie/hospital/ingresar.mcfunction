# A21 - Ingreso: el jugador queda herido (nausea y debilidad) y con la marca de paciente.
# Uso: /function swr:serie/hospital/ingresar
tag @s add swr_herido
effect give @s minecraft:nausea 120 0 true
effect give @s minecraft:weakness 120 1 true
title @s title [{"text":"INGRESADO","color":"red","bold":true}]
tellraw @s [{"text":"[Hospital] ","color":"gold","bold":true},{"text":"Te tumbas en la cama. La sulfamida corta la infeccion: /function swr:serie/hospital/curar","color":"gray"}]
