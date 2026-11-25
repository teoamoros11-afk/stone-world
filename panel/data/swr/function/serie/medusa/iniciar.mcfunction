# La medusa de verdad: gasta una carga, clava el marcador donde estas y empieza la cuenta atras.
# Uso: /function swr:serie/medusa/iniciar   (o el boton de swr:serie/medusa/voz)
scoreboard players add MEDUSA_CARGA swr 0
execute unless score MEDUSA_CARGA swr matches 1.. run return run tellraw @s [{"text":"[Medusa] ","color":"light_purple","bold":true},{"text":"No le quedan cargas. La bateria de diamante se gasta: en la serie, cada uso era una vida.","color":"red"}]
execute if entity @e[tag=swr_medusa,limit=1] run return run tellraw @s [{"text":"[Medusa] ","color":"light_purple","bold":true},{"text":"Ya hay una medusa activa. Desactivala antes: /function swr:serie/medusa/desactivar","color":"red"}]
scoreboard players remove MEDUSA_CARGA swr 1
execute at @s run summon minecraft:marker ~ ~1 ~ {Tags:["swr_medusa"]}
scoreboard players set MEDUSA_T swr 30
schedule function swr:serie/medusa/ciclo 20t replace
title @a actionbar [{"text":"Medusa: 30 s","color":"light_purple"}]
tellraw @a [{"text":"[Medusa] ","color":"light_purple","bold":true},{"text":"La piedra esta armada. 30 segundos y todo lo que este a 12 bloques se queda quieto.","color":"dark_purple"}]
