# Ficha de personaje: el nombre y el ASPECTO salen del indice de estatua (ESTATUAS mod 38),
# no de un sorteo. La misma estatua siempre es la misma persona, con su aldea, su oficio y
# su objeto en la mano. Las doce primeras son la aldea de Ishigami; las veintiseis siguientes
# son el resto del reparto, que no ocupa puesto de oficio (no llevan tag swr_oficio_N).
# Cada ficha vive en su archivo; aqui solo se elige cual toca.
# Uso: automatico desde swr:pueblo/nombre (se ejecuta COMO la estatua recien puesta).
scoreboard players operation SUERTE swr = ESTATUAS swr
scoreboard players operation SUERTE swr %= TREINTA_Y_OCHO swr
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
execute if score SUERTE swr matches 12 run function swr:personajes/tsukasa
execute if score SUERTE swr matches 13 run function swr:personajes/hyoga
execute if score SUERTE swr matches 14 run function swr:personajes/gen
execute if score SUERTE swr matches 15 run function swr:personajes/ukyo
execute if score SUERTE swr matches 16 run function swr:personajes/taiju
execute if score SUERTE swr matches 17 run function swr:personajes/yuzuriha
execute if score SUERTE swr matches 18 run function swr:personajes/byakuya
execute if score SUERTE swr matches 19 run function swr:personajes/lillian
execute if score SUERTE swr matches 20 run function swr:personajes/ryusui
execute if score SUERTE swr matches 21 run function swr:personajes/francois
execute if score SUERTE swr matches 22 run function swr:personajes/sai
execute if score SUERTE swr matches 23 run function swr:personajes/moz
execute if score SUERTE swr matches 24 run function swr:personajes/ibara
execute if score SUERTE swr matches 25 run function swr:personajes/kirisame
execute if score SUERTE swr matches 26 run function swr:personajes/soyuz
execute if score SUERTE swr matches 27 run function swr:personajes/amaryllis
execute if score SUERTE swr matches 28 run function swr:personajes/matsukaze
execute if score SUERTE swr matches 29 run function swr:personajes/chelsea
execute if score SUERTE swr matches 30 run function swr:personajes/luna
execute if score SUERTE swr matches 31 run function swr:personajes/xeno
execute if score SUERTE swr matches 32 run function swr:personajes/stanley
execute if score SUERTE swr matches 33 run function swr:personajes/brody
execute if score SUERTE swr matches 34 run function swr:personajes/joel
execute if score SUERTE swr matches 35 run function swr:personajes/charlotte
execute if score SUERTE swr matches 36 run function swr:personajes/max
execute if score SUERTE swr matches 37 run function swr:personajes/carlos
