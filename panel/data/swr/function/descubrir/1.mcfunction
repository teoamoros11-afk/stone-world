# Anota las formulas de la era 1 en el cuaderno (no borra lo ya anotado).
# Cada ficha es un marcador f_<id>: el progreso es UNO solo para los dos jugadores.
scoreboard players set f_fuego swr 1
scoreboard players set f_carbon swr 1
scoreboard players set f_ceramica swr 1
scoreboard players set f_fluido swr 1
function swr:libro/contar
tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Anotadas las 4 fichas de la era 1 - No morir.", "color": "green"}]
tellraw @a [{"text": "  + Fuego por friccion", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "W = F*d ; 1 J = 0,24 cal. Frotar convierte trabajo en calor y la yesca prende hacia 250 C.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Carbon vegetal", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Pirolisis: C6H10O5 -> 6 C + 5 H2O + volatiles. Rinde cerca del 25 % del peso seco.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Ceramica y crisoles", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Caolinita Al2Si2O5(OH)4 -> metacaolin + 2 H2O entre 500 y 600 C; aguanta 900 C.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Fluido milagroso (nitalo)", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "NaNO3 + H2SO4 -> NaHSO4 + HNO3 (destilando). Nitalo = HNO3 + C2H5OH.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
