# A8 - Pasa a la siguiente prueba si nadie ha llegado a tres.
execute unless score BOUT_ACTIVO serie matches 1 run return 0
scoreboard players add BOUT_RONDA serie 1
execute if score BOUT_RONDA serie matches 4.. run scoreboard players set BOUT_RONDA serie 3
function swr:serie/bout/prueba
