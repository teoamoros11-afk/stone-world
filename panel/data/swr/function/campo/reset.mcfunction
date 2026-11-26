# Vacía el campo: quita los cultivos, borra los marcadores y deja el rendimiento a 3.
# Uso: /function swr:campo/reset
execute at @e[tag=swr_parcela_1,limit=1] run setblock ~ ~ ~ minecraft:air
execute at @e[tag=swr_parcela_2,limit=1] run setblock ~ ~ ~ minecraft:air
execute at @e[tag=swr_parcela_3,limit=1] run setblock ~ ~ ~ minecraft:air
execute at @e[tag=swr_parcela_4,limit=1] run setblock ~ ~ ~ minecraft:air
kill @e[tag=swr_parcela]
scoreboard players set P1 campo 0
scoreboard players set P2 campo 0
scoreboard players set P3 campo 0
scoreboard players set P4 campo 0
scoreboard players set R1 campo 3
scoreboard players set R2 campo 3
scoreboard players set R3 campo 3
scoreboard players set R4 campo 3
scoreboard players set COSECHAS campo 0
scoreboard players set ULTIMA_COSECHA campo 0
tellraw @a [{"text":"[Campo] ","color":"gold","bold":true},{"text":"Campo vacio y cuentas a cero.","color":"gray"}]
