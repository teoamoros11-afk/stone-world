# Lo que hay plantado y con que rendimiento esta cada parcela.
# Uso: /function swr:campo/estado
tellraw @a [{"text":"=== CAMPO DEL PUEBLO ===","color":"gold","bold":true},{"text":"  (cultivo 0 vacio, 1 trigo, 2 patata, 3 zanahoria, 4 remolacha)","color":"gray","italic":true}]
tellraw @a [{"text":"  Parcela 1: ultimo ","color":"gray"},{"score":{"name":"P1","objective":"campo"},"color":"white"},{"text":", rendimiento ","color":"gray"},{"score":{"name":"R1","objective":"campo"},"color":"aqua"}]
tellraw @a [{"text":"  Parcela 2: ultimo ","color":"gray"},{"score":{"name":"P2","objective":"campo"},"color":"white"},{"text":", rendimiento ","color":"gray"},{"score":{"name":"R2","objective":"campo"},"color":"aqua"}]
tellraw @a [{"text":"  Parcela 3: ultimo ","color":"gray"},{"score":{"name":"P3","objective":"campo"},"color":"white"},{"text":", rendimiento ","color":"gray"},{"score":{"name":"R3","objective":"campo"},"color":"aqua"}]
tellraw @a [{"text":"  Parcela 4: ultimo ","color":"gray"},{"score":{"name":"P4","objective":"campo"},"color":"white"},{"text":", rendimiento ","color":"gray"},{"score":{"name":"R4","objective":"campo"},"color":"aqua"}]
tellraw @a [{"text":"  Cosechas: ","color":"gray"},{"score":{"name":"COSECHAS","objective":"campo"},"color":"white"},{"text":", ultima: ","color":"gray"},{"score":{"name":"ULTIMA_COSECHA","objective":"campo"},"color":"aqua"},{"text":" piezas","color":"gray"}]
