# A13 - Bateria del telefono.
# Uso: /function swr:serie/telefono/estado
tellraw @s [{"text":"[Telefono] ","color":"aqua","bold":true},{"text":"Bateria: ","color":"gray"},{"score":{"name":"TELEFONO_BATERIA","objective":"serie"},"color":"white"},{"text":" de 5 llamadas","color":"gray"}]
