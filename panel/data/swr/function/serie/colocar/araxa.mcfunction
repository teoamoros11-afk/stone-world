# Coloca el plano Araxa donde estas. La esquina (0,0,0) del plano cae a tus pies.
# Temporada 4: santuario amurallado con la torre de la medusa.
# Uso: /function swr:serie/colocar/araxa
execute at @s run place template swr:araxa ~ ~ ~
tellraw @a [{"text":"[Serie] ","color":"gold","bold":true},{"text":"Araxa colocado.","color":"gray"}]
