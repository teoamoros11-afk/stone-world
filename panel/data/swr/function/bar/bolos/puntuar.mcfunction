# Cierra la tirada: apunta los bolos al jugador, canta pleno o media y deja la mesa lista.
# Uso: interno, desde bolos/check
# la ultima tirada se guarda para poder mirarla despues (el reset la borra)
scoreboard players operation BOLOS_ULTIMA swr = BOLOS_TIRADOS swr
scoreboard players set BOLOS_ACTIVO swr 0
kill @e[tag=swr_bola]
execute as @a[tag=swr_bolos_jugador] run scoreboard players operation @s bolos += BOLOS_TIRADOS swr
tellraw @a [{"text":"[Bolos] ","color":"gold","bold":true},{"text":"Bolos tumbados: ","color":"white"},{"score":{"name":"BOLOS_TIRADOS","objective":"swr"},"color":"aqua"}]
execute if score BOLOS_TIRADOS swr matches 10 run tellraw @a [{"text":"[Bolos] ","color":"gold","bold":true},{"text":"PLENO.","color":"green","bold":true}]
execute if score BOLOS_TIRADOS swr matches 1..9 run tellraw @a [{"text":"[Bolos] ","color":"gold","bold":true},{"text":"Media: vuelve a tirar.","color":"yellow"}]
execute if score BOLOS_TIRADOS swr matches 0 run tellraw @a [{"text":"[Bolos] ","color":"gold","bold":true},{"text":"Ni uno. La mesa esta nivelada, que no es culpa de la bola.","color":"red"}]
execute as @a[tag=swr_bolos_jugador] run tellraw @s [{"text":"[Bolos] ","color":"gold","bold":true},{"text":"Tu marcador: ","color":"gray"},{"score":{"name":"@s","objective":"bolos"},"color":"aqua"}]
tag @a remove swr_bolos_jugador
function swr:bar/bolos/reset
