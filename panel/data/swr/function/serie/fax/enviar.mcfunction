# A14 - El fax (T4, ep. 73, 85): manda el mapa que llevas dibujado a otro jugador.
# Copia el objeto tal cual con item replace ... from entity, asi que el mapa llega
# con su dibujo, no con una hoja en blanco. Gasta un papel.
# Uso: /function swr:serie/fax/enviar
execute unless items entity @s weapon.mainhand minecraft:filled_map run return run tellraw @s [{"text":"[Fax] ","color":"gold","bold":true},{"text":"Lleva el mapa lleno en la mano principal.","color":"red"}]
execute unless items entity @s container.* minecraft:paper run return run tellraw @s [{"text":"[Fax] ","color":"gold","bold":true},{"text":"Hace falta un papel para la copia.","color":"red"}]
tag @s add swr_fax
scoreboard players set FAX_N serie 0
execute as @a[distance=..64,tag=!swr_fax] run scoreboard players add FAX_N serie 1
execute if score FAX_N serie matches 0 run tag @s remove swr_fax
execute if score FAX_N serie matches 0 run return run tellraw @s [{"text":"[Fax] ","color":"gold","bold":true},{"text":"No hay nadie al alcance del fax (64 bloques).","color":"red"}]
clear @s minecraft:paper 1
execute as @a[distance=..64,tag=!swr_fax,sort=nearest,limit=1] run item replace entity @s weapon.mainhand from entity @e[tag=swr_fax,limit=1] weapon.mainhand
scoreboard players add FAX_ENVIADOS serie 1
playsound minecraft:block.beacon.activate master @a ~ ~ ~ 0.5 1.2
tellraw @s [{"text":"[Fax] ","color":"gold","bold":true},{"text":"Mapa enviado. Papel gastado: queda la copia exacta en la mano del otro.","color":"gray"}]
tag @s remove swr_fax
