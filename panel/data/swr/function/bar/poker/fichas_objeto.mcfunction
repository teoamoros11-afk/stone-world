# B2 - Las cinco fichas con su color, como piezas de la mesa.
# Las fichas del juego siguen siendo el marcador «fichas»; estas son las que se ven.
# Uso: /function swr:bar/poker/fichas_objeto
give @s minecraft:gold_nugget[minecraft:custom_name='{"text":"Ficha de 1","color":"white","italic":false}',minecraft:custom_model_data=7211]
give @s minecraft:gold_nugget[minecraft:custom_name='{"text":"Ficha de 5","color":"red","italic":false}',minecraft:custom_model_data=7212]
give @s minecraft:gold_nugget[minecraft:custom_name='{"text":"Ficha de 10","color":"blue","italic":false}',minecraft:custom_model_data=7213]
give @s minecraft:gold_nugget[minecraft:custom_name='{"text":"Ficha de 25","color":"green","italic":false}',minecraft:custom_model_data=7214]
give @s minecraft:gold_nugget[minecraft:custom_name='{"text":"Ficha de 100","color":"gold","italic":false}',minecraft:custom_model_data=7215]
tellraw @s [{"text":"[Poker] ","color":"gold","bold":true},{"text":"Cinco fichas de muestra: 1, 5, 10, 25 y 100. Para jugar sigue mandando el marcador de fichas.","color":"gray"}]
