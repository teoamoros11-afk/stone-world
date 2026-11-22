# Anota las formulas de la era 3 en el cuaderno (no borra lo ya anotado).
# Cada ficha es un marcador f_<id>: el progreso es UNO solo para los dos jugadores.
scoreboard players set f_tatara swr 1
scoreboard players set f_bateria swr 1
scoreboard players set f_acidos swr 1
scoreboard players set f_central swr 1
function swr:libro/contar
tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Anotadas las 4 fichas de la era 3 - Stone Wars.", "color": "green"}]
tellraw @a [{"text": "  + Hierro por tatara", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Fe2O3 + 3 CO -> 2 Fe + 3 CO2. El carbon no arde: reduce el oxido.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Bateria de plomo-acido", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Pb + PbO2 + 2 H2SO4 <-> 2 PbSO4 + 2 H2O; unos 2,1 V por celda.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Acidos y polvora", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "S + O2 -> SO2 ; SO2 + H2O -> H2SO3 -> H2SO4. Polvora: 75 KNO3 / 15 C / 10 S.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Central hidroelectrica", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "P = rho*g*Q*h*eta. Con 18 m de salto y 1 m3/s salen unos 130 kW teoricos.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
