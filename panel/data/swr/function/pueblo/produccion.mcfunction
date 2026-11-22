# Cada puesto deposita lo que produce en el cofre de al lado, una vez por minuto de trabajo.
# Se ejecuta desde swr:pueblo/horario/reloj. El cofre se llena por la fila de arriba, rotando.
scoreboard players add PROD swr 1
scoreboard players operation PROD swr %= TRES swr
# 0 cantero -> ladrillos de piedra (cofre a +2)
execute at @e[tag=swr_puesto_0,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_0,distance=..6] if score PROD swr matches 0 run item replace block ~2 ~-1 ~ container.0 with minecraft:stone_bricks 3
execute at @e[tag=swr_puesto_0,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_0,distance=..6] if score PROD swr matches 1 run item replace block ~2 ~-1 ~ container.1 with minecraft:stone_bricks 3
execute at @e[tag=swr_puesto_0,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_0,distance=..6] if score PROD swr matches 2 run item replace block ~2 ~-1 ~ container.2 with minecraft:stone_bricks 3
# 1 granjero -> pan del compostador (cofre a +2)
execute at @e[tag=swr_puesto_1,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_1,distance=..6] if score PROD swr matches 0 run item replace block ~2 ~-1 ~ container.0 with minecraft:bread 2
execute at @e[tag=swr_puesto_1,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_1,distance=..6] if score PROD swr matches 1 run item replace block ~2 ~-1 ~ container.1 with minecraft:bread 2
execute at @e[tag=swr_puesto_1,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_1,distance=..6] if score PROD swr matches 2 run item replace block ~2 ~-1 ~ container.2 with minecraft:bread 2
# 2 pastor -> lana (cofre a -2)
execute at @e[tag=swr_puesto_2,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_2,distance=..6] if score PROD swr matches 0 run item replace block ~-2 ~-1 ~ container.0 with minecraft:white_wool 2
execute at @e[tag=swr_puesto_2,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_2,distance=..6] if score PROD swr matches 1 run item replace block ~-2 ~-1 ~ container.1 with minecraft:white_wool 2
execute at @e[tag=swr_puesto_2,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_2,distance=..6] if score PROD swr matches 2 run item replace block ~-2 ~-1 ~ container.2 with minecraft:white_wool 2
# 3 pescador -> bacalao (cofre a -2)
execute at @e[tag=swr_puesto_3,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_3,distance=..6] if score PROD swr matches 0 run item replace block ~-2 ~-1 ~ container.0 with minecraft:cod 2
execute at @e[tag=swr_puesto_3,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_3,distance=..6] if score PROD swr matches 1 run item replace block ~-2 ~-1 ~ container.1 with minecraft:cod 2
execute at @e[tag=swr_puesto_3,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_3,distance=..6] if score PROD swr matches 2 run item replace block ~-2 ~-1 ~ container.2 with minecraft:cod 2
# 4 flechero -> flechas (cofre a -2)
execute at @e[tag=swr_puesto_4,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_4,distance=..6] if score PROD swr matches 0 run item replace block ~-2 ~-1 ~ container.0 with minecraft:arrow 6
execute at @e[tag=swr_puesto_4,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_4,distance=..6] if score PROD swr matches 1 run item replace block ~-2 ~-1 ~ container.1 with minecraft:arrow 6
execute at @e[tag=swr_puesto_4,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_4,distance=..6] if score PROD swr matches 2 run item replace block ~-2 ~-1 ~ container.2 with minecraft:arrow 6
# 5 bibliotecario -> libros (cofre a +2)
execute at @e[tag=swr_puesto_5,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_5,distance=..6] if score PROD swr matches 0 run item replace block ~2 ~-1 ~ container.0 with minecraft:book 1
execute at @e[tag=swr_puesto_5,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_5,distance=..6] if score PROD swr matches 1 run item replace block ~2 ~-1 ~ container.1 with minecraft:book 1
execute at @e[tag=swr_puesto_5,limit=1] if entity @e[tag=swr_vecino,tag=swr_oficio_5,distance=..6] if score PROD swr matches 2 run item replace block ~2 ~-1 ~ container.2 with minecraft:book 1
