# Rutinas propias de cada personaje. El horario comun (despertar, trabajo, comida, reunion,
# noche) pone a todo el mundo en su sitio; aqui cada canonico hace lo suyo dentro de ese
# turno: Kinro monta guardia, Kohaku sale de caza con el arco, a Chrome se le olvida comer,
# Suika no se separa de Kohaku... Se ejecuta al final de cada cambio de turno, asi que manda
# sobre el reparto general (swr:pueblo/horario/cambiar llama a esto despues).
# Uso: automatico desde swr:pueblo/horario/cambiar
execute unless entity @e[tag=swr_plaza,limit=1] run return 0

# Ruri abre el dia: amanece a un lado de la campana, que es la que toca ella.
execute if score TURNO swr matches 1 at @e[tag=swr_plaza,limit=1] run tp @e[tag=swr_es_ruri] ~1.5 ~ ~1.5 facing ~ ~ ~
# quien tiene que quedarse quieto en su sitio (y volver a moverse al amanecer): un aldeano
# con la IA encendida se vuelve solo a la campana de la plaza y la rutina no dura nada
execute if score TURNO swr matches 1 as @e[tag=swr_es_kinro] run data merge entity @s {NoAI:0b}
execute if score TURNO swr matches 1 as @e[tag=swr_es_suika] run data merge entity @s {NoAI:0b}

# Kohaku: por la manana sale a cazar con arco y flecha; por la tarde vuelve a su hacha de
# piedra, que es con la que talla las lanzas en la mesa de flechas.
execute if score TURNO swr matches 2 as @e[tag=swr_es_kohaku,limit=1] run item replace entity @s weapon.mainhand with minecraft:bow
execute if score TURNO swr matches 2 as @e[tag=swr_es_kohaku,limit=1] run item replace entity @s weapon.offhand with minecraft:arrow 8
execute if score TURNO swr matches 4 as @e[tag=swr_es_kohaku,limit=1] run item replace entity @s weapon.mainhand with minecraft:stone_axe
execute if score TURNO swr matches 4 as @e[tag=swr_es_kohaku,limit=1] run item replace entity @s weapon.offhand with minecraft:air

# Suika es la sombra de Kohaku: se pone en la mesa de flechas, que es donde Kohaku acaba
# (si se la pone al lado, la cazadora sigue andando hasta su mesa y la deja atras).
execute if score TURNO swr matches 2..4 at @e[tag=swr_puesto_4,limit=1] run tp @e[tag=swr_es_suika] ~1.5 ~ ~1.5 facing ~ ~ ~
execute if score TURNO swr matches 2..4 as @e[tag=swr_es_suika] run data merge entity @s {NoAI:1b}
execute if score TURNO swr matches 2..4 as @e[tag=swr_es_suika] run item replace entity @s weapon.mainhand with minecraft:melon_slice

# Kinro, el guardia: no trabaja en la plaza, vigila la boca de la calle norte, que es por
# donde se entra al pueblo. Come alli mismo, sin dejar la entrada sin cubrir.
execute if score TURNO swr matches 2..4 at @e[tag=swr_plaza,limit=1] run tp @e[tag=swr_es_kinro] ~0.5 ~ ~-23.5 facing ~ ~ ~
execute if score TURNO swr matches 2..4 as @e[tag=swr_es_kinro] run data merge entity @s {NoAI:1b}
execute if score TURNO swr matches 2..4 as @e[tag=swr_es_kinro] run item replace entity @s weapon.mainhand with minecraft:iron_sword
execute if score TURNO swr matches 3 at @e[tag=swr_plaza,limit=1] run particle minecraft:cloud ~ ~1.5 ~-24 0.4 0.3 0.4 0.01 6 normal

# Chrome no come: cuando suena la campana del mediodia sigue en el atril con el frasco y el
# cuaderno. Hay que ir a buscarlo para que suelte el libro.
execute if score TURNO swr matches 3 at @e[tag=swr_puesto_5,limit=1] run tp @e[tag=swr_es_chrome] ~ ~ ~
execute if score TURNO swr matches 3 as @e[tag=swr_es_chrome,limit=1] run item replace entity @s weapon.mainhand with minecraft:glass_bottle
execute if score TURNO swr matches 3 at @e[tag=swr_puesto_5,limit=1] run particle minecraft:enchant ~ ~1 ~ 0.4 0.3 0.4 0.03 8 normal

# Kokuyo, el jefe: en la reunion no se sienta con los demas, se pone al lado de la campana
# a contar lo del dia.
execute if score TURNO swr matches 5 at @e[tag=swr_plaza,limit=1] run tp @e[tag=swr_es_kokuyo] ~-1.5 ~ ~-1.5 facing ~ ~ ~
