# A21 - Cura: gasta una sulfamida del mod y quita los efectos.
# Uso: /function swr:serie/hospital/curar
execute unless entity @s[tag=swr_herido] run return run tellraw @s [{"text":"[Hospital] ","color":"gold","bold":true},{"text":"No estas ingresado. /function swr:serie/hospital/ingresar","color":"red"}]
execute unless items entity @s container.* stonepharmacy:sulfamida run return run tellraw @s [{"text":"[Hospital] ","color":"gold","bold":true},{"text":"No llevas sulfamida. El cofre del hospital tiene tres.","color":"red"}]
clear @s stonepharmacy:sulfamida 1
effect clear @s minecraft:nausea
effect clear @s minecraft:weakness
effect give @s minecraft:regeneration 10 1 true
tag @s remove swr_herido
playsound minecraft:entity.player.levelup master @a ~ ~ ~ 0.6 1.4
tellraw @a [{"text":"[Hospital] ","color":"green","bold":true},{"selector":"@s"},{"text":" sale curado. La sulfamida es el invento que separa la medicina de la supersticion.","color":"gray"}]
