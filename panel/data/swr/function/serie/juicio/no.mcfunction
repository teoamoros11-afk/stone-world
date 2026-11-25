# A9 - Voto para perdonar. Un voto por jugador.
execute if entity @s[tag=swr_voto_juicio] run return run tellraw @s [{"text":"[Juicio] ","color":"red","bold":true},{"text":"Ya has votado.","color":"red"}]
tag @s add swr_voto_juicio
scoreboard players add JUICIO_NO serie 1
tellraw @a [{"text":"[Juicio] ","color":"gray"},{"selector":"@s"},{"text":" vota perdonar.","color":"green"}]
tellraw @a [{"text":"  Desterrar: ","color":"gray"},{"score":{"name":"JUICIO_SI","objective":"serie"},"color":"red"},{"text":"   |   Perdonar: ","color":"gray"},{"score":{"name":"JUICIO_NO","objective":"serie"},"color":"green"}]
