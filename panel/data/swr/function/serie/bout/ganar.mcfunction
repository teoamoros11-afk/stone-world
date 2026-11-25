# A8 - Cierra el torneo y entrega el cinturon. Se ejecuta COMO el ganador.
title @a title [{"text":"GANADOR","color":"gold","bold":true}]
title @a subtitle [{"selector":"@s"},{"text":" del Grand Bout","color":"yellow"}]
give @s minecraft:gold_ingot[minecraft:custom_name='{"text":"Cinturon del Grand Bout","color":"gold","italic":false}'] 1
playsound minecraft:ui.toast.challenge_complete master @a ~ ~ ~ 1 1
tellraw @a [{"text":"[Grand Bout] ","color":"gold","bold":true},{"selector":"@s"},{"text":" gana el torneo de la aldea. En la serie, el Grand Bout no era solo una pelea: era la forma de elegir quien mandaba.","color":"gray"}]
scoreboard players set BOUT_ACTIVO serie 0
scoreboard players set BOUT_RONDA serie 0
