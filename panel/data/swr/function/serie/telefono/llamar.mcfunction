# A13 - Llamada: suena en el jugador mas cercano a menos de 48 bloques y gasta bateria.
# Uso: /function swr:serie/telefono/llamar
execute unless items entity @s weapon.mainhand minecraft:echo_shard unless items entity @s weapon.offhand minecraft:echo_shard run return run tellraw @s [{"text":"[Telefono] ","color":"aqua","bold":true},{"text":"Necesitas el telefono en la mano. /function swr:serie/telefono/dar","color":"red"}]
execute unless score TELEFONO_BATERIA serie matches 1.. run return run tellraw @s [{"text":"[Telefono] ","color":"aqua","bold":true},{"text":"Sin bateria: /function swr:serie/telefono/recargar","color":"red"}]
tag @s add swr_llamando
scoreboard players set LLAMADA_N serie 0
execute as @a[distance=..48,tag=!swr_llamando] run scoreboard players add LLAMADA_N serie 1
execute if score LLAMADA_N serie matches 0 run tag @s remove swr_llamando
execute if score LLAMADA_N serie matches 0 run return run tellraw @s [{"text":"[Telefono] ","color":"aqua","bold":true},{"text":"No hay nadie al alcance (48 bloques).","color":"red"}]
scoreboard players remove TELEFONO_BATERIA serie 1
execute as @a[distance=..48,tag=!swr_llamando,sort=nearest,limit=1] run function swr:serie/telefono/timbre
tellraw @s [{"text":"[Telefono] ","color":"aqua","bold":true},{"text":"Llamada conectada. Bateria restante: ","color":"gray"},{"score":{"name":"TELEFONO_BATERIA","objective":"serie"},"color":"white"}]
tag @s remove swr_llamando
