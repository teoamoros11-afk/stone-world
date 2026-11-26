# A9 - Cierra el juicio: cuenta los votos y dicta sentencia.
# Uso: /function swr:serie/juicio/resolver
tellraw @a [{"text":"[Juicio] ","color":"red","bold":true},{"text":"Votos: ","color":"gray"},{"score":{"name":"JUICIO_SI","objective":"serie"},"color":"red"},{"text":" desterrar, ","color":"gray"},{"score":{"name":"JUICIO_NO","objective":"serie"},"color":"green"},{"text":" perdonar.","color":"gray"}]
execute if score JUICIO_SI serie > JUICIO_NO serie run title @a title [{"text":"DESTIERRO","color":"red","bold":true}]
execute if score JUICIO_SI serie > JUICIO_NO serie run tellraw @a [{"text":"[Juicio] ","color":"red","bold":true},{"text":"La aldea destierra a Magma. En la serie, el juicio no lo gana el mas fuerte: lo gana quien tiene razon delante de todos.","color":"gray"}]
execute if score JUICIO_NO serie > JUICIO_SI serie run title @a title [{"text":"PERDON","color":"green","bold":true}]
execute if score JUICIO_NO serie > JUICIO_SI serie run tellraw @a [{"text":"[Juicio] ","color":"green","bold":true},{"text":"La aldea perdona a Magma. Se queda, pero con la mirada de todos encima.","color":"gray"}]
execute if score JUICIO_SI serie = JUICIO_NO serie run title @a title [{"text":"EMPATE","color":"gold","bold":true}]
execute if score JUICIO_SI serie = JUICIO_NO serie run tellraw @a [{"text":"[Juicio] ","color":"gold","bold":true},{"text":"Empate. Decide el jefe: Kokuyo tiene la ultima palabra.","color":"gray"}]
tag @a remove swr_voto_juicio
