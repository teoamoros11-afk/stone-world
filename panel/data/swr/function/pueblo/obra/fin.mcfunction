# Fin de la obra: el taller esta en pie y los vecinos vuelven a su vida.
scoreboard players set OBRA swr 0
execute as @e[tag=swr_colocado] run item replace entity @s weapon.mainhand with minecraft:air
execute as @e[tag=swr_colocado] run data merge entity @s {NoAI:0b}
tag @e[tag=swr_vecino] remove swr_colocado
execute at @e[tag=swr_obra,limit=1] run particle minecraft:happy_villager ~ ~1 ~ 4 2 3 0.05 80 normal
execute at @e[tag=swr_obra,limit=1] run particle minecraft:end_rod ~ ~2 ~ 3 2 2 0.05 40 normal
playsound minecraft:ui.toast.challenge_complete master @a ~ ~ ~ 1 1
playsound minecraft:entity.villager.celebrate master @a ~ ~ ~ 1 1
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Obra terminada. El taller esta en pie: lo levantaron los que salieron de la piedra.","color":"green"}]
tellraw @a [{"text":"[Pueblo] ","color":"gray"},{"text":"Estado: /function swr:pueblo/estado  |  Otra obra: /function swr:pueblo/obra/iniciar","color":"white"}]
title @a times 5 50 20
title @a subtitle [{"text":"Los agradecidos ya tienen donde trabajar.","color":"gray"}]
title @a title [{"text":"OBRA TERMINADA","color":"green","bold":true}]
advancement grant @a only swr:serie/pueblo
kill @e[tag=swr_obra]
