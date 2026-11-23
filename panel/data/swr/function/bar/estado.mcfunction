# El bar de un vistazo: si esta montado, si esta Francois, la despensa, las fichas y la ultima tirada.
# Uso: /function swr:bar/estado
tellraw @a [{"text":"=== BAR DEL PERSEUS ===","color":"gold","bold":true}]
execute if entity @e[tag=swr_bar,limit=1] run tellraw @a [{"text":"  Salon: ","color":"gray"},{"text":"montado en cubierta","color":"green"}]
execute unless entity @e[tag=swr_bar,limit=1] run tellraw @a [{"text":"  Salon: ","color":"gray"},{"text":"sin montar (/function swr:bar/montar)","color":"red"}]
execute if entity @e[tag=swr_cocinero,limit=1] run tellraw @a [{"text":"  Cocinera: ","color":"gray"},{"text":"Francois a bordo","color":"green"}]
execute unless entity @e[tag=swr_cocinero,limit=1] run tellraw @a [{"text":"  Cocinera: ","color":"gray"},{"text":"falta (/function swr:tripulacion/reclutar/cocinero)","color":"red"}]
execute if entity @e[tag=swr_bolos_origen,limit=1] run tellraw @a [{"text":"  Bolos: ","color":"gray"},{"text":"mesa montada","color":"green"}]
execute unless entity @e[tag=swr_bolos_origen,limit=1] run tellraw @a [{"text":"  Bolos: ","color":"gray"},{"text":"sin mesa (/function swr:bar/bolos/montar)","color":"red"}]
tellraw @a [{"text":"  Despensa: ","color":"gray"},{"score":{"name":"PAN","objective":"despensa"},"color":"aqua"},{"text":" pan, ","color":"white"},{"score":{"name":"PESCADO","objective":"despensa"},"color":"aqua"},{"text":" pescado, ","color":"white"},{"score":{"name":"PATATA","objective":"despensa"},"color":"aqua"},{"text":" patata, ","color":"white"},{"score":{"name":"BAYAS","objective":"despensa"},"color":"aqua"},{"text":" bayas","color":"white"}]
tellraw @a [{"text":"  Fichas: ","color":"gray"},{"score":{"name":"@s","objective":"fichas"},"color":"aqua"},{"text":"  |  Ultima tirada de bolos: ","color":"gray"},{"score":{"name":"BOLOS_ULTIMA","objective":"swr"},"color":"aqua"}]
