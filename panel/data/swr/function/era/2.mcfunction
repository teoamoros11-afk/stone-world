# Era 2 - Ganarse la aldea (serie: cap. 16-60)
# Los dos jugadores avanzan juntos: sin los dos conectados y cerca, la era no se abre.
execute unless score MODO swr matches 1 run function swr:reino/juntos
execute unless score MODO swr matches 1 if score JUGADORES swr matches ..1 run return fail
execute unless score MODO swr matches 1 if score CERCA swr matches 0 run return fail
# Candado: no se abre sin cerrar la era 1 (/function swr:era/cerrar).
execute unless score CERRADA1 swr matches 1.. run return run tellraw @s [{"text":"[Era 2] bloqueada: cierra primero la era 1 con /function swr:era/cerrar","color":"red"}]
scoreboard players set ERA swr 2
advancement grant @a only swr:serie/aldea
tellraw @a [{"text":"[Era 2] ","color":"gold","bold":true},{"text":"Aldea Ishigami: vidrio, lentes, imanes, dinamo, bombilla, sulfamidas.","color":"white"}]
tellraw @a [{"text":" Serie (cap. 16-60): ","color":"gray"},{"text":"la cura de Ruri compra la aldea entera, y los aldeanos descienden de la tripulacion que estaba en orbita cuando el destello.","color":"dark_gray"}]
# la era abre sus fichas del cuaderno
function swr:descubrir/2
