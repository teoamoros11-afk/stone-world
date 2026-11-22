# Zarpamos. Se niega si falta barco botado, tripulacion o si estan lejos.
# Uso: /function swr:tripulacion/zarpar
execute unless entity @s run tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"El zarpe lo ordena un jugador, no la consola.","color":"red"}]
execute unless entity @s run return fail
execute unless score ERA swr matches 4.. run tellraw @s [{"text":"[Perseus] El Perseus es de la era 4 (/function swr:era/4).","color":"red"}]
execute unless score ERA swr matches 4.. run return fail
execute unless score BOTADO swr matches 1 run tellraw @s [{"text":"[Perseus] Sin botadura no hay zarpe: /function swr:tripulacion/botadura en el puerto.","color":"red"}]
execute unless score BOTADO swr matches 1 run return fail
execute unless entity @e[tag=swr_navegante] run tellraw @a [{"text":"[Perseus] ","color":"red","bold":true},{"text":"Sin navegante no se zarpa: nadie decide el rumbo. /function swr:tripulacion/reclutar/navegante","color":"red"}]
execute unless entity @e[tag=swr_navegante] run return fail
execute unless entity @e[tag=swr_contable] run tellraw @a [{"text":"[Perseus] ","color":"red","bold":true},{"text":"Sin contable no se zarpa: nadie cuenta los viveres. /function swr:tripulacion/reclutar/contable","color":"red"}]
execute unless entity @e[tag=swr_contable] run return fail
execute unless entity @e[tag=swr_cocinero] run tellraw @a [{"text":"[Perseus] ","color":"red","bold":true},{"text":"Sin cocinero no se zarpa: la expedicion se muere de hambre. /function swr:tripulacion/reclutar/cocinero","color":"red"}]
execute unless entity @e[tag=swr_cocinero] run return fail
execute at @s unless entity @e[tag=swr_navegante,distance=..48] run tellraw @s [{"text":"[Perseus] El navegante esta lejos del barco: traelo a menos de 48 bloques.","color":"red"}]
execute at @s unless entity @e[tag=swr_navegante,distance=..48] run return fail
execute at @s unless entity @e[tag=swr_contable,distance=..48] run tellraw @s [{"text":"[Perseus] El contable esta lejos del barco: traelo a menos de 48 bloques.","color":"red"}]
execute at @s unless entity @e[tag=swr_contable,distance=..48] run return fail
execute at @s unless entity @e[tag=swr_cocinero,distance=..48] run tellraw @s [{"text":"[Perseus] El cocinero esta lejos del barco: traelo a menos de 48 bloques.","color":"red"}]
execute at @s unless entity @e[tag=swr_cocinero,distance=..48] run return fail
scoreboard players set ZARPE swr 1
advancement grant @a only swr:serie/zarpe
give @a minecraft:oak_boat 2
give @a written_book[minecraft:written_book_content={title:"Carta de navegacion",author:"Ryusui",pages:['{"text":"CARTA DE NAVEGACION DEL PERSEUS","color":"gold","bold":true}','{"text":"Rumbo: 3.000 bloques al este. La isla del tesoro cae hacia x 3000, z 100. El navegante no adivina: mide, corrige y vuelve a medir."}','{"text":"Tripulacion: Ryusui (rumbo), Sai (cuenta de viveres y distancia), Francois (comida y agua). Cada uno hace lo suyo o la expedicion se hunde."}','{"text":"Aviso del astillero: el casco no navega solo. Se va en bote, y el barco se queda amarrado como prueba de lo que habeis construido."}']}]
tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"Zarpe. La tripulacion esta a bordo: el Perseus queda listo y la carta de navegacion repartida.","color":"green"}]
tellraw @a [{"text":"[Perseus] ","color":"gray"},{"text":"Isla del tesoro: 3.000 al este, en bote. Vuelve con platino y cierra la era 4.","color":"white"}]
