# Los vecinos sueltan lo que traian y cogen material de la obra.
execute as @e[tag=swr_colocado] run item replace entity @s weapon.mainhand with minecraft:oak_planks 16
execute as @e[tag=swr_colocado] at @s run particle minecraft:item{item:{id:"minecraft:oak_planks"}} ~ ~1 ~ 0.4 0.4 0.4 0.02 12 normal
playsound minecraft:entity.item.pickup master @a ~ ~ ~ 1 1
execute at @e[tag=swr_obra,limit=1] run particle minecraft:crit ~ ~1 ~ 3 1 2 0.05 30 normal
