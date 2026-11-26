# A18 - Precios del bar y del mercado, en denarios.
# Uso: /function swr:serie/moneda/precios
tellraw @s [{"text":"[Moneda] ","color":"gold","bold":true},{"text":"Precios del reino","color":"yellow"}]
tellraw @s [{"text":"  Pan: 1 denario   |   Pescado: 2   |   Comida del bar: 3","color":"gray"}]
tellraw @s [{"text":"  Trigo x8: 1 denario   |   Pan x6: 8 denarios","color":"gray"}]
tellraw @s [{"text":"  Ficha de poker: 1 denario (se compra en el bar)","color":"gray"}]
tellraw @s [{"text":"  Piezas: ","color":"gray"},{"text":"Ver el denario y el billete","color":"gold","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/moneda/objetos"},"hoverEvent":{"action":"show_text","value":"Las dos texturas de la moneda"}}]
tellraw @s [{"text":"  Tu cartera: ","color":"gray"},{"score":{"name":"@s","objective":"moneda"},"color":"white"},{"text":" denarios.","color":"gray"}]
