# A16 - Cada minuto, si hay alguien delante, la camara avisa.
execute unless entity @e[tag=swr_camara,limit=1] run scoreboard players set CAMARA_ACTIVA serie 0
execute unless entity @e[tag=swr_camara,limit=1] run return 0
execute at @e[tag=swr_camara,limit=1] if entity @a[distance=..8] run function swr:serie/camara/vigilar
execute at @e[tag=swr_camara,limit=1] if entity @a[distance=..8] run playsound minecraft:block.note_block.pling master @a ~ ~ ~ 0.6 1.8
schedule function swr:serie/camara/ciclo 1200t replace
