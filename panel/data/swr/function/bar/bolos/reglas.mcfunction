# Reglas de la mesa de bolos, tal como estan programadas.
# Uso: /function swr:bar/bolos/reglas
tellraw @a [{"text":"=== MESA DE BOLOS ===","color":"gold","bold":true}]
tellraw @a [{"text":"1. ","color":"yellow"},{"text":"Diez bolos en triangulo al fondo de una mesa de 5x12.","color":"white"}]
tellraw @a [{"text":"2. ","color":"yellow"},{"text":"La bola rueda sola por la mesa: /function swr:bar/bolos/tirar (16 pasos).","color":"white"}]
tellraw @a [{"text":"3. ","color":"yellow"},{"text":"Cada bolo que pilla se queda tumbado; se cuentan todos al final.","color":"white"}]
tellraw @a [{"text":"4. ","color":"yellow"},{"text":"Diez de diez es PLENO. El marcador es tuyo y no se borra.","color":"white"}]
