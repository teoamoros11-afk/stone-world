# Tumba el bolo que pilla la bola (uno por paso, el mas cercano).
# Uso: interno, desde bolos/check
execute if entity @e[tag=swr_bolo,tag=!swr_bolo_caido,distance=..1.5] run scoreboard players add BOLOS_TIRADOS swr 1
tag @e[tag=swr_bolo,tag=!swr_bolo_caido,distance=..1.5,limit=1,sort=nearest] add swr_bolo_caido
execute as @e[tag=swr_bolo,tag=swr_bolo_caido,tag=!swr_bolo_tumbado] run data merge entity @s {Rotation:[0f,90f],Pose:{Head:[85f,0f,0f]}}
execute as @e[tag=swr_bolo,tag=swr_bolo_caido,tag=!swr_bolo_tumbado] run tag @s add swr_bolo_tumbado
execute as @e[tag=swr_bolo,tag=swr_bolo_caido,tag=swr_bolo_tumbado] run playsound minecraft:entity.arrow.hit_player block @a ~ ~ ~ 0.8 1.5
