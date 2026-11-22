# Cierra una casa (se ejecuta COMO su marcador).
execute at @s run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"selector":"@e[tag=swr_dueno,distance=..7,limit=1]"},{"text":" ya tiene su casa.","color":"green"}]
execute as @e[tag=swr_dueno,distance=..7] run item replace entity @s weapon.mainhand with minecraft:air
execute as @e[tag=swr_dueno,distance=..7] run data merge entity @s {NoAI:0b}
# queda marcado para siempre: su casa ya esta hecha y no vuelve a la cola
tag @e[tag=swr_dueno,distance=..7] add swr_casa_hecha
tag @e[tag=swr_dueno,distance=..7] remove swr_dueno
execute at @s run kill @e[tag=swr_texto,distance=..7,sort=nearest,limit=1]
execute at @s run particle minecraft:happy_villager ~ ~1 ~ 3 1.5 3 0.05 50 normal
execute at @s run particle minecraft:end_rod ~ ~2 ~ 2 1.5 2 0.05 20 normal
execute at @s run playsound minecraft:entity.villager.celebrate master @a ~ ~ ~ 1 1
execute at @s run playsound minecraft:ui.toast.challenge_complete master @a ~ ~ ~ 1 1.2
# el marcador se queda: es la direccion de su casa para el horario de noche
tag @s remove swr_casa
tag @s add swr_casa_lista
