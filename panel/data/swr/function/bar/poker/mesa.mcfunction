# Una mesa de poker de 3x3 con dos asientos, uno a cada lado (norte y sur).
# Uso: se llama desde swr:bar/montar; tambien suelta: /function swr:bar/poker/mesa
fill ~-1 ~1 ~-1 ~1 ~1 ~1 minecraft:dark_oak_planks
setblock ~-1 ~ ~-1 minecraft:oak_fence
setblock ~1 ~ ~-1 minecraft:oak_fence
setblock ~-1 ~ ~1 minecraft:oak_fence
setblock ~1 ~ ~1 minecraft:oak_fence
setblock ~ ~ ~-2 minecraft:oak_stairs[facing=south]
setblock ~ ~ ~2 minecraft:oak_stairs[facing=north]
setblock ~ ~1 ~ minecraft:lantern
particle minecraft:happy_villager ~ ~1 ~ 1 0 1 0.01 6 normal
