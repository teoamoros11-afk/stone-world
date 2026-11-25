# A11 - Cuenta atras del consejo, un segundo por vez.
scoreboard players remove CONSEJO_T serie 1
execute if score CONSEJO_T serie matches 1.. run title @a actionbar [{"text":"Consejo: ","color":"gold"},{"score":{"name":"CONSEJO_T","objective":"serie"},"color":"white"},{"text":" s","color":"gold"}]
execute if score CONSEJO_T serie matches 1.. run schedule function swr:serie/consejo/cuenta 20t replace
execute if score CONSEJO_T serie matches ..0 run title @a title [{"text":"TIEMPO","color":"red","bold":true}]
execute if score CONSEJO_T serie matches ..0 run tellraw @a [{"text":"[Consejo] ","color":"gold","bold":true},{"text":"Se acabo el plazo. La orden se cumple o se paga.","color":"gray"}]
