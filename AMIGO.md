# LO QUE TIENE QUE HACER TU AMIGO

> **Si usa TLauncher, la guía buena es [`GUIA_TLAUNCHER.md`](GUIA_TLAUNCHER.md).** Este archivo es para quien use CurseForge App, que sí importa el `.zip` del perfil de una vez.

Pásale este archivo y el `.zip` del perfil. No necesita saber nada de mods: solo seguir el orden.

## Antes de empezar

Tenéis que usar **exactamente** lo mismo:
- Minecraft **1.21.1**
- **NeoForge 21.1.262**
- las mismas versiones de mods que `mods.txt`

Si uno tiene una versión distinta, al entrar verá una pantalla de "mod mismatch" y no le dejará pasar. No es un bug: es la protección contra desincronización.

## Paso 1 — Instalar CurseForge App

Descarga e instala **CurseForge App** (curseforge.com/download-app). Es el único gestor que tiene todos los mods de este pack; la mitad no están en Modrinth.

## Paso 2 — Importar el perfil

1. Abre CurseForge App → pestaña **Minecraft**.
2. Arriba a la derecha: **Create Custom Profile** → **Import**.
3. Elige el `.zip` que te ha pasado tu amigo.
4. Espera a que descargue los mods. Tarda; no cierres la app.
5. Selecciona el perfil y pulsa **Play**. La primera vez tarda varios minutos en arrancar: está generando configuración.

## Paso 3 — Comprobar que arranca

- Si crashea antes del menú: falta una dependencia o sobra un mod. Manda el `latest.log` (CurseForge → perfil → carpeta → `logs/latest.log`).
- Si arranca pero un mundo da error: casi siempre es un mod de mundo (Earth Platform) mal configurado. Prueba sin él.

## Paso 4 — Entrar a la partida

**Opción A — Abrir a LAN (rápido, sin servidor)**
1. Tú (el anfitrión) abres el mundo y pulsas `Esc` → **Open to LAN**.
2. La consola te da `Local game hosted on port XXXXX`.
3. Tu amigo entra en **Multiplayer → Direct Connection** y pone `tu-ip-local:XXXXX`.
4. Ambos en la misma red (mismo WiFi) o con una VPN tipo Tailscale/ZeroTier si estáis en casas distintas.

*Límite:* cuando tú cierras el juego, se acaba. Y **las colonias no avanzan** con el mundo cerrado.

**Opción B — Servidor dedicado (para el efecto 0 A.D.)**
1. Descarga el instalador de NeoForge 21.1.262 y crea la carpeta del servidor (`java -jar neoforge-installer.jar --installServer`).
2. Copia los `.jar` de mods del perfil a `mods/` del servidor.
3. Arranca una vez para que genere `eula.txt`, acepta (`eula=true`) y vuelve a arrancar.
4. Tu amigo se conecta a `tu-ip:25565`.
5. **Déjalo encendido.** Es lo único que hace que los pueblos crezcan mientras no jugáis.

## Paso 5 — Instalar el panel (los dos)

1. En la carpeta del mundo: `saves/<nombre-del-mundo>/datapacks/`.
2. Copia ahí `panel-del-reino.zip`.
3. Dentro del juego: `/reload` y luego `/function swr:panel/informe`.

Si dice que el datapack no existe, reinicia el mundo: algunos datapacks solo cargan al abrirlo.

## Problemas típicos

| Síntoma | Causa | Arreglo |
|---|---|---|
| "Mod mismatch" al conectar | versión distinta de un mod | reimportar el mismo `.zip` |
| Crash al crear mundo | Earth Platform + worldgen | crear mundo sin Earth Platform |
| Las aldeas de Millénaire no aparecen | config de Millénaire | activar `villages` en su config |
| El panel sale vacío | el datapack no cargó | `/datapack list` debe mostrar `panel-del-reino` |
| Colonias que no crecen | servidor apagado o Autonomous Colonies sin Colony Autopilot | revisar `mods` y dejar el servidor encendido |
