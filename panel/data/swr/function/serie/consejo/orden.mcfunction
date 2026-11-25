# A11 - Orden del consejo. Cicla entre tres planes y arranca sesenta segundos.
# Uso: /function swr:serie/consejo/orden
scoreboard players add CONSEJO_ORDEN serie 1
execute if score CONSEJO_ORDEN serie matches 4.. run scoreboard players set CONSEJO_ORDEN serie 1
scoreboard players set CONSEJO_T serie 60
schedule function swr:serie/consejo/cuenta 20t replace
execute if score CONSEJO_ORDEN serie matches 1 run tellraw @a [{"text":"[Consejo] ","color":"gold","bold":true},{"text":"Orden 1: cerrar el puerto. Nadie entra ni sale hasta que acabe la cuenta.","color":"yellow"}]
execute if score CONSEJO_ORDEN serie matches 2 run tellraw @a [{"text":"[Consejo] ","color":"gold","bold":true},{"text":"Orden 2: cortar el suministro. La aldea aguanta con lo que hay en la despensa.","color":"yellow"}]
execute if score CONSEJO_ORDEN serie matches 3 run tellraw @a [{"text":"[Consejo] ","color":"gold","bold":true},{"text":"Orden 3: tomar la torre. La medusa cambia de manos antes de que anochezca.","color":"yellow"}]
title @a actionbar [{"text":"Consejo: 60 s","color":"gold"}]
