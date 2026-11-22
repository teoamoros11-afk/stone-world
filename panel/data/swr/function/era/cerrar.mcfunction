# Cierra la era actual. Sin cerrar una era no se abre la siguiente.
# Uso: /function swr:era/cerrar
scoreboard players add CERRADA1 swr 0
scoreboard players add CERRADA2 swr 0
scoreboard players add CERRADA3 swr 0
scoreboard players add CERRADA4 swr 0
scoreboard players add CERRADA5 swr 0
execute if score ERA swr matches 1 run scoreboard players set CERRADA1 swr 1
execute if score ERA swr matches 2 run scoreboard players set CERRADA2 swr 1
execute if score ERA swr matches 3 run scoreboard players set CERRADA3 swr 1
execute if score ERA swr matches 4 run scoreboard players set CERRADA4 swr 1
execute if score ERA swr matches 5 run scoreboard players set CERRADA5 swr 1
tellraw @a [{"text":"[Era ","color":"green","bold":true},{"score":{"name":"ERA","objective":"swr"},"color":"green","bold":true},{"text":"] cerrada. La siguiente ya se puede abrir con /function swr:era/N.","color":"green"}]
