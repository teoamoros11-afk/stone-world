# Una carta al azar que no haya salido todavia, para el jugador: la dice y la anota.
# Uso: cinco veces desde poker/iniciar
scoreboard players set INTENTOS swr 0
execute store result score CARTA swr run random value 1..52
execute if score CARTA cs matches 1.. run function swr:bar/poker/repetir_a
execute if score CARTA cs matches 1.. run return 0
scoreboard players set CARTA cs 1
function swr:bar/poker/nombres_a
function swr:bar/poker/rank_palo
function swr:bar/poker/anotar_a
