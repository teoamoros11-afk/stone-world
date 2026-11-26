# El Perseus: plano y comprobacion fisica

Modelo y simulacion propios, escala **1 bloque = 1 m**. Nada de imagenes de la serie: la forma se
reconstruye a partir de lo que el manga y el anime dicen y se comprueba con hidrostaticas.

## Lo que dice la serie (cap. 84-100, anime Dr. Stone Ryusui)

- Bergantin **modificado**: dos palos cuadros con **tres velas** cada uno y **dos foques**.
- Sin vela cangreja: en su sitio, la torre de escapes; el palo de proa gira con un engranaje movido por el motor.
- Cubierta plana, **toldilla** a popa con sala de comunicaciones y escapes, **invernadero** a crujia,
  **tres escalones** en proa, timon, **dos helices** y bote motor en las gruas.
- Proa pintada como una cara (figura de proa) y **nueve portillas** por banda.
- **Mas de 20 m de eslora** (Ryusui: minimo para que despegue un avion). Kaseki trabaja sobre un modelo 1:48.

## Dimensiones elegidas

| Parametro | Valor | Por que |
|---|---|---|
| Eslora total | 30 m | El minimo documentado (20 m) con margen para el bote y el invernadero |
| Eslora en flotacion | 26.2 m | 87 % de la total: overhangs de bergantin |
| Manga | 7.2 m | Proporcion 4,2:1, la de un bergantin de la epoca |
| Puntal | 4.2 m | Para dos cubiertas y el invernadero |
| Calado de diseno | 1.66 m | El que pide el peso; barco de agua somera |
| Tripulacion | 12 | Ryusui, Sai, Francois, Senku, Kohaku y guardia |

## Cuadernas (replanteo en bloques)

| x | quilla | cubierta | semimanga a calado | semimanga media | semimanga cubierta |
|---|---|---|---|---|---|
| 0.0 | 0.51 | 4.22 | 1.69 | 1.85 | 2.23 |
| 3.0 | 0.32 | 4.11 | 2.32 | 2.44 | 2.93 |
| 6.0 | 0.19 | 3.93 | 2.63 | 2.66 | 3.21 |
| 9.0 | 0.14 | 3.89 | 2.85 | 2.86 | 3.45 |
| 12.0 | 0.07 | 3.84 | 3.02 | 2.99 | 3.60 |
| 15.0 | 0.01 | 3.79 | 3.01 | 2.95 | 3.55 |
| 18.0 | 0.02 | 3.81 | 2.95 | 2.90 | 3.49 |
| 21.0 | 0.15 | 3.98 | 2.58 | 2.62 | 3.16 |
| 24.0 | 0.23 | 4.08 | 2.04 | 2.11 | 2.54 |
| 27.0 | 0.81 | 4.40 | 1.19 | 1.43 | 1.72 |
| 30.0 | 1.40 | 4.72 | 0.30 | 0.48 | 0.58 |

## Bloques por capa (casco)

|capa 0|capa 1|capa 2|capa 3|capa 4|
|---|---|---|---|---|
|63|121|155|171|175|

Total del casco: **685 bloques** de madera (forro de 1 bloque de grosor, hueco por dentro).

## Estructura de cubierta

| Elemento | x | semimanga | altura |
|---|---|---|---|
| toldilla / sala de comunicaciones | 2.0-7.2 | 2.4 | 4.2-5.8 |
| invernadero | 13.0-18.2 | 2.2 | 4.2-5.3 |
| escalones de proa | 27.0-29.0 | 1.4 | 4.2-5.0 |
| timon | 0.2-1.0 | 0.3 | 0.2-4.2 |

Palos: trinquete en x=8,6 con 16 m de altura; mesana en x=20,2 con 18 m. Tres vergas por palo
(anchuras 3,6 / 3,05 / 2,5 m de semiverga) y dos foques al bauprés.

## Como construirlo en el juego

**Los aldeanos no construyen.** En este pack no hay ningun aldeano que coloque bloques:
`swr:tripulacion/reclutar/*` solo hace `summon villager` con nombre, profesion y `Tags`,
y el barco se construye antes de botarlo. La tripulacion es decorado y guion (son los que
suben a bordo al zarpar), no un sistema de construccion. Un aldeano de Minecraft no puede
picar ni poner bloques ni con datapack: eso solo lo hacen jugadores, goles o mods.

### Metodo 1: colocar la estructura (recomendado)

El barco ya esta modelado bloque a bloque en `panel/data/swr/structure/perseus.nbt`
(32 x 24 x 9, 814 bloques solidos: casco, cubierta, tres palos, barra del salon y una mesa de poker;
se regenera con
`python3 herramientas/generar_estructura_perseus.py`). El origen es la esquina de popa
a la altura de la quilla, asi que hay que dejar agua (o aire) y 4 bloques de calado libre debajo:

```
/place template swr:perseus <x> <y> <z>
```

Con el barco ya en el mundo, la quilla queda en `y`, la cubierta en `y+4` y el agua de
flotacion ronda `y+2`: unos 2 bloques de obra muerta por encima de la linea de flotacion, como
pide el modelo. El comando exige que el chunk este cargado: en un mundo nuevo usa antes
`/forceload add <x> <z>` o coloca el barco cerca del spawn. Comprobado en un servidor 1.21.1
con este pack: cubierta, vela de trinquete, invernadero, escalon de proa y helice aparecen
donde dice el plano.

### Metodo 2: a mano con las tablas de arriba

1. Marca la quilla en la capa 0 con el rocker de la tabla (sube 1 bloque en proa y 0,5 en popa).
2. Levanta las cuadernas cada 2 bloques usando las semimangas; el casco es hueco.
3. Cubre la cubierta en la capa 4 y deja los huecos de las tres escotillas.
4. Toldilla en x 2-7, invernadero de cristal en x 13-18, escalones en x 27-29, timon en x 0-1.
5. Palos y vergas donde dice la tabla; velas de lana blanca, tres por palo, y dos foques.
6. Nueve portillas por banda entre x=6 y x=24, a media altura de la obra muerta.
7. Dos helices bajo el espejo de popa y el bote motor colgando de las gruas de cubierta.

### Metodo 3: un mod de construccion

Si prefieres verlo crecer solo, cualquier mod de constructores (Create con sus brazos,
MineColonies o similares) puede poner los bloques del plano, pero ninguno viene en el pack y
habria que anadirlo. Para navegar de verdad hace falta ademas un mod de barcos (Small Ships
o similar): la estructura por si sola es un barco quieto, coherente con la fisica pero sin
flotacion propia, porque Minecraft no la tiene.

El perfil longitudinal, la planta y las estructuras estan dibujados en `PERSEUS_PERFIL.svg`
(se regenera con `python3 herramientas/perseus_modelo.py`).

## Resultado del simulador

| Medida | Valor |
|---|---|
| Masa total | 132.3 t |
| Calado de equilibrio | 1.66 m |
| Francobordo minimo | 2.12 m |
| GM inicial | 1.45 m |
| GZ a 30 grados | 0.79 m |
| Area bajo GZ hasta 30 grados | 0.200 m·rad |
| Borda al agua | 37 grados |
| AVS real (inundacion) | 37 grados |
| Velocidad limite de casco | 12.4 nudos |
| Superficie velica | 143 m2 (SA/D 5.60) |

Detalle por escora en `PERSEUS_FISICA.md`.

## Limites honestos del modelo

- Es teoria de franjas con casco discretizado: no modela olas, viento racheado ni la maniobra.
- La inundacion se detecta cuando la borda toca el agua; no simula el agua entrando poco a poco.
- Los pesos son un presupuesto de ingenieria, no un pesaje: forro de 12 cm, cuadernas al 160 %,
  techo interior, cubierta, motor, tanques y lastre de 22 t.
- Un Minecraft no tiene flotacion: esto valida que el barco **seria** coherente en el agua real.
