# Dice que mano es (Tu mano: ) segun el tipo ya evaluado.
# Uso: interno, desde poker/resolver
tellraw @a [{"text":"Tu mano: ","color":"gray"},{"text":"escalera de color","color":"aqua","bold":true}]
execute if score TIPO_JUGADOR poker matches 8 run tellraw @a [{"text":"Tu mano: ","color":"gray"},{"text":"poker","color":"aqua","bold":true}]
execute if score TIPO_JUGADOR poker matches 7 run tellraw @a [{"text":"Tu mano: ","color":"gray"},{"text":"full","color":"aqua","bold":true}]
execute if score TIPO_JUGADOR poker matches 6 run tellraw @a [{"text":"Tu mano: ","color":"gray"},{"text":"color","color":"aqua","bold":true}]
execute if score TIPO_JUGADOR poker matches 5 run tellraw @a [{"text":"Tu mano: ","color":"gray"},{"text":"escalera","color":"aqua","bold":true}]
execute if score TIPO_JUGADOR poker matches 4 run tellraw @a [{"text":"Tu mano: ","color":"gray"},{"text":"trio","color":"aqua","bold":true}]
execute if score TIPO_JUGADOR poker matches 3 run tellraw @a [{"text":"Tu mano: ","color":"gray"},{"text":"doble pareja","color":"aqua","bold":true}]
execute if score TIPO_JUGADOR poker matches 2 run tellraw @a [{"text":"Tu mano: ","color":"gray"},{"text":"pareja","color":"aqua","bold":true}]
execute if score TIPO_JUGADOR poker matches 1 run tellraw @a [{"text":"Tu mano: ","color":"gray"},{"text":"carta alta","color":"aqua","bold":true}]
