# A23 - Fotos del equipo y del pasado (T4, ep. 85). Un papel y el catalejo como camara.
# El retrato dibujado seria tramo B; aqui la foto es un objeto con su fecha.
# Uso: /function swr:serie/fotos/revelar
execute unless items entity @s container.* minecraft:paper run return run tellraw @s [{"text":"[Fotos] ","color":"gold","bold":true},{"text":"Hace falta un papel.","color":"red"}]
execute unless items entity @s container.* minecraft:spyglass run return run tellraw @s [{"text":"[Fotos] ","color":"gold","bold":true},{"text":"Hace falta el catalejo (la camara).","color":"red"}]
clear @s minecraft:paper 1
scoreboard players add FOTOS serie 1
give @s minecraft:paper[minecraft:custom_name='{"text":"Foto del equipo","color":"gold","italic":false}',minecraft:lore=['{"text":"Reino de la Ciencia - dia de la aldea","color":"gray","italic":true}']] 1
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.5 1.8
tellraw @s [{"text":"[Fotos] ","color":"gold","bold":true},{"text":"Foto revelada. Tiradas: ","color":"gray"},{"score":{"name":"FOTOS","objective":"serie"},"color":"white"},{"text":". /function swr:serie/fotos/montar la cuelga donde estas.","color":"gray"}]
