# Reintenta la carta del jugador si ya habia salido (hasta 40 intentos).
scoreboard players add INTENTOS swr 1
execute store result score CARTA swr run random value 1..52
execute if score CARTA cs matches 1.. if score INTENTOS swr matches ..40 run function swr:bar/poker/repetir_a
