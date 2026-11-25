# A6 - Cuantos han vuelto y cuanto falta para el siguiente hito.
# Uso: /function swr:serie/millon/estado
tellraw @s [{"text":"[El millon] ","color":"gold","bold":true},{"text":"Revividos en total: ","color":"gray"},{"score":{"name":"REVIDOS_TOTAL","objective":"serie"},"color":"white"},{"text":" de 1.000.000","color":"gray"}]
execute if score REVIDOS_TOTAL serie matches ..999 run tellraw @s [{"text":"  Siguiente hito: 1.000.","color":"gray"}]
execute if score REVIDOS_TOTAL serie matches 1000..9999 run tellraw @s [{"text":"  Siguiente hito: 10.000.","color":"gray"}]
execute if score REVIDOS_TOTAL serie matches 10000..99999 run tellraw @s [{"text":"  Siguiente hito: 100.000.","color":"gray"}]
execute if score REVIDOS_TOTAL serie matches 100000..999999 run tellraw @s [{"text":"  Siguiente hito: 1.000.000.","color":"gray"}]
execute if score REVIDOS_TOTAL serie matches 1000000.. run tellraw @s [{"text":"  Objetivo cumplido.","color":"gold"}]
