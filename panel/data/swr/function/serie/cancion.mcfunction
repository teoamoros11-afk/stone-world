# La cancion de Lilian: el disco que atraviesa generaciones (cap. 101-140).
# Suena la pieza original del pack de recursos (assets/swr/sounds/lilian.ogg).
# Uso: /function swr:serie/cancion  (hace falta el resource pack ReinoDeLaCiencia activo)
playsound swr:lilian master @a ~ ~ ~ 1 1
tellraw @a [{"text":"[Cancion] ","color":"gold","bold":true},{"text":"Lilian la grabo en un disco para que la memoria no dependiera de nadie. Esta es la pieza original del pack, no la de la serie: activa el resource pack ReinoDeLaCiencia para oirla.","color":"gray"}]
