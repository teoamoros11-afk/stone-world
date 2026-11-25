# Apaga la medusa sin disparar: mata el reloj y el marcador.
# Uso: /function swr:serie/medusa/desactivar
schedule clear swr:serie/medusa/ciclo
kill @e[tag=swr_medusa]
scoreboard players set MEDUSA_T swr 0
tellraw @a [{"text":"[Medusa] ","color":"light_purple","bold":true},{"text":"Desactivada. La carga gastada no vuelve.","color":"gray"}]
