# A17 - Fichas, mano abierta y ultimo numero de la ruleta.
# Uso: /function swr:serie/casino/estado
tellraw @s [{"text":"[Casino] ","color":"gold","bold":true},{"text":"Tus fichas: ","color":"gray"},{"score":{"name":"@s","objective":"fichas"},"color":"white"},{"text":"   |   Mano abierta: ","color":"gray"},{"score":{"name":"CASINO_ACTIVO","objective":"serie"},"color":"white"},{"text":"   |   Ultima ruleta: ","color":"gray"},{"score":{"name":"RULETA","objective":"serie"},"color":"white"}]
