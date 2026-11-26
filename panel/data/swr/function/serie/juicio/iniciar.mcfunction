# A9 - El juicio de Magma (T1, ep. 22). La aldea vota que hacer con el que ataco.
# Uso: /function swr:serie/juicio/iniciar
scoreboard players set JUICIO_SI serie 0
scoreboard players set JUICIO_NO serie 0
tag @a remove swr_voto_juicio
title @a title [{"text":"JUICIO","color":"red","bold":true}]
tellraw @a [{"text":"[Juicio] ","color":"red","bold":true},{"text":"Magma ha atacado la aldea. Se vota una vez por cabeza: desterrarlo o perdonarlo.","color":"gray"}]
tellraw @a [{"text":" • ","color":"gray"},{"text":"Desterrar","color":"red","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/juicio/si"},"hoverEvent":{"action":"show_text","value":"Un voto para desterrarlo"}},{"text":"   • ","color":"gray"},{"text":"Perdonar","color":"green","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/juicio/no"},"hoverEvent":{"action":"show_text","value":"Un voto para perdonarlo"}},{"text":"   • ","color":"gray"},{"text":"Cerrar","color":"gold","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/juicio/resolver"},"hoverEvent":{"action":"show_text","value":"Cuenta los votos y dicta sentencia"}}]
