# 6 - Agua del barril: gratis: el agua del marco no se acaba.
# Uso: /function swr:bar/pedir/6


give @s minecraft:potion[minecraft:potion_contents={potion:"minecraft:water"}] 1
tellraw @s [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Agua del barril, de la cocina de Francois.","color":"green"}]
