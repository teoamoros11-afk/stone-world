# Ficha de personaje: el nombre y el ASPECTO salen del indice de estatua (ESTATUAS mod 12),
# no de un sorteo. La misma estatua siempre es la misma persona, con su aldea, su oficio y
# su objeto en la mano. Cada ficha vive en su archivo; aqui solo se elige cual toca.
# Uso: automatico desde swr:pueblo/nombre (se ejecuta COMO la estatua recien puesta).
scoreboard players operation SUERTE swr = ESTATUAS swr
scoreboard players operation SUERTE swr %= DOCE swr
execute if score SUERTE swr matches 0 run function swr:personajes/kohaku
execute if score SUERTE swr matches 1 run function swr:personajes/chrome
execute if score SUERTE swr matches 2 run function swr:personajes/ruri
execute if score SUERTE swr matches 3 run function swr:personajes/kaseki
execute if score SUERTE swr matches 4 run function swr:personajes/suika
execute if score SUERTE swr matches 5 run function swr:personajes/ginro
execute if score SUERTE swr matches 6 run function swr:personajes/kinro
execute if score SUERTE swr matches 7 run function swr:personajes/magma
execute if score SUERTE swr matches 8 run function swr:personajes/kokuyo
execute if score SUERTE swr matches 9 run function swr:personajes/jasper
execute if score SUERTE swr matches 10 run function swr:personajes/turquoise
execute if score SUERTE swr matches 11 run function swr:personajes/sapphire
