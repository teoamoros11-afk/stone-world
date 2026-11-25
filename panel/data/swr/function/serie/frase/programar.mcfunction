# A33 - «Quieres morir?» por radio (T4, ep. 82). Una vez al dia, con voz y ruido.
# Uso: /function swr:serie/frase/programar
scoreboard players set FRASE_ACTIVA serie 1
schedule function swr:serie/frase/ciclo 24000t replace
tellraw @a [{"text":"[Radio] ","color":"dark_purple","bold":true},{"text":"La frecuencia queda abierta. Una vez al dia, la voz de la medusa.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Oirla ahora","color":"dark_purple","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/frase/decir"},"hoverEvent":{"action":"show_text","value":"La frase completa, sin esperar al dia"}}]
