# El reloj del campo: una vuelta cada 10 s (200 ticks). Se reprograma sola.
# Uso: automatico desde swr:load
function swr:campo/revisar
schedule function swr:campo/ciclo 200t replace
