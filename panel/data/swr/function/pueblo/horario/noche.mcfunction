# Noche: cada vecino se recoge en su casa y se queda dentro hasta el amanecer.
execute unless entity @e[tag=swr_plaza,limit=1] run return 0
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Noche: cada vecino se recoge en su casa.","color":"yellow"}]
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] run item replace entity @s weapon.mainhand with minecraft:air
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] run data merge entity @s {NoAI:1b}
execute as @e[tag=swr_casa_lista,tag=swr_solar_1] at @s run tp @e[tag=swr_vecino,tag=swr_solar_1] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_2] at @s run tp @e[tag=swr_vecino,tag=swr_solar_2] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_3] at @s run tp @e[tag=swr_vecino,tag=swr_solar_3] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_4] at @s run tp @e[tag=swr_vecino,tag=swr_solar_4] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_5] at @s run tp @e[tag=swr_vecino,tag=swr_solar_5] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_6] at @s run tp @e[tag=swr_vecino,tag=swr_solar_6] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_7] at @s run tp @e[tag=swr_vecino,tag=swr_solar_7] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_8] at @s run tp @e[tag=swr_vecino,tag=swr_solar_8] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_9] at @s run tp @e[tag=swr_vecino,tag=swr_solar_9] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_10] at @s run tp @e[tag=swr_vecino,tag=swr_solar_10] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_11] at @s run tp @e[tag=swr_vecino,tag=swr_solar_11] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_12] at @s run tp @e[tag=swr_vecino,tag=swr_solar_12] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_13] at @s run tp @e[tag=swr_vecino,tag=swr_solar_13] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_14] at @s run tp @e[tag=swr_vecino,tag=swr_solar_14] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_15] at @s run tp @e[tag=swr_vecino,tag=swr_solar_15] ~ ~ ~
execute as @e[tag=swr_casa_lista,tag=swr_solar_16] at @s run tp @e[tag=swr_vecino,tag=swr_solar_16] ~ ~ ~
execute as @e[tag=swr_vecino,tag=swr_casa_hecha] at @s run particle minecraft:cloud ~ ~ ~ 0.3 0.2 0.3 0.01 5 normal
