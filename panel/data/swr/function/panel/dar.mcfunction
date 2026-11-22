# Da el Panel del pueblo al jugador que lo ejecuta (una brújula de recuperación con nombre).
# Se abre pulsando la tecla del hueco que ocupa en la barra rapida (1..9), o llevando el libro de
# instrucciones en la mano; no hace falta comando.
give @s minecraft:recovery_compass[minecraft:custom_name='{"text":"Panel del pueblo","italic":false,"color":"gold"}',minecraft:lore=['{"text":"Pulsa la tecla de su hueco, o lleva el libro en la mano.","color":"gray","italic":true}','{"text":"Ensena todo lo que hace el pueblo y su progreso.","color":"gray","italic":true}']] 1
tellraw @s [{"text":"[Panel] ","color":"gold","bold":true},{"text":"Toma el ","color":"white"},{"text":"Panel del pueblo","color":"gold","bold":true},{"text":". Ponlo en la barra rapida y pulsa su tecla (1..9), o lleva el libro de instrucciones en la mano, para ver el estado; si lo pierdes: /function swr:panel/dar","color":"white"}]
# la primera vez llega tambien el libro de instrucciones, y solo la primera
execute unless entity @s[tag=swr_guia_panel] run function swr:panel/guia
