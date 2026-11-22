# Bota el casco del Perseus. Hay que estar en el puerto y con la era 4 abierta.
# Uso: /function swr:tripulacion/botadura
execute unless entity @s run tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"La botadura la firma un jugador, no la consola.","color":"red"}]
execute unless entity @s run return fail
execute unless score ERA swr matches 4.. run tellraw @s [{"text":"[Perseus] Todavia no toca: el astillero es de la era 4 (/function swr:era/4).","color":"red"}]
execute unless score ERA swr matches 4.. run return fail
execute unless entity @s[x=-50,y=40,z=450,dx=220,dy=120,dz=140] run tellraw @s [{"text":"[Perseus] Para botar hay que estar en el puerto y astillero: zona 5, esquina -50 450. Usa /function swr:viaje/puerto","color":"red"}]
execute unless entity @s[x=-50,y=40,z=450,dx=220,dy=120,dz=140] run return fail
execute if score BOTADO swr matches 1 run tellraw @s [{"text":"[Perseus] El casco ya esta en el agua. Siguiente: tripulacion y /function swr:tripulacion/zarpar","color":"yellow"}]
execute if score BOTADO swr matches 1 run return fail
scoreboard players set BOTADO swr 1
tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"Botadura: el casco toca el agua. Falta gente que sepa llevarlo.","color":"green"}]
tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"/function swr:tripulacion/lista | reclutar/navegante | reclutar/contable | reclutar/cocinero","color":"gray"}]
