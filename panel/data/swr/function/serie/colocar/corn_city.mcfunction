# Coloca el plano Corn City donde estas. La esquina (0,0,0) del plano cae a tus pies.
# Temporada 4: maizales, silo, casas y torre de radio.
# Uso: /function swr:serie/colocar/corn_city
execute at @s run place template swr:corn_city ~ ~ ~
tellraw @a [{"text":"[Serie] ","color":"gold","bold":true},{"text":"Corn City colocado.","color":"gray"}]
