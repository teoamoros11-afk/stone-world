# A3 - Estado del yacimiento de la cueva.
# Uso: /function swr:serie/cueva/estado
tellraw @s [{"text":"[Cueva del milagro] ","color":"gold","bold":true},{"text":"Yacimiento: ","color":"gray"},{"score":{"name":"CUEVA_ACTIVA","objective":"serie"},"color":"white"}]
execute if score CUEVA_ACTIVA serie matches 1 run tellraw @s [{"text":"  El barril se rellena solo cada minuto. Guano = nitrato: de ahi sale el fluido milagroso.","color":"gray"}]
execute unless score CUEVA_ACTIVA serie matches 1 run tellraw @s [{"text":"  Sin montar. /function swr:serie/cueva/montar deja el barril y el caldero donde estas.","color":"red"}]
