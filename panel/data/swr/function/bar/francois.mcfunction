# Francois, la cocinera del Perseus, detras de la barra: quieta, mirando al salon.
# Si todavia no esta a bordo se avisa: se recluta con /function swr:tripulacion/reclutar/cocinero
execute unless entity @e[tag=swr_cocinero,limit=1] run tellraw @a [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Falta Francois: /function swr:tripulacion/reclutar/cocinero y vuelve a montar el bar.","color":"red"}]
execute unless entity @e[tag=swr_cocinero,limit=1] run return 0
execute at @s as @e[tag=swr_cocinero,limit=1] run tp @s ~ ~ ~-1 0 0
execute at @s as @e[tag=swr_cocinero,limit=1] run data merge entity @s {NoAI:1b,PersistenceRequired:1b,Invulnerable:1b,CustomName:'{"text":"Francois","color":"gold"}'}
