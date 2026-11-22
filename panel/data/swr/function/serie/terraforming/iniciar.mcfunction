# EPILOGO - TERRAFORMING (one-shot del tomo 27, despues del final; en octubre de 2026 se
# anuncio como nueva animacion). Cuatro escenas encadenadas: no es una era, es lo que pasa
# despues. Se abre solo cuando la era 5 esta cerrada.
# Uso: /function swr:serie/terraforming/iniciar
scoreboard players add TERRAFORM swr 0
execute unless score CERRADA5 swr matches 1.. run tellraw @s [{"text":"[TERRAFORMING] ","color":"aqua","bold":true},{"text":"Primero cierra la era 5 con /function swr:era/cerrar. El epilogo va despues del final, no antes.","color":"red"}]
execute unless score CERRADA5 swr matches 1.. run return fail
execute if score TERRAFORM swr matches 1.. run tellraw @s [{"text":"[TERRAFORMING] ","color":"aqua","bold":true},{"text":"Ya esta empezado. Mira por donde vas con /function swr:serie/terraforming/estado","color":"yellow"}]
execute if score TERRAFORM swr matches 1.. run return fail
scoreboard players set TERRAFORM swr 1
tellraw @a [{"text":"[TERRAFORMING] ","color":"aqua","bold":true},{"text":"Despues del final: un avion, un mar lleno de basura y un plan que no cabe en este planeta.","color":"gray"}]
function swr:serie/terraforming/naufragio
