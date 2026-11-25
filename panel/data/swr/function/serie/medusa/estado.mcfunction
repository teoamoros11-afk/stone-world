# Cuantas cargas quedan, si hay una armada y cuanto falta.
# Uso: /function swr:serie/medusa/estado
tellraw @s [{"text":"[Medusa] ","color":"light_purple","bold":true},{"text":"Cargas: ","color":"gray"},{"score":{"name":"MEDUSA_CARGA","objective":"swr"},"color":"white"},{"text":"   |   Radio: ","color":"gray"},{"score":{"name":"MEDUSA_R","objective":"swr"},"color":"white"},{"text":"   |   Cuenta atras: ","color":"gray"},{"score":{"name":"MEDUSA_T","objective":"swr"},"color":"white"},{"text":" s","color":"gray"}]
execute if entity @e[tag=swr_medusa,limit=1] run tellraw @s [{"text":"Armada y contando. Desactivala con /function swr:serie/medusa/desactivar","color":"dark_purple"}]
execute unless entity @e[tag=swr_medusa,limit=1] run tellraw @s [{"text":"Sin armar. /function swr:serie/medusa/iniciar gasta una carga.","color":"gray"}]
