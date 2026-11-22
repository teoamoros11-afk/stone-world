# Recluta al navegante (Ryusui) donde estas. Era 4 abierta y sin duplicados.
# Uso: /function swr:tripulacion/reclutar/navegante
execute unless entity @s run tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"Hay que ejecutarlo un jugador, no la consola.","color":"red"}]
execute unless entity @s run return fail
execute unless score ERA swr matches 4.. run tellraw @s [{"text":"[Perseus] La tripulacion es cosa de la era 4: abre la era con /function swr:era/4","color":"red"}]
execute unless score ERA swr matches 4.. run return fail
execute if entity @e[tag=swr_navegante] run tellraw @s [{"text":"[Perseus] Ya tienes navegante. /function swr:tripulacion/lista","color":"yellow"}]
execute if entity @e[tag=swr_navegante] run return fail
summon villager ~ ~ ~ {CustomName:'{"text":"Ryusui, navegante","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Tags:["swr_tripulante","swr_navegante"],VillagerData:{profession:"minecraft:cartographer",level:2,type:"minecraft:plains"}}
tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"Ryusui se sube a bordo: cobra en propiedades futuras y no suelta el timon.","color":"green"}]
execute if entity @e[tag=swr_navegante] if entity @e[tag=swr_contable] if entity @e[tag=swr_cocinero] run advancement grant @a only swr:serie/tripulacion
