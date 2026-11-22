# Escena 1/4: Senku despierta solo en mitad del oceano, untado de aceite y con un auricular
# de cristal en el bolsillo. La baliza del chaleco de Kohaku es lo unico que suena.
# Uso: automatico desde swr:serie/terraforming/iniciar (o a mano, en orden)
execute unless score TERRAFORM swr matches 1 run return run tellraw @s [{"text":"[TERRAFORMING] ","color":"aqua","bold":true},{"text":"Esta escena va despues de iniciar: /function swr:serie/terraforming/iniciar","color":"red"}]
scoreboard players set TERRAFORM swr 2
title @a times 10 60 20
title @a subtitle [{"text":"Sin tierra, sin barco y sin recordar como ha llegado hasta aqui.","color":"gray"}]
title @a title [{"text":"TERRAFORMING","color":"aqua","bold":true}]
playsound minecraft:entity.generic.splash master @a ~ ~ ~ 0.8 0.9
playsound minecraft:ambient.underwater.enter master @a ~ ~ ~ 1 0.8
particle minecraft:bubble ~ ~1 ~ 2 1 2 0.02 40 normal
particle minecraft:splash ~ ~ ~ 3 0.3 3 0.02 30 normal
give @s minecraft:glass_bottle[minecraft:custom_name='{"text":"Fluido que lo desperto","color":"aqua","italic":false}']
tellraw @a [{"text":"[Escena 1] ","color":"aqua","bold":true},{"text":"El aceite con el que se cubrio es un aislante termico: le da tiempo antes de la hipotermia. Con el auricular de cristal oye una baliza y encuentra a Kohaku petrificada.","color":"gray"}]
tellraw @a [{"text":" Siguiente: ","color":"dark_gray"},{"text":"/function swr:serie/terraforming/balsa","color":"white"}]
