# Un frasco de fluido milagroso: botella con nombre que vale por una dosis.
# Uso: /function swr:reino/fluido
give @s minecraft:experience_bottle[minecraft:custom_name='{"text":"Fluido milagroso","color":"light_purple","italic":false}'] 1
tellraw @s [{"text":"[Reino] ","color":"gold","bold":true},{"text":"Un frasco de fluido milagroso. Se gasta al revivir: vale igual que una dosis del cupo, pero se puede llevar, dar o guardar.","color":"gray"}]
