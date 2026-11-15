# Contador de ticks: refresca los recuentos cada 5 segundos (100 ticks).
scoreboard players add TICK swr 1
execute if score TICK swr matches 100.. run function swr:panel/refrescar
