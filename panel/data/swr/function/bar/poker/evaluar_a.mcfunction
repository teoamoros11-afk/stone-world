# Evalua la mano manoA y deja los puntos en MANO_JUGADOR.
# Tipos: 1 carta alta, 2 pareja, 3 doble pareja, 4 trio, 5 escalera, 6 color,
#        7 full, 8 poker, 9 escalera de color. Puntos = tipo*100 + carta alta.
# Simplificacion honesta: no se comparan los kickers; si empatan, se devuelve la apuesta.
scoreboard players set TIPO poker 1
scoreboard players set MAXR poker 0
scoreboard players set MINR poker 14
scoreboard players set DISTINTAS poker 0
scoreboard players set PARES poker 0
scoreboard players set TRIPLES poker 0
scoreboard players set CUATRO poker 0
scoreboard players set ALTA poker 0
scoreboard players set COLOR poker 0
scoreboard players set ESCALERA poker 0
execute if score s1 manoA matches 5.. run scoreboard players set COLOR poker 1
execute if score s2 manoA matches 5.. run scoreboard players set COLOR poker 1
execute if score s3 manoA matches 5.. run scoreboard players set COLOR poker 1
execute if score s4 manoA matches 5.. run scoreboard players set COLOR poker 1
execute if score r1 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r1 manoA matches 1.. run scoreboard players set MAXR poker 1
execute if score r1 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r1 manoA matches 2.. run scoreboard players set ALTA poker 1
execute if score r1 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r1 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r2 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r2 manoA matches 1.. run scoreboard players set MAXR poker 2
execute if score r2 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r2 manoA matches 2.. run scoreboard players set ALTA poker 2
execute if score r2 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r2 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r3 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r3 manoA matches 1.. run scoreboard players set MAXR poker 3
execute if score r3 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r3 manoA matches 2.. run scoreboard players set ALTA poker 3
execute if score r3 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r3 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r4 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r4 manoA matches 1.. run scoreboard players set MAXR poker 4
execute if score r4 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r4 manoA matches 2.. run scoreboard players set ALTA poker 4
execute if score r4 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r4 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r5 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r5 manoA matches 1.. run scoreboard players set MAXR poker 5
execute if score r5 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r5 manoA matches 2.. run scoreboard players set ALTA poker 5
execute if score r5 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r5 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r6 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r6 manoA matches 1.. run scoreboard players set MAXR poker 6
execute if score r6 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r6 manoA matches 2.. run scoreboard players set ALTA poker 6
execute if score r6 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r6 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r7 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r7 manoA matches 1.. run scoreboard players set MAXR poker 7
execute if score r7 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r7 manoA matches 2.. run scoreboard players set ALTA poker 7
execute if score r7 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r7 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r8 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r8 manoA matches 1.. run scoreboard players set MAXR poker 8
execute if score r8 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r8 manoA matches 2.. run scoreboard players set ALTA poker 8
execute if score r8 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r8 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r9 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r9 manoA matches 1.. run scoreboard players set MAXR poker 9
execute if score r9 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r9 manoA matches 2.. run scoreboard players set ALTA poker 9
execute if score r9 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r9 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r10 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r10 manoA matches 1.. run scoreboard players set MAXR poker 10
execute if score r10 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r10 manoA matches 2.. run scoreboard players set ALTA poker 10
execute if score r10 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r10 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r11 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r11 manoA matches 1.. run scoreboard players set MAXR poker 11
execute if score r11 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r11 manoA matches 2.. run scoreboard players set ALTA poker 11
execute if score r11 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r11 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r12 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r12 manoA matches 1.. run scoreboard players set MAXR poker 12
execute if score r12 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r12 manoA matches 2.. run scoreboard players set ALTA poker 12
execute if score r12 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r12 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r13 manoA matches 1.. run scoreboard players add DISTINTAS poker 1
execute if score r13 manoA matches 1.. run scoreboard players set MAXR poker 13
execute if score r13 manoA matches 2 run scoreboard players add PARES poker 1
execute if score r13 manoA matches 2.. run scoreboard players set ALTA poker 13
execute if score r13 manoA matches 3 run scoreboard players add TRIPLES poker 1
execute if score r13 manoA matches 4 run scoreboard players add CUATRO poker 1
execute if score r13 manoA matches 1.. run scoreboard players set MINR poker 13
execute if score r12 manoA matches 1.. run scoreboard players set MINR poker 12
execute if score r11 manoA matches 1.. run scoreboard players set MINR poker 11
execute if score r10 manoA matches 1.. run scoreboard players set MINR poker 10
execute if score r9 manoA matches 1.. run scoreboard players set MINR poker 9
execute if score r8 manoA matches 1.. run scoreboard players set MINR poker 8
execute if score r7 manoA matches 1.. run scoreboard players set MINR poker 7
execute if score r6 manoA matches 1.. run scoreboard players set MINR poker 6
execute if score r5 manoA matches 1.. run scoreboard players set MINR poker 5
execute if score r4 manoA matches 1.. run scoreboard players set MINR poker 4
execute if score r3 manoA matches 1.. run scoreboard players set MINR poker 3
execute if score r2 manoA matches 1.. run scoreboard players set MINR poker 2
execute if score r1 manoA matches 1.. run scoreboard players set MINR poker 1
scoreboard players operation DIFF poker = MAXR poker
scoreboard players operation DIFF poker -= MINR poker
execute if score DISTINTAS poker matches 5 if score DIFF poker matches 4 run scoreboard players set ESCALERA poker 1
execute if score DISTINTAS poker matches 5 if score r1 manoA matches 1.. if score r10 manoA matches 1.. if score r11 manoA matches 1.. if score r12 manoA matches 1.. if score r13 manoA matches 1.. run scoreboard players set ESCALERA poker 1
execute if score ALTA poker matches 0 run scoreboard players operation ALTA poker = MAXR poker
execute if score PARES poker matches 1.. run scoreboard players set TIPO poker 2
execute if score PARES poker matches 2.. run scoreboard players set TIPO poker 3
execute if score TRIPLES poker matches 1.. run scoreboard players set TIPO poker 4
execute if score ESCALERA poker matches 1 run scoreboard players set TIPO poker 5
execute if score COLOR poker matches 1 run scoreboard players set TIPO poker 6
execute if score PARES poker matches 1.. if score TRIPLES poker matches 1.. run scoreboard players set TIPO poker 7
execute if score CUATRO poker matches 1.. run scoreboard players set TIPO poker 8
execute if score ESCALERA poker matches 1 if score COLOR poker matches 1 run scoreboard players set TIPO poker 9
scoreboard players operation PUNTOS poker = TIPO poker
scoreboard players operation PUNTOS poker *= CIEN swr
scoreboard players operation PUNTOS poker += ALTA poker
scoreboard players operation MANO_JUGADOR poker = PUNTOS poker
