# Reparto del amanecer: los oficios se igualan segun lo que falte en el pueblo.
# Se encadenan hasta tres cambios por dia (reparto_uno se llama a si mismo mientras queden
# oficios cargados), para que el pueblo no se reorganice entero de golpe.
# Uso: automatico desde swr:pueblo/horario/despertar
execute unless entity @e[tag=swr_plaza,limit=1] run return 0
scoreboard players set MOVED swr 0
function swr:pueblo/oficios/reparto_uno
