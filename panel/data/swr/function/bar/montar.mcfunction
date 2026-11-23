# Salon del Perseus: la barra, dos mesas de poker y (aparte) la mesa de bolos.
# Se monta alrededor de quien lo ejecuta y mira al sur (+z): deja 7x9 libre en cubierta.
# Uso: /function swr:bar/montar   (despues: /function swr:bar/bolos/montar)
# si no hay suelo bajo los pies, no se monta nada (se saldria por la borda)
execute if block ~ ~-1 ~ minecraft:air run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Aqui no hay cubierta bajo tus pies. Ponte en el suelo del barco.","color":"red"}]
execute if block ~ ~-1 ~ minecraft:air run return 0
execute if block ~ ~-1 ~ minecraft:water run tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Estas sobre el agua: busca la cubierta.","color":"red"}]
execute if block ~ ~-1 ~ minecraft:water run return 0
# un solo salon: se quita el marcador viejo antes de montar el nuevo
kill @e[tag=swr_bar]
summon minecraft:marker ~ ~ ~ {Tags:["swr_bar"]}
# la barra: cinco barriles con tapa de losa y cinco taburetes delante
fill ~-2 ~ ~ ~2 ~ ~ minecraft:barrel
fill ~-2 ~1 ~ ~2 ~1 ~ minecraft:smooth_stone_slab
setblock ~-2 ~ ~1 minecraft:oak_stairs[facing=north]
setblock ~-1 ~ ~1 minecraft:oak_stairs[facing=north]
setblock ~0 ~ ~1 minecraft:oak_stairs[facing=north]
setblock ~1 ~ ~1 minecraft:oak_stairs[facing=north]
setblock ~2 ~ ~1 minecraft:oak_stairs[facing=north]
# el cartel de la carta, encima de la barra
setblock ~2 ~2 ~ minecraft:oak_sign{front_text:{messages:['"CARTA DEL BAR"','"/function"','"swr:bar/carta"','""']}}
setblock ~-2 ~2 ~ minecraft:oak_sign{front_text:{messages:['"DESPENSA"','"/function"','"swr:bar/despensa"','""']}}
# dos mesas de poker, a derecha e izquierda del salon
execute positioned ~-2 ~ ~4 run function swr:bar/poker/mesa
execute positioned ~2 ~ ~4 run function swr:bar/poker/mesa
# la cocinera, detras de la barra
function swr:bar/francois
particle minecraft:happy_villager ~ ~1 ~ 2 0 1 0.02 20 normal
tellraw @a [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Salon montado en cubierta: barra con Francois, dos mesas de poker y el cartel de la carta. La mesa de bolos va aparte: /function swr:bar/bolos/montar","color":"green"}]
tellraw @a [{"text":"[Bar] ","color":"gold","bold":true},{"text":"La despensa se llena con lo que traen los puestos del pueblo y con lo que entregueis vosotros: /function swr:bar/despensa","color":"gray"}]
