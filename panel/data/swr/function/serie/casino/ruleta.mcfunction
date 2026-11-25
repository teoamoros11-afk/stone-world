# A17 - La ruleta del casino (T4, ep. 58). Cinco fichas al par o al impar.
# Uso: /function swr:serie/casino/ruleta
execute unless score @s fichas matches 5.. run return run tellraw @s [{"text":"[Casino] ","color":"gold","bold":true},{"text":"Hacen falta cinco fichas. /function swr:bar/poker/comprar","color":"red"}]
scoreboard players remove @s fichas 5
execute store result score RULETA serie run random value 1..36
execute if score RULETA serie matches 2.. run tellraw @a [{"text":"[Casino] ","color":"gold","bold":true},{"text":"La bola cae en el ","color":"gray"},{"score":{"name":"RULETA","objective":"serie"},"color":"white"},{"text":".","color":"gray"}]
execute if score RULETA serie matches 1 run tellraw @a [{"text":"[Casino] ","color":"gold","bold":true},{"text":"Cero. La banca se lo lleva todo.","color":"red"}]
execute if score RULETA serie matches 2.. unless score RULETA serie matches 1 run scoreboard players add @s fichas 10
execute if score RULETA serie matches 2.. run tellraw @s [{"text":"[Casino] ","color":"green","bold":true},{"text":"Ganas: la banca paga el doble. Diez fichas de vuelta.","color":"gray"}]
