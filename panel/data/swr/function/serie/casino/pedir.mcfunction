# A17 - Pide carta. Pasarse de 21 pierde la mano.
# Uso: /function swr:serie/casino/pedir
execute unless score CASINO_ACTIVO serie matches 1 run return run tellraw @s [{"text":"[Casino] ","color":"gold","bold":true},{"text":"No hay mano abierta. /function swr:serie/casino/blackjack","color":"red"}]
execute store result score CARTA_TMP serie run random value 1..11
scoreboard players operation MANO_JUGADOR serie += CARTA_TMP serie
tellraw @s [{"text":"[Casino] ","color":"gold","bold":true},{"text":"Carta: ","color":"gray"},{"score":{"name":"CARTA_TMP","objective":"serie"},"color":"white"},{"text":"  |  Total: ","color":"gray"},{"score":{"name":"MANO_JUGADOR","objective":"serie"},"color":"white"}]
execute if score MANO_JUGADOR serie matches 22.. run function swr:serie/casino/pasarse
