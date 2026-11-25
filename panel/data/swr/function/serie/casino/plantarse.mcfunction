# A17 - Se planta: compara con la banca y paga o cobra.
# Uso: /function swr:serie/casino/plantarse
execute unless score CASINO_ACTIVO serie matches 1 run return run tellraw @s [{"text":"[Casino] ","color":"gold","bold":true},{"text":"No hay mano abierta. /function swr:serie/casino/blackjack","color":"red"}]
tellraw @a [{"text":"[Casino] ","color":"gold","bold":true},{"text":"Banca: ","color":"gray"},{"score":{"name":"MANO_BANCA","objective":"serie"},"color":"white"},{"text":"   |   Jugador: ","color":"gray"},{"score":{"name":"MANO_JUGADOR","objective":"serie"},"color":"white"}]
execute if score MANO_JUGADOR serie > MANO_BANCA serie run scoreboard players add @s fichas 10
execute if score MANO_JUGADOR serie > MANO_BANCA serie run tellraw @s [{"text":"[Casino] ","color":"green","bold":true},{"text":"Ganas diez fichas.","color":"gray"}]
execute if score MANO_JUGADOR serie = MANO_BANCA serie run scoreboard players add @s fichas 5
execute if score MANO_JUGADOR serie = MANO_BANCA serie run tellraw @s [{"text":"[Casino] ","color":"gold","bold":true},{"text":"Empate: te devuelven la apuesta.","color":"gray"}]
execute if score MANO_JUGADOR serie < MANO_BANCA serie run tellraw @s [{"text":"[Casino] ","color":"red","bold":true},{"text":"Gana la banca.","color":"gray"}]
scoreboard players set CASINO_ACTIVO serie 0
