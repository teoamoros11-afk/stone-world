# Las reglas del campo, tal como estan programadas.
# Uso: /function swr:campo/reglas
tellraw @a [{"text":"=== REGLAS DEL CAMPO ===","color":"gold","bold":true}]
tellraw @a [{"text":"1. ","color":"yellow"},{"text":"Cuatro parcelas y una acequia: el campo cosecha solo cada 10 s lo que este maduro.","color":"white"}]
tellraw @a [{"text":"2. ","color":"yellow"},{"text":"Cada parcela lleva su cuenta: lo ultimo que dio y su rendimiento (1 a 3).","color":"white"}]
tellraw @a [{"text":"3. ","color":"yellow"},{"text":"Repetir el mismo cultivo en la misma parcela resta 1 de rendimiento (minimo 1).","color":"white"}]
tellraw @a [{"text":"4. ","color":"yellow"},{"text":"Cambiar de cultivo suma 1 (maximo 3). Eso es la rotacion: trigo, patata, zanahoria, remolacha.","color":"white"}]
tellraw @a [{"text":"5. ","color":"yellow"},{"text":"El rendimiento son las piezas que reparte la cosecha: 3 es campo cuidado, 1 es campo cansado.","color":"white"}]
tellraw @a [{"text":"Ojo: ","color":"red"},{"text":"si rompes el cultivo a mano recoges lo de siempre y no cuenta para la rotacion; el campo solo apunta lo que cosecha el.","color":"gray"}]
