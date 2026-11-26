# A17 - Te has pasado de 21: la mano se cierra sin pagar.
title @s title [{"text":"TE PASASTE","color":"red","bold":true}]
tellraw @s [{"text":"[Casino] ","color":"red","bold":true},{"text":"Mas de 21. La banca se queda las cinco fichas.","color":"gray"}]
scoreboard players set CASINO_ACTIVO serie 0
