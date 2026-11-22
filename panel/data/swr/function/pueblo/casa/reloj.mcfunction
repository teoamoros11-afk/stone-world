# Reloj de las casas: un tic por segundo para toda la tanda a la vez.
execute if score CASA_T swr matches ..0 run return fail
scoreboard players remove CASA_T swr 1
execute if score CASA_T swr matches 26 run function swr:pueblo/casa/cimientos
execute if score CASA_T swr matches 22 run function swr:pueblo/casa/muro0
execute if score CASA_T swr matches 19 run function swr:pueblo/casa/muro1
execute if score CASA_T swr matches 16 run function swr:pueblo/casa/muro2
execute if score CASA_T swr matches 13 run function swr:pueblo/casa/muro3
execute if score CASA_T swr matches 9 run function swr:pueblo/casa/techo
execute if score CASA_T swr matches 5 run function swr:pueblo/casa/puerta
execute if score CASA_T swr matches 2 run function swr:pueblo/casa/detalles
execute if score CASA_T swr matches 0 run function swr:pueblo/casa/fin
execute if score CASA_T swr matches 1.. run schedule function swr:pueblo/casa/reloj 20t replace
