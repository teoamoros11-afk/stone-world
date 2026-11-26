# A10 - Cierra la eleccion y proclama el gobierno.
# Uso: /function swr:serie/politica/resolver
tellraw @a [{"text":"[Politica] ","color":"gold","bold":true},{"text":"Ruri: ","color":"gray"},{"score":{"name":"VOTOS_RURI","objective":"serie"},"color":"light_purple"},{"text":"   |   Kokuyo: ","color":"gray"},{"score":{"name":"VOTOS_KOKUYO","objective":"serie"},"color":"gold"}]
execute if score VOTOS_RURI serie > VOTOS_KOKUYO serie run scoreboard players set GOBIERNO serie 1
execute if score VOTOS_RURI serie > VOTOS_KOKUYO serie run title @a title [{"text":"GOBIERNO DE RURI","color":"light_purple","bold":true}]
execute if score VOTOS_RURI serie > VOTOS_KOKUYO serie run tellraw @a [{"text":"[Politica] ","color":"light_purple","bold":true},{"text":"Ruri manda. Las cien historias pasan a ser la ley de la aldea.","color":"gray"}]
execute if score VOTOS_KOKUYO serie > VOTOS_RURI serie run scoreboard players set GOBIERNO serie 2
execute if score VOTOS_KOKUYO serie > VOTOS_RURI serie run title @a title [{"text":"GOBIERNO DE KOKUYO","color":"gold","bold":true}]
execute if score VOTOS_KOKUYO serie > VOTOS_RURI serie run tellraw @a [{"text":"[Politica] ","color":"gold","bold":true},{"text":"Kokuyo sigue mandando, pero ahora con el voto de la aldea detras.","color":"gray"}]
execute if score VOTOS_RURI serie = VOTOS_KOKUYO serie run scoreboard players set GOBIERNO serie 0
execute if score VOTOS_RURI serie = VOTOS_KOKUYO serie run tellraw @a [{"text":"[Politica] ","color":"gold","bold":true},{"text":"Empate: se queda Kokuyo hasta la proxima votacion.","color":"gray"}]
tag @a remove swr_voto_politica
