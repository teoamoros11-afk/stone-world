# A21 - El hospital de campana (T1 sulfamidas, T4 ep. 66).
# Dos camas, un cofre con sulfamida y luz. La cura gasta una sulfamida del mod.
# Uso: /function swr:serie/hospital/montar
execute at @s run setblock ~ ~ ~ minecraft:red_bed[part=foot,facing=south]
execute at @s run setblock ~ ~ ~1 minecraft:red_bed[part=head,facing=south]
execute at @s run setblock ~2 ~ ~ minecraft:red_bed[part=foot,facing=south]
execute at @s run setblock ~2 ~ ~1 minecraft:red_bed[part=head,facing=south]
execute at @s run setblock ~1 ~ ~-1 minecraft:chest
execute at @s run item replace block ~1 ~ ~-1 container.0 with stonepharmacy:sulfamida 3
execute at @s run setblock ~1 ~2 ~ minecraft:lantern
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["swr_hospital"]}
tellraw @a [{"text":"[Hospital] ","color":"gold","bold":true},{"text":"Dos camas y un cofre con tres sulfamidas. El herido se tumba, y la cura gasta una dosis.","color":"gray"}]
tellraw @s [{"text":" • ","color":"gray"},{"text":"Ingresar","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/hospital/ingresar"},"hoverEvent":{"action":"show_text","value":"Te tumbas como herido"}},{"text":"   • ","color":"gray"},{"text":"Curar","color":"green","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/hospital/curar"},"hoverEvent":{"action":"show_text","value":"Gasta una sulfamida"}},{"text":"   • ","color":"gray"},{"text":"Estado","color":"gray","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:serie/hospital/estado"},"hoverEvent":{"action":"show_text","value":"Pacientes y camas"}}]
