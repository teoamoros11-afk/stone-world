# Por donde va el epilogo y cual es el siguiente paso.
# TERRAFORM: 0 sin empezar, 2 naufragio hecho, 3 balsa, 4 rayo, 5 silicio (epilogo completo).
# Uso: /function swr:serie/terraforming/estado
scoreboard players add TERRAFORM swr 0
tellraw @s [{"text":"[TERRAFORMING] ","color":"aqua","bold":true},{"text":"Epilogo: cuatro escenas despues del final (pide la era 5 cerrada)","color":"white"}]
execute if score TERRAFORM swr matches 0 run tellraw @s [{"text":" Sin empezar. ","color":"gray"},{"text":"/function swr:serie/terraforming/iniciar","color":"white"}]
execute if score TERRAFORM swr matches 1 run tellraw @s [{"text":" Abierto, sin escenas. Toca: ","color":"gray"},{"text":"/function swr:serie/terraforming/naufragio","color":"white"}]
execute if score TERRAFORM swr matches 2 run tellraw @s [{"text":" 1 de 4: el naufragio. Toca: ","color":"gray"},{"text":"/function swr:serie/terraforming/balsa","color":"white"}]
execute if score TERRAFORM swr matches 3 run tellraw @s [{"text":" 2 de 4: la balsa. Toca: ","color":"gray"},{"text":"/function swr:serie/terraforming/nitrico","color":"white"}]
execute if score TERRAFORM swr matches 4 run tellraw @s [{"text":" 3 de 4: el rayo. Toca: ","color":"gray"},{"text":"/function swr:serie/terraforming/silicio","color":"white"}]
execute if score TERRAFORM swr matches 5.. run tellraw @s [{"text":" Las 4 escenas hechas: epilogo completo. Para volver a verlo, /scoreboard players set TERRAFORM swr 1 y sigue desde naufragio.","color":"green"}]
