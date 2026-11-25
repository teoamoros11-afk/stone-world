# A31 - Apaga la onda antes de que llegue el destello.
# Uso: /function swr:serie/onda/parar
execute unless entity @e[tag=swr_onda,limit=1] run return run tellraw @s [{"text":"[Onda] ","color":"dark_purple","bold":true},{"text":"No hay ninguna onda activa.","color":"red"}]
kill @e[tag=swr_onda]
scoreboard players set ONDA_T serie 0
scoreboard players set ONDA_ACTIVA serie 0
schedule clear swr:serie/onda/ciclo
tellraw @a [{"text":"[Onda] ","color":"dark_purple","bold":true},{"text":"Onda apagada antes de tiempo.","color":"gray"}]
