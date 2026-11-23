# Una carta al azar para la banca: no se dice hasta el recuento, pero se guarda su nombre.
# Uso: cinco veces desde poker/iniciar
scoreboard players set INTENTOS swr 0
execute store result score CARTA swr run random value 1..52
execute if score CARTA cs matches 1.. run function swr:bar/poker/repetir_b
execute if score CARTA cs matches 1.. run return 0
scoreboard players set CARTA cs 1
function swr:bar/poker/nombres_b
function swr:bar/poker/rank_palo
function swr:bar/poker/anotar_b
