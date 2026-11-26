# A10 - Voto para Ruri. Un voto por jugador.
execute if entity @s[tag=swr_voto_politica] run return run tellraw @s [{"text":"[Politica] ","color":"gold","bold":true},{"text":"Ya has votado.","color":"red"}]
tag @s add swr_voto_politica
scoreboard players add VOTOS_RURI serie 1
tellraw @a [{"text":"[Politica] ","color":"gray"},{"selector":"@s"},{"text":" vota a Ruri.","color":"light_purple"}]
