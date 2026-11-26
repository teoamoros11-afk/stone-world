# A10 - Voto para Kokuyo. Un voto por jugador.
execute if entity @s[tag=swr_voto_politica] run return run tellraw @s [{"text":"[Politica] ","color":"gold","bold":true},{"text":"Ya has votado.","color":"red"}]
tag @s add swr_voto_politica
scoreboard players add VOTOS_KOKUYO serie 1
tellraw @a [{"text":"[Politica] ","color":"gray"},{"selector":"@s"},{"text":" vota a Kokuyo.","color":"gold"}]
