# Manana y tarde: al tajo. Cada vecino va a su puesto de oficio, con su herramienta
# en la mano, y el pueblo suena a trabajo.
execute unless entity @e[tag=swr_plaza,limit=1] run return 0
execute if score TURNO swr matches 2 run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Manana: cada vecino a su puesto, a ganarse el pan.","color":"yellow"}]
execute if score TURNO swr matches 4 run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Tarde: se acabo la siesta, de vuelta al puesto.","color":"yellow"}]
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] run data merge entity @s {NoAI:0b}
# cada oficio a su puesto (si los puestos no existen, estos comandos no hacen nada)
execute at @e[tag=swr_puesto_0,limit=1] run spreadplayers ~ ~ 1 2 false @e[tag=swr_vecino,tag=swr_oficio_0,tag=swr_casa_hecha]
execute at @e[tag=swr_puesto_1,limit=1] run spreadplayers ~ ~ 1 2 false @e[tag=swr_vecino,tag=swr_oficio_1,tag=swr_casa_hecha]
execute at @e[tag=swr_puesto_2,limit=1] run spreadplayers ~ ~ 1 2 false @e[tag=swr_vecino,tag=swr_oficio_2,tag=swr_casa_hecha]
execute at @e[tag=swr_puesto_3,limit=1] run spreadplayers ~ ~ 1 2 false @e[tag=swr_vecino,tag=swr_oficio_3,tag=swr_casa_hecha]
execute at @e[tag=swr_puesto_4,limit=1] run spreadplayers ~ ~ 1 2 false @e[tag=swr_vecino,tag=swr_oficio_4,tag=swr_casa_hecha]
execute at @e[tag=swr_puesto_5,limit=1] run spreadplayers ~ ~ 1 2 false @e[tag=swr_vecino,tag=swr_oficio_5,tag=swr_casa_hecha]
# la herramienta de cada oficio, en la mano
execute as @e[tag=swr_vecino,tag=swr_oficio_0,tag=swr_casa_hecha] run item replace entity @s weapon.mainhand with minecraft:bricks 4
execute as @e[tag=swr_vecino,tag=swr_oficio_1,tag=swr_casa_hecha] run item replace entity @s weapon.mainhand with minecraft:wheat 4
execute as @e[tag=swr_vecino,tag=swr_oficio_2,tag=swr_casa_hecha] run item replace entity @s weapon.mainhand with minecraft:white_wool 4
execute as @e[tag=swr_vecino,tag=swr_oficio_3,tag=swr_casa_hecha] run item replace entity @s weapon.mainhand with minecraft:cod 4
execute as @e[tag=swr_vecino,tag=swr_oficio_4,tag=swr_casa_hecha] run item replace entity @s weapon.mainhand with minecraft:arrow 4
execute as @e[tag=swr_vecino,tag=swr_oficio_5,tag=swr_casa_hecha] run item replace entity @s weapon.mainhand with minecraft:book 4
# el sonido propio de cada oficio, en su puesto
execute if entity @e[tag=swr_vecino,tag=swr_oficio_0,tag=swr_casa_hecha] at @e[tag=swr_puesto_0,limit=1] run playsound minecraft:entity.villager.work_mason master @a ~ ~ ~ 1 1
execute if entity @e[tag=swr_vecino,tag=swr_oficio_1,tag=swr_casa_hecha] at @e[tag=swr_puesto_1,limit=1] run playsound minecraft:entity.villager.work_farmer master @a ~ ~ ~ 1 1
execute if entity @e[tag=swr_vecino,tag=swr_oficio_2,tag=swr_casa_hecha] at @e[tag=swr_puesto_2,limit=1] run playsound minecraft:entity.villager.work_shepherd master @a ~ ~ ~ 1 1
execute if entity @e[tag=swr_vecino,tag=swr_oficio_3,tag=swr_casa_hecha] at @e[tag=swr_puesto_3,limit=1] run playsound minecraft:entity.villager.work_fisherman master @a ~ ~ ~ 1 1
execute if entity @e[tag=swr_vecino,tag=swr_oficio_4,tag=swr_casa_hecha] at @e[tag=swr_puesto_4,limit=1] run playsound minecraft:entity.villager.work_fletcher master @a ~ ~ ~ 1 1
execute if entity @e[tag=swr_vecino,tag=swr_oficio_5,tag=swr_casa_hecha] at @e[tag=swr_puesto_5,limit=1] run playsound minecraft:entity.villager.work_librarian master @a ~ ~ ~ 1 1
# polvo de trabajo en cada puesto
execute at @e[tag=swr_puesto_0,limit=1] run particle minecraft:crit ~ ~0.5 ~ 0.4 0.3 0.4 0.05 10 normal
execute at @e[tag=swr_puesto_1,limit=1] run particle minecraft:happy_villager ~ ~0.5 ~ 0.4 0.3 0.4 0.05 10 normal
execute at @e[tag=swr_puesto_2,limit=1] run particle minecraft:crit ~ ~0.5 ~ 0.4 0.3 0.4 0.05 10 normal
execute at @e[tag=swr_puesto_3,limit=1] run particle minecraft:cloud ~ ~0.5 ~ 0.4 0.3 0.4 0.05 10 normal
execute at @e[tag=swr_puesto_4,limit=1] run particle minecraft:crit ~ ~0.5 ~ 0.4 0.3 0.4 0.05 10 normal
execute at @e[tag=swr_puesto_5,limit=1] run particle minecraft:enchant ~ ~0.5 ~ 0.4 0.3 0.4 0.05 10 normal
