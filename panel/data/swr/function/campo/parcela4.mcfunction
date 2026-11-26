# Parcela 4: mira que hay plantado, y si esta maduro lo cosecha con el rendimiento que
# toque. La rotacion la lleva P4 (ultimo cultivo) y R4 (rendimiento 1..3).
# Uso: interno, desde swr:campo/revisar
scoreboard players set CULTIVO campo 0
execute at @e[tag=swr_parcela_4,limit=1] if block ~ ~ ~ minecraft:wheat run scoreboard players set CULTIVO campo 1
execute at @e[tag=swr_parcela_4,limit=1] if block ~ ~ ~ minecraft:potatoes run scoreboard players set CULTIVO campo 2
execute at @e[tag=swr_parcela_4,limit=1] if block ~ ~ ~ minecraft:carrots run scoreboard players set CULTIVO campo 3
execute at @e[tag=swr_parcela_4,limit=1] if block ~ ~ ~ minecraft:beetroots run scoreboard players set CULTIVO campo 4
execute if score CULTIVO campo matches 0 run return 0
scoreboard players set MADURO campo 0
execute at @e[tag=swr_parcela_4,limit=1] if block ~ ~ ~ minecraft:wheat[age=7] run scoreboard players set MADURO campo 1
execute at @e[tag=swr_parcela_4,limit=1] if block ~ ~ ~ minecraft:potatoes[age=7] run scoreboard players set MADURO campo 1
execute at @e[tag=swr_parcela_4,limit=1] if block ~ ~ ~ minecraft:carrots[age=7] run scoreboard players set MADURO campo 1
execute at @e[tag=swr_parcela_4,limit=1] if block ~ ~ ~ minecraft:beetroots[age=3] run scoreboard players set MADURO campo 1
execute if score MADURO campo matches 0 run return 0
scoreboard players operation REND campo = R4 campo
execute at @e[tag=swr_parcela_4,limit=1] run setblock ~ ~ ~ minecraft:air
execute if score CULTIVO campo matches 1 run execute as @a run give @s minecraft:wheat 1
execute if score CULTIVO campo matches 1 run execute if score REND campo matches 2.. as @a run give @s minecraft:wheat 1
execute if score CULTIVO campo matches 1 run execute if score REND campo matches 3 as @a run give @s minecraft:wheat 1
execute if score CULTIVO campo matches 2 run execute as @a run give @s minecraft:potato 1
execute if score CULTIVO campo matches 2 run execute if score REND campo matches 2.. as @a run give @s minecraft:potato 1
execute if score CULTIVO campo matches 2 run execute if score REND campo matches 3 as @a run give @s minecraft:potato 1
execute if score CULTIVO campo matches 3 run execute as @a run give @s minecraft:carrot 1
execute if score CULTIVO campo matches 3 run execute if score REND campo matches 2.. as @a run give @s minecraft:carrot 1
execute if score CULTIVO campo matches 3 run execute if score REND campo matches 3 as @a run give @s minecraft:carrot 1
execute if score CULTIVO campo matches 4 run execute as @a run give @s minecraft:beetroot 1
execute if score CULTIVO campo matches 4 run execute if score REND campo matches 2.. as @a run give @s minecraft:beetroot 1
execute if score CULTIVO campo matches 4 run execute if score REND campo matches 3 as @a run give @s minecraft:beetroot 1
scoreboard players operation ULTIMA_COSECHA campo = REND campo
scoreboard players add COSECHAS campo 1
# rotacion: repetir cultivo resta uno (minimo 1); cambiar de cultivo suma uno (maximo 3)
execute if score CULTIVO campo = P4 campo run scoreboard players remove R4 campo 1
execute if score CULTIVO campo = P4 campo unless score R4 campo matches 1.. run scoreboard players set R4 campo 1
execute unless score CULTIVO campo = P4 campo run scoreboard players add R4 campo 1
execute unless score CULTIVO campo = P4 campo unless score R4 campo matches ..3 run scoreboard players set R4 campo 3
scoreboard players operation P4 campo = CULTIVO campo
