# A20 - Como va el examen.
# Uso: /function swr:serie/escuela/estado
tellraw @s [{"text":"[Escuela] ","color":"gold","bold":true},{"text":"Aciertos: ","color":"gray"},{"score":{"name":"EXAMEN_ACIERTOS","objective":"serie"},"color":"white"},{"text":" de 3   |   Pregunta: ","color":"gray"},{"score":{"name":"EXAMEN_PREG","objective":"serie"},"color":"white"}]
