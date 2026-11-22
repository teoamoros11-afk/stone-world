# Cada despetrificado se levanta su casa en un solar de la plaza.
# Se ejecuta COMO el vecino. El solar sale de CASAS mod 16: 4 rumbos en 4 anillos.
# Uso: automatico desde swr:pueblo/despetrificar_uno, swr:pueblo/fundar y swr:pueblo/casa/fin
execute unless entity @e[tag=swr_plaza,limit=1] run return fail
execute if entity @s[tag=swr_dueno] run return fail
execute if entity @s[tag=swr_casa_hecha] run return fail
execute if score OBRA swr matches 1.. run return fail
execute if score CASAS swr matches 16.. run tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"No quedan solares: la plaza admite 16 casas.","color":"red"}]
execute if score CASAS swr matches 16.. run return fail
# si ya hay una tanda en marcha, este vecino espera a la siguiente
execute if score CASA_T swr matches 1.. run return fail
scoreboard players add CASAS swr 1
scoreboard players operation SOLAR swr = CASAS swr
scoreboard players remove SOLAR swr 1
scoreboard players operation SOLAR swr %= DIECISEIS swr
scoreboard players add SOLAR swr 1
scoreboard players operation DIR swr = SOLAR swr
scoreboard players remove DIR swr 1
scoreboard players operation DIR swr %= CUATRO swr
tag @s add swr_dueno_tmp
execute if score SOLAR swr matches 1 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~10 ~ ~0 {Tags:["swr_casa","swr_casa_nueva","swr_dir_0","swr_solar_1"]}
execute if score SOLAR swr matches 2 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~0 ~ ~10 {Tags:["swr_casa","swr_casa_nueva","swr_dir_1","swr_solar_2"]}
execute if score SOLAR swr matches 3 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~-10 ~ ~0 {Tags:["swr_casa","swr_casa_nueva","swr_dir_2","swr_solar_3"]}
execute if score SOLAR swr matches 4 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~0 ~ ~-10 {Tags:["swr_casa","swr_casa_nueva","swr_dir_3","swr_solar_4"]}
execute if score SOLAR swr matches 5 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~20 ~ ~0 {Tags:["swr_casa","swr_casa_nueva","swr_dir_0","swr_solar_5"]}
execute if score SOLAR swr matches 6 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~0 ~ ~20 {Tags:["swr_casa","swr_casa_nueva","swr_dir_1","swr_solar_6"]}
execute if score SOLAR swr matches 7 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~-20 ~ ~0 {Tags:["swr_casa","swr_casa_nueva","swr_dir_2","swr_solar_7"]}
execute if score SOLAR swr matches 8 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~0 ~ ~-20 {Tags:["swr_casa","swr_casa_nueva","swr_dir_3","swr_solar_8"]}
execute if score SOLAR swr matches 9 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~30 ~ ~0 {Tags:["swr_casa","swr_casa_nueva","swr_dir_0","swr_solar_9"]}
execute if score SOLAR swr matches 10 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~0 ~ ~30 {Tags:["swr_casa","swr_casa_nueva","swr_dir_1","swr_solar_10"]}
execute if score SOLAR swr matches 11 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~-30 ~ ~0 {Tags:["swr_casa","swr_casa_nueva","swr_dir_2","swr_solar_11"]}
execute if score SOLAR swr matches 12 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~0 ~ ~-30 {Tags:["swr_casa","swr_casa_nueva","swr_dir_3","swr_solar_12"]}
execute if score SOLAR swr matches 13 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~40 ~ ~0 {Tags:["swr_casa","swr_casa_nueva","swr_dir_0","swr_solar_13"]}
execute if score SOLAR swr matches 14 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~0 ~ ~40 {Tags:["swr_casa","swr_casa_nueva","swr_dir_1","swr_solar_14"]}
execute if score SOLAR swr matches 15 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~-40 ~ ~0 {Tags:["swr_casa","swr_casa_nueva","swr_dir_2","swr_solar_15"]}
execute if score SOLAR swr matches 16 at @e[tag=swr_plaza,limit=1] run summon minecraft:marker ~0 ~ ~-40 {Tags:["swr_casa","swr_casa_nueva","swr_dir_3","swr_solar_16"]}
execute if score SOLAR swr matches 1 run tag @s add swr_solar_1
execute if score SOLAR swr matches 2 run tag @s add swr_solar_2
execute if score SOLAR swr matches 3 run tag @s add swr_solar_3
execute if score SOLAR swr matches 4 run tag @s add swr_solar_4
execute if score SOLAR swr matches 5 run tag @s add swr_solar_5
execute if score SOLAR swr matches 6 run tag @s add swr_solar_6
execute if score SOLAR swr matches 7 run tag @s add swr_solar_7
execute if score SOLAR swr matches 8 run tag @s add swr_solar_8
execute if score SOLAR swr matches 9 run tag @s add swr_solar_9
execute if score SOLAR swr matches 10 run tag @s add swr_solar_10
execute if score SOLAR swr matches 11 run tag @s add swr_solar_11
execute if score SOLAR swr matches 12 run tag @s add swr_solar_12
execute if score SOLAR swr matches 13 run tag @s add swr_solar_13
execute if score SOLAR swr matches 14 run tag @s add swr_solar_14
execute if score SOLAR swr matches 15 run tag @s add swr_solar_15
execute if score SOLAR swr matches 16 run tag @s add swr_solar_16
# el texto flotante lleva el nombre del dueno y luego la barra de avance
execute as @e[tag=swr_casa_nueva,limit=1] at @s run summon minecraft:armor_stand ~ ~5 ~ {Tags:["swr_texto","swr_texto_nuevo"],Invisible:1b,Marker:1b,NoGravity:1b,CustomNameVisible:1b,CustomName:'{"text":"[----------]","color":"gray"}'}
execute as @e[tag=swr_texto_nuevo,limit=1] run data modify entity @s CustomName set from entity @e[tag=swr_dueno_tmp,limit=1] CustomName
tag @e[tag=swr_texto_nuevo] remove swr_texto_nuevo
tag @e[tag=swr_casa_nueva] remove swr_casa_nueva
# el dueno trabaja delante de su puerta, mirando a la casa
execute if score DIR swr matches 0 at @e[tag=swr_plaza,limit=1] run tp @e[tag=swr_dueno_tmp,limit=1] ~6 ~ ~0 facing entity @e[tag=swr_casa,sort=nearest,limit=1] feet
execute if score DIR swr matches 1 at @e[tag=swr_plaza,limit=1] run tp @e[tag=swr_dueno_tmp,limit=1] ~0 ~ ~6 facing entity @e[tag=swr_casa,sort=nearest,limit=1] feet
execute if score DIR swr matches 2 at @e[tag=swr_plaza,limit=1] run tp @e[tag=swr_dueno_tmp,limit=1] ~-6 ~ ~0 facing entity @e[tag=swr_casa,sort=nearest,limit=1] feet
execute if score DIR swr matches 3 at @e[tag=swr_plaza,limit=1] run tp @e[tag=swr_dueno_tmp,limit=1] ~0 ~ ~-6 facing entity @e[tag=swr_casa,sort=nearest,limit=1] feet
tag @e[tag=swr_dueno_tmp] remove swr_dueno_tmp
tag @s add swr_dueno
execute as @e[tag=swr_dueno] run data merge entity @s {NoAI:1b,PersistenceRequired:1b}
execute as @e[tag=swr_dueno] run item replace entity @s weapon.mainhand with minecraft:oak_planks 8
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"selector":"@s"},{"text":" se pone a levantar su casa: 30 segundos.","color":"green"}]
scoreboard players set CASA_T swr 30
schedule function swr:pueblo/casa/reloj 20t replace
