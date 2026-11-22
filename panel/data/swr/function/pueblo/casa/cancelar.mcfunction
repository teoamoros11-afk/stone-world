# Cancela la tanda de casas: se retiran los marcadores y los duenos vuelven a su vida.
execute as @e[tag=swr_dueno] run item replace entity @s weapon.mainhand with minecraft:air
execute as @e[tag=swr_dueno] run data merge entity @s {NoAI:0b}
tag @e[tag=swr_dueno] remove swr_dueno
kill @e[tag=swr_texto]
kill @e[tag=swr_casa]
scoreboard players set CASA_T swr 0
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Casas canceladas: los vecinos sueltan el material y vuelven a lo suyo.","color":"yellow"}]
