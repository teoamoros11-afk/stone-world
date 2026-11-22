# El pueblo de los agradecidos

Despetrificas gente, esa gente te lo agradece levantando un pueblo, cada uno se construye su
casa y cuando arrancas el temporizador todos cogen materiales y trabajan. Todo con datapack y el
mod Dr. Stone KoS que ya trae el pack: no hay que compilar nada.

## Los comandos

| Comando | Que hace |
|---|---|
| `/function swr:pueblo/estatua` | Coloca una persona petrificada donde estas. Sale el personaje que toca por el indice (Kohaku, Chrome, Ruri, Kaseki, Suika, Ginro, Kinro, Magma, Kokuyo, Jasper, Turquoise, Sapphire) con su aspecto y oficio fijos: ver [`PERSONAJES.md`](PERSONAJES.md). |
| `/function swr:pueblo/despetrificar` | Gasta una dosis de fluido milagroso y devuelve la vida a la estatua mas cercana (hasta 6 bloques). |
| `/function swr:pueblo/estado` | Vecinos, pueblo, estatuas, casas en obra, fluido y obra general. |
| `/function swr:pueblo/obra/iniciar` | Arranca el temporizador de 45 s: todos los vecinos van a por materiales y levantan el taller. `/function swr:pueblo/obra/cancelar` lo corta. |
| `/function swr:pueblo/casa/cancelar` | Corta la tanda de casas y devuelve a los duenos a su vida. |

Las casas **no** se piden: cada despetrificado empieza la suya solo.

## El bucle, paso a paso

1. **Estatuas.** `swr:pueblo/estatua` invoca un aldeano con `NoAI`, `Silent`, `Invulnerable` y
   `PersistenceRequired`, le pone **ficha de personaje** y le aplica la petrificacion **de
   verdad** con `drstonekos petrify`: el efecto `drstonekos:petrified` (duracion infinita) es el
   que hace que el mod lo dibuje como piedra. No es un armor stand ni un bloque disfrazado.
   La ficha (`swr:personajes/`) es fija, no aleatoria: cada estatua recibe el personaje que
   toca por el indice (Kohaku, Chrome, Ruri…), con su aldea de Minecraft, su oficio, su nivel y
   su objeto en la mano. Esta en [`PERSONAJES.md`](PERSONAJES.md) y no cambia al revivir.
2. **Despetrificar.** `swr:pueblo/despetrificar` comprueba que hay una estatua a menos de 6
   bloques y que queda fluido (`CUPO`, 60 dosis por partida), gasta una y llama a
   `drstonekos depetrify`. El aldeano vuelve a moverse y entra en el censo `VECINOS`. El
   oficio tambien es fijo: los personajes con ficha (`swr_canon`) conservan el suyo y el
   reparto de oficios no los toca; el resto va al oficio que falta en el pueblo (albanil,
   granjero, pastor, pescador, flechero o bibliotecario), que se reequilibra al amanecer.
3. **El pueblo nace solo.** Al tercer despetrificado, `swr:pueblo/fundar` levanta una plaza de
   piedra de 13x13 (el anillo de fuera es para los puestos), con campana y cuatro faroles
   **donde estaba el tercero** (no donde el jugador quiera): la gratitud no pide permiso.
   Debajo lleva zapata de piedra, asi que la plaza no queda colgada si cae en una ladera.
   Marca `PUEBLO 1` y concede el avance `swr:serie/pueblo`.
4. **Cada vecino, su casa.** En cuanto hay plaza, cada despetrificado se pone a levantar su casa
   en un solar. Son **16 solares en cuadricula**, cuatro por brazo: dos filas de dos a cada lado
   de la calle, en los brazos norte y sur a 9 bloques de la calle y 14/22 del centro, y lo mismo
   en los brazos este y oeste. No es un reparto a ojo: `tests/test_pueblo_geometria.py` comprueba
   que no hay dos casas que se pisen, que ninguna invade la plaza y que cada puerta tiene su
   camino (si alguien mueve un solar, el test falla).
   La casa es de 5x5, con suelo de piedra, tres capas de muro (piedra, cristal, madera), techo de
   tablon oscuro con vuelo, cofre dentro y dos faroles encima. La puerta mira siempre a la calle
   que lleva a la plaza, y debajo del suelo lleva una zapata de piedra que rellena el hueco: ni
   flota en una ladera ni queda cortada contra el terreno. Encima flota su nombre y una barra de
   avance, y la obra dura **30 segundos**.
   `swr:pueblo/caminos` traza ademas las cuatro calles de 3 de ancho (del borde de la plaza al
   final de cada brazo, con farola), el camino de tierra de cada puerta a su calle y el cimiento
   de las calles. Sin eso el pueblo eran casas sueltas en cruz.
5. **Una tanda a la vez.** Si llegan mas vecinos mientras se construye, esperan turno: al acabar
   la tanda empieza otra con los que faltaban, sin que tengas que hacer nada. Cada vecino levanta
   **una sola casa** (queda marcado con `swr_casa_hecha`) y entre tandas el reloj vuelve a 0; no
   hay obras encadenadas de rebote.
6. **El temporizador general.** `swr:pueblo/obra/iniciar` pone `OBRA 45` y arranca un reloj de un
   tic por segundo (`swr:pueblo/obra/tick`, reprogramado desde `load` si el servidor se reinicia
   a mitad). La cuenta sale en la barra de accion y las etapas caen a los 42, 36, 32, 29, 26, 23,
   17, 11, 5 y 0 segundos: materiales, cimientos, cuatro capas de muro, techo con vuelo, puerta
   doble, mesa de trabajo, cofre y faroles.

Las dos obras no se pisan: `/function swr:pueblo/obra/iniciar` se niega mientras hay casas en
marcha, y un vecino que sale de la piedra durante la obra general espera a que esta acabe para
empezar su casa.

## El horario del pueblo

Desde que hay plaza, los vecinos cumplen un dia de trabajo. El reloj (`swr:pueblo/horario/reloj`)
mira la hora del mundo cada 5 segundos y cambia de turno solo:

| Turno | Hora del mundo | Que pasa |
|---|---|---|
| 1 Amanecer | 0–999 | Salen de casa, se reunen en la plaza y la campana suena. |
| 2 Manana | 1000–5999 | A trabajar. Se les devuelve la IA y se mueven por el pueblo. |
| 3 Comida | 6000–6999 | Se para todo: pan en la mano, sonido de comer y sobremesa en la plaza. |
| 4 Tarde | 7000–10999 | Vuelta al tajo. |
| 5 Reunion | 11000–11999 | La campana los llama a la plaza; se reparte el dia siguiente. |
| 6 Noche | 12000–23999 | Cada uno se recoge **en su casa** (por su tag `swr_solar_N`) y se queda dentro. |

Los turnos se anuncian en el chat. Cada casa lleva una **cama** desde la fase de detalles, asi que
al recogerse tienen donde dormir. Encima del turno comun, cada personaje con ficha tiene su rutina
propia (`swr:pueblo/horario/rutinas`): Kinro vigila la entrada, Kohaku caza con arco por la manana,
Suika no se separa de ella, a Chrome se le olvida comer y Kokuyo habla al lado de la campana. La
tabla esta en [`PERSONAJES.md`](PERSONAJES.md#rutinas-propias).

## Los puestos de oficio

Cuando nace la plaza se colocan seis puestos a su alrededor (radio 6), cada uno con su **bloque de
trabajo** y una **mesa de trabajo** al lado, y quedan ahi para siempre (`swr:pueblo/puestos`, se
recolocan solos con `/reload` si el mundo es viejo y le faltan):

| Oficio | Bloque de trabajo | En la mano | Sonido |
|---|---|---|---|
| Cantero (mason) | Cortapiedras | Ladrillos | `entity.villager.work_mason` |
| Granjero | Compostador | Trigo | `entity.villager.work_farmer` |
| Pastor | Telar | Lana blanca | `entity.villager.work_shepherd` |
| Pescador | Barril | Bacalao | `entity.villager.work_fisherman` |
| Flechero | Mesa de flechas | Flechas | `entity.villager.work_fletcher` |
| Bibliotecario | Atril | Libro | `entity.villager.work_librarian` |

Cada despetrificado guarda su oficio en un tag (`swr_oficio_0..5`) y, en los turnos de trabajo, se
le lleva a su puesto (a dos bloques a la redonda, para no apilarlos), se le pone la herramienta en
la mano y suena el sonido del oficio en ese puesto, con polvo de trabajo. Los puestos son ademas
bloques de trabajo **de verdad**: un aldeano con su oficio puede reconocerlos y usarlos con la IA
normal de Minecraft cuando esta suelto.

### Lo que produce cada puesto

Cada puesto tiene su **cofre** al lado y, mientras haya alguien trabajando en el (a menos de 6
bloques), deposita su parte **una vez por minuto de turno** en la fila de arriba del cofre, rotando
las tres primeras casillas para que se vaya viendo el monton:

| Puesto | Cohe | Produce |
|---|---|---|
| Cantero | `+8 0` de la plaza | 3 ladrillos de piedra |
| Granjero | `+5 +5` | 2 panes |
| Pastor | `-5 +5` | 2 lanas blancas |
| Pescador | `-8 0` | 2 bacalaos |
| Flechero | `-5 -5` | 6 flechas |
| Bibliotecario | `+5 -5` | 1 libro |

Son items de verdad en un cofre de verdad: se pueden sacar, apilar o dejar que un embudo los lleve.
Si no hay nadie en el puesto, no produce. La cuenta (`swr:pueblo/produccion`) la llama el reloj del
horario, asi que solo fabrica en los turnos de manana y tarde.

### El Panel del pueblo: una tecla y lo ves todo

El datapack no puede inventar teclas nuevas —eso es cosa del mod—, pero si puede aprovechar una que
ya existe: la de los **huecos de la barra rapida (1..9)**. Al entrar (o tras un `/reload`) cada
jugador recibe una **brujula de recuperacion** llamada *Panel del pueblo*; cuando cae en la barra
rapida, **pulsar la tecla de su hueco** imprime el informe completo en el chat, una vez por
seleccion:

- era actual y fichas del cuaderno anotadas (de 26);
- vecinos despetrificados, estatuas en pie y fluido restante;
- casas empezadas y en obra, y cuantos de los 6 puestos estan en pie;
- el turno del horario (y si esta apagado);
- **cuantos vecinos tiene cada oficio** ahora mismo, con su puesto y lo que produce;
- la obra en marcha o parada.

No hay comando que memorizar: sacar el objeto de la barra y volver a pulsar su tecla lo vuelve a
abrir, y `/function swr:panel/ver` hace lo mismo sin el objeto. El **libro de instrucciones** que
llega con la brújula abre el mismo informe: basta llevarlo en la mano principal o en la secundaria
y sale solo, sin tocar la barra rápida. Se reconoce por su portada, así que vale también el libro
entregado antes de existir esta vía. Tiene diez páginas: la novena dice qué produce cada puesto y
cada cuánto, y la última lleva los atajos del pueblo, **cada uno copiable**: pasar el ratón enseña
el comando y pulsarlo lo manda al portapapeles, y solo esa vez. Si el panel se pierde,
`/function swr:panel/dar` lo devuelve (sin libro nuevo).

### Cambiar de oficio segun lo que falta

El reparto no es fijo. El que sale de la piedra coge **el oficio con menos gente**
(`swr:pueblo/oficios/asignar`), no el que toque por turno. Y cada amanecer se hace un reparto
(`swr:pueblo/oficios/reparto`): si un oficio tiene dos o mas vecinos que el mas vacio, **uno se
pasan** al que falta, con su profesion nueva y su puesto. Se mueven como mucho **tres por dia**
(uno detras de otro, recalculando cada vez), para que el pueblo se iguale sin reorganizarse entero
de golpe. `/function swr:pueblo/horario/parar` lo apaga y
`/function swr:pueblo/horario/iniciar` lo vuelve a encender; `/function swr:pueblo/estado` dice en
que turno esta.

Lo que **no** hace: los aldeanos de Minecraft no tienen hambre ni sueño de verdad. No pierden
comida, no se acuestan (no hay animacion de tumbarse) y no se mueren de hambre si no comen. El
datapack les pone la rutina —irse, parar, comer con pan en la mano, volver a casa— y el jugador ve
el pueblo vivir; la necesidad es escena, no mecanica. Igual que con la obra.

## Que es mecanica y que es puesta en escena

Los aldeanos de Minecraft **no pueden colocar bloques**: no hay comando, ni datapack, ni IA que
los haga picar o construir. Cualquier pack que lo "haga" esta poniendo los bloques por detras.
Aqui se dice claro:

- **Mecanica real:** la petrificacion y la despetrificacion (efecto y comandos del mod), el
  censo de vecinos, el gasto de fluido, el oficio, la plaza, los solares, la cola de tandas y los
  dos relojes.
- **Puesta en escena:** al empezar su casa (o la obra general) cada vecino va a su puesto, se
  queda quieto con `NoAI` mirando a la obra y lleva material en la mano (se le ve el bloque). Las
  capas las coloca el datapack en el mismo instante, con particulas de bloque y sonido de
  colocacion. Al terminar recupera la IA y suelta el material.

Es el mismo truco que usan los mapas de aventura: el espectador ve a la cuadrilla trabajar y el
edificio crecer. Si algun dia un mod de constructores entra en el pack, esta parte se puede
sustituir por mano de obra de verdad.

## Donde esta contado

- **Cuaderno de campo:** la era 2 tiene cuatro fichas del pueblo —«El pueblo de los agradecidos»,
  «Cada vecino, su casa», «El dia del pueblo» y «Los oficios y sus puestos»—
  (`/function swr:libro/era/2`, tambien salen al abrir la era). La quinta era cierra con «Lo que
  antes no se podia», que resume el cambio de fondo: aldeas que eran decorado y ahora viven. El
  cuaderno pasa a **26 fichas**.
- **Quests:** la mision «El pueblo de los agradecidos» es la tercera de la era 2, entre el Town
  Hall y el almacen. Es un checkmark: la marcas cuando de verdad has fundado la plaza y cerrado
  el taller. El arbol pasa a **34 misiones**.

## Limites, dichos antes de que sorprendan

- **Hacen falta 3 vecinos vivos** para el pueblo y para la obra general. El contador `VECINOS` es
  acumulado; la obra cuenta los que siguen en el mundo (`PRESENTES`).
- **16 casas como maximo**, y un pueblo por partida (`PUEBLO` se queda en 1). Para mas gente no
  hay solares: el aviso sale en el chat.
- **Sitio despejado.** Cada casa despeja 7x7 y la obra general 10x6 alrededor de donde te pones
  (fachada en tus pies, casa hacia un lado, puestos a 3 bloques al otro), y borra lo que hubiera
  ahi: no pongas el pueblo encima de tu almacen.
- **La zapata rellena 9 bloques hacia abajo**, no mas. En una cuesta normal basta (probado con la
  casa colgando sobre un hoyo de 5); en un acantilado de mas de 9 bloques la casa seguiria
  asomada. Y por debajo de **y=-54** el relleno se sale del mundo (el fondo esta en -64) y
  Minecraft cancela el comando, asi que ahi no hay zapata.
- **Ocho puestos** en la obra general: con mas de ocho vecinos, los demas miran desde detras.
- **Seis puestos de oficio** y dieciseis vecinos: los oficios se repiten (el reparto es
  `VECINOS % 6`), asi que varios comparten puesto. En los turnos de trabajo se reparten a dos
  bloques a la redonda del puesto, no se apilan.
- **El fluido es finito:** 60 dosis (`CUPO`, el mismo contador que `/function swr:reino/revivir`).
  Ese comando viejo sigue existiendo pero solo suma el contador; el que devuelve gente al mundo
  es `despetrificar`.
- **Sin mod no hay piedra:** si quitas Dr. Stone KoS, `drstonekos petrify` falla, la estatua se
  queda de pie como un aldeano normal y `depetrify` no tiene nada que deshacer.

## Verificado en servidor (22/11/2026)

Misma maquina y mismas 41 jars, mundo plano nuevo con **plataforma a y=64** (el suelo del mundo
plano esta en -61 y por debajo de -63 el relleno se sale del mundo, asi que se prueba a una altura
de verdad) y un **hoyo de 7x7x5 bajo el solar 1** para reproducir lo peor de una ladera: la casa
sin nada debajo.

- **Zapata:** con la casa colgando sobre el hoyo, quedaron en `stone_bricks` el suelo (`9 63 -16`),
  las dos esquinas de la zapata (`7 62 -14`, `11 62 -18`) y el fondo a cinco bloques (`9 59 -16`),
  sin un solo hueco de aire debajo (`9 61 -16`). La zapata de la plaza (`0 55 0`) y la calle
  (`0 63 -20`) tambien. Antes de esto el pueblo colgaba: los cimientos solo limpiaban aire hacia
  arriba.
- **Rutinas:** con la hora forzada, en manana Kinro queda en la boca de la calle norte
  (`1 64 -23`) con la espada, Kohaku con `bow` y 8 `arrow` en la otra mano, y Suika en la mesa de
  flechas (`-1 64 -3`) con su `melon_slice`; en la comida Chrome sigue en el atril
  (`3.5 63.9 -4.5`) con el `glass_bottle` y Kinro no se mueve de la entrada; en la reunion Kokuyo
  esta junto a la campana. Todo leido con `data get entity ... Pos` / `HandItems`.

## Verificado en servidor (19/11/2026)

Servidor NeoForge 21.1.262, Minecraft 1.21.1, 41 jars, mundo aparte de pruebas
(`/var/tmp/sw3`, nunca una partida real):

- Las funciones y el avance nuevos cargan con **0 `Failed to load function`** (hubo dos fallos por
  el camino, ya corregidos: la sintaxis 1.20.5+ de las particulas y el `scoreboard ... add -1`,
  que en 1.21.1 hay que escribir como `remove`).
- Estatuas: `active_effects` con `id: "drstonekos:petrified", duration: -1`; al revivir,
  `Depetrified ...`, `VECINOS`, `PUEBLO 1`, oficio asignado y campana de la plaza presente.
- Casas: al revivir a un vecino con plaza, `CASA_T 30`, un marcador en el solar 1
  (`282 73 -96` junto a la plaza de pruebas) y su nombre flotante; el dueno queda con `NoAI 1b`.
  Al acabar: techo de tablon oscuro, muro de madera, banda de cristal, suelo de piedra, puerta de
  roble y cofre comprobados con `execute if block`, el dueno vuelve a `NoAI 0b` y los marcadores
  desaparecen.
- La casa de otra tanda se comprobo igual en el solar sur (`272 73 -86`): techo en `272 77 -86` y
  puerta en el muro que mira a la plaza, `272 73 -88`, `facing=north`. Junto con la puerta del
  solar este (`280 73 -96`) quedan validadas las orientaciones; cada solar lleva su tag
  `swr_dir_0..3`.
- Cola y tope: dos vecinos revividos seguidos hacen una tanda de uno y la siguiente del otro
  (`CASAS` 1 → 2), y al final `CASA_T 0` sin marcadores, sin `NoAI` colgando y con los dos
  marcados `swr_casa_hecha`. Se rellenaron los 16 solares uno tras otro y la cadena se detuvo sola
  en 16, sin repetir casas. Ese fue un fallo real encontrado en pruebas: al cerrar la casa se le
  quitaba la marca al dueno y volvia a la cola; ahora lleva `swr_casa_hecha` de por vida.
- Horario: con el reloj encendido y la hora forzada, a mediodia (`time set 6000`) `TURNO 3`, los
  vecinos quedan con `NoAI 1b` y pan en la mano (`HandItems` = `minecraft:bread`); de noche
  (`time set 13000`) `TURNO 6` y cada uno aparece dentro de su casa, en las coordenadas exactas de
  su marcador (`272 73 -136` para el solar 16); por la manana (`time set 1000`) `TURNO 2` y vuelven
  a`NoAI 0b`. La cama de la casa se comprobo con `execute if block`.
- Dos fallos reales que salieron en estas pruebas y quedan corregidos: el reloj del horario no se
  reprogramaba solo (`schedule` es de un solo uso, asi que se paraba a los 5 s) y `drstonekos
  petrify` sin objetivo petrificaba al aldeano mas cercano en vez de a la estatua recien invocada;
  ahora va con `petrify @s` / `depetrify @s`.
- El marcador de cada casa ya no se borra al terminar: se queda como direccion para el horario de
  noche (`swr_casa_lista`), y por eso `estado` sigue contando solo las casas en obra.
- Puestos de oficio: tras el `/reload` aparecen los **6 marcadores** `swr_puesto_0..5` y los bloques
  comprobados con `execute if block`: cortapiedras y su mesa en `278/279 72 -96`, compostador en
  `275 72 -91`, telar en `269 72 -91`, barril en `266 72 -96`, mesa de flechas en `269 72 -101` y
  atril en `275 72 -101`, cada uno con su mesa de trabajo al lado. Con el reloj en turno 2, un
  vecino marcado como granjero (`swr_oficio_1`) quedo a dos bloques de su puesto con
  `HandItems` = `wheat` x4 y `NoAI` fuera, que es lo que hace `horario/trabajo`. `estado` da
  `Puestos de oficio: 6`.
- **Con cliente real** (`PruebaPanel`, copia del mundo de pruebas): al pulsar la tecla del hueco
  del *Panel del pueblo* sale el informe completo en el chat —era y fichas, vecinos, estatuas,
  fluido, casas, puestos, turno del horario, los seis oficios con su gente y la obra—, y la
  entrega del panel y del libro se anuncia en el chat tal cual. Se recorto el parrafo largo del
  panel (se salia de pantalla) y quedo en el libro, que es donde toca.
- Libro: el objeto con sus diez paginas —la de produccion y la de atajos con siete enlaces
  copiables— se crea sin errores en el juego (`[Instrucciones del Panel]`, 10 paginas, 7
  `copy_to_clipboard`), y el juego normaliza el `hoverEvent` a `contents` con su comando. No
  llegue a abrir el libro en el cliente: el teclado del banco de pruebas no manda bien los
  comandos y el mundo de prueba mata al jugador de noche antes de poder darle el libro.
- Produccion: con el granjero en su puesto, tres llamadas a `swr:pueblo/produccion` dejaron en el
  cofre `277 72 -91` tres casillas con `bread` x2 (slots 0, 1 y 2), que es la rotacion prevista.
- Oficios: `contar` da los seis contadores (C0..C5) y el mas vacio en `MINID`; `asignar` sobre
  Ruri le puso `swr_oficio_2` y `VillagerData.profession` = `minecraft:shepherd`, que era el
  oficio que faltaba; y `reparto`, con el oficio 0 cargado (4 contra 0 y 2 en el 5), hizo sus
  **tres cambios del dia** (`MOVED 3`) dejando 1/1/1/1/0/2; al amanecer siguiente, un solo paso mas
  (`MOVED 1`, C5 2→1 y C4 0→1), con el vecino ya con su profesion nueva (`minecraft:fletcher`).
- Los sonidos (`entity.villager.work_mason`, `work_farmer`, `work_shepherd`, `work_fisherman`,
  `work_fletcher`, `work_librarian`) no se han podido oir: sin jugadores conectados `playsound`
  responde "No player was found" y no valida el id. Son los eventos de trabajo de aldeano de
  1.21.1, pero suenan de verdad solo con un cliente delante.
- La obra general se niega con casas en marcha (`OBRA` se queda en 0) y funciona sola cuando no
  hay ninguna: 45 s, obreros con material, y las seis etapas comprobadas.
- `obra/cancelar` y `casa/cancelar`: estado a 0, sin marcadores y vecinos con `NoAI 0b`.

Lo que **no** se ha podido ver: el chat, los titulos, la barra de accion y los nombres flotantes
con jugadores reales (el servidor de pruebas no tiene clientes conectados). Los comandos, las
entidades y los bloques si estan comprobados.
