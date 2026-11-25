# A20 - Tres de tres: aprobado. Se cierra el examen y se entrega el titulo.
scoreboard players set EXAMEN_ACTIVO serie 0
title @s title [{"text":"APROBADO","color":"gold","bold":true}]
title @s subtitle [{"text":"Escuela de la aldea","color":"yellow"}]
give @s minecraft:paper[minecraft:custom_name='{"text":"Titulo de la escuela","color":"gold","italic":false}'] 1
playsound minecraft:ui.toast.challenge_complete master @a ~ ~ ~ 1 1
tellraw @a [{"text":"[Escuela] ","color":"gold","bold":true},{"selector":"@s"},{"text":" aprueba el examen. En la serie, la escuela no ensena obediencia: ensena a preguntar.","color":"gray"}]
