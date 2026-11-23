# Lo que no está hecho, y por qué

Lista corta y sin adornos de lo que falta en este repositorio, con el motivo real de cada cosa.
Si algo de aquí se hace, se borra de la lista.

## 1. Integración continua (GitHub Actions)

**No hay** `.github/workflows`. El token de `gh` de esta máquina no tiene el ámbito `workflow`, así
que no se puede subir ni probar un flujo de trabajo. Se arregla con:

```bash
gh auth refresh -s workflow
```

Cuando esté, el flujo es sencillo: `python3 -m pytest`, `python3 -m validador`, `./gradlew build`
en los tres mods y comprobación de enlaces. **No se ha probado en un runner de verdad**, así que
hoy la comprobación es local (`./comprobar_todo.sh`).

## 2. Versión publicada (`v1.1`)

No se ha creado ni la etiqueta ni la release, ni los paquetes con sus `SHA256SUMS`. Motivo: los
cambios viven en dos ramas con PR abierto (#1 y #2) y **no se publica nada sin que el dueño lo
pida**. Para publicarla: mergear en orden, subir la versión en los tres `gradle.properties`,
compilar, empaquetar el datapack, el resourcepack y el mapa, y firmar los hashes.

## 3. El sonido, los títulos y el avance del epílogo

La cadena de `swr:serie/terraforming/*` está comprobada de punta a punta: los pasos, el orden, los
objetos que da y las partículas. Lo que **no** se puede comprobar sin cliente es lo que solo ven
los jugadores:

- los **identificadores de sonido** (`playsound` rechaza cualquier cosa que no sea un jugador, así
  que un id mal escrito solo se vería en partida);
- los **títulos** en pantalla;
- el **avance** `swr:serie/terraforming`, porque `advancement grant` necesita un jugador real
  (el JSON carga: el servidor cuenta 4501 avances sin errores de parseo).

## 4. El aspecto de los doce personajes, visto en pantalla

Los datos están comprobados (`VillagerData`: tipo de aldea, oficio, nivel) y el objeto en la mano
también, pero **no hay cliente en este entorno**, así que nadie los ha visto con sus ropas puestas.
Falta una captura de los doce y, si alguno no se reconoce, cambiarle el tipo de aldea.

## 5. La zapata en una ladera de verdad

Lo probado es el peor caso de "casa colgando": la casa sobre un **hoyo de 5 bloques** bajo el
solar, y ahí la zapata rellena hasta el fondo sin huecos. Lo que **no** se ha probado es una
pendiente natural con terreno alrededor (ni agua, ni cuevas debajo). Además:

- el relleno llega a **9 bloques** de profundidad; un acantilado mayor deja la casa asomada;
- por debajo de **y=-54** el relleno se sale del mundo y Minecraft cancela el comando, así que a
  esa altura no hay zapata.

## 6. Rutinas propias para seis de los doce

Tienen rutina Ruri, Kohaku, Suika, Kinro, Chrome y Kokuyo. Los otros seis (Kaseki, Ginro, Jasper,
Magma, Turquoise, Sapphire) siguen el horario común porque su oficio ya tiene puesto y no había
nada que contar que el pueblo no haga solo. **No se han inventado gestos** que el datapack no
pueda cumplir.

## 7. Lo que no se ha vuelto a probar en esta tanda

El horario completo, la producción de los puestos, los avances, las quests y el libro no se han
tocado, pero tampoco se han vuelto a probar después del pueblo nuevo. Lo verificado el 22/11 es la
zapata, la calle y las rutinas (`PUEBLO.md`), y la cadena del epílogo (`ERAS.md`).

El epílogo tampoco tiene **capítulo propio en FTB Quests** ni **ficha en el cuaderno**: las quests
están en `.snbt` dentro de `quests/chapters/` y el cuaderno se genera desde `swr:descubrir/N`, así
que añadir uno de los dos es un cambio aparte y sin probar en cliente.

## 8. Enlaces externos

Los 18 mods que solo están en CurseForge se listan con enlace, pero **no se han comprobado uno a
uno** con una descarga: sus licencias no permiten bajarlos por detrás y aquí no hay cuenta.

## 9. Capturas

La única captura del pueblo (`docs/capturas/pueblo.jpg`) es de antes de la cuadrícula. No hay
captura del pueblo nuevo, ni del recorrido, ni un vídeo. Hacen falta un cliente y un rato de juego.

## 10. Cosas que el datapack no puede hacer, por si alguien las pide

- **Los aldeanos no colocan bloques.** Minecraft no lo permite: el datapack pone las capas de la
  obra y los vecinos hacen la cuadrilla. Igual con las casas.
- **No hay ropa a medida** para cada personaje: sin resourcepack propio, el aspecto es el tipo de
  aldea (que cambia ropa y tono de piel), el oficio y lo que lleva en la mano.
- **Un aldeano con la IA encendida vuelve solo a la campana o a su mesa**, así que cualquier
  puesta en escena que dure tiene que congelarlo (`NoAI:1b`). Es la razón de que quien monta
  guardia se quede quieto.

## 11. Avances de las eras (resuelto en esta tanda)

- [x] **Avances inalcanzables** — resuelto: `serie/raiz` se concede en el primer tick (con tag `swr_raiz`, para que la pestaña Dr. Stone aparezca) y `serie/fluido` se concede al gastar una dosis en `reino/revivir` y `pueblo/despetrificar`. `tests/test_eras.py` vigila que ningún avance `impossible` quede huérfano.

## 12. El bar del Perseus

El salon (barra, dos mesas de poker, mesa de bolos, Francois y la carta) esta programado y probado
por estructura, pero **no se ha visto en un cliente ni colocado en la cubierta del barco jugado**.
Los montajes piden 7x9 y 5x12 libres: si la cubierta real no los tiene, hay que mover el montaje o
hacerlo modular. Tampoco se ha probado el reparto de cartas con un jugador de verdad (`/random` y
los marcadores si se pueden probar por consola).

Lo que **no** se ha añadido: el mod *Playing Cards & Chips* (NeoForge 1.21.1, CurseForge), que
seria la base natural para las cartas. Se decidio no meter otra dependencia; si se añade, las
mesas y las fichas del datapack siguen valiendo. De bolos no hay nada jugable para 1.21.1
NeoForge: solo decorado y mapas con resource pack.
