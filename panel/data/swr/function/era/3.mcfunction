# Era 3 - Stone Wars (serie: cap. 61-100)
# Los dos jugadores avanzan juntos: sin los dos conectados y cerca, la era no se abre.
execute unless score MODO swr matches 1 run function swr:reino/juntos
execute unless score MODO swr matches 1 if score JUGADORES swr matches ..1 run return fail
execute unless score MODO swr matches 1 if score CERCA swr matches 0 run return fail
# Candado: no se abre sin cerrar la era 2 (/function swr:era/cerrar).
execute unless score CERRADA2 swr matches 1.. run return run tellraw @s [{"text":"[Era 3] bloqueada: cierra primero la era 2 con /function swr:era/cerrar","color":"red"}]
scoreboard players set ERA swr 3
advancement grant @a only swr:serie/stone-wars
tellraw @a [{"text":"[Era 3] ","color":"gold","bold":true},{"text":"Stone Wars: hierro nivel 3, baterias de plomo-acido, central hidroelectrica y telefono.","color":"white"}]
tellraw @a [{"text":" Serie (cap. 61-100): ","color":"gray"},{"text":"la guerra se gana con suministros y propaganda. Gen mueve mas gente con la radio pirata que cualquier ejercito, y Hyoga pelea por el poder, no por la idea.","color":"dark_gray"}]
# la era abre sus fichas del cuaderno
function swr:descubrir/3
