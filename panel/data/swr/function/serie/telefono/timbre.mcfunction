# A13 - Suena en el telefono de quien recibe. Se ejecuta COMO el receptor.
title @s title [{"text":"TE LLAMAN","color":"aqua","bold":true}]
title @s subtitle [{"text":"Telefono del reino","color":"gray"}]
playsound minecraft:block.note_block.bell master @s ~ ~ ~ 1 1.6
tellraw @s [{"text":"[Telefono] ","color":"aqua","bold":true},{"text":"Alguien te llama desde cerca. Contesta hablando: no hay boton de descolgar.","color":"gray"}]
