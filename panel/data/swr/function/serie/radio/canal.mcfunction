# A12 - Cambia de canal. Tres frecuencias, como en la serie: general, puerto e isla.
# Uso: /function swr:serie/radio/canal
scoreboard players add RADIO_CANAL serie 1
execute if score RADIO_CANAL serie matches 4.. run scoreboard players set RADIO_CANAL serie 1
execute if score RADIO_CANAL serie matches 1 run tellraw @a [{"text":"[Radio] ","color":"aqua","bold":true},{"text":"Canal 1: general. La aldea entera.","color":"gray"}]
execute if score RADIO_CANAL serie matches 2 run tellraw @a [{"text":"[Radio] ","color":"aqua","bold":true},{"text":"Canal 2: puerto. Solo el Perseus y el muelle.","color":"gray"}]
execute if score RADIO_CANAL serie matches 3 run tellraw @a [{"text":"[Radio] ","color":"aqua","bold":true},{"text":"Canal 3: isla. La frecuencia de la medusa.","color":"gray"}]
