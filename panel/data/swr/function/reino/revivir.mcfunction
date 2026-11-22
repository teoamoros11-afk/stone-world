# Revivir a un aldeano del campo de estatuas: cada uno gasta una dosis de fluido.
# El campo no es infinito (40-60 estatuas utiles, ISLA.md): cuando se agota, no hay mas gente.
# Uso: /function swr:reino/revivir
scoreboard players add CUPO swr 0
execute unless score CUPO swr matches 1.. run return run tellraw @s [{"text":"[Reino] No queda fluido. El campo de estatuas se agoto: las estatuas rotas no vuelven.","color":"red"}]
scoreboard players remove CUPO swr 1
advancement grant @s only swr:serie/fluido
scoreboard players add REVIDOS swr 1
execute if score CUPO swr matches 0 run tellraw @a [{"text":"[Reino] Ultima dosis de fluido gastada. A partir de aqui, la aldea crece solo con los que ya viven.","color":"dark_red","bold":true}]
tellraw @a [{"text":"[Reino] Revivido ","color":"green"},{"score":{"name":"REVIDOS","objective":"swr"},"color":"green"},{"text":". Quedan ","color":"green"},{"score":{"name":"CUPO","objective":"swr"},"color":"green"},{"text":" dosis de fluido.","color":"green"}]
