# Era 1 - No morir (serie: cap. 1-15)
# Los dos jugadores avanzan juntos: sin los dos conectados y cerca, la era no se abre.
execute unless score MODO swr matches 1 run function swr:reino/juntos
execute unless score MODO swr matches 1 if score JUGADORES swr matches ..1 run return fail
execute unless score MODO swr matches 1 if score CERCA swr matches 0 run return fail
scoreboard players set ERA swr 1
advancement grant @a only swr:serie/despertar
tellraw @a [{"text":"[Era 1] ","color":"gold","bold":true},{"text":"No morir: fuego, ceramica, cuero y el fluido milagroso.","color":"white"}]
tellraw @a [{"text":" Serie (cap. 1-15): ","color":"gray"},{"text":"Senku cuenta 3700 anos dentro de la piedra. El fluido solo deshace la piedra de un cuerpo intacto: las estatuas rotas no vuelven.","color":"dark_gray"}]
# la era abre sus fichas del cuaderno
function swr:descubrir/1
