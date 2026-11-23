# Vuelve a poner los diez bolos de pie (y quita la bola de la tirada anterior).
# Uso: /function swr:bar/bolos/reset
kill @e[tag=swr_bola]
kill @e[tag=swr_bolo]
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:armor_stand ~-1.5 ~ ~10.5 {Tags:["swr_bolo"],NoGravity:1b,Invulnerable:1b,Small:1b,ShowArms:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}],Rotation:[0f,0f]}
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:armor_stand ~-0.5 ~ ~10.5 {Tags:["swr_bolo"],NoGravity:1b,Invulnerable:1b,Small:1b,ShowArms:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}],Rotation:[0f,0f]}
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:armor_stand ~0.5 ~ ~10.5 {Tags:["swr_bolo"],NoGravity:1b,Invulnerable:1b,Small:1b,ShowArms:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}],Rotation:[0f,0f]}
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:armor_stand ~1.5 ~ ~10.5 {Tags:["swr_bolo"],NoGravity:1b,Invulnerable:1b,Small:1b,ShowArms:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}],Rotation:[0f,0f]}
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:armor_stand ~-1.0 ~ ~9.5 {Tags:["swr_bolo"],NoGravity:1b,Invulnerable:1b,Small:1b,ShowArms:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}],Rotation:[0f,0f]}
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:armor_stand ~0.0 ~ ~9.5 {Tags:["swr_bolo"],NoGravity:1b,Invulnerable:1b,Small:1b,ShowArms:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}],Rotation:[0f,0f]}
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:armor_stand ~1.0 ~ ~9.5 {Tags:["swr_bolo"],NoGravity:1b,Invulnerable:1b,Small:1b,ShowArms:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}],Rotation:[0f,0f]}
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:armor_stand ~-0.5 ~ ~8.5 {Tags:["swr_bolo"],NoGravity:1b,Invulnerable:1b,Small:1b,ShowArms:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}],Rotation:[0f,0f]}
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:armor_stand ~0.5 ~ ~8.5 {Tags:["swr_bolo"],NoGravity:1b,Invulnerable:1b,Small:1b,ShowArms:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}],Rotation:[0f,0f]}
execute at @e[tag=swr_bolos_origen,limit=1] run summon minecraft:armor_stand ~0.0 ~ ~7.5 {Tags:["swr_bolo"],NoGravity:1b,Invulnerable:1b,Small:1b,ShowArms:0b,ArmorItems:[{},{},{},{id:"minecraft:carved_pumpkin",count:1}],Rotation:[0f,0f]}
scoreboard players set BOLOS_TIRADOS swr 0
