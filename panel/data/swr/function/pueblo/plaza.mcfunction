# La plaza del pueblo, construida alrededor del marcador swr_plaza.
execute at @e[tag=swr_plaza,limit=1] run fill ~-4 ~-1 ~-4 ~4 ~-1 ~4 minecraft:stone_bricks
execute at @e[tag=swr_plaza,limit=1] run fill ~-4 ~-1 ~-4 ~4 ~-1 ~4 minecraft:stone_bricks replace minecraft:grass_block
execute at @e[tag=swr_plaza,limit=1] run fill ~-1 ~-1 ~-7 ~1 ~-1 ~-5 minecraft:coarse_dirt
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
