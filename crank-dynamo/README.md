# Stone Industry — dinamo de manivela para NeoForge 1.21.1

Mod propio del pack Stone World Reborn. Cierra el hueco de la **era 2/3** que la serie
pone en el centro: en la aldea la electricidad empieza con **dos personas girando una
manivela**, no con una central.

## Qué incluye

| Pieza | Qué hace |
|---|---|
| **Dinamo de manivela** (`crank_dynamo`) | Bloque. Clic derecho = girar: suma 200 ticks (10 s) de giro, acumulables hasta 1200. Mientras gira mete **8 FE/tick** en un buffer de 40.000 FE. |
| Energía | Expone `Capabilities.EnergyStorage.BLOCK` de NeoForge: cualquier cable o máquina del pack (Immersive Engineering, Mekanism…) puede extraer. |
| Receta | 2 cobre + 5 hierro + 1 piedra en patrón `CIC / ISI / III`. |

Guarda su estado en NBT (`TicksGirando`, `Energia`), así que no se pierde al recargar el chunk.

## Compilar (probado el 17/11/2026)

Igual que `optics-mod`: hace falta **Gradle 8.10 y un JDK 21 con `javac`**.

```bash
cd minecraft/stone-world/crank-dynamo
export JAVA_HOME=/ruta/al/jdk-21
gradle --no-daemon -Porg.gradle.java.installations.paths=$JAVA_HOME build
```

Resultado medido: **BUILD SUCCESSFUL in 11s** y `build/libs/stoneindustry-0.1.0.jar` de
**13357 B**. La copia lista está en `dist/`.

## Verificado

- Compila contra NeoForge 21.1.262. Único tropiezo del camino: `BaseEntityBlock` exige
  `codec()` en 21.1; se resolvió con `simpleCodec(CrankDynamoBlock::new)`.
- **Cargado en servidor dedicado**: aparece como «Stone Industry 0.1.0», el bloque se
  coloca con `/setblock` y la receta entra en el recuento de recetas del servidor.
- **Sin probar**: el giro con un jugador real y la transferencia de energía a una máquina
  concreta del pack (hace falta abrir cliente y montar el cableado).

## Siguiente pieza natural

Un **eje y una polea** para llevar la energía al taller, y un bloque «biela» que permita
dos manivelas a la vez (en la serie son dos personas girando, y ese es el gag y la lección).
