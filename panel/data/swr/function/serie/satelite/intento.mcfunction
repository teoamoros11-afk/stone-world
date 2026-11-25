# A35 - El satelite Senku-1 y sus siete intentos (T4, ep. 89).
# Los seis primeros fallan por una causa distinta; el septimo llega a orbita.
# Uso: /function swr:serie/satelite/intento
execute if score SATELITE_INTENTOS serie matches 7.. run return run tellraw @s [{"text":"[Senku-1] ","color":"aqua","bold":true},{"text":"Ya esta en orbita. /function swr:serie/satelite/estado","color":"red"}]
scoreboard players add SATELITE_INTENTOS serie 1
execute if score SATELITE_INTENTOS serie matches 7 run scoreboard players set SATELITE_FALLO serie 0
execute if score SATELITE_INTENTOS serie matches ..6 run execute store result score SATELITE_FALLO serie run random value 1..6
execute if score SATELITE_FALLO serie matches 1 run tellraw @a [{"text":"[Senku-1] ","color":"aqua","bold":true},{"text":"Intento ","color":"gray"},{"score":{"name":"SATELITE_INTENTOS","objective":"serie"},"color":"white"},{"text":": fallo la tobera. El propergol se quemo antes de tiempo.","color":"red"}]
execute if score SATELITE_FALLO serie matches 2 run tellraw @a [{"text":"[Senku-1] ","color":"aqua","bold":true},{"text":"Intento ","color":"gray"},{"score":{"name":"SATELITE_INTENTOS","objective":"serie"},"color":"white"},{"text":": fallo el guiado. El cohete se fue de lado.","color":"red"}]
execute if score SATELITE_FALLO serie matches 3 run tellraw @a [{"text":"[Senku-1] ","color":"aqua","bold":true},{"text":"Intento ","color":"gray"},{"score":{"name":"SATELITE_INTENTOS","objective":"serie"},"color":"white"},{"text":": fallo la etapa. No se separo a tiempo.","color":"red"}]
execute if score SATELITE_FALLO serie matches 4 run tellraw @a [{"text":"[Senku-1] ","color":"aqua","bold":true},{"text":"Intento ","color":"gray"},{"score":{"name":"SATELITE_INTENTOS","objective":"serie"},"color":"white"},{"text":": fallo la telemetria. Sin datos no hay correccion.","color":"red"}]
execute if score SATELITE_FALLO serie matches 5 run tellraw @a [{"text":"[Senku-1] ","color":"aqua","bold":true},{"text":"Intento ","color":"gray"},{"score":{"name":"SATELITE_INTENTOS","objective":"serie"},"color":"white"},{"text":": fallo el encendido. Un segundo de retraso y no despega.","color":"red"}]
execute if score SATELITE_FALLO serie matches 6 run tellraw @a [{"text":"[Senku-1] ","color":"aqua","bold":true},{"text":"Intento ","color":"gray"},{"score":{"name":"SATELITE_INTENTOS","objective":"serie"},"color":"white"},{"text":": fallo la estructura. El cohete se partio en la torre.","color":"red"}]
execute if score SATELITE_INTENTOS serie matches 7 run title @a title [{"text":"EN ORBITA","color":"aqua","bold":true}]
execute if score SATELITE_INTENTOS serie matches 7 run tellraw @a [{"text":"[Senku-1] ","color":"aqua","bold":true},{"text":"Septimo intento: orbita baja. La voz de la aldea ya puede cruzar el mundo.","color":"gray"}]
playsound minecraft:entity.firework_rocket.launch master @a ~ ~ ~ 0.8 1
