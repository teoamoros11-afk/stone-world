# Apaga el horario: los vecinos se quedan como esten y no se les mueve mas.
scoreboard players set HORARIO swr 0
schedule clear swr:pueblo/horario/reloj
tellraw @a [{"text":"[Pueblo] ","color":"gold","bold":true},{"text":"Horario apagado. Los vecinos se quedan a su aire.","color":"yellow"}]
