# A7 - El indice de la biblioteca: los diez capitulos que Ruri recita.
# Uso: /function swr:serie/biblioteca/indice
tellraw @s [{"text":"[Biblioteca] ","color":"gold","bold":true},{"text":"Indice de las cien historias","color":"yellow"}]
tellraw @s [{"text":"  I. Del cielo.","color":"gray","hoverEvent":{"action":"show_text","value":"La casa que daba vueltas sobre el mundo."}}]
tellraw @s [{"text":"  II. Del agua que obedece.","color":"gray","hoverEvent":{"action":"show_text","value":"Un grifo: agua limpia sin rio ni pozo."}}]
tellraw @s [{"text":"  III. De la luz sin fuego.","color":"gray","hoverEvent":{"action":"show_text","value":"Soles pequenos que no quemaban."}}]
tellraw @s [{"text":"  IV. De la voz lejana.","color":"gray","hoverEvent":{"action":"show_text","value":"Hablar a una piedra y que la voz cruce el mar."}}]
tellraw @s [{"text":"  V. Del carro sin bueyes.","color":"gray","hoverEvent":{"action":"show_text","value":"Un camino de piedra negra y un carro que corre mas que un caballo."}}]
tellraw @s [{"text":"  VI. De la medicina.","color":"gray","hoverEvent":{"action":"show_text","value":"Polvos que matan a los bichos invisibles."}}]
tellraw @s [{"text":"  VII. Del metal que vuela.","color":"gray","hoverEvent":{"action":"show_text","value":"Pajaros de metal con gente dentro."}}]
tellraw @s [{"text":"  VIII. Del hielo que guarda.","color":"gray","hoverEvent":{"action":"show_text","value":"Una caja fria donde la comida dura semanas."}}]
tellraw @s [{"text":"  IX. De los numeros.","color":"gray","hoverEvent":{"action":"show_text","value":"Todo se calculaba antes de construirlo."}}]
tellraw @s [{"text":"  X. Del fin.","color":"gray","hoverEvent":{"action":"show_text","value":"La luz verde lo cubrio todo."}}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Leer el libro","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/historias"},"hoverEvent":{"action":"show_text","value":"Ruri te entrega el libro con las historias"}},{"text":"   • ","color":"gray"},{"text":"Montar la estanteria","color":"gold","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/biblioteca/montar"},"hoverEvent":{"action":"show_text","value":"Baldas, atril y cartel donde estas"}}]
