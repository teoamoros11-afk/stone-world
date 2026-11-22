# Anota las formulas de la era 4 en el cuaderno (no borra lo ya anotado).
# Cada ficha es un marcador f_<id>: el progreso es UNO solo para los dos jugadores.
scoreboard players set f_brujula swr 1
scoreboard players set f_barco swr 1
scoreboard players set f_petroleo swr 1
scoreboard players set f_medusa swr 1
function swr:libro/contar
tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Anotadas las 4 fichas de la era 4 - New World.", "color": "green"}]
tellraw @a [{"text": "  + Brujula", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Magnetita Fe3O4. La aguja se alinea con el campo terrestre, de 25 a 65 microteslas.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + El Perseus", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Arquimedes: E = rho*g*V. Un casco de 40 t desplaza 40 m3 de agua.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Petroleo y refino", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Separar por punto de ebullicion: gases bajo 0 C, gasolina 40-200, queroseno 175-325, gasoleo 250-400.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + La medusa", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "No tiene formula: es la licencia fantastica del manga. Lo que si es real es el miedo como tecnologia.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
