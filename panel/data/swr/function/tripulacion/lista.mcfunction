# Quien va a bordo y que falta para zarpar. El progreso es uno solo para los dos jugadores.
# Uso: /function swr:tripulacion/lista
scoreboard players set TRIPULANTES swr 0
execute if entity @e[tag=swr_navegante] run scoreboard players add TRIPULANTES swr 1
execute if entity @e[tag=swr_contable] run scoreboard players add TRIPULANTES swr 1
execute if entity @e[tag=swr_cocinero] run scoreboard players add TRIPULANTES swr 1
tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"Tripulacion: ","color":"white"},{"score":{"name":"TRIPULANTES","objective":"swr"},"color":"aqua"},{"text":" de 3 a bordo","color":"white"}]
execute if entity @e[tag=swr_navegante] run tellraw @a [{"text":"  Navegante: ","color":"gray"},{"text":"Ryusui, a bordo. Decide el rumbo.","color":"green"}]
execute unless entity @e[tag=swr_navegante] run tellraw @a [{"text":"  Navegante: ","color":"gray"},{"text":"falta (/function swr:tripulacion/reclutar/navegante)","color":"red"}]
execute if entity @e[tag=swr_contable] run tellraw @a [{"text":"  Contable: ","color":"gray"},{"text":"Sai, a bordo. Cuenta la carga y los viveres.","color":"green"}]
execute unless entity @e[tag=swr_contable] run tellraw @a [{"text":"  Contable: ","color":"gray"},{"text":"falta (/function swr:tripulacion/reclutar/contable)","color":"red"}]
execute if entity @e[tag=swr_cocinero] run tellraw @a [{"text":"  Cocinero: ","color":"gray"},{"text":"Francois, a bordo. Raciona la comida.","color":"green"}]
execute unless entity @e[tag=swr_cocinero] run tellraw @a [{"text":"  Cocinero: ","color":"gray"},{"text":"falta (/function swr:tripulacion/reclutar/cocinero)","color":"red"}]
execute if score BOTADO swr matches 1 run tellraw @a [{"text":"  Barco: ","color":"gray"},{"text":"botado y en el agua.","color":"green"}]
execute unless score BOTADO swr matches 1 run tellraw @a [{"text":"  Barco: ","color":"gray"},{"text":"aun en el varadero (/function swr:tripulacion/botadura).","color":"red"}]
execute if score ZARPE swr matches 1 run tellraw @a [{"text":"  Estado: ","color":"gray"},{"text":"ya zarpasteis una vez.","color":"aqua"}]
