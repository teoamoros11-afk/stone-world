# A8 - El torneo Grand Bout (T1, ep. 20-24).
# Tres pruebas (sumo, tiro y carrera) y gana el primero que llega a tres puntos.
# Uso: /function swr:serie/bout/iniciar
scoreboard players set @a bout 0
scoreboard players set BOUT_RONDA serie 1
scoreboard players set BOUT_ACTIVO serie 1
title @a title [{"text":"GRAND BOUT","color":"gold","bold":true}]
title @a subtitle [{"text":"Tres pruebas. Primero a tres puntos.","color":"yellow"}]
tellraw @a [{"text":"[Grand Bout] ","color":"gold","bold":true},{"text":"Reglas de la aldea: nada de armas letales. Se gana con empuje, punteria y piernas. Un punto por prueba ganada.","color":"gray"}]
function swr:serie/bout/prueba
