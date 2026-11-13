# Stone World Reborn

Pack de Dr. Stone para **2 jugadores** en Minecraft **1.21.1 + NeoForge**, más el utillaje para convertirlo en un mundo que se juega solo: pueblos autónomos, eras cerradas y un panel de control.

> Este repo **no contiene los mods**. Son de sus autores y varios son ARR (todos los derechos reservados). Aquí está el trabajo propio: documentación, coordenadas del mapa, datapack y un mod de óptica.

## Empezar aquí

| Si eres… | Lee esto |
|---|---|
| **El amigo que se une** (TLauncher) | [`GUIA_TLAUNCHER.md`](GUIA_TLAUNCHER.md) |
| El anfitrión / montas la partida | [`LEEME.md`](LEEME.md) |
| Quieres la lista de mods con enlaces | [`DESCARGAS.md`](DESCARGAS.md) |
| Quieres el mapa de la isla | [`ISLA.md`](ISLA.md) + [`mapa-isla.png`](mapa-isla.png) |
| Quieres entender qué se puede y qué no | [`ERAS.md`](ERAS.md) |

## Qué hay

```
LEEME.md            el pack: decisiones, arranque, cómo se juega
AMIGO.md            guía del segundo jugador (CurseForge App)
GUIA_TLAUNCHER.md   guía del segundo jugador con TLauncher  ← la buena si usas TLauncher
DESCARGAS.md        mods con enlace y versión
ERAS.md             la serie era por era y su traducción a Minecraft
ISLA.md             diseño de la isla: 8 zonas y orden de construcción
isla.json           las mismas coordenadas en formato máquina
mapa-isla.png       plano cenital generado desde isla.json
mods.txt            lista de mods, fuente y versión
panel/              datapack: eras, ciudadanos, aldeas y viajes
panel-del-reino.zip el datapack listo para copiar a saves/<mundo>/datapacks/
herramientas/       generador del plano + zip
optics-mod/         mod de óptica (lentes y telescopio) para NeoForge 1.21.1
```

## Arranque rápido (anfitrión)

1. Minecraft 1.21.1 + **NeoForge 21.1.262**.
2. Instala los mods de [`DESCARGAS.md`](DESCARGAS.md).
3. Copia `panel-del-reino.zip` a `saves/<mundo>/datapacks/`.
4. Entra y escribe `/function swr:panel/informe`.
5. Sigue [`ISLA.md`](ISLA.md) en orden: fase 0 → 3 antes de construir nada grande.

## El bucle

Petrificar → revivir aldeanos → cada uno da un oficio → la colonia crece sola → el crecimiento paga la siguiente era → las aldeas rivales reaccionan.

## Estado

- El datapack y el plano están **verificados** (JSON válido, zip correcto, 8/8 zonas, 20 funciones).
- El mod de óptica está **sin compilar** aquí: falta Gradle y el entorno de NeoForge. Ver su propio README.
- Nada de esto se ha probado dentro de Minecraft todavía. La primera prueba es `/datapack list` y `/function swr:panel/informe`.

## Créditos y legal

Dr. Stone es de Riichiro Inagaki, Boichi y Shueisha. Este proyecto es un homenaje privado sin ánimo de lucro y no está afiliado a los autores ni a Mojang. Los mods pertenecen a sus autores: se enlazan, no se redistribuyen.
