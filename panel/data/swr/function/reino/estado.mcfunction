# Estado del reino: era, revividos y fluido que queda en el campo de estatuas.
# Uso: /function swr:reino/estado
tellraw @s [{"text":"[Reino] ","color":"gold","bold":true},{"text":"Estado de la reconstruccion","color":"white"}]
tellraw @s [{"text":" Era actual: ","color":"gray"},{"score":{"name":"ERA","objective":"swr"},"color":"white"},{"text":"  |  Revividos: ","color":"gray"},{"score":{"name":"REVIDOS","objective":"swr"},"color":"white"},{"text":"  |  Fluido: ","color":"gray"},{"score":{"name":"CUPO","objective":"swr"},"color":"white"}]
tellraw @s [{"text":" Ciudades: ","color":"gray"},{"score":{"name":"CIUDADANOS","objective":"swr"},"color":"white"},{"text":" ciudadanos  |  ","color":"gray"},{"score":{"name":"ALDEANOS","objective":"swr"},"color":"white"},{"text":" aldeanos  |  ","color":"gray"},{"score":{"name":"ALDEA","objective":"swr"},"color":"white"},{"text":" aldeas","color":"gray"}]
