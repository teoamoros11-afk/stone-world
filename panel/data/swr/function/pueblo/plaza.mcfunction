# La plaza del pueblo, construida alrededor del marcador swr_plaza.
# 13x13 de piedra (el anillo de fuera es para los puestos de oficio) y zapata de piedra debajo,
# para que la plaza tampoco quede colgada si cae en una ladera.
execute at @e[tag=swr_plaza,limit=1] run fill ~-6 ~-1 ~-6 ~6 ~-1 ~6 minecraft:stone_bricks
execute at @e[tag=swr_plaza,limit=1] run fill ~-6 ~-9 ~-6 ~6 ~-2 ~6 minecraft:stone_bricks replace minecraft:air
execute at @e[tag=swr_plaza,limit=1] run setblock ~ ~ ~ minecraft:stone_bricks
execute at @e[tag=swr_plaza,limit=1] run setblock ~ ~1 ~ minecraft:bell[attachment=floor,facing=north]
execute at @e[tag=swr_plaza,limit=1] run setblock ~-3 ~ ~-3 minecraft:oak_fence
execute at @e[tag=swr_plaza,limit=1] run setblock ~-3 ~1 ~-3 minecraft:lantern
execute at @e[tag=swr_plaza,limit=1] run setblock ~3 ~ ~-3 minecraft:oak_fence
execute at @e[tag=swr_plaza,limit=1] run setblock ~3 ~1 ~-3 minecraft:lantern
execute at @e[tag=swr_plaza,limit=1] run setblock ~-3 ~ ~3 minecraft:oak_fence
execute at @e[tag=swr_plaza,limit=1] run setblock ~-3 ~1 ~3 minecraft:lantern
execute at @e[tag=swr_plaza,limit=1] run setblock ~3 ~ ~3 minecraft:oak_fence
execute at @e[tag=swr_plaza,limit=1] run setblock ~3 ~1 ~3 minecraft:lantern
