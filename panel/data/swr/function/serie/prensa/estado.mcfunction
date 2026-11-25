# A15 - Cuantas tiradas lleva la imprenta.
# Uso: /function swr:serie/prensa/estado
tellraw @s [{"text":"[Prensa] ","color":"gold","bold":true},{"text":"Tiradas: ","color":"gray"},{"score":{"name":"PRENSA_TIRADA","objective":"serie"},"color":"white"},{"text":". Cada tirada gasta tres papeles y un tinte.","color":"gray"}]
