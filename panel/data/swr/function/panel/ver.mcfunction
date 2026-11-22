# Panel del pueblo: todo lo que hace el pueblo y su progreso, de una tirada.
# Se ejecuta COMO el jugador que pulsa la tecla del Panel del pueblo (o con /function swr:panel/ver).
# La llama swr:tick.mcfunction al seleccionar el objeto, una vez por seleccion.
function swr:pueblo/oficios/contar
execute store result score PUESTOS swr run execute if entity @e[tag=swr_puesto]
execute store result score CASAS_OBRA swr run execute if entity @e[tag=swr_casa]
tellraw @s [{"text":"=== LO QUE HACE EL PUEBLO ===","color":"gold","bold":true}]
tellraw @s [{"text":" Era ","color":"gray"},{"score":{"name":"ERA","objective":"swr"},"color":"white"},{"text":" / 6   |   Fichas del cuaderno: ","color":"gray"},{"score":{"name":"DESCUBRIMIENTOS","objective":"swr"},"color":"white"},{"text":" / 26","color":"dark_gray"}]
tellraw @s [{"text":" Vecinos que salieron de la piedra: ","color":"gray"},{"score":{"name":"VECINOS","objective":"swr"},"color":"white"},{"text":"   |   Estatuas aun en pie: ","color":"gray"},{"score":{"name":"ESTATUAS","objective":"swr"},"color":"white"},{"text":"   |   Fluido: ","color":"gray"},{"score":{"name":"CUPO","objective":"swr"},"color":"white"}]
tellraw @s [{"text":" Casas: ","color":"gray"},{"score":{"name":"CASAS","objective":"swr"},"color":"white"},{"text":" empezadas, ","color":"gray"},{"score":{"name":"CASAS_OBRA","objective":"swr"},"color":"yellow"},{"text":" en obra   |   Puestos de oficio en pie: ","color":"gray"},{"score":{"name":"PUESTOS","objective":"swr"},"color":"white"},{"text":" / 6","color":"dark_gray"}]
tellraw @s [{"text":" Horario: turno ","color":"gray"},{"score":{"name":"TURNO","objective":"swr"},"color":"white"},{"text":" de 6 (1 amanecer, 2 manana, 3 comida, 4 tarde, 5 reunion, 6 noche)","color":"dark_gray"}]
execute if score HORARIO swr matches 0 run tellraw @s [{"text":" Horario: apagado (/function swr:pueblo/horario/iniciar)","color":"red"}]
tellraw @s [{"text":" Los oficios, ahora mismo:","color":"gold"}]
tellraw @s [{"text":"  Cantero ","color":"white"},{"score":{"name":"C0","objective":"swr"},"color":"aqua"},{"text":" (cortapiedras, ladrillos)   Granjero ","color":"gray"},{"score":{"name":"C1","objective":"swr"},"color":"aqua"},{"text":" (compostador, pan)","color":"gray"}]
tellraw @s [{"text":"  Pastor ","color":"white"},{"score":{"name":"C2","objective":"swr"},"color":"aqua"},{"text":" (telar, lana)   Pescador ","color":"gray"},{"score":{"name":"C3","objective":"swr"},"color":"aqua"},{"text":" (barril, bacalao)","color":"gray"}]
tellraw @s [{"text":"  Flechero ","color":"white"},{"score":{"name":"C4","objective":"swr"},"color":"aqua"},{"text":" (mesa de flechas, flechas)   Bibliotecario ","color":"gray"},{"score":{"name":"C5","objective":"swr"},"color":"aqua"},{"text":" (atril, libros)","color":"gray"}]
execute if score OBRA swr matches 1.. run tellraw @s [{"text":" Obra en marcha: quedan ","color":"gray"},{"score":{"name":"OBRA","objective":"swr"},"color":"yellow"},{"text":" s","color":"yellow"}]
execute unless score OBRA swr matches 1.. run tellraw @s [{"text":" Obra: parada","color":"gray"}]
execute if score PUEBLO swr matches 0 run tellraw @s [{"text":" Aun no hay plaza: revive tres vecinos y el pueblo se funda solo.","color":"yellow"}]
tellraw @s [{"text":" Mas detalle: /function swr:pueblo/estado   |   Cuaderno: swr:libro/cuaderno","color":"dark_gray"}]
tag @s add swr_panel_abierto
