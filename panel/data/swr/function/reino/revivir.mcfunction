# Revivir a un aldeano del campo de estatuas: cada uno gasta una dosis de fluido.
# El campo no es infinito (40-60 estatuas utiles, ISLA.md): cuando se agota, no hay mas gente.
# Si llevas un frasco de fluido milagroso se gasta el frasco; si no, se gasta el cupo.
# Uso: /function swr:reino/revivir
scoreboard players set FRASCO swr 0
execute if items entity @s container.* minecraft:experience_bottle run scoreboard players set FRASCO swr 1
execute if score FRASCO swr matches 1 run clear @s minecraft:experience_bottle 1
execute if score FRASCO swr matches 0 run scoreboard players add CUPO swr 0
execute if score FRASCO swr matches 0 unless score CUPO swr matches 1.. run return run tellraw @s [{"text":"[Reino] No queda fluido. El campo de estatuas se agoto: las estatuas rotas no vuelven.","color":"red"}]
execute if score FRASCO swr matches 0 run scoreboard players remove CUPO swr 1
advancement grant @s only swr:serie/fluido
scoreboard players add REVIDOS swr 1
execute if score FRASCO swr matches 0 if score CUPO swr matches 0 run tellraw @a [{"text":"[Reino] Ultima dosis de fluido gastada. A partir de aqui, la aldea crece solo con los que ya viven.","color":"dark_red","bold":true}]
execute if score FRASCO swr matches 1 run tellraw @a [{"text":"[Reino] Revivido ","color":"green"},{"score":{"name":"REVIDOS","objective":"swr"},"color":"green"},{"text":" con un frasco de fluido milagroso. El cupo sigue en ","color":"green"},{"score":{"name":"CUPO","objective":"swr"},"color":"green"},{"text":" dosis.","color":"green"}]
execute unless score FRASCO swr matches 1 run tellraw @a [{"text":"[Reino] Revivido ","color":"green"},{"score":{"name":"REVIDOS","objective":"swr"},"color":"green"},{"text":". Quedan ","color":"green"},{"score":{"name":"CUPO","objective":"swr"},"color":"green"},{"text":" dosis de fluido.","color":"green"}]
scoreboard players set FRASCO swr 0
