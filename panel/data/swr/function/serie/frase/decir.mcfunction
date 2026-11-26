# A33 - La frase de la medusa, por la radio del reino.
# Uso: /function swr:serie/frase/decir
playsound minecraft:block.note_block.bit master @a ~ ~ ~ 0.4 0.6
playsound minecraft:entity.wither.spawn master @a ~ ~ ~ 0.25 1.6
title @a title [{"text":"Quieres morir?","color":"dark_purple","bold":true,"italic":true}]
title @a subtitle [{"text":"La voz de la medusa","color":"gray"}]
tellraw @a [{"text":"[Radio] ","color":"dark_purple","bold":true},{"text":"La frecuencia esta abierta. En la serie, la medusa no era un arma: era una voz que convencia a un pueblo entero.","color":"gray","italic":true}]
