# A8 - Anuncia la prueba que toca segun la ronda.
execute unless score BOUT_ACTIVO serie matches 1 run return 0
execute if score BOUT_RONDA serie matches 1 run title @a title [{"text":"PRUEBA 1: SUMO","color":"gold","bold":true}]
execute if score BOUT_RONDA serie matches 1 run tellraw @a [{"text":"[Grand Bout] ","color":"gold","bold":true},{"text":"Sumo: saca al rival del circulo sin armas. El primero que lo consiga pulsa /function swr:serie/bout/punto.","color":"gray"}]
execute if score BOUT_RONDA serie matches 2 run title @a title [{"text":"PRUEBA 2: TIRO","color":"gold","bold":true}]
execute if score BOUT_RONDA serie matches 2 run tellraw @a [{"text":"[Grand Bout] ","color":"gold","bold":true},{"text":"Tiro con arco a la diana. Quien clave la flecha mas cerca del centro se lleva el punto.","color":"gray"}]
execute if score BOUT_RONDA serie matches 3 run title @a title [{"text":"PRUEBA 3: CARRERA","color":"gold","bold":true}]
execute if score BOUT_RONDA serie matches 3 run tellraw @a [{"text":"[Grand Bout] ","color":"gold","bold":true},{"text":"Carrera de la plaza a la puerta norte. Sin monturas ni pociones.","color":"gray"}]
