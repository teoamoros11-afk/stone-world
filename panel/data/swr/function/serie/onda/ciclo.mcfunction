# A31 - Cuenta atras de la onda, con el aire cargado de particulas.
execute unless entity @e[tag=swr_onda,limit=1] run scoreboard players set ONDA_ACTIVA serie 0
execute unless entity @e[tag=swr_onda,limit=1] run return 0
execute at @e[tag=swr_onda,limit=1] run particle minecraft:end_rod ~ ~1 ~ 12 2 12 0.1 80 normal
execute at @e[tag=swr_onda,limit=1] run particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 12 2 12 0.1 40 normal
scoreboard players remove ONDA_T serie 1
execute if score ONDA_T serie matches 1.. run title @a actionbar [{"text":"Onda: ","color":"dark_purple"},{"score":{"name":"ONDA_T","objective":"serie"},"color":"white"},{"text":" s","color":"dark_purple"}]
execute if score ONDA_T serie matches 1.. run schedule function swr:serie/onda/ciclo 20t replace
execute if score ONDA_T serie matches ..0 run function swr:serie/onda/disparar
