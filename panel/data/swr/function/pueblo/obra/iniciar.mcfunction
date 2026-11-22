# Arranca la obra del pueblo: temporizador de 45 s y todos los despetrificados a trabajar.
# Se levanta donde estas de pie, tenga o no la plaza al lado.
# Uso: /function swr:pueblo/obra/iniciar
execute unless score PUEBLO swr matches 1 run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Todavia no hay pueblo: hacen falta 3 despetrificados (/function swr:pueblo/despetrificar).","color":"red"}]
execute unless score PUEBLO swr matches 1 run return fail
execute if score OBRA swr matches 1.. run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Ya hay una obra en marcha. Dejadla terminar (o /function swr:pueblo/obra/cancelar).","color":"yellow"}]
execute if score OBRA swr matches 1.. run return fail
execute if score CASA_T swr matches 1.. run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Hay vecinos levantando su casa: dejad que terminen (30 s) y volved a intentarlo.","color":"yellow"}]
execute if score CASA_T swr matches 1.. run return fail
# el taller es 8x3: si hay una casa a menos de 10 bloques se la comeria al limpiar el solar
execute if entity @e[tag=swr_casa_lista,distance=..10,limit=1] run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Aqui no: hay una casa a menos de 10 bloques y el taller la taparia. Busca un hueco.","color":"red"}]
execute if entity @e[tag=swr_casa_lista,distance=..10,limit=1] run return fail
scoreboard players set PRESENTES swr 0
execute store result score PRESENTES swr run execute if entity @e[tag=swr_vecino]
execute if score PRESENTES swr matches ..2 run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Hacen falta al menos 3 vecinos despetrificados para arrancar la obra.","color":"red"}]
execute if score PRESENTES swr matches ..2 run return fail
scoreboard players set OBRA swr 45
summon minecraft:marker ~ ~ ~ {Tags:["swr_obra"]}
function swr:pueblo/obra/puestos
title @a times 5 45 15
title @a subtitle [{"text":"45 segundos. Todos los que salieron de la piedra, a la obra.","color":"gray"}]
title @a title [{"text":"OBRA DEL PUEBLO","color":"gold","bold":true}]
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Se arranca el temporizador: los vecinos van a por materiales y levantan el taller.","color":"green"}]
schedule function swr:pueblo/obra/tick 20t replace
