# El marcador de bolos: lo que lleva cada jugador. No se reinicia solo.
# Uso: /function swr:bar/bolos/marcador
tellraw @a [{"text":"=== BOLOS ===","color":"gold","bold":true},{"text":"  (cada tirada: los diez bolos que tumbe la bola)","color":"gray","italic":true}]
execute as @a run tellraw @a [{"text":"  ","color":"gray"},{"selector":"@s","color":"white"},{"text":": ","color":"gray"},{"score":{"name":"@s","objective":"bolos"},"color":"aqua"}]
