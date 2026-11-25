# A8 - Quien va ganando y en que prueba esta.
# Uso: /function swr:serie/bout/estado
tellraw @s [{"text":"[Grand Bout] ","color":"gold","bold":true},{"text":"Activo: ","color":"gray"},{"score":{"name":"BOUT_ACTIVO","objective":"serie"},"color":"white"},{"text":"   |   Prueba: ","color":"gray"},{"score":{"name":"BOUT_RONDA","objective":"serie"},"color":"white"}]
execute as @a run tellraw @s [{"text":"  ","color":"gray"},{"selector":"@s"},{"text":": ","color":"gray"},{"score":{"name":"@s","objective":"bout"},"color":"aqua"},{"text":" puntos","color":"gray"}]
