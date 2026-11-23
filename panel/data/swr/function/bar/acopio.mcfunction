# Lo que traen los puestos del pueblo al bar, una vez al dia (se llama desde horario/noche).
# Solo pan del granjero y bacalao del pescador: es lo unico que producen los oficios.
# Ni leche ni miel ni bayas salen de aqui: eso lo tiene que traer el jugador.
execute if entity @e[tag=swr_vecino,tag=swr_oficio_1] run scoreboard players add PAN despensa 6
execute if entity @e[tag=swr_vecino,tag=swr_oficio_3] run scoreboard players add PESCADO despensa 6
execute if score PAN despensa matches 65.. run scoreboard players set PAN despensa 64
execute if score PESCADO despensa matches 65.. run scoreboard players set PESCADO despensa 64
execute if entity @e[tag=swr_vecino,tag=swr_oficio_1] run tellraw @a [{"text":"[Bar] ","color":"gold","bold":true},{"text":"El granjero deja 6 panes en la despensa.","color":"green"}]
execute if entity @e[tag=swr_vecino,tag=swr_oficio_3] run tellraw @a [{"text":"[Bar] ","color":"gold","bold":true},{"text":"El pescador deja 6 bacalaos en la despensa.","color":"green"}]
execute unless entity @e[tag=swr_vecino,tag=swr_oficio_1] unless entity @e[tag=swr_vecino,tag=swr_oficio_3] run tellraw @a [{"text":"[Bar] ","color":"gold","bold":true},{"text":"Hoy el pueblo no ha traido nada: faltan el granjero y el pescador en su puesto.","color":"red"}]
