# Quita la tripulacion reclutada, por si se duplica o se queda atascada.
# Uso: /function swr:tripulacion/limpiar
kill @e[tag=swr_tripulante]
scoreboard players set TRIPULANTES swr 0
tellraw @a [{"text":"[Perseus] ","color":"gold","bold":true},{"text":"Tripulacion retirada. Puedes volver a reclutarla: /function swr:tripulacion/reclutar/navegante","color":"yellow"}]
