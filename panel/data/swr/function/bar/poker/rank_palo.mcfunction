# De la carta (1..52) saca su rango (1..13) y su palo (1..4) con aritmetica de marcador.
# Uso: interno, desde poker/robar_a y poker/robar_b
scoreboard players operation RANGO swr = CARTA swr
scoreboard players remove RANGO swr 1
scoreboard players operation RANGO swr %= TRECE swr
scoreboard players add RANGO swr 1
scoreboard players operation PALO swr = CARTA swr
scoreboard players remove PALO swr 1
scoreboard players operation PALO swr -= RANGO swr
scoreboard players add PALO swr 1
scoreboard players operation PALO swr /= TRECE swr
scoreboard players add PALO swr 1
