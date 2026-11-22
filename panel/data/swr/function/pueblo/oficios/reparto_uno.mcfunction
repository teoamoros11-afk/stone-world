# Un paso del reparto: cuenta los oficios y, si alguno pasa en dos al mas vacio,
# pasa a uno de sus vecinos al que falta (MINID). Se repite hasta tres veces por dia.
function swr:pueblo/oficios/contar
scoreboard players set MOVIDO swr 0
scoreboard players operation LIMITE swr = MIN swr
scoreboard players add LIMITE swr 1
execute if score C0 swr > LIMITE swr if score MOVIDO swr matches 0 run execute as @e[tag=swr_vecino,tag=swr_oficio_0,tag=!swr_canon,limit=1] run function swr:pueblo/oficios/vestir
execute if score C1 swr > LIMITE swr if score MOVIDO swr matches 0 run execute as @e[tag=swr_vecino,tag=swr_oficio_1,tag=!swr_canon,limit=1] run function swr:pueblo/oficios/vestir
execute if score C2 swr > LIMITE swr if score MOVIDO swr matches 0 run execute as @e[tag=swr_vecino,tag=swr_oficio_2,tag=!swr_canon,limit=1] run function swr:pueblo/oficios/vestir
execute if score C3 swr > LIMITE swr if score MOVIDO swr matches 0 run execute as @e[tag=swr_vecino,tag=swr_oficio_3,tag=!swr_canon,limit=1] run function swr:pueblo/oficios/vestir
execute if score C4 swr > LIMITE swr if score MOVIDO swr matches 0 run execute as @e[tag=swr_vecino,tag=swr_oficio_4,tag=!swr_canon,limit=1] run function swr:pueblo/oficios/vestir
execute if score C5 swr > LIMITE swr if score MOVIDO swr matches 0 run execute as @e[tag=swr_vecino,tag=swr_oficio_5,tag=!swr_canon,limit=1] run function swr:pueblo/oficios/vestir
execute if score MOVIDO swr matches 1 run scoreboard players add MOVED swr 1
execute if score MOVIDO swr matches 1 if score MOVED swr matches ..2 run function swr:pueblo/oficios/reparto_uno
