# Panel del pueblo: se abre al seleccionar el objeto en la barra rapida (tecla 1..9) y tambien
# al llevar el libro de instrucciones en la mano (barra rapida o mano secundaria), una vez por
# seleccion; al soltarlo se vuelve a armar.
# El libro se reconoce por su portada, asi que vale tambien el que ya se entrego antes de esto.
tag @a remove swr_panel_mano
execute as @a[nbt={SelectedItem:{id:"minecraft:recovery_compass"}}] run tag @s add swr_panel_mano
execute as @a[nbt={SelectedItem:{id:"minecraft:written_book",components:{"minecraft:written_book_content":{title:{raw:"Instrucciones del Panel"}}}}}] run tag @s add swr_panel_mano
execute as @a[nbt={Inventory:[{Slot:-106b,id:"minecraft:written_book",components:{"minecraft:written_book_content":{title:{raw:"Instrucciones del Panel"}}}}]}] run tag @s add swr_panel_mano
execute as @a[tag=!swr_panel_mano] run tag @s remove swr_panel_abierto
execute as @a[tag=swr_panel_mano,tag=!swr_panel_abierto] run function swr:panel/ver
# Contador de ticks: refresca los recuentos cada 5 segundos (100 ticks).
scoreboard players add TICK swr 1
execute if score TICK swr matches 100.. run function swr:panel/refrescar

# La pestaña "Dr. Stone" necesita su raiz ganada: sin ella el arbol entero se queda
# invisible aunque las eras concedan sus avances. Se da una vez por jugador (tag).
execute as @a[tag=!swr_raiz] run advancement grant @s only swr:serie/raiz
execute as @a[tag=!swr_raiz] run tag @s add swr_raiz

execute if score BOLOS_ACTIVO swr matches 1 run function swr:bar/bolos/check
