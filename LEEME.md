# Stone World Reborn

Pack de Dr. Stone para **2 jugadores**, montado tomando lo que ya existe y corrigiendo lo que falla.
Base: **Minecraft 1.21.1 + NeoForge** (única combinación donde conviven la petrificación, las colonias autónomas y las aldeas de Millénaire).

| Archivo | Qué es |
|---|---|
| `mods.txt` | Lista ordenada, con fuente (CurseForge / Modrinth / GitHub) y versión |
| `AMIGO.md` | Lo que tiene que hacer el segundo jugador, paso a paso |
| `ERAS.md` | Estudio de la serie era por era y su traducción a Minecraft |
| `panel/` | Datapack del panel del reino (eras, ciudadanos, aldeas) |
| `panel-del-reino.zip` | El mismo datapack listo para copiar al mundo |

---

## 1. ¿Mi amigo tiene que instalarse todo?

**Sí.** Los mods que hacen la gracia (Dr. Stone KoS, MineColonies, Millénaire, Create) son **cliente + servidor**: añaden bloques y pantallas, y un cliente vanilla no puede conectarse. Lo que no tiene que hacer es *montarlo*: importa el `.zip` del perfil y la app le baja las versiones exactas. Los pasos están en `AMIGO.md`.

Ojo: **la mitad de estos mods no están en Modrinth** (Millénaire, MineColonies, FTB Quests, Immersive Engineering, Serene Seasons y las dependencias de MineColonies dan 404; comprobado hoy). Todos están en CurseForge, así que ese es el gestor del pack.

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
2. **Se puede rushear el hierro en 20 minutos.** FTB Quests cierra las eras.
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
/function swr:panel/on|off       mostrar u ocultar la barra lateral
/function swr:era/1 … /era/5     fijar la era (anuncia en el chat)
/function swr:panel/diagnostico  comprobar el recuento de ciudadanos
/scoreboard players set Ishigami aldeas 12   registrar una aldea con su población
```

Refresca solo cada 5 segundos. Cuenta `minecolonies:citizen` y `minecraft:villager`; si tu versión usa otro id para los aldeanos de Millénaire, la línea está comentada en `panel/data/swr/function/panel/refrescar.mcfunction` para que la cambies.

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

En `ERAS.md`: las cinco eras con sus inventos reales y qué existe, qué se aproxima y qué **no existe**. Resumen de los huecos de verdad: óptica (lentes), dinamo de manivela, sulfamidas y submarino. Son huecos de **contenido nuevo**, o sea mod Java con ítems y bloques; el panel y las eras van como datapack porque son datos. Los tres primeros son mods pequeños y están apuntados como siguiente fase.

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
6. Solo entonces: invita a tu amigo (`AMIGO.md`).

## 8. El bucle que hay que probar antes de construir nada

Petrificar → revivir 3 aldeanos → cada uno da un oficio → la colonia crece sola → el crecimiento paga la siguiente era → Millénaire reacciona (comercio o razzia).

Si aguanta una tarde, el mapa grande merece la pena. Si no, el mapa es decorado caro.

## 9. Legal

Dr. Stone KoS, MineColonies y varios de estos mods son **ARR**: servidor privado sí, redistribuir o vender el pack no. Dr. Stone es de Inagaki/Boichi/Shueisha: el mapa se comparte entre vosotros, no se publica. Earth Platform es LGPL-3.0 (se puede usar y modificar).
