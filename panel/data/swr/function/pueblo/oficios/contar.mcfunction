# Cuenta los vecinos de cada oficio y se queda con el que menos gente tiene (MINID).
# Lo usan swr:pueblo/oficios/asignar y swr:pueblo/oficios/reparto.
scoreboard players set C0 swr 0
scoreboard players set C1 swr 0
scoreboard players set C2 swr 0
scoreboard players set C3 swr 0
scoreboard players set C4 swr 0
scoreboard players set C5 swr 0
execute as @e[tag=swr_vecino,tag=swr_oficio_0] run scoreboard players add C0 swr 1
execute as @e[tag=swr_vecino,tag=swr_oficio_1] run scoreboard players add C1 swr 1
execute as @e[tag=swr_vecino,tag=swr_oficio_2] run scoreboard players add C2 swr 1
execute as @e[tag=swr_vecino,tag=swr_oficio_3] run scoreboard players add C3 swr 1
execute as @e[tag=swr_vecino,tag=swr_oficio_4] run scoreboard players add C4 swr 1
execute as @e[tag=swr_vecino,tag=swr_oficio_5] run scoreboard players add C5 swr 1
scoreboard players operation MIN swr = C0 swr
scoreboard players set MINID swr 0
execute if score C1 swr < MIN swr run scoreboard players set MINID swr 1
execute if score C1 swr < MIN swr run scoreboard players operation MIN swr = C1 swr
execute if score C2 swr < MIN swr run scoreboard players set MINID swr 2
execute if score C2 swr < MIN swr run scoreboard players operation MIN swr = C2 swr
execute if score C3 swr < MIN swr run scoreboard players set MINID swr 3
execute if score C3 swr < MIN swr run scoreboard players operation MIN swr = C3 swr
execute if score C4 swr < MIN swr run scoreboard players set MINID swr 4
execute if score C4 swr < MIN swr run scoreboard players operation MIN swr = C4 swr
execute if score C5 swr < MIN swr run scoreboard players set MINID swr 5
execute if score C5 swr < MIN swr run scoreboard players operation MIN swr = C5 swr
