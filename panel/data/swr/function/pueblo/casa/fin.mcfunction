# Fin de la tanda de casas.
execute as @e[tag=swr_casa] run function swr:pueblo/casa/fin_uno
scoreboard players set CASA_T swr 0
# los vecinos que esperaban turno empiezan otra tanda
execute as @e[tag=swr_vecino,tag=!swr_dueno] run function swr:pueblo/casa/empezar
