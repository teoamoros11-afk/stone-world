# Coloca el plano Haber-Bosch donde estas. La esquina (0,0,0) del plano cae a tus pies.
# Temporada 4: torre, chimeneas, tanques, maizal y pista.
# Uso: /function swr:serie/colocar/haber_bosch
execute at @s run place template swr:haber_bosch ~ ~ ~
tellraw @a [{"text":"[Serie] ","color":"gold","bold":true},{"text":"Haber-Bosch colocado.","color":"gray"}]
