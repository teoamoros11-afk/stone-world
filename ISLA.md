# LA ISLA DEL REINO DE LA CIENCIA

Diseño de mapa para el pack Stone World Reborn. Todo en bloques (1 bloque = 1 m).
Ejes: **X = este**, **Z = sur**, **Y = altura**. El plano `mapa-isla.png` cubre 2.400 × 2.400 bloques y sale del mismo `isla.json` que esta tabla, así que si cambias uno, cambias el otro.

- `isla.json` → zonas y polígono del terreno, para WorldPainter / Axiom / máscaras.
- `mapa-isla.png` → plano cenital con los 8 marcadores.
- Datapack → `/function swr:viaje/<zona>` te lleva a cada sitio.

## Las 8 zonas

| # | Zona | Esquina (X, Z) | Tamaño | Y | Para qué |
|---|---|---|---|---|---|
| 1 | **Aldea de Ishigami** | −370, −300 | 220 × 200 | 70 | Colonia principal: Town Hall, chozas, horno tatara, laboratorio |
| 2 | **Cueva del milagro** (Montaña Calva) | 110, −490 | 180 × 140 | 78 | Entrada de cueva y cámara del fluido: aquí empieza el bucle |
| 3 | **Campo de estatuas** | 290, 10 | 260 × 260 | 65 | Llanura de aldeanos petrificados: la mano de obra |
| 4 | **Cascada y central** | −120, −10 | 120 × 140 | 62 | Salto de 18 bloques para la hidroeléctrica (era 3) |
| 5 | **Puerto y astillero** | −50, 450 | 220 × 140 | 63 | Muelle, grúa y varadero (era 4) |
| 6 | **Bambú y cantera** | −520, 20 | 200 × 200 | 72 | Bambú, carbón, cobre y estaño: la despensa de la era 2 |
| 7 | **Colonia rival (Tsukasa)** | 160, −200 | 180 × 180 | 74 | Segunda colonia, para tu amigo: a 518 bloques de la aldea |
| 8 | **Punto de aparición** | 240, 600 | 40 × 40 | 64 | Playa sureste; se llega a la aldea caminando |

**Fuera del plano:** la isla del tesoro está **3.000 bloques al este** (era 4: platino, la medusa, el barco de vapor). No se construye hasta que el reino funcione.

## Por qué estas distancias

- **Aldea → campo de estatuas: 760 bloques.** Suficiente para que el campo no se vea desde la plaza, pero se llega en un minuto. El jugador tiene que *ir a buscar* gente, no encontrarla en el jardín.
- **Aldea → colonia rival: 518 bloques** (justo por encima del mínimo de 500 de MineColonies; por debajo no deja fundar la segunda). Si tu config pide más, mueve el marcador 7 hacia el este.
- **Cascada a 328 bloques del pueblo**: el tendido eléctrico de la era 3 tiene que *llegar*, y eso es contenido, no decorado.
- **Spawn a 970 bloques de la aldea y 224 del puerto**: empezar lejos obliga a atravesar la isla, pero no tanto como para aburrir.
- **Cueva arriba (Y 78) y campo abajo (Y 65)**: la subida a la Montaña Calva es el primer "viaje" de la serie.

## Materiales por zona

| Zona | Paleta | Nota |
|---|---|---|
| Aldea | roble oscuro, piedra, teja de arcilla, camino de tierra | nada de piedra pulida: sigue siendo era 1-2 |
| Cueva | piedra, piedra musgosa, antorchas | oscura a propósito: sin luz no se ve el milagro |
| Estatuas | hierba seca, piedra, **aldeanos petrificados de verdad** | no son decorado: son entidades petrificadas con el mod |
| Cascada | piedra, agua, roca pulida | el desnivel se hace antes de la central |
| Puerto | tablones, troncos, cadena | influencia de Ryusui: más rico que la aldea |
| Bambú | bambú, tierra, grava | el filamento de la primera bombilla sale de aquí |

## Orden de construcción (7 fases)

Cada fase tiene criterio de terminado. **No pases a la siguiente sin cumplirlo**: es lo que evita tener un mapa bonito y un reino que no funciona.

### Fase 0 — Preparación (1 h)
- Semilla y tipo de mundo decididos; **copia de seguridad antes de tocar terreno**.
- `/gamerule keepInventory false`, dificultad Hard.
- Datapack `panel-del-reino.zip` en `saves/<mundo>/datapacks/`.
- Trucos activados (los necesitas para `/function swr:viaje/*`).
- ✅ *Terminado cuando* `/function swr:panel/informe` responde.

### Fase 1 — La isla (8-15 h)
- Contorno del polígono de `isla.json`, playas al sur, sierra al norte.
- Río de punta a punta y **salto de 18 bloques** en (−60, 60).
- Bioma coherente: bosque templado, bambú al oeste, llanura al este.
- ✅ *Terminado cuando* puedes recorrer el río desde la montaña hasta el mar sin salir del cauce.

### Fase 2 — Aldea de Ishigami (10-20 h)
1. **Primero el Town Hall de MineColonies** en la plaza (−260, 70, −200): define el área de colonia y trae los 4 primeros ciudadanos. Si construyes las casas antes, el área protegida te las tapa o te las deja fuera.
2. Plaza, 6 chozas, almacén, granja de mijo, horno de carbón.
3. Cercado de animales y pozo.
- ✅ *Terminado cuando* hay 10 ciudadanos trabajando y la colonia sube de nivel sola.

### Fase 3 — Cueva del milagro y campo de estatuas (3-5 h) ← **el núcleo**
1. Entrada de cueva en (200, 78, −420) y cámara del fluido dentro.
2. Campo de estatuas: coloca un grupo de aldeanos y **petrifícalos con el evento del mod** (o revivelos selectivamente). No uses armor stands: el campo tiene que ser reversible.
3. Cerca perimetral y camino de vuelta a la aldea.
- ✅ *Terminado cuando* revives 3 aldeanos y **se convierten en ciudadanos con oficio**. Si no se convierten, para todo: el pack no funciona.

### Fase 4 — Infraestructura y comida (5-8 h)
- Camino aldea ↔ cueva ↔ campo de estatuas, puente sobre el río, muelle pequeño.
- Granjas suficientes para que la colonia no pase hambre mientras construyes.
- ✅ *Terminado cuando* dejas el servidor 20 minutos sin jugar y la colonia ha avanzado sola.

### Fase 5 — Cascada y central (6-10 h)
- Reforzar el salto, canalizar el agua, construir la central (Create / Immersive Engineering).
- Tendido eléctrico hasta la aldea y primeras bombillas.
- ✅ *Terminado cuando* hay luz eléctrica en la plaza a medianoche.

### Fase 6 — Puerto y astillero (8-12 h)
- Muelle, grúa, varadero; el barco de Create.
- Depósitos y almacén del puerto.
- Ningun mod del pack simula un barco que flote: el casco de Create es escenografia y para navegar de verdad se usa el bote vanilla.
- El casco se construye con el plano de `PERSEUS.md` (cuadernas, capas y estructuras) y se comprueba con el simulador de `PERSEUS_FISICA.md`.
- En partida no hace falta picar bloque a bloque: el barco entero esta en la estructura `swr:perseus` y se coloca con `/place template swr:perseus <x> <y> <z>` (chunk cargado). Los aldeanos de la tripulacion **no** construyen: son decorado con oficio y candado de zarpe.
- ✅ *Terminado cuando* sales a mar abierto, vuelves y traes carga: el viaje se hace en bote, el astillero es el proyecto.

### Fase 7 — Colonia rival e isla del tesoro (10-20 h)
- Colonia de tu amigo en el marcador 7: su reino, no el tuyo. MineColonies permite una colonia por jugador.
- Isla del tesoro 3.000 al este: cofres, platino y el evento de la medusa.
- ✅ *Terminado cuando* las dos colonias comerciales se ven y compiten por el bambú y el hierro.

**Total: 50-90 h.** Si solo quieres jugar, **fases 0-3 (25-40 h)** ya son Dr. Stone completo y jugable.

## Trampas conocidas

1. **Isla hecha a mano = sin aldeas de Millénaire.** Esas aldeas se generan con el worldgen normal; sobre una isla pintada a mano no aparecen. Solución: o generas el mundo normal y construyes encima, o aceptas que el papel de "los otros" lo haga la colonia rival.
2. **MineColonies necesita suelo llano** para el Town Hall y las chozas. La plaza de la fase 2 tiene que estar plana *antes* de colocar nada.
3. **Petrificar a todos los aldeanos de golpe** te deja sin mano de obra y sin forma de recuperarla. Petrifica por tandas.
4. **Spawn chunks activos**: en un servidor dedicado, mantén el spawn (marcador 8) lejos de la aldea para que la simulación no cargue el pueblo constantemente. Si quieres que la colonia avance sola, al contrario: deja la aldea cerca del spawn.
5. **El campo de estatuas con 200 aldeanos petrificados destroza el rendimiento** (son entidades). 40-60 es el número útil.
6. **Río y lagos**: el agua de Minecraft no simula pendientes. El salto de 18 bloques hay que construirlo con bloques, no esperar que baje solo.

## Herramientas

- **Axiom** (mod de construcción, 1.21.1): terraformar en creativo mucho más rápido que a mano.
- **WorldPainter**: pintar la isla desde `isla.json` antes de entrar al juego.
- **Litematica**: guardar la aldea como esquemático y repetirla en la colonia rival.
- **Chunky**: pregenerar chunks para que no se note el tirón al explorar.
