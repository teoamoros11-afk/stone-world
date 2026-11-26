# A4 - Arranque desnudo y sin memoria (T1, ep. 1).
# Deja el punto de aparicion aqui, vacia el inventario y pone el contador de dias a cero.
# Uso: /function swr:serie/arranque/iniciar
spawnpoint @s ~ ~ ~
clear @s
effect clear @s
scoreboard players set DIAS serie 0
scoreboard players set ARRANQUE serie 1
schedule function swr:serie/arranque/dia 24000t replace
function swr:panel/guia
tellraw @a [{"text":"[Arranque] ","color":"gold","bold":true},{"text":"Sin inventario, sin memoria y con el cuaderno en la mano. El punto de aparicion queda aqui y cada dia que pasa se cuenta.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Dias","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/arranque/estado"},"hoverEvent":{"action":"show_text","value":"Cuantos dias llevas despierto"}}]
