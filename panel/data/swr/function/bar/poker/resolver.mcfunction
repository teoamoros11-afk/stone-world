# Ensenia la banca, compara y paga el bote. Si empatan, se devuelve la apuesta.
# Uso: interno, al final de poker/iniciar
tellraw @a [{"text":"[Poker] ","color":"gold","bold":true},{"text":"La banca: ","color":"gray"},{"nbt":"nombresB[0]","storage":"swr:poker","color":"white"},{"text":", ","color":"gray"},{"nbt":"nombresB[1]","storage":"swr:poker","color":"white"},{"text":", ","color":"gray"},{"nbt":"nombresB[2]","storage":"swr:poker","color":"white"},{"text":", ","color":"gray"},{"nbt":"nombresB[3]","storage":"swr:poker","color":"white"},{"text":", ","color":"gray"},{"nbt":"nombresB[4]","storage":"swr:poker","color":"white"}]
tellraw @a [{"text":"[Poker] ","color":"gold","bold":true},{"text":"Tu mano vale ","color":"gray"},{"score":{"name":"MANO_JUGADOR","objective":"poker"},"color":"aqua"},{"text":" y la de la banca ","color":"gray"},{"score":{"name":"MANO_BANCA","objective":"poker"},"color":"aqua"}]
execute if score MANO_JUGADOR poker > MANO_BANCA poker run tellraw @a [{"text":"[Poker] ","color":"gold","bold":true},{"text":"Ganas el bote.","color":"green","bold":true}]
execute if score MANO_JUGADOR poker > MANO_BANCA poker run scoreboard players operation @s fichas += BOTE fichas
execute if score MANO_JUGADOR poker < MANO_BANCA poker run tellraw @a [{"text":"[Poker] ","color":"gold","bold":true},{"text":"La banca se lleva el bote.","color":"red"}]
execute if score MANO_JUGADOR poker = MANO_BANCA poker run tellraw @a [{"text":"[Poker] ","color":"gold","bold":true},{"text":"Empate: se devuelve la apuesta.","color":"yellow"}]
execute if score MANO_JUGADOR poker = MANO_BANCA poker run scoreboard players add @s fichas 10
scoreboard players set BOTE fichas 0
execute as @s run tellraw @s [{"text":"[Poker] ","color":"gold","bold":true},{"text":"Te quedan ","color":"gray"},{"score":{"name":"@s","objective":"fichas"},"color":"aqua"},{"text":" fichas.","color":"gray"}]
