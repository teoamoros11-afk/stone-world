# A10 - Eleccion de la aldea (T1, ep. 9-24). Ruri o Kokuyo, un voto por jugador.
# Uso: /function swr:serie/politica/eleccion
scoreboard players set VOTOS_RURI serie 0
scoreboard players set VOTOS_KOKUYO serie 0
tag @a remove swr_voto_politica
tellraw @a [{"text":"[Politica] ","color":"gold","bold":true},{"text":"La aldea elige quien manda. Un voto por cabeza.","color":"gray"}]
tellraw @a [{"text":" • ","color":"gray"},{"text":"Ruri","color":"light_purple","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/politica/votar/ruri"},"hoverEvent":{"action":"show_text","value":"Votar a Ruri, la que recita las cien historias"}},{"text":"   • ","color":"gray"},{"text":"Kokuyo","color":"gold","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/politica/votar/kokuyo"},"hoverEvent":{"action":"show_text","value":"Votar a Kokuyo, el jefe que ya estaba"}},{"text":"   • ","color":"gray"},{"text":"Cerrar","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/politica/resolver"},"hoverEvent":{"action":"show_text","value":"Cuenta los votos y proclama al gobierno"}}]
