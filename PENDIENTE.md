# Lo que no está hecho, y por qué

Lista corta y sin adornos de lo que falta en este repositorio, con el motivo real de cada cosa.
Si algo de aquí se hace, se borra de la lista.

Lo que falta **del lado de la serie** (no del repositorio) está en [`FALTAN.md`](FALTAN.md),
ordenado de más a menos factible.

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

## 4. El aspecto de los 38 personajes, visto en pantalla

Los datos están comprobados (`VillagerData`: tipo de aldea, oficio, nivel) y el objeto en la mano
también, pero **no hay cliente en este entorno**, así que nadie ha visto con sus ropas puestas ni a
los doce de Ishigami ni a las 26 fichas nuevas. Falta una captura de los 38 y, si alguno no se
reconoce, cambiarle el tipo de aldea.
Qué lleva puesto cada uno, y por que, esta en `PERSONAJES.md` ("Lo que se ve de cada uno").
**Tampoco hay skins propias**: un aldeano no acepta textura, y el resource pack cambia a todos
a la vez; haria falta un mod o cabezas de jugador con textura alojada.

## 5. La zapata en una ladera de verdad

Lo probado es el peor caso de "casa colgando": la casa sobre un **hoyo de 5 bloques** bajo el
solar, y ahí la zapata rellena hasta el fondo sin huecos. Lo que **no** se ha probado es una
pendiente natural con terreno alrededor (ni agua, ni cuevas debajo). Además:

- el relleno llega a **9 bloques** de profundidad; un acantilado mayor deja la casa asomada;
- por debajo de **y=-54** el relleno se sale del mundo y Minecraft cancela el comando, así que a
  esa altura no hay zapata.

## 6. Rutinas propias para seis de los doce de Ishigami

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

El salon esta programado y probado por estructura. La barra, los cinco taburetes, una mesa de poker
de 3x3 con dos taburetes y el farol **viajan dentro de `perseus.nbt`** (814 bloques solidos), asi que
al colocar el barco ya estan puestos; la segunda mesa y los carteles los pone `swr:bar/montar`. La
**mesa de bolos no entra a bordo** (12 bloques de largo para 7 de manga) y se monta aparte.

Sigue sin verse en un cliente: el aspecto, la altura de los taburetes y como queda la barra contra
la borda no se han mirado en pantalla. Tampoco se ha repartido una mano con un jugador de verdad
(`/random` y los marcadores si se prueban por consola y en el arnes de servidor).

Lo que **no** se ha añadido: el mod *Playing Cards & Chips* (NeoForge 1.21.1, CurseForge), que
seria la base natural para las cartas. Se decidio no meter otra dependencia; si se añade, las
mesas y las fichas del datapack siguen valiendo. De bolos no hay nada jugable para 1.21.1
NeoForge: solo decorado y mapas con resource pack.

## 13. El arnes de servidor

`herramientas/probar_servidor.py` arranca el mundo de pruebas, espera a RCON (cliente propio en
`herramientas/rcon.py`, sin dependencias) y comprueba nueve cosas sin jugador: que el datapack carga,
que `CIEN` vale 100, que un poker de reyes suma 813, que `bolos/montar` deja diez bolos, que
`swr:bar/estado` responde, que el trigo del campo da 3 y luego 2, que la medusa arma y desactiva, que
`reino/fluido` responde y que los cuatro planos se colocan con `place template`. Sale con 0 solo si
las nueve pasan y apaga lo que encendio. Antes de mandar `reload` espera a que el log diga
`Done (` y lo reintenta hasta tres veces: sin eso, el puerto abre antes de que carguen los 40
mods y el `reload` se comia el tiempo de espera del socket.

```
python3 herramientas/probar_servidor.py --servidor /var/tmp/sw3 --solo-listar   # sin tocar nada
python3 herramientas/probar_servidor.py --servidor /var/tmp/sw3                # arranca y prueba
```

Lo que **no** puede comprobar: `/give` de cartas y platos, `playsound`, `title` y `advancement grant`
necesitan un jugador conectado. Probado en vivo el 25/11/2026 contra `/var/tmp/sw3`: **9/9 en verde** (arrancar tarda unos 4
minutos con 40 mods). Si no hay tiempo, queda `--solo-listar`, que `comprobar_todo.sh` ya ejecuta.

## 14. Detalles de la serie que aun no estan

Cinco cosas que la serie cuenta y el pack todavia no tiene. No son ideas sueltas: cada una dice
que haria falta y que la bloquea. Lo que ya existe no se repite aqui: `serie/destello`,
`serie/cancion`, `serie/cuaderno`, `serie/historias`, `serie/medusa`, las cuatro escenas de
`serie/terraforming/*`, las gafas de Kinro en el mod de optica y los catorce avances de `serie/`.

| Detalle | Donde lo cuenta la serie | Que haria falta | Estado |
|---|---|---|---|
| La radio pirata de Gen | SERIE 5.3; B.15 | funcion con titulo, sonido y avance; sin dependencias | no esta |
| El torneo de la aldea | SERIE 4.5; 9.1 | concurso con marcador y turnos, sin pelea: es lo unico de la lista que el arnes puede comprobar | no esta |
| El disco de Lilian | SERIE 9.4; B.18 | hecho: mod `musica-mod` (`swrmusica:disco_lilian`), `jukebox_song` en el datapack y `serie/disco`; falta oirlo en cliente | hecho |
| El telefono de Senku | SERIE 5.2 | dos jugadores a la vez; en solitario no se nota | no esta |
| El casco de sandia de Suika | SERIE 1.4; 9.1 | hecho: mod `suika-mod` (armadura de casco). Un aldeano no puede llevarlo; lo lleva el jugador | hecho |

El torneo es el unico de los tres que queda y el unico que se puede probar sin cliente
(marcador por RCON). La radio suena en el cliente y el telefono necesita dos personas: se
pueden escribir, no verificar.

### Detalles que no son aspecto

Lo que la serie cuenta y no se ve en una ficha: mecanicas de verdad, no ropa. Salen de la
seccion H de `SERIE.md` (los inventos que la serie no muestra) y del arco del barco.

| Detalle | Donde lo cuenta la serie | Que haria falta |
|---|---|---|
| Conservas y salazon | SERIE 6.4 y H | receta de pescado curado y un barril que alargue la duracion: comida que no se estropee en el viaje |
| Higiene y saneamiento | SERIE H | jabon (ya hay receta), agua limpia y letrinas: menos enfermedad en la colonia |
| Contabilidad y raciones | SERIE 6.4 y 9.3 | cuenta de raciones por dia y aviso cuando baje de un minimo; es marcador, se prueba por RCON |
| Cartografia | SERIE H | mapa del barco y del pueblo con marcadores, no solo el mapa de vanilla |
| Arado y rotacion de cultivos | SERIE H | hecho: `swr:campo` (cuatro parcelas, rendimiento 1..3 y la comprobacion del arnes (9/9)); ver `CAMPO.md` | hecho |
| Trampas y control de plagas | SERIE H | que el grano almacenado se pierda sin trampas |

Arado ya esta hecho y lo comprueba el arnes. Le quedan contabilidad y trampas, que tambien se
pueden comprobar sin cliente; conservas e higiene son recetas y efectos, y la cartografia
necesita mirar el mapa.

## 15. La tanda del 25/11, lo que no se pudo ver

- **Los cuatro planos** se han comprobado como NBT (claves, `DataVersion` 3955 y reproducción byte a
  byte con `--comprobar`) y el arnés los coloca de verdad con `place template` en el mundo de
  pruebas. Lo que **no** se ha visto es cómo quedan en un paisaje: si la isla del tesoro encaja en
  una costa, si Haber-Bosch cabe entre montañas o si Araxá se come una cueva. Hace falta cliente.
- **La medusa** arma, cuenta y desactiva por RCON, pero `drstonekos petrify` sobre un jugador o un
  aldeano de verdad no se ha ejecutado: sin cliente ni jugador conectado, el destello no tiene a
  quién petrificar. El comando del mod ya funcionaba en `pueblo/estatua`, así que el riesgo es bajo.
- **Las 26 fichas nuevas** no se han visto puestas; lo comprobado es que cada archivo existe, que el
  índice 0-37 es contiguo y que el validador acepta sus `VillagerData` y sus nombres.

## 16. Tramo A de la serie (25/11/2026)

Las 29 piezas pendientes del tramo A están escritas y se descubren con
`/function swr:serie/tramo_a`. Lo que se puede comprobar aquí ya se comprobó: 309 pruebas,
validador limpio, `reload` sin funciones rotas y 9/9 en el arnés. Además se ejecutaron en vivo,
sobre un soporte de armadura, los sistemas que no dependen de un jugador real (planos, carteles,
marcadores, contadores y `random`).

Lo que sigue sin poder afirmarse sin cliente:

- el aspecto de las estatuas, las camas, los carteles y las fotos;
- si un jugador real ve los títulos, oye la radio y recibe los objetos de cada sistema;
- la petrificación de un jugador real (se probó con un aldeano: el mod aplica y retira el efecto, y la etiqueta desaparece);
- el Grand Bout, el juicio y la escuela jugados por dos personas de verdad.

Nada de esto se da por bueno por escrito: queda como pendiente de una partida con cliente.

## 17. Tramo B parcial: texturas de la serie (26/11/2026)

Se dibujaron y engancharon 75 texturas de 16x16 en `pack-inmersion/`: la medusa (corazón del
mar, `custom_model_data` 7101), la baraja completa (52 caras, dorso y cinco fichas de 1, 5, 10,
25 y 100), el denario, el billete y los 14 iconos de los avances. Los modelos entran como
`overrides` del ítem vanilla, así que el ítem normal no cambia de aspecto; las cartas y fichas
se dan con `/function swr:bar/poker/muestra` y `fichas_objeto`, y la moneda con
`/function swr:serie/moneda/objetos`. Se regenera con
`python3 herramientas/generar_texturas_tramo_b.py`.

Comprobado: `validador/recursos.py` revisa que cada PNG de ítem mida 16x16, que cada modelo
apunte a una textura que existe y que no haya dos `custom_model_data` repetidos en el mismo
ítem (0 errores en el pack); `tests/test_tramo_b.py` lo comprueba sobre los archivos reales, y
el `reload` del servidor de pruebas no dio errores de avance ni de componentes.

Lo que sigue sin poder afirmarse sin cliente:

- el aspecto de las 52 caras y de los iconos: si se leen a 16x16 y si el glifo de cada avance se distingue;
- si el cliente dibuja el icono de avance a partir de `minecraft:paper` con `custom_model_data` (el dato carga; el dibujo no se vio);
- las otras ocho piezas del tramo B (B3-B6, B8-B10 y B12), que siguen pendientes.
