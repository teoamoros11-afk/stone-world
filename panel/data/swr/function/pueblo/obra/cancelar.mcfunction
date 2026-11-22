# Cancela la obra en marcha y devuelve a los vecinos a su vida.
scoreboard players set OBRA swr 0
execute as @e[tag=swr_colocado] run item replace entity @s weapon.mainhand with minecraft:air
execute as @e[tag=swr_colocado] run data merge entity @s {NoAI:0b}
tag @e[tag=swr_vecino] remove swr_colocado
kill @e[tag=swr_obra]
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Obra cancelada: los vecinos dejan los materiales y vuelven a lo suyo.","color":"yellow"}]
