# Era 5 - Science Future (serie: cap. 141-232)
# Los dos jugadores avanzan juntos: sin los dos conectados y cerca, la era no se abre.
execute unless score MODO swr matches 1 run function swr:reino/juntos
execute unless score MODO swr matches 1 if score JUGADORES swr matches ..1 run return fail
execute unless score MODO swr matches 1 if score CERCA swr matches 0 run return fail
# Candado: no se abre sin cerrar la era 4 (/function swr:era/cerrar).
execute unless score CERRADA4 swr matches 1.. run return run tellraw @s [{"text":"[Era 5] bloqueada: cierra primero la era 4 con /function swr:era/cerrar","color":"red"}]
scoreboard players set ERA swr 5
advancement grant @a only swr:serie/why
tellraw @a [{"text":"[Era 5] ","color":"gold","bold":true},{"text":"Science Future: computadora, telescopio de fluorita y el cohete pendiente.","color":"white"}]
tellraw @a [{"text":" Serie (cap. 141-232): ","color":"gray"},{"text":"el petroleo cambia la escala de todo, y la radio solo repite una palabra: why. La respuesta esta fuera del planeta.","color":"dark_gray"}]
# la era abre sus fichas del cuaderno
function swr:descubrir/5
