# Anota las formulas de la era 5 en el cuaderno (no borra lo ya anotado).
# Cada ficha es un marcador f_<id>: el progreso es UNO solo para los dos jugadores.
scoreboard players set f_computadora swr 1
scoreboard players set f_optica swr 1
scoreboard players set f_cohete swr 1
scoreboard players set f_espacio swr 1
scoreboard players set f_vivo swr 1
function swr:libro/contar
tellraw @a [{"text": "[Cuaderno] ", "color": "gold", "bold": true}, {"text": "Anotadas las 5 fichas de la era 5 - Science Future.", "color": "green"}]
tellraw @a [{"text": "  + Computadora", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Puertas AND, OR y NOT; reloj f = 1/T. Todo lo digital sale de ahi.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Telescopio de fluorita", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Refraccion: n1*sen(t1) = n2*sen(t2). Aumento = f_objetivo / f_ocular.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Cohete", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Tsiolkovski: dv = ve*ln(m0/m1). Para orbita baja hacen falta unos 9,4 km/s.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Base y traje", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "PV = nRT. A 1 atm y 20 C, un metro cubico son unos 41 mol de aire.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
tellraw @a [{"text": "  + Lo que antes no se podia", "color": "aqua", "extra": [{"text": "", "hoverEvent": {"action": "show_text", "value": {"text": "", "extra": [{"text": "Antes las aldeas eran decorado. Ahora se despetrifica con el efecto del mod, al tercer vecino nace la plaza, cada uno levanta su casa, el pueblo cumple horario y la tripulacion del Perseus zarpa de verdad.", "color": "white"}, {"text": " "}, {"text": "Copia nueva: /function swr:libro/cuaderno", "color": "gray"}]}}}]}]
