scoreboard players set TICK swr 0
# execute if entity devuelve el numero de entidades que coinciden.
execute store result score CIUDADANOS swr run execute if entity @e[type=minecolonies:citizen]
execute store result score ALDEANOS swr run execute if entity @e[type=minecraft:villager]
# Millenaire usa entidades propias. Si quieres contarlas, mira el id en el log del servidor
# y descomenta esta linea cambiando el tipo:
# execute store result score ALDEANOS swr run execute if entity @e[type=millenaire:villager]
# el Panel del pueblo tambien llega a quien entre con el servidor ya encendido
execute as @a unless items entity @s container.* minecraft:recovery_compass run function swr:panel/dar
