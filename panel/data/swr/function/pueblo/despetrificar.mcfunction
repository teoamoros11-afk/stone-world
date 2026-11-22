# Devuelve la vida a la estatua mas cercana (hasta 6 bloques). Cuesta una dosis de fluido.
# Uso: /function swr:pueblo/despetrificar
execute unless entity @e[tag=swr_estatua,distance=..6,sort=nearest,limit=1] run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"No hay ninguna estatua a menos de 6 bloques. Coloca una con /function swr:pueblo/estatua","color":"red"}]
execute unless entity @e[tag=swr_estatua,distance=..6,sort=nearest,limit=1] run return fail
execute unless score CUPO swr matches 1.. run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"No queda fluido milagroso. Las estatuas rotas no vuelven: el campo no es infinito.","color":"red"}]
execute unless score CUPO swr matches 1.. run return fail
scoreboard players remove CUPO swr 1
execute as @e[tag=swr_estatua,distance=..6,sort=nearest,limit=1] run function swr:pueblo/despetrificar_uno
