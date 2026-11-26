# B11 - Las piezas fisicas de la moneda: el denario y el billete.
# La cartera sigue siendo el marcador «moneda»; estos objetos son los que se ven en el mostrador.
# Uso: /function swr:serie/moneda/objetos
give @s minecraft:gold_nugget[minecraft:custom_name='{"text":"Denario","color":"gold","italic":false}',minecraft:custom_model_data=7201]
give @s minecraft:paper[minecraft:custom_name='{"text":"Billete de diez denarios","color":"dark_green","italic":false}',minecraft:custom_model_data=7301]
tellraw @s [{"text":"[Moneda] ","color":"gold","bold":true},{"text":"Un denario y un billete. La cartera sigue en el marcador; estas son las piezas que se ven en el mostrador.","color":"gray"}]
