# Escena 3/4: el rayo. Con la lanza de Ginro de pararrayos sacan el acido nitrico que falta
# para el fluido, y con el vuelven todos los demas.
# Uso: automatico (o /function swr:serie/terraforming/nitrico)
execute unless score TERRAFORM swr matches 3 run return run tellraw @s [{"text":"[TERRAFORMING] ","color":"aqua","bold":true},{"text":"Antes toca la balsa: /function swr:serie/terraforming/balsa","color":"red"}]
scoreboard players set TERRAFORM swr 4
title @a times 10 50 20
title @a subtitle [{"text":"Un pararrayos de fortuna, una tormenta y el acido que faltaba.","color":"gray"}]
title @a title [{"text":"EL RAYO","color":"aqua","bold":true}]
playsound minecraft:entity.lightning_bolt.thunder master @a ~ ~ ~ 1 1
playsound minecraft:block.beacon.activate master @a ~ ~ ~ 0.6 1.4
particle minecraft:end_rod ~ ~1 ~ 2 2 2 0.05 40 normal
particle minecraft:crit ~ ~1 ~ 3 1 3 0.03 30 normal
give @s minecraft:lightning_rod
tellraw @a [{"text":"[Escena 3] ","color":"aqua","bold":true},{"text":"Con el acido nitrico vuelven Ukyo, Tsukasa, Ryusui, Gen, Taiju, Yuzuriha, Kinro, Ginro y los demas: de un naufragio sale una tripulacion.","color":"gray"}]
tellraw @a [{"text":" Lo que dice la ciencia: ","color":"dark_gray"},{"text":"el proceso es real (Birkeland-Eyde), pero necesita un arco electrico de miles de grados: con el fuego de San Telmo de una tormenta no sale. La serie lo cuenta como teatro.","color":"dark_gray"}]
tellraw @a [{"text":" Siguiente: ","color":"dark_gray"},{"text":"/function swr:serie/terraforming/silicio","color":"white"}]
