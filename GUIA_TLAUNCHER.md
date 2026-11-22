# GUÍA DESDE CERO — JUGAR CON TLAUNCHER

Para el segundo jugador, con TLauncher ya instalado y el `.zip` descargado.
Sigue el orden. No saltes al paso 6 sin haber pasado el 5.

> ## Aviso: esta no es la vía que el proyecto recomienda
>
> La guía existe porque el pack **se probó de verdad** con TLauncher y mucha gente
ya lo tiene instalado, así que funciona. Pero TLauncher es un launcher cerrado que
> se asocia a cuentas no premium y a instaladores con adware, y no queremos que eso
> sea lo primero que aprende quien llega aquí.
>
> **Lo recomendado:** el launcher oficial de Minecraft, creando una instalación de
> NeoForge 21.1.262 aparte, o **Prism Launcher / MultiMC**, que hacen lo mismo con
> un perfil por juego, sin tocar el `.minecraft` de siempre y sin historias. Los
> pasos 3 y 4 son los únicos que cambian: en Prism se crea una instancia
> `1.21.1 + NeoForge 21.1.262` y los mods van en `.minecraft/mods` de **esa**
> instancia.

> ¿Prefieres que lo monte un agente de terminal por ti? → [`IA.md`](IA.md).

---

## Paso 0 — Descomprimir lo que has descargado

El archivo de la release (`stone-world-v1.zip`) **no es un modpack instalable**: es documentación + el datapack.

1. Clic derecho → **Extraer todo** (o descomprime en el Escritorio).
2. Te queda una carpeta con: `README.md`, `GUIA_TLAUNCHER.md`, `DESCARGAS.md`, `LEEME.md`, `ERAS.md`, `ISLA.md`, `isla.json`, `mapa-isla.png`, `panel/`, `panel-del-reino.zip`, `optics-mod/` y `herramientas/`.
3. **De todo eso, para jugar solo necesitas `herramientas/`** (el instalador) y, si eres tú quien abre el mundo, el `panel-del-reino.zip`.
4. El instalador es **Node**, no Java: comprueba con `node --version` (necesitas 18 o más). Si no lo tienes, instálalo desde nodejs.org (LTS) y vuelve aquí.

## Paso 1 — Java 21

NeoForge 1.21.1 exige Java 21. Si TLauncher arranca con Java 17 u 8, el perfil morirá al iniciar.

1. Comprueba: abre la consola y escribe `java -version`. Debe decir **21**.
2. Si no lo tienes, instala **Eclipse Temurin 21** (adoptium.net).
3. En TLauncher → **Configuración** → ruta de Java: apunta a esa instalación si tienes varias.

## Paso 2 — RAM

1. TLauncher → **Configuración** → memoria asignada: **6144 MB** (mínimo 4096).
2. Con 2 GB, MineColonies y 20 mods no cargan: se queda en la pantalla de carga y crashea.
3. Mas de 8 GB no ayuda: Java se pasa el rato recolectando basura y el juego da tirones aunque sobre memoria. En una maquina de 16 GB se probo con 10.492 MB y el cliente real solo usaba 3,4 GB; a 6144 MB va mejor.

## Paso 2.5 — Rendimiento: que no vaya a tirones

En una grafica integrada (Intel HD, Vega, Iris) Minecraft se arrastra con los ajustes de fabrica. Con el juego cerrado, deja `options.txt` asi en la carpeta del `--gameDir`, o ponlo a mano en **Opciones → Graficos**:

| Ajuste | Valor | Por que |
|---|---|---|
| Distancia de render | **8 chunks** | es lo que mas pesa, y crece casi lineal |
| Distancia de simulacion | **8** | alivia al servidor interno, que es el que avisa de `Can't keep up!` |
| Nubes | **desactivadas** | cuestan frames y no aportan nada |
| Sombras de entidades | **desactivadas** | una pasada de render extra por entidad |
| Particulas | **minimas** | con "todas", las aldeas llenan la pantalla |
| Mipmaps | **2** | menos trabajo de texturas |
| Mezcla de bioma | **1** | se nota en los bordes de bioma |
| Vsync | **desactivado** | no limita a 60 ni mete retardo |
| Limite de FPS | **60** | deja CPU libre al servidor interno |

Las claves exactas en `options.txt`:

```text
renderDistance:8
simulationDistance:8
entityShadows:false
particles:2
mipmapLevels:2
biomeBlendRadius:1
renderClouds:"false"
enableVsync:false
maxFps:60
```

**Hazlo con el juego cerrado:** Minecraft reescribe `options.txt` al salir con los valores que tiene en memoria, y si editas mientras juegas no se queda nada.

Si aun asi va justo, el siguiente salto es un mod de render tipo Sodium para NeoForge (Embeddium). No viene en el pack porque cambia la lista de mods y hay que ponerlo en los dos lados.

## Paso 3 — Crear el perfil NeoForge 1.21.1

**Ruta A (automática, la normal)**
1. Abre TLauncher → icono **TL MODS** (abajo a la derecha).
2. **Create** (arriba).
3. Nombre: `Stone World`.
4. Tipo de loader: **NeoForge**.
5. Versión de Minecraft: **1.21.1**.
6. Versión de NeoForge: la que elija. **Apunta el número** (debe ser `21.1.x`) y pásaselo al anfitrión: los dos tenéis que llevar la misma.
7. **Create**.

**Ruta B (si no aparece NeoForge 1.21.1)**
1. Descarga el instalador **21.1.262** de `neoforged.net`.
2. **Cierra TLauncher** antes de ejecutarlo.
3. Ejecuta el instalador → **Install client** → carpeta de juego: la de TLauncher (`%appdata%\.minecraft` en Windows).
4. Abre TLauncher: en la lista de versiones sale algo como `neoforge-21.1.262`. Selecciónala.

## Paso 4 — Meter los mods

**Cuidado con la carpeta:** con TLauncher, `%appdata%\.minecraft\mods` **no es** la carpeta buena. Cada perfil tiene la suya:

```
%appdata%\.minecraft\versions\<nombre-del-perfil>\mods
```

Y en Linux/macOS: `~/.minecraft/versions/<perfil>/mods`. Si metes los mods en la carpeta global, cargas los de tu otra instalación (por ejemplo, uno de Fabric) y el juego muere.

**Pero no todas las instalaciones son iguales.** Hay perfiles de TLauncher configurados a mano que arrancan con la carpeta raíz, y entonces `mods` y `saves` son los de `.minecraft` a secas. Comprobación en 10 segundos: arranca el perfil, abre `logs/latest.log` y busca `--gameDir`. Esa es la carpeta buena:

- `--gameDir ...\.minecraft\versions\Stone World` → mods en `...\versions\Stone World\mods`.
- `--gameDir ...\.minecraft` → mods en `.minecraft\mods` (y los mundos en `.minecraft\saves`).

Pásale ese mismo valor al instalador con `--mc-dir`: si el `--check` dice `0 faltan`, están donde el juego los va a leer.

**Cómo, sin abrir ni una página** (desde la carpeta descomprimida):

```bash
node herramientas/instalar.mjs --check --mc-dir "%appdata%\.minecraft\versions\Stone World"
node herramientas/instalar.mjs --download --mc-dir "%appdata%\.minecraft\versions\Stone World"
```

En Linux/macOS, entre comillas si la ruta tiene espacios:

```bash
node herramientas/instalar.mjs --download --mc-dir "$HOME/.minecraft/versions/Stone World"
```

Baja los **33** (14 por la API de Modrinth, 18 por cfwidget + CDN de CurseForge, más Patchouli que pide el libro de War 'N Taxes). Tarda unos minutos y ocupa ~160 MB. Al terminar debe decir **`0 faltan`**.

**Si algo falla** (sin Node, o un mod cambia de archivo): el script te da el nombre exacto y el enlace; ábrelo, pestaña **Files**, y coge el de **1.21.1 + NeoForge**. Mueve el `.jar` a la carpeta del perfil, no a la global. `DESCARGAS.md` tiene la lista completa como respaldo.

**No añadas OptiFine.** Ya rompió una partida vanilla en esta misma máquina: `NoSuchMethodError: Direction.getUpdateOrder()` al tickear una colmena. El pack no lo necesita.

Después, arranca el perfil **Stone World** (no vanilla). Menú principal → **Mods**: deben salir todos.

## Paso 5 — Comprobar antes de conectar

1. Arranca el perfil y llega al menú principal.
2. **Mods** → están todos.
3. Crea un mundo de prueba en creativo y entra.
4. Si crashea: `logs/latest.log` dice qué mod falta o qué versión no encaja.
5. Si el juego arranca **sin** mods: estás lanzando vanilla, no el perfil NeoForge.
6. Arriba del inventario debe poner **Supervivencia**. Si pone Creativo, `/gamemode survival` (F3+F4 cambia de modo y te deja la partida en trampa).

## Paso 6 — El datapack: solo lo pone el anfitrión

Esto es lo que más se equivoca: **el datapack es del mundo, no del jugador.**

- Si **el anfitrión abre el mundo** (LAN o servidor), el `panel-del-reino.zip` va en **su** carpeta: `saves/<nombre-del-mundo>/datapacks/`. Tú no tienes que hacer nada.
- Si algún día **tú** abres el mundo, entonces sí: `%appdata%\.minecraft\saves\<mundo>\datapacks\` y `/reload` dentro del juego.
- El comando `/function swr:panel/informe` solo funciona para el anfitrión o para un OP.

## Paso 7 — Conectar

**LAN (lo más rápido)**
1. El anfitrión abre el mundo → `Esc` → **Open to LAN**.
2. En el chat le sale `Local game hosted on port XXXXX`. Te pasa ese número.
3. **Multiplayer → Direct Connection** → `ip-del-anfitrión:XXXXX` → Join.
4. Misma WiFi, o VPN (Tailscale/ZeroTier) si estáis en casas distintas.

**Servidor dedicado**
- Te conectas a `ip:25565`.
- El servidor tiene que estar en **`online-mode=false`** (las cuentas de TLauncher no son de Microsoft) y con **whitelist**, o cualquiera con la IP entra.

## Paso 8 — Primera partida

1. El anfitrión escribe `/function swr:panel/informe`: sale era, ciudadanos y aldeas.
2. Los dos comprobáis el chat: si veis "Panel activo", el datapack cargó.
3. Empezad por la fase 2 de `ISLA.md`: **el Town Hall de MineColonies antes que las casas**.
4. No os separéis más de 500 bloques al principio: las colonias solo avanzan con el mundo cargado.
5. Para no perder el hilo de la serie: `/function swr:panel/libro` os da un libro con los pasos, era por era.

## Si algo falla

| Síntoma | Causa | Arreglo |
|---|---|---|
| Crashea al cargar | falta una dependencia o Java no es 21 | mira `logs/latest.log`, instala Java 21 |
| Crashea al añadir un mod | Autonomous Colonies o versión cruzada | quita ese mod y arranca |
| "Mod mismatch" al conectar | versión distinta de un mod o de NeoForge | compara tu carpeta `mods` con la del anfitrión |
| Arranca vanilla | lanzaste la versión sin NeoForge | selecciona el perfil NeoForge |
| Arranca sin mods aunque los jars esten | los jars estan en otra carpeta que la del `--gameDir` | mira `--gameDir` en `logs/latest.log` y pon los mods ahi |
| No hay aldeas de Millénaire | config del mod | activa `villages` en su config |
| `/function` no existe | datapack no cargado o no eres OP | lo pone el anfitrión; `/reload` y `/datapack list` |
| Crashea con `ResolutionException: Modules minecraft and _1._21_1 export package net.minecraft.client` | el lanzador metió el `.jar` vanilla en el classpath junto a NeoForge | selecciona y arranca el perfil `neoforge-21.1.262` tal cual, sin jar suelto de 1.21.1 |
| 8 fps | RAM o render | 6 GB de RAM y baja la distancia de render |

## Aviso

Probado con el juego abierto hasta el menú principal: un servidor NeoForge 21.1.262 arranca en 2,1 s con el datapack detectado (`file/panel-del-reino.zip (world)`) y el cliente carga los mods sin errores propios del pack.

> Ojo con el recuento: en esa prueba (13/11/2026) el instalador bajaba **34 mods** de Modrinth y CurseForge. Ahora baja solo los **20 de Modrinth** y los 18 de CurseForge se cogen a mano, así que el total de jars que verás es el mismo, pero el `--download` no los pone todos.

También **dentro de un mundo** (17/11/2026): mundo copiado a un gameDir aparte, los mods de entonces y fps leídos con el overlay F3 del propio juego. Con los ajustes de §2.5 a 1280x720: **mediana 59,5 fps quieto y 63 andando**, mínimos de 28-36 en los picos de carga de chunks y de colonias. Si algo no coincide, manda el `latest.log` y se corrige.
