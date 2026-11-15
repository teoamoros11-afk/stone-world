# Carga inicial del panel. Objetivo swr = panel de la barra lateral.
scoreboard objectives add swr dummy {"text":"Reino de la Ciencia"}
scoreboard objectives add aldeas dummy {"text":"Aldeas registradas"}
scoreboard players set ERA swr 1
scoreboard players set CIUDADANOS swr 0
scoreboard players set ALDEANOS swr 0
scoreboard players set ALDEA swr 0
scoreboard players set TICK swr 0
scoreboard objectives setdisplay sidebar swr
tellraw @a [{"text":"[Stone World] ","color":"gold","bold":true},{"text":"Panel activo. Parte: /function swr:panel/informe | Viajes: /function swr:viaje/aldea (cueva, estatuas, cascada, puerto, bambu, rival, spawn)","color":"gray"}]
