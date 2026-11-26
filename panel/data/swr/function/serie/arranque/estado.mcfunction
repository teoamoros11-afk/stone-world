# A4 - Cuantos dias llevas y si el arranque esta puesto.
# Uso: /function swr:serie/arranque/estado
execute if score ARRANQUE serie matches 1 run tellraw @s [{"text":"[Arranque] ","color":"gold","bold":true},{"text":"Dias desde la piedra: ","color":"gray"},{"score":{"name":"DIAS","objective":"serie"},"color":"white"}]
execute unless score ARRANQUE serie matches 1 run tellraw @s [{"text":"[Arranque] ","color":"gold","bold":true},{"text":"Sin empezar. /function swr:serie/arranque/iniciar vacia el inventario y fija el punto de aparicion.","color":"red"}]
