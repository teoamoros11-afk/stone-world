# Escena 4/4: el silicio. Vuelven a tierra con silicio de cuarzo de Noruega (la materia prima
# de los semiconductores) y Senku suelta el plan: terraformar mundos que no son la Tierra.
# Uso: automatico (o /function swr:serie/terraforming/silicio)
execute unless score TERRAFORM swr matches 4 run return run tellraw @s [{"text":"[TERRAFORMING] ","color":"aqua","bold":true},{"text":"Antes toca el rayo: /function swr:serie/terraforming/nitrico","color":"red"}]
scoreboard players set TERRAFORM swr 5
title @a times 10 70 30
title @a subtitle [{"text":"Silicio de cuarzo en la mano: con esto empieza la electronica.","color":"gray"}]
title @a title [{"text":"TERRAFORMAR","color":"light_purple","bold":true}]
advancement grant @s only swr:serie/terraforming
give @s minecraft:quartz[minecraft:custom_name='{"text":"Silicio de cuarzo","color":"white","italic":false}']
playsound minecraft:ui.toast.challenge_complete master @a ~ ~ ~ 1 1
playsound minecraft:entity.firework_rocket.launch master @a ~ ~ ~ 1 1
particle minecraft:firework ~ ~1 ~ 1 1 1 0.1 40 normal
particle minecraft:end_rod ~ ~1 ~ 2 2 2 0.05 60 normal
tellraw @a [{"text":"[Escena 4] ","color":"aqua","bold":true},{"text":"El silicio purisimo de Noruega es lo que convierte la ciencia en electronica. Y el plan que cierra la historia: terraformar mundos ajenos para seguir creciendo con materiales que en la Tierra no hay.","color":"gray"}]
tellraw @a [{"text":" Lo que dice la ciencia: ","color":"dark_gray"},{"text":"el silicio elemental no aparece puro en la naturaleza y el de grado semiconductor se refina hasta una parte entre mil millones; la serie lo simplifica, pero el uso es el correcto.","color":"dark_gray"}]
tellraw @a [{"text":"[TERRAFORMING] ","color":"light_purple","bold":true},{"text":"Epilogo completo. Esto si que es emocionante.","color":"light_purple"}]
