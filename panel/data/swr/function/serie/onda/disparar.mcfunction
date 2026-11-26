# A31 - El destello: petrifica todo lo que este a 40 bloques del origen marcado.
execute at @e[tag=swr_onda,limit=1] run particle minecraft:end_rod ~ ~1 ~ 20 3 20 0.2 400 normal
execute at @e[tag=swr_onda,limit=1] run particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 20 3 20 0.2 300 normal
execute at @e[tag=swr_onda,limit=1] as @e[distance=..40,type=!marker,type=!item,type=!experience_orb] run drstonekos petrify @s
execute at @e[tag=swr_onda,limit=1] run playsound minecraft:entity.lightning_bolt.thunder master @a ~ ~ ~ 0.8 0.8
tellraw @a [{"text":"[Onda] ","color":"dark_purple","bold":true},{"text":"El destello. Cuarenta bloques a la redonda, todo quieto. El fluido milagroso lo devuelve.","color":"dark_purple"}]
kill @e[tag=swr_onda]
scoreboard players set ONDA_T serie 0
scoreboard players set ONDA_ACTIVA serie 0
schedule clear swr:serie/onda/ciclo
