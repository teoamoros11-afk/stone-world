# EL SEGUNDO JUGADOR

Guia para quien se une a la partida. Sirve para cualquier pareja de jugadores, no para una persona concreta.

> **Con TLauncher, la guia buena es [`GUIA_TLAUNCHER.md`](GUIA_TLAUNCHER.md).** Este archivo es para quien use CurseForge App, que si importa un perfil exportado. Y si prefieres no hacer nada a mano: [`IA.md`](IA.md).

## Antes de empezar

Los dos tienen que llevar **exactamente** lo mismo:

- Minecraft **1.21.1**
- **NeoForge 21.1.262** (o el 21.1.x que fije el anfitrion: el mismo en los dos)
- las mismas versiones de mods que `mods.txt`

Si uno lleva otra version, al entrar sale una pantalla de "mod mismatch" y no deja pasar. No es un bug: es la proteccion contra desincronizacion.

## Paso 1 — Gestor

**CurseForge App** (curseforge.com/download-app) es el unico que tiene todos los mods del pack; la mitad no estan en Modrinth. Si el anfitrion te pasa un perfil exportado (`.zip`), este es el programa para importarlo.

## Paso 2 — Importar el perfil

1. CurseForge App → pestaña **Minecraft**.
2. Arriba a la derecha: **Create Custom Profile** → **Import**.
3. Elige el `.zip` del perfil.
4. Espera a que baje los mods. Tarda; no cierres la app.
5. Selecciona el perfil y **Play**. La primera vez tarda varios minutos: esta generando configuracion.

Si no hay `.zip` de perfil, instala los mods a mano siguiendo `DESCARGAS.md`, dependencias primero. `node herramientas/instalar.mjs --check` te dice que falta.

## Paso 3 — Comprobar antes de conectar

- Menu **Mods**: aparecen todos.
- Un mundo de prueba en creativo entra sin crashear.
- Si crashea antes del menu: `logs/latest.log` dice que dependencia falta.

## Paso 4 — Entrar

**A — LAN (rapido, sin servidor)**

1. El anfitrion abre el mundo → `Esc` → **Open to LAN**.
2. En el chat sale `Local game hosted on port XXXXX`.
3. **Multiplayer → Direct Connection** → `ip-del-anfitrion:XXXXX`.
4. Misma red, o VPN tipo Tailscale/ZeroTier si estais en sitios distintos.

*Limite:* al cerrar el juego se acaba, y **las colonias no avanzan** con el mundo cerrado.

**B — Servidor dedicado (para el efecto 0 A.D.)**

1. `java -jar neoforge-21.1.262-installer.jar --installServer` en una carpeta aparte.
2. Copia los `.jar` del perfil a `mods/` del servidor.
3. Arranca una vez, pon `eula=true` en `eula.txt`, vuelve a arrancar.
4. Conecta a `ip:25565`.
5. **Dejalo encendido.** Es lo unico que hace crecer los pueblos mientras no jugais.

## Paso 5 — El panel: solo lo pone el anfitrion

El datapack es **del mundo**, no del jugador.

- Si el mundo lo abre el anfitrion (LAN o servidor): `panel-del-reino.zip` va en **su** `saves/<mundo>/datapacks/`. El segundo jugador no toca nada.
- Si abres tu el mundo: `saves/<mundo>/datapacks/`, luego `/reload` y `/function swr:panel/informe`.
- `/function` solo responde al anfitrion o a un OP.

## Problemas tipicos

| Sintoma | Causa | Arreglo |
|---|---|---|
| "Mod mismatch" al conectar | version distinta de un mod | igualar la carpeta `mods` |
| Crash al crear mundo | Earth Platform + worldgen | crear mundo sin Earth Platform |
| Las aldeas de Millenaire no aparecen | config del mod | activar `villages` en su config |
| El panel sale vacio | el datapack no cargo | `/datapack list` debe mostrar `panel-del-reino` |
| Colonias que no crecen | servidor apagado | dejarlo encendido |
| 8 fps | RAM o render | 6 GB y bajar distancia de render |
