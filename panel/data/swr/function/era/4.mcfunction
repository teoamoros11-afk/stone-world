# Era 4 - New World (serie: cap. 101-140)
# Los dos jugadores avanzan juntos: sin los dos conectados y cerca, la era no se abre.
execute unless score MODO swr matches 1 run function swr:reino/juntos
execute unless score MODO swr matches 1 if score JUGADORES swr matches ..1 run return fail
execute unless score MODO swr matches 1 if score CERCA swr matches 0 run return fail
# Candado: no se abre sin cerrar la era 3 (/function swr:era/cerrar).
execute unless score CERRADA3 swr matches 1.. run return run tellraw @s [{"text":"[Era 4] bloqueada: cierra primero la era 3 con /function swr:era/cerrar","color":"red"}]
scoreboard players set ERA swr 4
advancement grant @a only swr:serie/perseus
tellraw @a [{"text":"[Era 4] ","color":"gold","bold":true},{"text":"New World: brujula, barco, globo, dron, radar y la medusa.","color":"white"}]
tellraw @a [{"text":" Serie (cap. 101-140): ","color":"gray"},{"text":"el platino paga el Perseus, que es un proyecto de meses y no un objeto. La medusa convierte la petrificacion en un arma con dueno.","color":"dark_gray"}]
# la era abre sus fichas del cuaderno
function swr:descubrir/4
tellraw @a [{"text":"[Era 4] ","color":"gold","bold":true},{"text":"Perseus: astillero -> botadura -> tripulacion -> zarpe. Empieza con /function swr:tripulacion/lista","color":"gray"}]
