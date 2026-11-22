# Revive esta estatua (se ejecuta COMO la estatua). El mod quita el efecto y el aldeano
# vuelve a moverse; aqui se le da oficio, se le apunta como vecino y se le agradece.
drstonekos depetrify @s
data merge entity @s {NoAI:0b,Invulnerable:0b,Silent:0b,PersistenceRequired:1b}
tag @s remove swr_estatua
tag @s add swr_vecino
tag @s add swr_agradecido
scoreboard players add VECINOS swr 1
scoreboard players add REVIDOS swr 1
particle minecraft:block{block_state:"minecraft:stone"} ~ ~1 ~ 0.4 0.6 0.4 0.2 50 normal
particle minecraft:happy_villager ~ ~1 ~ 0.4 0.6 0.4 0.05 12 normal
playsound minecraft:block.stone.break master @a ~ ~ ~ 0.9 0.7
playsound minecraft:entity.villager.ambient master @a ~ ~ ~ 1 1.2
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"selector":"@s"},{"text":" sale de la piedra. \"Llevaba 3.700 anos asi. Gracias. Lo que sepa hacer, es tuyo.\"","color":"green","italic":true}]
# el oficio se elige por lo que falta en el pueblo, no por turno
function swr:pueblo/oficios/asignar
# el oficio queda en un tag: el horario lo manda a su puesto de trabajo
execute if score VECINOS swr matches 3.. unless score PUEBLO swr matches 1 run function swr:pueblo/fundar
execute if entity @e[tag=swr_plaza,limit=1] run function swr:pueblo/casa/empezar
tellraw @a [{"text":"[Pueblo] ","color":"gray"},{"text":"Vecinos despetrificados: ","color":"gray"},{"score":{"name":"VECINOS","objective":"swr"},"color":"white"},{"text":"  |  Fluido: ","color":"gray"},{"score":{"name":"CUPO","objective":"swr"},"color":"white"}]
