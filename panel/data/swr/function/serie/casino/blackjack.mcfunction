# A17 - Blackjack contra la banca. Cinco fichas, dos cartas y a pedir o plantarse.
# Uso: /function swr:serie/casino/blackjack
execute unless score @s fichas matches 5.. run return run tellraw @s [{"text":"[Casino] ","color":"gold","bold":true},{"text":"Hacen falta cinco fichas. /function swr:bar/poker/comprar","color":"red"}]
execute if score CASINO_ACTIVO serie matches 1 run return run tellraw @s [{"text":"[Casino] ","color":"gold","bold":true},{"text":"Hay una mano abierta: /function swr:serie/casino/plantarse","color":"red"}]
scoreboard players remove @s fichas 5
scoreboard players set CASINO_ACTIVO serie 1
execute store result score MANO_JUGADOR serie run random value 2..21
execute store result score MANO_BANCA serie run random value 15..21
tellraw @s [{"text":"[Casino] ","color":"gold","bold":true},{"text":"Tu mano: ","color":"gray"},{"score":{"name":"MANO_JUGADOR","objective":"serie"},"color":"white"},{"text":"   |   La banca muestra un 10.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Pedir","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/casino/pedir"},"hoverEvent":{"action":"show_text","value":"Otra carta"}},{"text":"   • ","color":"gray"},{"text":"Plantarse","color":"gold","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/casino/plantarse"},"hoverEvent":{"action":"show_text","value":"Compara con la banca"}}]
