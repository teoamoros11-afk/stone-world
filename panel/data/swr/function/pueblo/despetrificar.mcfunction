# Devuelve la vida a la estatua mas cercana (hasta 6 bloques). Cuesta una dosis de fluido.
# Si llevas un frasco de fluido milagroso se gasta el frasco; si no, se gasta el cupo.
# Uso: /function swr:pueblo/despetrificar
execute unless entity @e[tag=swr_estatua,distance=..6,sort=nearest,limit=1] run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"No hay ninguna estatua a menos de 6 bloques. Coloca una con /function swr:pueblo/estatua","color":"red"}]
execute unless entity @e[tag=swr_estatua,distance=..6,sort=nearest,limit=1] run return fail
scoreboard players set FRASCO swr 0
execute if items entity @s container.* minecraft:experience_bottle run scoreboard players set FRASCO swr 1
execute if score FRASCO swr matches 1 run clear @s minecraft:experience_bottle 1
execute if score FRASCO swr matches 0 run scoreboard players add CUPO swr 0
execute if score FRASCO swr matches 0 unless score CUPO swr matches 1.. run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"No queda fluido milagroso. Las estatuas rotas no vuelven: el campo no es infinito.","color":"red"}]
execute if score FRASCO swr matches 0 unless score CUPO swr matches 1.. run return fail
execute if score FRASCO swr matches 0 run scoreboard players remove CUPO swr 1
# el fluido milagroso, por fin: se concede al gastar una dosis de verdad
advancement grant @s only swr:serie/fluido
execute as @e[tag=swr_estatua,distance=..6,sort=nearest,limit=1] run function swr:pueblo/despetrificar_uno
scoreboard players set FRASCO swr 0
