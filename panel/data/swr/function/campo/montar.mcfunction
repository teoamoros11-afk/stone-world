# El campo del pueblo: cuatro parcelas de cultivo con su acequia, al lado del puesto del
# granjero (compostador). Se monta alrededor de quien lo ejecuta, hacia el este (+x).
# Uso: /function swr:campo/montar
kill @e[tag=swr_parcela]
fill ~-1 ~-1 ~-1 ~4 ~-1 ~2 minecraft:dirt
fill ~ ~-1 ~ ~3 ~-1 ~ minecraft:farmland[moisture=7]
fill ~ ~-1 ~1 ~3 ~-1 ~1 minecraft:water
fill ~ ~ ~ ~3 ~ ~ minecraft:air
fill ~-1 ~ ~-1 ~-1 ~ ~2 minecraft:oak_fence
fill ~4 ~ ~-1 ~4 ~ ~2 minecraft:oak_fence
summon minecraft:marker ~ ~ ~ {Tags:["swr_parcela","swr_parcela_1"]}
summon minecraft:marker ~1 ~ ~ {Tags:["swr_parcela","swr_parcela_2"]}
summon minecraft:marker ~2 ~ ~ {Tags:["swr_parcela","swr_parcela_3"]}
summon minecraft:marker ~3 ~ ~ {Tags:["swr_parcela","swr_parcela_4"]}
execute unless score R1 campo matches 1..3 run scoreboard players set R1 campo 3
execute unless score R2 campo matches 1..3 run scoreboard players set R2 campo 3
execute unless score R3 campo matches 1..3 run scoreboard players set R3 campo 3
execute unless score R4 campo matches 1..3 run scoreboard players set R4 campo 3
tellraw @a [{"text":"[Campo] ","color":"gold","bold":true},{"text":"Cuatro parcelas y su acequia. Planta trigo, patatas, zanahorias o remolacha; el campo cosecha solo cada 10 s y reparte segun la rotacion. Estado: /function swr:campo/estado","color":"green"}]
