# Cuantas cargas quedan, si hay una armada y cuanto falta.
# Uso: /function swr:serie/medusa/estado
tellraw @s [{"text":"[Medusa] ","color":"light_purple","bold":true},{"text":"Cargas: ","color":"gray"},{"score":{"name":"MEDUSA_CARGA","objective":"swr"},"color":"white"},{"text":"   |   Radio: ","color":"gray"},{"score":{"name":"MEDUSA_R","objective":"swr"},"color":"white"},{"text":"   |   Cuenta atras: ","color":"gray"},{"score":{"name":"MEDUSA_T","objective":"swr"},"color":"white"},{"text":" s","color":"gray"}]
