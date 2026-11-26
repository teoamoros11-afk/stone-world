# Un segundo menos. Si no queda marcador, la medusa se apaga sola (mundo recargado, alguien la rompio).
execute unless entity @e[tag=swr_medusa,limit=1] run return run function swr:serie/medusa/desactivar
scoreboard players remove MEDUSA_T swr 1
execute if score MEDUSA_T swr matches 1.. run title @a actionbar [{"text":"Medusa: ","color":"light_purple"},{"score":{"name":"MEDUSA_T","objective":"swr"},"color":"white"},{"text":" s","color":"light_purple"}]
execute if score MEDUSA_T swr matches 1.. run schedule function swr:serie/medusa/ciclo 20t replace
execute if score MEDUSA_T swr matches ..0 run function swr:serie/medusa/disparar
