# A20 - Respuesta incorrecta: no suma y pasa a la siguiente.
scoreboard players add EXAMEN_PREG serie 1
playsound minecraft:entity.villager.no master @s ~ ~ ~ 0.7 0.9
tellraw @s [{"text":"[Escuela] ","color":"red","bold":true},{"text":"No. Sigue: un fallo no cierra el examen, pero no cuenta.","color":"gray"}]
execute if score EXAMEN_PREG serie matches 4.. run function swr:serie/escuela/cerrar
execute if score EXAMEN_PREG serie matches ..3 run function swr:serie/escuela/pregunta
