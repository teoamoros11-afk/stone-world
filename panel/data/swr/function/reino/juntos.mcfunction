# ¿Estan los dos jugadores conectados y cerca? Deja JUGADORES y CERCA listos para el candado de eras.
# Uso: lo llaman las eras, y a mano /function swr:reino/juntos
scoreboard players set JUGADORES swr 0
scoreboard players set CERCA swr 0
execute as @a run scoreboard players add JUGADORES swr 1
execute as @a at @s if entity @a[distance=0.5..80] run scoreboard players set CERCA swr 1
execute if score JUGADORES swr matches 0 run tellraw @a [{"text":"[Juntos] ","color":"gold","bold":true},{"text":"No hay nadie conectado: la era no se puede abrir desde la consola.","color":"red"}]
execute if score JUGADORES swr matches 1 run tellraw @a [{"text":"[Juntos] ","color":"gold","bold":true},{"text":"Falta uno. El reino avanza de dos en dos: que entre el otro jugador.","color":"red"}]
execute if score JUGADORES swr matches 2.. unless score CERCA swr matches 1 run tellraw @a [{"text":"[Juntos] ","color":"gold","bold":true},{"text":"Estais los dos, pero lejos. Acercaos (menos de 80 bloques) para cerrar la etapa juntos.","color":"red"}]
