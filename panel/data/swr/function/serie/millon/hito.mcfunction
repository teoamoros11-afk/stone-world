# A6 - Hitos del millon de revividos (T4, ep. 69-81).
# Se llama desde pueblo/despetrificar_uno despues de sumar un revivido. Cada hito se
# anuncia una sola vez porque solo cae cuando el contador vale exactamente eso.
execute if score REVIDOS_TOTAL serie matches 1000 run tellraw @a [{"text":"[El millon] ","color":"gold","bold":true},{"text":"Mil personas han vuelto de la piedra. En la serie, el contador es lo que convierte una aldea en un pais.","color":"gray"}]
execute if score REVIDOS_TOTAL serie matches 10000 run tellraw @a [{"text":"[El millon] ","color":"gold","bold":true},{"text":"Diez mil. Ya no cabe en una plaza: hacen falta ciudades.","color":"gray"}]
execute if score REVIDOS_TOTAL serie matches 100000 run tellraw @a [{"text":"[El millon] ","color":"gold","bold":true},{"text":"Cien mil. La ciencia ya no es un taller, es una civilizacion.","color":"gray"}]
execute if score REVIDOS_TOTAL serie matches 1000000 run tellraw @a [{"text":"[El millon] ","color":"gold","bold":true},{"text":"Un millon. El objetivo que Senku se puso al salir de la piedra, cumplido.","color":"gold"}]
