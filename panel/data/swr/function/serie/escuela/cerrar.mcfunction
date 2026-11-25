# A20 - Se acaban las preguntas sin tres aciertos.
scoreboard players set EXAMEN_ACTIVO serie 0
title @s title [{"text":"SUSPENSO","color":"red","bold":true}]
tellraw @s [{"text":"[Escuela] ","color":"red","bold":true},{"text":"Se acabaron las preguntas. /function swr:serie/escuela/pregunta para repetir.","color":"gray"}]
