# A8 - Un punto para quien lo ejecuta. Al tercero, se acaba el torneo.
execute unless score BOUT_ACTIVO serie matches 1 run return run tellraw @s [{"text":"[Grand Bout] ","color":"gold","bold":true},{"text":"No hay torneo en marcha. /function swr:serie/bout/iniciar","color":"red"}]
scoreboard players add @s bout 1
tellraw @a [{"text":"[Grand Bout] ","color":"gold","bold":true},{"selector":"@s"},{"text":" se lleva el punto (","color":"gray"},{"score":{"name":"@s","objective":"bout"},"color":"white"},{"text":"/3).","color":"gray"}]
execute if score @s bout matches 3.. run function swr:serie/bout/ganar
