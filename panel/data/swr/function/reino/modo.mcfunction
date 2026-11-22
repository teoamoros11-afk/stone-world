# Alterna el candado de eras: MODO 2 = hacen falta los dos jugadores (por defecto), MODO 1 = uno solo.
# Uso: /function swr:reino/modo
execute if score MODO swr matches 2 run scoreboard players set MODO_NUEVO swr 1
execute if score MODO swr matches 1 run scoreboard players set MODO_NUEVO swr 2
execute unless score MODO swr matches 1..2 run scoreboard players set MODO_NUEVO swr 2
scoreboard players operation MODO swr = MODO_NUEVO swr
execute if score MODO swr matches 2 run tellraw @a [{"text":"[Juntos] ","color":"gold","bold":true},{"text":"Candado en equipo: las eras piden a los dos jugadores conectados y a menos de 80 bloques.","color":"green"}]
execute if score MODO swr matches 1 run tellraw @a [{"text":"[Juntos] ","color":"gold","bold":true},{"text":"Candado en solitario: una era se abre con un solo jugador. El progreso sigue siendo compartido.","color":"yellow"}]
