# Stone World Reborn

Pack de Dr. Stone para **2 jugadores**, montado tomando lo que ya existe y corrigiendo lo que falla.
Base: **Minecraft 1.21.1 + NeoForge** (única combinación donde conviven la petrificación, las colonias autónomas y las aldeas de Millénaire).

| Archivo | Qué es |
|---|---|
| `mods.txt` | Lista ordenada, con fuente (CurseForge / Modrinth / GitHub) y versión |
| `IA.md` | Delegar la instalación a un agente de terminal, con el prompt para pegar |
| `SEGUNDO_JUGADOR.md` | Lo que tiene que hacer el segundo jugador, paso a paso |
| `REGLAS.md` | Reglas de la partida, el bucle y el recorrido completo con criterios de terminado |
| `ERAS.md` | Estudio de la serie era por era y su traducción a Minecraft |
| `panel/` | Datapack del panel del reino (eras, ciudadanos, aldeas) |
| `panel-del-reino.zip` | El mismo datapack listo para copiar al mundo |

---

## 1. ¿El segundo jugador tiene que instalarse todo?

**Sí.** Los mods que hacen la gracia (Dr. Stone KoS, MineColonies, Millénaire, Create) son **cliente + servidor**: añaden bloques y pantallas, y un cliente vanilla no puede conectarse. Lo que no tiene que hacer es *montarlo*: importa el `.zip` del perfil y la app le baja las versiones exactas. Los pasos están en `SEGUNDO_JUGADOR.md`; si prefieres no hacerlos a mano, `IA.md` deja que los haga un agente.

Ojo: **la mitad de estos mods no están en Modrinth** (Millénaire, MineColonies, FTB Quests, Immersive Engineering, Serene Seasons y las dependencias de MineColonies dan 404; comprobado). Todos están en CurseForge, así que ese es el gestor del pack.

Y ojo con lo que baja el instalador: `--download` **solo trae los de Modrinth** (20). Los 18 que solo viven en CurseForge los imprime con su página y se cogen a mano, porque son obra de sus autores y varios son ARR; bajar sus archivos por el CDN sin pasar por su web no es algo que este proyecto haga por ti.

| Método | Quién hace qué |
|---|---|
| **CurseForge App + zip del perfil** | Tú exportas; él importa. Recomendado |
| **Prism Launcher + instancia exportada** | Le pasas el `.zip` de la instancia, con configs incluidas |

### Quién hospeda

- **LAN**: gratis, pero **tú tienes que estar jugando** y el mundo se cierra al salir.
- **Servidor dedicado**: jugáis cuando queráis y, sobre todo, **las colonias siguen construyendo aunque nadie esté dentro**. Un servidor apagado no simula nada. Si quieres el efecto 0 A.D. (volver y encontrar el pueblo más grande), esto no es opcional.

---

## 2. Qué he cambiado respecto a lo que ya existe

Los packs publicados (*Dokuta Suton*, *dr.stone Stone World*, *Age of Stone*, *Worlds New Dawn*) tienen la temática bien y tres fallos de fondo:

1. **No hay sociedades, hay aldeanos.** Ahora el fluido milagroso revive ciudadanos de MineColonies y aldeanos de Millénaire: cada revival es mano de obra y cada oficio abre una era.
2. **Se puede rushear el hierro en 20 minutos.** FTB Quests va en el pack **con árbol de misiones**: 5 capítulos y 34 misiones en `quests/` (cabecera de `generar_quests.py`), y el servidor las carga desde `config/ftbquests/quests`. Son de tipo «marcar hecho», así que el orden de eras se refuerza con `REGLAS.md` y con el libro (`/function swr:panel/libro`); y desde el 17/11/2026 **el candado es real**: `/function swr:era/N` se niega a abrir una era si la anterior no se cerró con `/function swr:era/cerrar`. Probado en servidor: con la era 1 abierta, era 3 queda bloqueada; tras cerrar la 2, abre.
3. **Nada compite.** Colonias que se expanden solas + razzias y diplomacia de Millénaire.

Más: `Autonomous Colonies` gestiona colonias sin ti (protegiendo las que fundéis vosotros), versiones clavadas (NeoForge 21.1.262, MineColonies 1.1.1403, Colony Autopilot 1.3.4) y **TerraFirmaCraft fuera del multijugador**.

---

## 3. La decisión difícil: TerraFirmaCraft fuera

TerraFirmaCraft es el mejor mod de realismo que existe y **es lo que rompe este pack**: sustituye el worldgen y renombra materiales. MineColonies pide tablones, trigo y hierro "vanilla"; Millénaire genera sobre terreno normal; KoS espera sus recetas. Meterlo obliga a reescribir medio pack con KubeJS.

- **Pack de 2 jugadores (este)**: realismo por presión (eras cerradas, estaciones, sed, temperatura, Hard, sin keepInventory).
- **Modo experto en solitario**: TFC + Create (packs *TerraFirma Rebirth 2* o *AdventureFirmaCreate*). TFC 4.2.16 sí tiene build 1.21.1 NeoForge. Sin colonias.

---

## 4. El panel de control de los pueblos

Ya existe casi todo, y no hace falta programarlo:

- **Town Hall de MineColonies**: la gestión real de la colonia (contratar, despedir, encargos, permisos). En multijugador tiene sistema de rangos.
- **`/colonyautopilot menu`**: todas las decisiones del alcalde, colonia por colonia (crecimiento, caminos, iluminación, seguridad).
- **Colony Dashboard** (añadido al pack): HUD permanente con constructores, encargos abiertos, enfermos, muertes y ciudadanos, sin abrir menús.

Lo que faltaba era **una vista por encima de todas las aldeas y de la era actual**, y eso es `panel/`:

```
/function swr:panel/informe      parte completo (era, ciudadanos, aldeanos, aldeas)
/function swr:panel/libro        libro con los pasos de la serie, era por era (te lo da como item)
/function swr:libro/indice       mapa de las 5 eras: pasa el raton por cada era, clic abre su ficha
/function swr:libro/era/N        ficha de la era N: que hacer, donde y las formulas al hover
/function swr:descubrir/N        anota las 4 formulas de la era N en el cuaderno
/function swr:libro/cuaderno     libro de campo con todas las paginas ya descubiertas
/function swr:reino/juntos      comprueba si estais los dos y cerca (lo usa el candado)
/function swr:reino/modo        alterna candado en equipo (defecto) / en solitario
/function swr:tripulacion/lista quien va a bordo y que falta para zarpar
/function swr:tripulacion/reclutar/navegante|contable|cocinero   recluta a Ryusui, Sai o Francois
/function swr:tripulacion/botadura  bota el casco (era 4, dentro del puerto)
/function swr:tripulacion/zarpar    zarpa: se niega sin barco botado y los tres a bordo
/function swr:tripulacion/limpiar   retira la tripulacion si se duplica
/function swr:serie/historias    libro «Las cien historias» de Ruri, 12 paginas, y su avance
/function swr:serie/medusa       trofeo de la medusa (era 4) y su avance
/function swr:panel/on|off       mostrar u ocultar la barra lateral
/function swr:era/1 … /era/5     abrir la era (anuncia en el chat; con candado)
/function swr:era/cerrar        cerrar la era actual y desbloquear la siguiente
/function swr:serie/destello    el 1 de abril: título, trueno y partículas verdes
/function swr:serie/cancion     el disco de Lilian (pieza original del resource pack)
/function swr:serie/terraforming/iniciar   epilogo TERRAFORMING (pide la era 5 cerrada); sigue con
                                naufragio, balsa, nitrico y silicio, y estado para saber por donde vas
/function swr:reino/estado      era, revividos y fluido que queda
/function swr:reino/revivir     gasta una dosis de fluido y suma un revivido (cupo 60)
/function swr:pueblo/estatua    coloca una persona petrificada (aldeano con el efecto del mod)
/function swr:pueblo/despetrificar  gasta fluido y revive la estatua mas cercana (6 bloques)
/function swr:pueblo/estado     vecinos, pueblo, estatuas y obra en curso
/function swr:pueblo/obra/iniciar  temporizador de 45 s: todos cogen materiales y construyen
/function swr:pueblo/obra/cancelar corta la obra y devuelve a los vecinos a su vida
/function swr:reglas/duras      Hard, sin regeneración natural, sin keepInventory
/function swr:panel/diagnostico  comprobar el recuento de ciudadanos
/scoreboard players set Ishigami aldeas 12   registrar una aldea con su población
```

Refresca solo cada 5 segundos. Cuenta `minecolonies:citizen` y `minecraft:villager`; si tu versión usa otro id para los aldeanos de Millénaire, la línea está comentada en `panel/data/swr/function/panel/refrescar.mcfunction` para que la cambies.

El mismo datapack trae una **pestaña de avances propia, «Dr. Stone»**: 10 hitos que siguen los arcos (cap. 1-15, 16-60, 61-100, 101-140 y 141-232), más tres sueltos —las gafas de Kinro, las cien historias y la medusa—. Los de era se conceden solos al ejecutar `/function swr:era/N`; el de las gafas salta de verdad al tener vidrio en el inventario.

El **cuaderno de campo** va aparte: el mapa de eras (`swr:libro/indice`) y las fichas (`swr:libro/era/N`) se leen en el chat y **el hover sí funciona ahí**; dentro de un libro escrito 1.21.1 no dibuja tooltips, así que el libro es el cuaderno que se llena. Hay 22 fichas repartidas en 5 eras (fuego, cerámica, vidrio, dinamo, tatara, batería, brújula, computadora, cohete…) cada una con su fórmula —`1/f = 1/s + 1/s'`, `Fe2O3 + 3 CO -> 2 Fe + 3 CO2`, `dv = ve*ln(m0/m1)`— y una nota de para qué sirve. Abrir una era con `/function swr:era/N` ya anota sus fichas; también se puede forzar con `/function swr:descubrir/N`. El contador es `DESCUBRIMIENTOS` en el objetivo `swr`, y `/function swr:libro/cuaderno` reparte 5 etapas de libro según lo que lleves (el libro no se puede editar: pide copia nueva al cerrar una era).

**Los dos jugadores avanzan juntos**: la era, el contador `DESCUBRIMIENTOS` y el cuaderno son **uno solo** para la partida, no uno por persona; abrir una era avisa y entrega el libro a los dos, y el candado se niega si falta alguien o si estais a mas de 80 bloques (`/function swr:reino/juntos` lo comprueba, `/function swr:reino/modo` lo pasa a solitario). Para que las **quests** tambien sean de equipo, montad una fiesta de FTB Teams: `/ftbteams party create` y `/ftbteams party invite <jugador>` (el otro acepta con `/ftbteams party accept`); sin fiesta, FTB Quests lleva el progreso por jugador.

**El pueblo de los agradecidos** es el otro uso del fluido: `/function swr:pueblo/estatua` deja una persona petrificada de verdad (el mod la dibuja en piedra), `/function swr:pueblo/despetrificar` la revive gastando una dosis y el aldeano entra en el censo con un oficio. Al tercero levantan una plaza con campana sin que nadie se lo pida, y cada vecino se construye su propia casa en uno de los 16 solares de alrededor (30 segundos, puerta mirando a la plaza, nombre y barra flotando encima, cama dentro). `/function swr:pueblo/obra/iniciar` arranca ademas un temporizador de 45 segundos: todos los vecinos van a sus puestos, cogen material y el taller se levanta capa a capa. Y desde la plaza cumplen **horario** (`/function swr:pueblo/horario/iniciar`): en los turnos de trabajo cada uno va a su puesto de oficio —seis puestos alrededor de la plaza, cada uno con su bloque de trabajo, su mesa y su sonido (cortapiedras, compostador, telar, barril, mesa de flechas y atril)—, comida a mediodia con pan en la mano, reunion al atardecer y noche cada uno en su casa. El **Panel del pueblo** (una brújula que llega al entrar; se abre pulsando la tecla de su hueco, 1..9, o llevando en la mano el libro de instrucciones que llega con él) enseña de golpe era, fichas, vecinos, casas, puestos, oficios y obra. Cada puesto tiene ademas su cofre y produce items de verdad cada minuto de trabajo (pan, flechas, libros, lana, bacalao, ladrillos), y el oficio no es fijo: el recien llegado coge el que falta y al amanecer se reparte. El cuaderno lo cuenta en cuatro fichas nuevas de la era 2 y una de la era 5 (**26 fichas**), y la mision «El pueblo de los agradecidos» esta en la era 2 de las quests. Los aldeanos no colocan bloques (Minecraft no lo permite): llevan el material y el datapack pone las capas con particulas y sonido. Detalle y limites en `PUEBLO.md`.

**La tripulacion del Perseus** (era 4) es lo que hace que el barco sea un proyecto y no un adorno: se bota el casco en el puerto (`/function swr:tripulacion/botadura`), se reclutan tres NPC con nombre y oficio —Ryusui navegante, Sai contable, Francois cocinero— y `/function swr:tripulacion/zarpar` **se niega** si falta el barco botado, falta uno de los tres o estan a mas de 48 bloques. El viaje sigue siendo en bote: ningun mod del pack simula un casco que flote.

**Qué NO hace**: no mueve a los aldeanos ni les asigna trabajos. Eso es MineColonies, y automatizarlo es Colony Autopilot. El panel es el libro de cuentas del reino, no el alcalde.

---

## 5. ¿Y un mundo con forma de la Tierra?

Sí, y hay una opción buena y reciente: **Earth Platform** (pirut, NeoForge 1.21.1, LGPL-3.0) genera la Tierra real **1:1**: un bloque = un metro, altura real (Everest a 8.848 bloques), clima y biomas reales, terreno dibujado hasta ~94 km.

Pero hay dos avisos serios:

1. **1:1 es enorme.** Japón a América son ~10.000 km de caminata. Para jugar, no para un servidor de dos personas.
2. **Rompe el worldgen de las aldeas.** Millénaire y MineColonies esperan terreno normal; sobre relieve real, las aldeas no aparecen donde toca y los sitios de colonia se colocan mal.

Por eso: **el mapa de la historia NO debe ser la Tierra**. Dr. Stone pasa en una isla pequeña y en la isla del tesoro. Usa Earth Platform como mundo aparte para explorar, y un mundo normal (o una isla pintada a mano) para el Reino de la Ciencia. `Terra 1-to-1`, el mod antiguo de 1:1, solo existe para 1.12.2: no sirve.

---

## 6. Estudio de la serie

En `ERAS.md`: las cinco eras con sus inventos reales y qué existe, qué se aproxima y qué **no existe**. Resumen de los huecos de verdad: **óptica y dinamo están resueltas** por los dos mods propios del pack, `optics-mod/` (lentes, telescopio, banco de pulido, gafas de Kinro) y `crank-dynamo/` (dinamo de manivela con energía NeoForge); los dos compilan con Gradle y se han probado cargados en servidor. Quedan las **sulfamidas** y el **submarino**, que son contenido nuevo, o sea mod Java con ítems y bloques. El panel, las eras, los avances, las quests, los cuadros nuevos y la canción van como datapack o resource pack porque son datos.

---

## 7. Primer arranque (30 minutos)

1. Instancia 1.21.1 + NeoForge 21.1.262, mods de `mods.txt` en orden.
2. **Arranca sin mundo** y mira el log: si falta algo, es una dependencia.
3. Crea mundo en Hard y comprueba:
   - `/gamerule keepInventory false`
   - aldeas de Millénaire al explorar
   - puedes colocar el bloque de colonia
4. Copia `panel-del-reino.zip` a `saves/<mundo>/datapacks/`, entra y `/reload`.
5. **Prueba la petrificación en un mundo de pruebas**: es el evento que puede dejaros a los dos de piedra sin entender el sistema.
6. Solo entonces: invita al segundo jugador (`SEGUNDO_JUGADOR.md` o `IA.md`).

## 8. El bucle que hay que probar antes de construir nada

Petrificar → revivir 3 aldeanos → cada uno da un oficio → la colonia crece sola → el crecimiento paga la siguiente era → Millénaire reacciona (comercio o razzia).

Si aguanta una tarde, el mapa grande merece la pena. Si no, el mapa es decorado caro.

## 9. Comprobar el datapack antes de empaquetar

Un JSON mal escrito o una función que llama a algo que no existe no rompen el mundo: Minecraft los ignora con un aviso en el log y el pack se queda a medias, que es la peor forma de fallar. Para eso está el validador:

```bash
cd minecraft/stone-world
./comprobar_todo.sh          # tests + validación + regenerar el zip
python3 -m validador         # solo validar panel/ y pack-inmersion/
python3 -m validador --json  # lo mismo, para el CI
```

Qué mira, en orden:

- **estructura**: `data/<namespace>/<tipo>/`, nombres en minúsculas, extensión que toca (`.mcfunction`, `.json`, `.nbt`), identificadores repetidos y archivos sueltos donde no van;
- **JSON**: que se lean todos (dice archivo y línea) y que `pack.mcmeta`, tags, advancements, loot tables y predicates tengan lo obligatorio;
- **funciones**: nada de `/` al principio, comillas, llaves y corchetes descuadrados, JSON inválido en `tellraw` y `title`, y comandos que no existen (los de mods salen como aviso, no como error);
- **referencias**: cada `function`, `predicate`, `loot table`, `advancement`, tag `#...` y objetivo de `scoreboard` que se nombra tiene que existir en el pack.

Sale con código 1 si hay algún error. Los avisos no bloquean: `drstonekos` es un comando del mod, así que ahí se espera.

El código está en `validador/`, sin dependencias fuera de la biblioteca estándar, y sus pruebas en `tests/` (`python3 -m pytest`, 61 casos).

## 10. Legal

Dr. Stone KoS, MineColonies y varios de estos mods son **ARR**: servidor privado sí, redistribuir o vender el pack no. Dr. Stone es de Inagaki/Boichi/Shueisha: el mapa se comparte entre vosotros, no se publica. Earth Platform es LGPL-3.0 (se puede usar y modificar).
