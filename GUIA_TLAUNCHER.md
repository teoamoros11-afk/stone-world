# GUÍA PARA JUGAR CON TLAUNCHER

Para el segundo jugador. Si ya tienes TLauncher instalado, **no necesitas CurseForge App**: TLauncher soporta NeoForge (por TL MODS o con el instalador oficial). Lo que TLauncher **no** hace es importar el `.zip` de un modpack de CurseForge, así que la instalación es guiada: elige bien la versión y copia los `.jar`.

Tiempo: 20-30 minutos la primera vez.

---

## 0. Antes de tocar nada

- **Java 21** instalado (NeoForge 1.21.1 lo exige). Si TLauncher usa su propio Java, asegúrate de que sea 21 o superior.
- **RAM asignada: 4-6 GB** en la configuración de TLauncher. Con MineColonies y 20 mods, 2 GB no llega.
- **Misma versión que el anfitrión**: Minecraft **1.21.1**, NeoForge **21.1.x**, y los mismos mods.

## 1. Crear el perfil NeoForge

**Ruta automática (recomendada)**
1. Abre TLauncher → icono **TL MODS** (abajo a la derecha).
2. **Create** (arriba).
3. Nombre: `Stone World`.
4. Loader: **NeoForge**.
5. Versión de Minecraft: **1.21.1**.
6. Versión de NeoForge: la que elija TLauncher. **Debe ser 21.1.x**; apunta cuál es, porque el anfitrión tiene que usar la misma.
7. **Create**.

**Si tu TLauncher no ofrece NeoForge 1.21.1**
1. Descarga el instalador de **21.1.262** en `neoforged.net`.
2. Ejecútalo → **Install client** → selecciona la carpeta de juego de TLauncher (`%appdata%\.minecraft` en Windows, o la que uses).
3. Cierra TLauncher antes de instalar y vuelve a abrirlo después.
4. En la lista de versiones aparecerá algo tipo `neoforge-21.1.262`.

## 2. Instalar los mods

Dos formas, y conviene combinarlas:

- **Catálogo TL MODS** del perfil: busca el nombre del mod e instálalo. Cómodo, pero los mods nuevos o poco conocidos (Dr. Stone KoS, Autonomous Colonies) puede que no estén.
- **Manual**: descarga cada `.jar` de [`DESCARGAS.md`](DESCARGAS.md) y pégalo en la carpeta `mods` del perfil.

**Ruta de la carpeta `mods`:**
- Windows: `%appdata%\.minecraft\mods`
- Si TLauncher usa carpeta propia: botón **Open folder** en el perfil.
- Si no existe la carpeta, créala (se llama exactamente `mods`).

**Orden**: primero las dependencias (GeckoLib, Structurize, Domum Ornamentum, BlockUI, Multi-Piston), luego los mods que las usan. Después de cada tanda, arranca el juego y comprueba que llega al menú.

## 3. Comprobar que arrancó bien

- Entra en **Mods** desde el menú principal: deben salir todos.
- Si crashea antes del menú: falta una dependencia. El archivo `logs/latest.log` dice cuál.
- Si el juego arranca sin mods: estás lanzando **vanilla** y no el perfil NeoForge.

## 4. Instalar el datapack (los dos jugadores)

1. Entra al mundo al menos una vez para que se cree la carpeta.
2. Copia `panel-del-reino.zip` a `saves/<nombre-del-mundo>/datapacks/`.
3. Dentro del juego: `/reload` y luego `/function swr:panel/informe`.
4. Comprueba con `/datapack list` que aparece `panel-del-reino`.

## 5. Conectar con el anfitrión

**Opción A — LAN (la fácil)**
1. El anfitrión abre el mundo y pulsa `Esc` → **Open to LAN**.
2. Te pasa el puerto que sale en el chat (`Local game hosted on port XXXXX`).
3. **Multiplayer → Direct Connection** → `ip-del-anfitrión:XXXXX`.
4. Misma red WiFi, o una VPN (Tailscale/ZeroTier) si estáis en casas distintas.

**Opción B — Servidor dedicado**
- Te conectas a `ip:25565`.
- El servidor tiene que estar en **`online-mode=false`**, porque las cuentas de TLauncher no son de Microsoft. Consecuencia: cualquiera con la IP puede entrar, así que el anfitrión debe poner **whitelist**.
- Servidor encendido = las colonias siguen creciendo. Servidor apagado = el mundo se congela.

## 6. Problemas típicos

| Síntoma | Causa | Arreglo |
|---|---|---|
| "Mod mismatch" / no deja entrar | versión distinta de un mod o de NeoForge | compara `mods.txt` con el anfitrión |
| Crash al crear mundo | Earth Platform u otro mod de worldgen | crea el mundo sin ese mod |
| Arranca vanilla | lanzaste la versión sin NeoForge | selecciona el perfil NeoForge |
| No aparecen aldeas de Millénaire | config del mod | activa `villages` en su config |
| `/function` no existe | datapack sin cargar o sin permisos | `/reload`, `/datapack list`, y ser OP |
| Va a 8 fps | RAM o render | sube RAM a 6 GB y baja distancia de render |

## 7. Aviso honesto

Esta guía está escrita sin poder probar el pack dentro de Minecraft (no hay juego ni Java de escritorio en el entorno donde se generó). Los pasos de TLauncher están basados en su documentación oficial, pero si algo no coincide, manda el `latest.log` y se corrige.
