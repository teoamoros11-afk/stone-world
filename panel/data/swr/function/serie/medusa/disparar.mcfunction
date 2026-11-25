# El destello. Petrifica a todo lo vivo que pille a 12 bloques del marcador, incluido quien la activo.
execute at @e[tag=swr_medusa,limit=1] run particle minecraft:end_rod ~ ~1 ~ 6 4 6 0.1 200 normal
execute at @e[tag=swr_medusa,limit=1] run particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 6 4 6 0.1 150 normal
execute at @e[tag=swr_medusa,limit=1] as @e[distance=..12,type=!marker,type=!item,type=!experience_orb] run drstonekos petrify @s
execute at @e[tag=swr_medusa,limit=1] run playsound minecraft:block.beacon.deactivate master @a ~ ~ ~ 1 0.6
execute at @e[tag=swr_medusa,limit=1] run playsound minecraft:entity.lightning_bolt.thunder master @a ~ ~ ~ 0.6 1.2
tellraw @a [{"text":"[Medusa] ","color":"light_purple","bold":true},{"text":"El destello. Lo que estaba cerca ya no se mueve: el fluido milagroso lo devuelve.","color":"dark_purple"}]
kill @e[tag=swr_medusa]
scoreboard players set MEDUSA_T swr 0
schedule clear swr:serie/medusa/ciclo
