# A13 - Recarga: un lingote de cobre por cinco rayas, como el cableado de la serie.
# Uso: /function swr:serie/telefono/recargar
execute unless items entity @s container.* minecraft:copper_ingot run return run tellraw @s [{"text":"[Telefono] ","color":"aqua","bold":true},{"text":"Hace falta un lingote de cobre.","color":"red"}]
clear @s minecraft:copper_ingot 1
scoreboard players set TELEFONO_BATERIA serie 5
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 0.6 1.5
tellraw @s [{"text":"[Telefono] ","color":"aqua","bold":true},{"text":"Bateria llena: cinco llamadas.","color":"gray"}]
