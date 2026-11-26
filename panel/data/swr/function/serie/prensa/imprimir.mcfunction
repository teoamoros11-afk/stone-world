# A15 - La imprenta y el periodico (T2-T4): tres papeles y un tinte por tirada.
# Uso: /function swr:serie/prensa/imprimir
execute store result score PAPEL_TMP serie run clear @s minecraft:paper 0
execute if score PAPEL_TMP serie matches ..2 run return run tellraw @s [{"text":"[Prensa] ","color":"gold","bold":true},{"text":"Hacen falta tres papeles.","color":"red"}]
execute store result score TINTA_TMP serie run clear @s minecraft:ink_sac 0
execute if score TINTA_TMP serie matches ..0 run return run tellraw @s [{"text":"[Prensa] ","color":"gold","bold":true},{"text":"Hace falta un tinte (ink sac).","color":"red"}]
clear @s minecraft:paper 3
clear @s minecraft:ink_sac 1
scoreboard players add PRENSA_TIRADA serie 1
give @s written_book[minecraft:written_book_content={title:"El Diario del Reino",author:"La imprenta de la aldea",pages:['{"text":"EL DIARIO DEL REINO","color":"gold","bold":true}','{"text":"LA ALDEA CRECE. Cada vecino que sale de la piedra levanta su casa. Las calles ya tienen nombre y la plaza, campana.","color":"black"}','{"text":"EL FLUIDO SE ACABA. El campo de estatuas no es infinito: cada dosis devuelve una vida y no hay dos sin tres.","color":"black"}','{"text":"DEL LABORATORIO. Chrome anota formulas; Senku las convierte en talleres. La ciencia no es magia: es repetir hasta que sale.","color":"black"}','{"text":"DEL MAR. El Perseus esta en el puerto. La tripulacion no zarpa sin navegante, contable y cocinero.","color":"black"}','{"text":"ULTIMA HORA. Si lees esto, la imprenta funciona. En la serie, el periodico fue la primera voz de la civilizacion.","color":"black"}']}] 1
tellraw @a [{"text":"[Prensa] ","color":"gold","bold":true},{"text":"Tirada numero ","color":"gray"},{"score":{"name":"PRENSA_TIRADA","objective":"serie"},"color":"white"},{"text":". Era ","color":"gray"},{"score":{"name":"ERA","objective":"swr"},"color":"white"},{"text":" | Vecinos: ","color":"gray"},{"score":{"name":"VECINOS","objective":"swr"},"color":"white"},{"text":" | Estatuas: ","color":"gray"},{"score":{"name":"ESTATUAS","objective":"swr"},"color":"white"},{"text":" | Fluido: ","color":"gray"},{"score":{"name":"CUPO","objective":"swr"},"color":"white"}]
