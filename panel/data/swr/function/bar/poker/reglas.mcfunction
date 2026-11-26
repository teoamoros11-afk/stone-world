# Las reglas de la mesa, tal como estan programadas (sin humo).
# Uso: /function swr:bar/poker/reglas
tellraw @a [{"text":"=== POKER DEL PERSEUS ===","color":"gold","bold":true}]
tellraw @a [{"text":"1. ","color":"yellow"},{"text":"Cada mano cuesta 10 fichas y van al bote.","color":"white"}]
tellraw @a [{"text":"2. ","color":"yellow"},{"text":"Cinco cartas para ti (se dicen) y cinco para la banca (se guardan).","color":"white"}]
tellraw @a [{"text":"3. ","color":"yellow"},{"text":"Gana la mejor mano: escalera de color, poker, full, color, escalera, trio, doble pareja, pareja o carta alta.","color":"white"}]
tellraw @a [{"text":"4. ","color":"yellow"},{"text":"Empate: se devuelven las 10 fichas. Las fichas se compran con oro (1 lingote = 25).","color":"white"}]
tellraw @a [{"text":"5. ","color":"yellow"},{"text":"Lo que esta programado no compara kickers: dos parejas iguales de distinto acompanante empatan. Esta dicho aqui a proposito.","color":"gray"}]
tellraw @a [{"text":"La baraja: ","color":"gray"},{"text":"Ver las cartas","color":"aqua","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:bar/poker/muestra"},"hoverEvent":{"action":"show_text","value":"Cinco caras y el dorso con su textura"}},{"text":" · ","color":"gray"},{"text":"Ver las fichas","color":"gold","underlined":true,"clickEvent":{"action":"run_command","value":"/function swr:bar/poker/fichas_objeto"},"hoverEvent":{"action":"show_text","value":"Las cinco fichas con su color"}}]
