# La mesa de bolos: 5 de ancho y 12 de largo, con los diez bolos al fondo.
# Se monta alrededor de quien la ejecuta y rueda hacia el sur (+z): deja 12 bloques libres.
# Uso: /function swr:bar/bolos/montar
kill @e[tag=swr_bolo]
kill @e[tag=swr_bolos_origen]
fill ~-2 ~-1 ~ ~2 ~-1 ~11 minecraft:spruce_planks
fill ~-2 ~ ~ ~-2 ~ ~11 minecraft:oak_fence
fill ~2 ~ ~ ~2 ~ ~11 minecraft:oak_fence
summon minecraft:marker ~ ~ ~ {Tags:["swr_bolos_origen"]}
function swr:bar/bolos/reset
tellraw @a [{"text":"[Bolos] ","color":"gold","bold":true},{"text":"Mesa de bolos montada. Tira con /function swr:bar/bolos/tirar y mira tus bolos con /function swr:bar/bolos/marcador","color":"green"}]
