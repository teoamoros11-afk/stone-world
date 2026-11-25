# A35 - Intentos y ultima causa de fallo.
# Uso: /function swr:serie/satelite/estado
tellraw @s [{"text":"[Senku-1] ","color":"aqua","bold":true},{"text":"Intentos: ","color":"gray"},{"score":{"name":"SATELITE_INTENTOS","objective":"serie"},"color":"white"},{"text":" de 7   |   Ultimo fallo: ","color":"gray"},{"score":{"name":"SATELITE_FALLO","objective":"serie"},"color":"white"}]
execute if score SATELITE_INTENTOS serie matches 7.. run tellraw @s [{"text":"  En orbita.","color":"green"}]
