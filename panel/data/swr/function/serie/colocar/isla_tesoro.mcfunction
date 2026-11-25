# Coloca el plano Isla del Tesoro donde estas. La esquina (0,0,0) del plano cae a tus pies.
# Temporada 3: ciudadela, altar de la medusa, celda y muelle.
# Uso: /function swr:serie/colocar/isla_tesoro
execute at @s run place template swr:isla_tesoro ~ ~ ~
tellraw @a [{"text":"[Serie] ","color":"gold","bold":true},{"text":"Isla del Tesoro colocado.","color":"gray"}]
