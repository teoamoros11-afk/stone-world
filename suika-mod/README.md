# Stone Suika — mod del casco de sandia

Pieza propia del pack Stone World Reborn (Dr. Stone): la cascara de melon que Suika no se quita.

## Que incluye

| Item | Receta | Papel en la serie |
|---|---|---|
| **Casco de sandia** (`suikacasco:watermelon_helmet`) | 5 rodajas de sandia, patron `MMM / M M` | la cascara con la que Suika se tapa la cara y con la que rastrea |

- Pieza de **armadura de casco**: 2 puntos, igual que el casco de cuero; se repara con rodajas de sandia.
- Material propio `suikacasco:suika` con textura `textures/models/armor/suika_layer_1.png` (64x32): verde con rayas y borde oscuro.
- Icono de 16x16 y nombre en es/en.

## La talla

La cascara ocupa la cabeza entera, que es exactamente el tamano de la cabeza del jugador: es el
maximo que da la geometria de armadura de vanilla. Mas grande que eso, como la cascara del
anime, pide un renderer propio; aqui no se hace y esta apuntado en `PENDIENTE.md`.

## Compilar

Hace falta un **JDK 21 con `javac`**, en `JAVA_HOME` o en la ruta habitual (el `gradle.properties`
del mod lee `JAVA_HOME`):

```bash
JAVA_HOME=/ruta/al/jdk21 ./gradlew build     # jar en build/libs/suikacasco-0.1.0.jar
```

## Que esta verificado y que no

- **Compilado**: `BUILD SUCCESSFUL` con Gradle 8.10 y JDK 21 contra NeoForge 21.1.262.
- **Cargado en servidor**: el jar en `mods/`, el servidor arranca sin errores del mod y registra
  `suikacasco:suika` y el item; las cinco comprobaciones del arnes siguen en verde.
- **Sin probar**: como se ve puesto y la receta en una mesa de crafteo de verdad (no hay cliente
  en este entorno).
