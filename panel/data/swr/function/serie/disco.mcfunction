# El disco de Lilian: la cancion grabada que atraviesa generaciones (cap. 101-140, B.18).
# El disco lo registra el mod Stone Musica (swrmusica:disco_lilian) con el componente
# jukebox_playable por defecto; aqui solo se entrega. Sin ese mod, el disco no existe.
# Uso: /function swr:serie/disco
give @s swrmusica:disco_lilian
tellraw @s [{"text":"[Disco] ","color":"gold","bold":true},{"text":"Lilian no dejo un discurso: dejo diez segundos de cancion. Pon el disco en un tocadiscos y suena.","color":"gray"}]
