# Stone World Reborn

Un mundo de **Dr. Stone** para Minecraft **1.21.1 + NeoForge**, pensado para jugar de dos en dos: petrificas, revives gente, y los pueblos crecen solos mientras tu estas fuera. Con eras cerradas, aldeas rivales, un mapa de isla diseñado a mano y un panel para llevar las cuentas del reino.

> Este repo **no contiene los mods**. Son de sus autores y varios son ARR. Aqui esta el trabajo propio: documentacion, coordenadas, datapack, herramientas y un mod de optica. Los mods se enlazan, no se redistribuyen.

## Empezar

Tres caminos, elige uno:

| Si eres… | Camino |
|---|---|
| **Pereza maxima** y tienes un agente de terminal | [`IA.md`](IA.md): pega un prompt y el agente instala y comprueba |
| **Segundo jugador** con TLauncher | [`GUIA_TLAUNCHER.md`](GUIA_TLAUNCHER.md), paso a paso desde cero |
| **Anfitrion** o quieres montarlo tu | [`LEEME.md`](LEEME.md) + [`DESCARGAS.md`](DESCARGAS.md) |

A que se juega y como se completa, paso a paso: [`REGLAS.md`](REGLAS.md).

Arranque en corto:

```bash
# 1. Java 21 y NeoForge 21.1.262 sobre Minecraft 1.21.1 (perfil aparte del de siempre)
# 2. mods en la carpeta DEL PERFIL, no en la global:
#    ~/.minecraft/versions/<perfil>/mods  (TLauncher);  .minecraft/mods en el launcher oficial
node herramientas/instalar.mjs --download --mc-dir "RUTA_AL_PERFIL"   # baja los 34
node herramientas/instalar.mjs --check    --mc-dir "RUTA_AL_PERFIL"   # debe decir 0 faltan
# 3. panel-del-reino.zip a saves/<mundo>/datapacks/
# 4. dentro del juego: /function swr:panel/informe   y el libro: /function swr:panel/libro
```

## Que hay

```
LEEME.md             el pack: decisiones, por que estos mods, como se juega
REGLAS.md            reglas, el bucle y el recorrido completo, era por era
IA.md                instalacion delegada a un agente + prompt para pegar
GUIA_TLAUNCHER.md    segundo jugador con TLauncher, desde cero
SEGUNDO_JUGADOR.md   segundo jugador con CurseForge App
DESCARGAS.md         mods con enlace y version
ERAS.md              la serie era por era y su traduccion a Minecraft
SERIE.md             estudio de la serie: arcos, personajes y ciencia, de arriba abajo
GUIA_INMERSION.md    paso a paso para jugar dentro de la serie (equipo, ajustes, eras)
pack-inmersion/      pack de recursos: 8 cuadros dibujados y textos del menu
quests/              arbol de misiones FTB Quests: 5 eras, 34 misiones
ISLA.md              diseño de la isla: 8 zonas y orden de construccion
isla.json            las mismas coordenadas en formato maquina
mapa-isla.png        plano cenital generado desde isla.json
mods.txt             lista de mods, fuente y version
panel/               datapack: eras, ciudadanos, aldeas, viajes y el libro de la serie
panel-del-reino.zip  el datapack listo para copiar a saves/<mundo>/datapacks/
herramientas/        instalar.mjs (instala y comprueba) + generador del plano
optics-mod/          mod de optica (lentes y telescopio) para NeoForge 1.21.1
```

## El bucle

Petrificar → revivir aldeanos → cada uno da un oficio → la colonia crece sola → el crecimiento paga la siguiente era → las aldeas rivales reaccionan.

## Estado, sin adornos

- Datapack, plano y coordenadas **verificados**: JSON valido, zip correcto, 8/8 zonas, 20 funciones, distancias minimas de MineColonies respetadas.
- `herramientas/instalar.mjs` **probado de verdad**: resuelve versiones contra la API de Modrinth, descarga, y devuelve codigo de salida 0/1 segun falten mods o no.
- Los **tres mods propios** estan compilados en local con Gradle 8.10 y JDK 21 contra NeoForge 21.1.262: `optics-mod` (`dist/stoneoptics-0.2.0.jar`), `crank-dynamo` (`dist/stoneindustry-0.1.0.jar`) y `pharmacy-mod` (`build/libs/stonepharmacy-0.1.0.jar`). No se bajan de ninguna web.
- **Pack arrancado de verdad** (13/11/2026): servidor NeoForge 21.1.262 dedicado, Java 21, 34 jars bajados de cero por el propio instalador. `Done (2.1s)`, sin dependencias rotas, el datapack lo detecto solo (`file/panel-del-reino.zip (world)`) y `/function swr:panel/informe` se ejecuto sin error. Quedan 4 recetas de compatibilidad de Thirst que el autor no actualizo (`Parsing error ... thirst:compat/...`): no rompen el arranque, solo no cargan esas recetas.
- Lo que esos arranques destaparon, ya corregido: faltaban **6 dependencias** (BlockUI, FTB Library, FTB Teams, Architectury API, GlitchCore y MineColonyTax), faltaba **Patchouli** para el libro de War 'N Taxes, y **CC: Tweaked 1.121.0 pide NeoForge 21.1.265+**, asi que se fija la 1.120.2.
- **Cliente arrancado de verdad** (13/11/2026): vanilla 1.21.1 + NeoForge 21.1.262, 34 mods, `Setting user: Teo`, `Sound engine started` y menu principal sin ningun error propio del pack (el menu cuenta **40 mods** porque suma los integrados de NeoForge).
- **Dentro de un mundo, medido** (17/11/2026): mundo copiado a un gameDir aparte para no tocar partidas, 34 mods, Java 21 y 1280x720 con Embeddium. **Mediana 59,5 fps quieto y 63 andando**, minimos de 28-36 en los picos de carga de chunks y de colonias. Con la GPU al 19-73 %, el limite es la CPU y el servidor integrado (30-63 ms por tick), no la grafica. Metodo y cifras completas en `GUIA_INMERSION.md` §0.
- **Contenido de la serie ampliado** (17/11/2026): pestana de avances propia «Dr. Stone» con 10 hitos repartidos por los arcos, libro de **«Las cien historias»** de Ruri (12 paginas, `/function swr:serie/historias`), trofeo de la **medusa** con su avance, y el arbol de FTB Quests de 25 a **27 misiones** (las cien historias y la medusa). Sigue siendo todo datapack: no hay que recompilar nada.
- **El Perseus con formas y fisica** (17/11/2026): el barco ya no es una caja. `PERSEUS.md` trae el plano a escala 1 bloque = 1 m (30 m de eslora, 7,2 de manga, cuadernas, cubierta, palos y portillas), `PERSEUS_PERFIL.svg` el perfil y la planta, y `PERSEUS_FISICA.md` la simulacion: GM 1,45 m, GZ 0,79 m a 30 grados, borda al agua a 37 grados, 12,4 nudos de velocidad limite de casco. Se regenera con `herramientas/perseus_modelo.py` y `herramientas/simular_perseus.py`. Ademas el barco esta ya modelado bloque a bloque en la estructura `swr:perseus` (la genera `herramientas/generar_estructura_perseus.py`): en partida se coloca entera con `/place template swr:perseus <x> <y> <z>`, sin picar a mano.
- **Tripulacion del Perseus** (17/11/2026): la era 4 deja de ser un checkmark. Botadura en el puerto (`/function swr:tripulacion/botadura`), tres NPC con nombre y oficio —Ryusui navegante, Sai contable, Francois cocinero— y un zarpe que **se niega** si falta barco botado, falta uno de los tres o estan a mas de 48 bloques. Dos avances nuevos (`swr:serie/tripulacion`, `swr:serie/zarpe`), la cadena completa en una pagina propia del cuaderno y en las quests, que pasan de 30 a **33**.
- **El pueblo de los agradecidos** (19/11/2026): el fluido deja de ser un contador. `/function swr:pueblo/estatua` coloca una persona **petrificada de verdad** con el efecto `drstonekos:petrified` del mod; `/function swr:pueblo/despetrificar` la revive gastando una dosis, le da oficio y la suma al censo `VECINOS`. Al tercero, los agradecidos levantan solos una plaza de 9x9 con campana, y `/function swr:pueblo/obra/iniciar` arranca un **temporizador de 45 segundos**: los vecinos van a sus puestos, cogen material y el taller sube capa a capa (cimientos, muros, cristal, techo, puerta, mesa, cofre). Los aldeanos no colocan bloques —Minecraft no lo permite—: el datapack pone las capas y ellos hacen la cuadrilla. Ademas **cada vecino se construye su casa**: 16 solares alrededor de la plaza (cuatro rumbos en anillos de 10, 20, 30 y 40 bloques), 30 segundos por tanda, todas las pendientes a la vez, puerta mirando a la plaza, nombre y barra flotando encima y turnos en cola si llega gente nueva. Ademas el pueblo cumple **horario**: amanecer en la plaza, manana y tarde de trabajo **en el puesto de su oficio** (seis puestos con su bloque de trabajo, su mesa y su sonido: cortapiedras, compostador, telar, barril, mesa de flechas y atril), comida con pan en la mano a mediodia, reunion al atardecer y noche recogidos en su casa, que ya lleva cama (`/function swr:pueblo/horario/iniciar` y `parar`). Una **tecla** (el hueco del *Panel del pueblo* en la barra rápida, 1..9) enseña en el chat todo lo que hace el pueblo y su progreso, y el libro de instrucciones que llega con él abre el mismo informe en cuanto lo llevas en la mano. Cada puesto tiene su cofre y **produce de verdad** una vez por minuto de trabajo (pan del compostador, flechas de la mesa, libros del atril...), y el reparto de oficios es vivo: el nuevo coge el que falta y al amanecer uno se pasa si un oficio va cargado. El cuaderno pasa a **26 fichas** —cuatro del pueblo en la era 2 y «Lo que antes no se podia» en la era 5— y la mision «El pueblo de los agradecidos» es la de la era 2 de las quests, que pasan de **33 a 34**. Todo el detalle, y lo que es teatro, en `PUEBLO.md`.
- **Espacio, farmacia y avance en equipo** (17/11/2026): entra **Ad Astra 1.16.26** (neoforge) con las tres librerias que exige su `mods.toml` —`resourcefullib` 3.0.12, `resourcefulconfig` 3.0.11 y `common-storage-lib` 0.0.10—, y la era 5 deja de ser la que no se podia jugar: el servidor registra Luna, Marte, Venus, Mercurio, Glacio y sus cinco orbitas. Tercer mod propio, **Stone Pharmacy 0.1.0**: sulfamida (C6H8N2O2S) y jeringa que corta veneno, podredumbre, nausea y debilidad. Las quests pasan de 27 a **30** (cohete Dr.1, satelite, base lunar). Y el progreso es **compartido**: una era, un contador `DESCUBRIMIENTOS` y un cuaderno para los dos, con candado que pide a los dos jugadores conectados y a menos de 80 bloques (`/function swr:reino/modo` para jugar solo). Probado en servidor: **41 jars**, `Loaded 5 chapters, 30 quests`, 0 `Failed to load function`.
- **Cuaderno de campo por eras** (17/11/2026): `/function swr:libro/indice` dibuja el mapa de las 5 eras y **pasa el raton por cada linea** para ver coordenadas y las fichas de esa era. `/function swr:libro/era/N` da la ficha de una era (que hacer, donde y las 4 formulas al hover /function swr:libro/era/N). `/function swr:descubrir/N` anota esas 4 fichas en el contador `DESCUBRIMIENTOS`, y `/function swr:libro/cuaderno` entrega el **libro de campo** con las paginas de todo lo ya anotado (5 etapas, 20 fichas). Los libros escritos no se editan: cada vez que creces pides copia nueva. Probado en servidor limpio: `DESCUBRIMIENTOS` 0 → 4 → 8 → 20 y las 47 funciones cargan sin `Failed to load function`.
- **Candado de eras y destello** (17/11/2026): `/function swr:era/N` ya no deja saltarse una era: exige cerrar la anterior con `/function swr:era/cerrar`. Y `/function swr:serie/destello` reproduce el 1 de abril (título, trueno y partículas verdes). Probado en servidor: con ERA en 1 la era 3 se queda en 1, y tras cerrar la 2 sí abre.
- **Dos mods propios y una tanda de detalles** (17/11/2026): `optics-mod` 0.2.0 añade **banco de pulido** (bloque que convierte lente turbia en pulida) y **gafas de Kinro**; `crank-dynamo` 0.1.0 añade la **dinamo de manivela** con energía NeoForge (8 FE/tick). Tres **cuadros propios** (el Perseus 3x2, la medusa 1x1, el destello 2x2) como variantes de cuadro del datapack, la **canción de Lilian** (pieza original en `lilian.ogg`), y reglas duras con **cupo de 60 revividos** (`/function swr:reino/revivir`). Probado en servidor limpio: los dos mods cargan, los bloques se colocan, las tres pinturas se invocan y las funciones corren.
- **Mod propio compilado** (17/11/2026): `optics-mod/` («Stone Optics») pasa de fuente sin compilar a `stoneoptics-0.1.0.jar` (10 KB) con Gradle 8.10 y Java 21 contra NeoForge 21.1.262: lentes sin pulir y pulidas, telescopio con zoom y sus tres recetas. Cierra el hueco de óptica de la era 2; el jar listo queda en `optics-mod/dist/` (no se baja de ninguna web: hay que compilarlo en local).
- **Probado en servidor dedicado** (17/11/2026): NeoForge 21.1.262 con los 34 mods, el `panel-del-reino.zip` cargado como datapack del mundo y las 23 funciones compiladas sin un solo `Failed to load function`; FTB Quests lee `config/ftbquests/quests`. Los avances entran en el arbol al cargar (3935 frente a 3925 de vanilla sin el pack).
- **Reglas y recorrido** (`REGLAS.md`): reglas de partida, el bucle y las cinco eras con criterio de terminado; el mismo texto se entrega dentro del juego con `/function swr:panel/libro`.
- **Rendimiento ajustado** (14/11/2026): con GPU integrada el pack iba a tirones con los valores de fabrica (12 chunks de render y simulacion, sombras, nubes, vsync y 10.492 MB de heap para un cliente que usaba 3,4 GB). `GUIA_TLAUNCHER.md` §2.5 trae la tabla completa; lo que mas se nota es render 8, simulacion 8 y 6144 MB de RAM.
- El mapa de la isla es un **plano esquematico**, no un mundo ya terraformado: `ISLA.md` explica las 7 fases para construirlo.

## Para quien llegue de fuera

- La mitad de los mods **no estan en Modrinth** (Millenaire, MineColonies, FTB Quests, Immersive Engineering, Serene Seasons y las dependencias de MineColonies dan 404; comprobado contra la API). El instalador los baja igual: usa `cfwidget` para el listado de archivos y el CDN `edge.forgecdn.net`, que no piden clave. Ya no hay que pulsar Download en 18 paginas.
- Los dos jugadores necesitan **las mismas versiones**. Si no, Minecraft corta la conexion con "mod mismatch", y eso no es un bug.
- `online-mode=false` **solo** tiene sentido en un servidor privado con whitelist. Publico y sin whitelist es regalar el mundo.
- El datapack **se comprueba solo**: `./comprobar_todo.sh` (tests, estructura, JSON, mcfunctions e ids) y el zip se regenera al final. Ver `LEEME.md` §9.

## Creditos y legal

Dr. Stone es de Riichiro Inagaki, Boichi y Shueisha. Este proyecto es un homenaje sin animo de lucro, no afiliado a los autores ni a Mojang. Los mods pertenecen a sus autores. TerraFirmaCraft se queda fuera del pack compartido a proposito: ver `LEEME.md` §3.
