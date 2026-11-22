# Reparte a los vecinos por los puestos de la obra (marcador swr_obra: pared en z=0,
# puestos en z=-3). Ocho puestos, de x=-4 a x=3; el resto mira desde atras.
tag @e[tag=swr_vecino] remove swr_colocado
execute at @e[tag=swr_obra,limit=1] run tp @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] ~-4 ~ ~-3
execute at @e[tag=swr_obra,limit=1] run tag @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] add swr_colocado
execute at @e[tag=swr_obra,limit=1] run tp @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] ~-3 ~ ~-3
execute at @e[tag=swr_obra,limit=1] run tag @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] add swr_colocado
execute at @e[tag=swr_obra,limit=1] run tp @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] ~-2 ~ ~-3
execute at @e[tag=swr_obra,limit=1] run tag @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] add swr_colocado
execute at @e[tag=swr_obra,limit=1] run tp @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] ~-1 ~ ~-3
execute at @e[tag=swr_obra,limit=1] run tag @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] add swr_colocado
execute at @e[tag=swr_obra,limit=1] run tp @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] ~0 ~ ~-3
execute at @e[tag=swr_obra,limit=1] run tag @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] add swr_colocado
execute at @e[tag=swr_obra,limit=1] run tp @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] ~1 ~ ~-3
execute at @e[tag=swr_obra,limit=1] run tag @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] add swr_colocado
execute at @e[tag=swr_obra,limit=1] run tp @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] ~2 ~ ~-3
execute at @e[tag=swr_obra,limit=1] run tag @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] add swr_colocado
execute at @e[tag=swr_obra,limit=1] run tp @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] ~3 ~ ~-3
execute at @e[tag=swr_obra,limit=1] run tag @e[tag=swr_vecino,tag=!swr_colocado,sort=nearest,limit=1] add swr_colocado
# los que sobran miran desde detras de la casa, sin estorbar
execute at @e[tag=swr_obra,limit=1] run tp @e[tag=swr_vecino,tag=!swr_colocado] ~ ~ ~4
# los puestos quedan mirando la pared (sur) y quietos hasta que acabe la obra
execute as @e[tag=swr_colocado] run data merge entity @s {NoAI:1b,PersistenceRequired:1b,Rotation:[0f,0f]}
execute as @e[tag=swr_colocado] run item replace entity @s weapon.mainhand with minecraft:cobblestone 8
