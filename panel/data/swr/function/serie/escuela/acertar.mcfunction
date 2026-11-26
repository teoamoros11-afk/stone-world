# A20 - Respuesta correcta: un punto y siguiente pregunta.
scoreboard players add EXAMEN_ACIERTOS serie 1
scoreboard players add EXAMEN_PREG serie 1
playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 0.7 1.4
tellraw @s [{"text":"[Escuela] ","color":"green","bold":true},{"text":"Correcto. Aciertos: ","color":"gray"},{"score":{"name":"EXAMEN_ACIERTOS","objective":"serie"},"color":"white"},{"text":" de 3.","color":"gray"}]
execute if score EXAMEN_ACIERTOS serie matches 3.. run function swr:serie/escuela/aprobar
execute if score EXAMEN_ACIERTOS serie matches ..2 run function swr:serie/escuela/pregunta
