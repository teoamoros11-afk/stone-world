# Los agradecidos no esperan orden: al tercero levantan su plaza. Se ejecuta COMO el vecino
# que acaba de salir de la piedra, asi que la plaza nace donde el estaba.
# Uso: automatico desde swr:pueblo/despetrificar_uno
execute if score PUEBLO swr matches 1 run return fail
scoreboard players set PUEBLO swr 1
summon minecraft:marker ~ ~ ~ {Tags:["swr_plaza"]}
execute at @e[tag=swr_plaza,limit=1] run function swr:pueblo/plaza
execute at @e[tag=swr_plaza,limit=1] run function swr:pueblo/puestos
function swr:pueblo/caminos
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Tres despetrificados y ya no esperan orden: plantan una plaza con campana. El pueblo existe.","color":"green"}]
tellraw @a [{"text":"[Pueblo] ","color":"gray"},{"text":"Cuando querais, la obra: /function swr:pueblo/obra/iniciar (echa a andar a todos los vecinos con materiales)","color":"white"}]
playsound minecraft:block.bell.use master @a ~ ~ ~ 1 1
particle minecraft:happy_villager ~ ~1 ~ 3 1 3 0.05 40 normal
advancement grant @a only swr:serie/pueblo
# los que ya estaban despetrificados tambien se levantan su casa
execute as @e[tag=swr_vecino,tag=!swr_dueno] run function swr:pueblo/casa/empezar
