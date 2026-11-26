# A3 - El yacimiento se repone: guano hasta dieciseis y el caldero lleno otra vez.
# Si el marcador desaparecio (mundo viejo), se apaga solo en vez de fallar cada minuto.
execute unless entity @e[tag=swr_cueva,limit=1] run scoreboard players set CUEVA_ACTIVA serie 0
execute unless entity @e[tag=swr_cueva,limit=1] run return 0
execute at @e[tag=swr_cueva,limit=1] run item replace block ~ ~ ~ container.0 with minecraft:bone_meal 16
execute at @e[tag=swr_cueva,limit=1] run setblock ~1 ~ ~ minecraft:water_cauldron[level=3]
schedule function swr:serie/cueva/ciclo 1200t replace
