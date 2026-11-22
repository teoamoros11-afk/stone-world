# El Perseus en el simulador fisico

Modelo geometrico en `herramientas/perseus_modelo.py`, simulacion en `herramientas/simular_perseus.py`.
Escala 1 bloque = 1 m. Cascada de calculo: casco discretizado en celdas de 0,20 m, giro del casco por
angulo de escora, busqueda de la flotacion que iguala el peso y calculo del brazo `GZ = y_B - y_G`
en coordenadas del mundo (separacion horizontal entre la vertical de empuje y la de peso).

## Pesos

| Partida | kg |
|---|---|
| forro exterior de roble | 40.610 |
| cuadernas. baos y mamparos | 18.275 |
| forro interior y sollados | 9.427 |
| cubierta y toldilla | 10.920 |
| palos. vergas y jarcia | 2.600 |
| velas y cabos | 140 |
| motor. ejes y dos helices | 3.800 |
| combustible y tanques | 2.800 |
| agua dulce | 1.600 |
| viveres y cocina | 1.300 |
| tripulacion (12 personas) | 936 |
| equipo cientifico y carga | 16.000 |
| hierros. clavazon y herrajes | 1.900 |
| lastre de piedra | 22.000 |
| **Total** | **132.308** |

## Resultado

- Calado de equilibrio: **1.66 m**
- Francobordo minimo: **2.12 m**
- Volumen desplazado: **129.1 m3**; reserva de flotabilidad: **282 %**
- KB **1.06 m**, BM **1.99 m**, KG **1.60 m**, **GM 1.45 m**
- GZ maximo **1.32 m** a 60 grados; AVS de formas **>70 grados**
- La borda baja al agua a **37 grados** (estacion x=14.5): AVS real **37 grados**
- Area bajo la curva: 0.200 m·rad hasta 30 grados, 0.363 m·rad hasta 40
- Velocidad limite de casco: **12.4 nudos** (23.0 km/h)
- Superficie velica 143 m2, SA/D 5.60

## Criterios

| Criterio | Valor | Estado |
|---|---|---|
| GM inicial >= 0,15 m | 1.45 m | cumple |
| GZ >= 0,20 m a 30 grados | 0.79 m | cumple |
| GM <= 1,60 m (no excesivamente rigido) | 1.45 m | cumple |
| AVS real (borda al agua) >= 30 grados | 37 grados | cumple |
| la borda no se inunda antes de 30 grados | 37 grados | cumple |
| area hasta 30 grados >= 0,055 m·rad | 0.200 | cumple |
| francobordo >= 0,90 m | 2.12 m | cumple |
| SA/D en rango de bergantin (4,5-6,5) | 5.60 | cumple |
| calado <= 2,20 m (agua somera) | 1.66 m | cumple |

## Curva de estabilidad

| Escora (grados) | GZ (m) |
|---|---|
| 0 | -0.008 |
| 5 | +0.116 |
| 10 | +0.245 |
| 15 | +0.376 |
| 20 | +0.512 |
| 25 | +0.647 |
| 30 | +0.790 |
| 35 | +0.936 |
| 40 | +1.077 |
| 45 | +1.171 |
| 50 | +1.257 |
| 55 | +1.305 |
| 60 | +1.322 |
| 65 | +1.310 |
| 70 | +1.281 |

## Por que estos numeros son los del Perseus y no otros

- La serie da: bergantin modificado, dos palos cuadros con tres velas cada uno, dos foques,
  cubierta plana, toldilla con sala de comunicaciones, invernadero, tres escalones de proa,
  timon y dos helices, y 'mas de 20 m de eslora' (lo que Ryusui pide para que despegue un avion).
- Lo que no da, y aqui se elige con criterio de ingenieria: 30 m de eslora total, 7 de manga,
  3,6 de puntal, 1,85 de calado, 12 de tripulacion y lastre de piedra de 34 t.
- El lastre es lo que hace que un casco de madera de 30 m no vuelque: sin esas 34 t bajas el KG
  sube y el GM se vuelve negativo. Es exactamente lo que Kaseki aprende a base de lastrar.
