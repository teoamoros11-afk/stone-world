# Recluta al contable (Sai) donde estas. Era 4 abierta y sin duplicados.
# Uso: /function swr:tripulacion/reclutar/contable
execute unless entity @s run tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"Hay que ejecutarlo un jugador, no la consola.","color":"red"}]
execute unless entity @s run return fail
execute unless score ERA swr matches 4.. run tellraw @s [{"text":"[Perseus] La tripulacion es cosa de la era 4: abre la era con /function swr:era/4","color":"red"}]
execute unless score ERA swr matches 4.. run return fail
execute if entity @e[tag=swr_contable] run tellraw @s [{"text":"[Perseus] Ya tienes contable. /function swr:tripulacion/lista","color":"yellow"}]
execute if entity @e[tag=swr_contable] run return fail
summon villager ~ ~ ~ {CustomName:'{"text":"Sai, contable","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Tags:["swr_tripulante","swr_contable"],VillagerData:{profession:"minecraft:librarian",level:2,type:"minecraft:plains"}}
tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"Sai lleva las cuentas: carga, viveres y distancia. Sin numeros no hay rumbo.","color":"green"}]
execute if entity @e[tag=swr_navegante] if entity @e[tag=swr_contable] if entity @e[tag=swr_cocinero] run advancement grant @a only swr:serie/tripulacion
