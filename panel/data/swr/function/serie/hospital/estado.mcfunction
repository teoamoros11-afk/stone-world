# A21 - Pacientes ingresados y si el hospital esta montado.
# Uso: /function swr:serie/hospital/estado
scoreboard players set HOSPITAL_N serie 0
execute as @a[tag=swr_herido] run scoreboard players add HOSPITAL_N serie 1
tellraw @s [{"text":"[Hospital] ","color":"gold","bold":true},{"text":"Pacientes: ","color":"gray"},{"score":{"name":"HOSPITAL_N","objective":"serie"},"color":"white"}]
execute if entity @e[tag=swr_hospital,limit=1] run tellraw @s [{"text":"  Hospital montado.","color":"green"}]
execute unless entity @e[tag=swr_hospital,limit=1] run tellraw @s [{"text":"  Sin montar: /function swr:serie/hospital/montar","color":"red"}]
