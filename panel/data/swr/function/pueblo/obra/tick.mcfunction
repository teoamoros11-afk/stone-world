# Reloj de la obra: un tic por segundo (reprogramado desde load si el servidor se reinicia).
execute if score OBRA swr matches ..0 run return fail
scoreboard players remove OBRA swr 1
title @a actionbar [{"text":"Obra del pueblo: ","color":"gold"},{"text":"quedan ","color":"gray"},{"score":{"name":"OBRA","objective":"swr"},"color":"white"},{"text":" s","color":"gray"}]
execute if score OBRA swr matches 42 run function swr:pueblo/obra/materiales
execute if score OBRA swr matches 36 run function swr:pueblo/obra/cimientos
execute if score OBRA swr matches 32 run function swr:pueblo/obra/muro0
execute if score OBRA swr matches 29 run function swr:pueblo/obra/muro1
execute if score OBRA swr matches 26 run function swr:pueblo/obra/muro2
execute if score OBRA swr matches 23 run function swr:pueblo/obra/muro3
execute if score OBRA swr matches 17 run function swr:pueblo/obra/techo
execute if score OBRA swr matches 11 run function swr:pueblo/obra/puerta
execute if score OBRA swr matches 5 run function swr:pueblo/obra/detalles
execute if score OBRA swr matches 0 run function swr:pueblo/obra/fin
execute if score OBRA swr matches 1.. run schedule function swr:pueblo/obra/tick 20t replace
