# A10 - Quien gobierna y que decreto esta en vigor.
# Uso: /function swr:serie/politica/estado
tellraw @s [{"text":"[Politica] ","color":"gold","bold":true},{"text":"Gobierno: ","color":"gray"},{"score":{"name":"GOBIERNO","objective":"serie"},"color":"white"},{"text":" (1 Ruri, 2 Kokuyo, 0 empate)   |   Decreto: ","color":"gray"},{"score":{"name":"DECRETO","objective":"serie"},"color":"white"}]
execute if score GOBIERNO serie matches 1 run tellraw @s [{"text":"  Ruri manda: las cien historias son la ley.","color":"light_purple"}]
execute if score GOBIERNO serie matches 2 run tellraw @s [{"text":"  Kokuyo manda: el jefe de siempre, con voto detras.","color":"gold"}]
execute if score GOBIERNO serie matches 0 run tellraw @s [{"text":"  Sin gobierno claro: /function swr:serie/politica/eleccion","color":"red"}]
