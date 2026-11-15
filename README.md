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
node herramientas/instalar.mjs --download --mc-dir "RUTA_AL_PERFIL"   # baja los 33
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
quests/              arbol de misiones FTB Quests: 5 eras, 25 misiones
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
- El mod de optica esta **sin compilar** aqui (falta Gradle y el SDK de NeoForge). Ver su README.
- **Pack arrancado de verdad** (13/11/2026): servidor NeoForge 21.1.262 dedicado, Java 21, 33 jars bajados de cero por el propio instalador. `Done (2.1s)`, sin dependencias rotas, el datapack lo detecto solo (`file/panel-del-reino.zip (world)`) y `/function swr:panel/informe` se ejecuto sin error. Quedan 4 recetas de compatibilidad de Thirst que el autor no actualizo (`Parsing error ... thirst:compat/...`): no rompen el arranque, solo no cargan esas recetas.
- Lo que esos arranques destaparon, ya corregido: faltaban **6 dependencias** (BlockUI, FTB Library, FTB Teams, Architectury API, GlitchCore y MineColonyTax), faltaba **Patchouli** para el libro de War 'N Taxes, y **CC: Tweaked 1.121.0 pide NeoForge 21.1.265+**, asi que se fija la 1.120.2.
- **Cliente arrancado de verdad** (13/11/2026): vanilla 1.21.1 + NeoForge 21.1.262, 33 mods, `Setting user: Teo`, `Sound engine started` y menu principal sin ningun error propio del pack. Eso prueba que los mods cargan juntos; **no** prueba aun dentro de un mundo (HUD del panel, shaders, generacion del mapa y rendimiento real).
- **Reglas y recorrido** (`REGLAS.md`): reglas de partida, el bucle y las cinco eras con criterio de terminado; el mismo texto se entrega dentro del juego con `/function swr:panel/libro`.
- **Rendimiento ajustado** (14/11/2026): con GPU integrada el pack iba a tirones con los valores de fabrica (12 chunks de render y simulacion, sombras, nubes, vsync y 10.492 MB de heap para un cliente que usaba 3,4 GB). `GUIA_TLAUNCHER.md` §2.5 trae la tabla completa; lo que mas se nota es render 8, simulacion 8 y 6144 MB de RAM.
- El mapa de la isla es un **plano esquematico**, no un mundo ya terraformado: `ISLA.md` explica las 7 fases para construirlo.

## Para quien llegue de fuera

- La mitad de los mods **no estan en Modrinth** (Millenaire, MineColonies, FTB Quests, Immersive Engineering, Serene Seasons y las dependencias de MineColonies dan 404; comprobado contra la API). El instalador los baja igual: usa `cfwidget` para el listado de archivos y el CDN `edge.forgecdn.net`, que no piden clave. Ya no hay que pulsar Download en 18 paginas.
- Los dos jugadores necesitan **las mismas versiones**. Si no, Minecraft corta la conexion con "mod mismatch", y eso no es un bug.
- `online-mode=false` **solo** tiene sentido en un servidor privado con whitelist. Publico y sin whitelist es regalar el mundo.

## Creditos y legal

Dr. Stone es de Riichiro Inagaki, Boichi y Shueisha. Este proyecto es un homenaje sin animo de lucro, no afiliado a los autores ni a Mojang. Los mods pertenecen a sus autores. TerraFirmaCraft se queda fuera del pack compartido a proposito: ver `LEEME.md` §3.
