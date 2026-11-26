# B2 - Una mano de muestra con las cartas nuevas: cinco caras y el dorso.
# El poker de verdad reparte por chat; esto es para ver el arte de la baraja.
# Uso: /function swr:bar/poker/muestra
give @s minecraft:paper[minecraft:custom_name='{"text":"As de picas","color":"white","italic":false}',minecraft:custom_model_data=101]
give @s minecraft:paper[minecraft:custom_name='{"text":"Rey de corazones","color":"white","italic":false}',minecraft:custom_model_data=126]
give @s minecraft:paper[minecraft:custom_name='{"text":"Reina de diamantes","color":"white","italic":false}',minecraft:custom_model_data=138]
give @s minecraft:paper[minecraft:custom_name='{"text":"Jota de treboles","color":"white","italic":false}',minecraft:custom_model_data=150]
give @s minecraft:paper[minecraft:custom_name='{"text":"Diez de picas","color":"white","italic":false}',minecraft:custom_model_data=110]
give @s minecraft:paper[minecraft:custom_name='{"text":"Dorso de la baraja","color":"blue","italic":false}',minecraft:custom_model_data=100]
tellraw @s [{"text":"[Poker] ","color":"gold","bold":true},{"text":"Seis cartas de muestra. El dorso es la 100; las caras van de la 101 (as de picas) a la 152 (rey de treboles).","color":"gray"}]
