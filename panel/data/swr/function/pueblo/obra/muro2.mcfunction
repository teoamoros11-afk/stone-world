# Muro, capa 3: la banda de cristal (las ventanas del taller).
execute at @e[tag=swr_obra,limit=1] run fill ~-4 ~2 ~ ~3 ~2 ~2 minecraft:glass outline
execute at @e[tag=swr_obra,limit=1] run particle minecraft:block{block_state:"minecraft:glass"} ~ ~2 ~1 4 0.3 1 0.05 30 normal
playsound minecraft:block.glass.place master @a ~ ~ ~ 0.9 1
