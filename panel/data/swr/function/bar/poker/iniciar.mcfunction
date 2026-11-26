# Una mano de poker contra la banca: 10 fichas, cinco cartas cada uno y el bote para el mejor.
# Uso: /function swr:bar/poker/iniciar
execute unless score @s fichas matches 10.. run tellraw @s [{"text":"[Poker] ","color":"gold","bold":true},{"text":"Hacen falta 10 fichas. Se compran con oro: /function swr:bar/poker/comprar","color":"red"}]
execute unless score @s fichas matches 10.. run return 0
scoreboard players remove @s fichas 10
scoreboard players add BOTE fichas 10
scoreboard players reset * cs
function swr:bar/poker/limpiar_a
function swr:bar/poker/limpiar_b
function swr:bar/poker/limpiar
data modify storage swr:poker nombresB set value []
tellraw @s [{"text":"[Poker] ","color":"gold","bold":true},{"text":"Tu mano:","color":"white"}]
function swr:bar/poker/robar_a
function swr:bar/poker/robar_a
function swr:bar/poker/robar_a
function swr:bar/poker/robar_a
function swr:bar/poker/robar_a
function swr:bar/poker/robar_b
function swr:bar/poker/robar_b
function swr:bar/poker/robar_b
function swr:bar/poker/robar_b
function swr:bar/poker/robar_b
function swr:bar/poker/evaluar_a
function swr:bar/poker/evaluar_b
function swr:bar/poker/resolver
