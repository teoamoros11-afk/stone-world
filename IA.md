# QUE LO INSTALE LA IA

Esta pagina es para quien quiera que un agente de terminal (Freebuff, Claude Code, Codex, OpenCode…) le monte el pack **sin ir abriendo 25 pestanas a mano**.

La idea: el agente baja **los 33 mods solo**, sin abrir una sola pagina, y comprueba el resultado con un script que devuelve un numero. Nada de "ya esta instalado, confia en mi".

---

## 1. Instala Freebuff (una vez)

Requiere **Node.js 18 o superior** (`node --version`). Si no lo tienes: nodejs.org, version LTS.

```bash
npm install -g freebuff
```

Comprueba que responde:

```bash
freebuff --version
```

## 2. Prepara una carpeta y entra

```bash
mkdir stone-world && cd stone-world
freebuff
```

Da igual que la carpeta este vacia: el agente clona el repo el mismo.

## 3. Pega esto

Copia el bloque tal cual. Es el mensaje que le dice al agente que hacer, con la fuente de verdad incluida.

```text
Instala el pack "Stone World Reborn" de Minecraft 1.21.1 + NeoForge en este PC.
Fuente de verdad: https://github.com/teoamoros11-afk/stone-world
Si no hay red, usa el zip ya descomprimido en esta carpeta.

Sigue estos pasos en orden sin pedirme permiso entre uno y otro:

1. Clona el repo aqui: git clone --depth 1 https://github.com/teoamoros11-afk/stone-world.git
   y entra en la carpeta. Lee IA.md, DESCARGAS.md y mods.txt antes de tocar nada.
2. Averigua mi carpeta de Minecraft segun mi sistema (.minecraft en %APPDATA% en Windows,
   ~/.minecraft en Linux). Si ya existe otra instalacion, preguntame solo cual usar.
3. Comprueba Java: "java -version" debe decir 21. Si no, para y dime que instale Eclipse
   Temurin 21; no sigas con otra version.
4. Ejecuta: node herramientas/instalar.mjs --check
   y ensename el resumen (cuantos mods faltan).
5. Ejecuta: node herramientas/instalar.mjs --download
   Baja los 33: Modrinth por su API y CurseForge por cfwidget + edge.forgecdn.net (ninguno
   de los dos pide clave). Tarda unos minutos y ocupa ~200 MB. Si alguno falla, no lo
   inventes: apuntalo y sigue; el script te dara su pagina.
6. Vuelve a ejecutar node herramientas/instalar.mjs --check. Tiene que decir "0 faltan".
   Si queda alguno, abre su pagina, pulsamelo y avisame del archivo exacto (1.21.1 + NeoForge).
7. Si usa TLauncher, averigua la carpeta real de juego: arranca el perfil una vez y busca
   --gameDir en logs/latest.log. Esa ruta es la que manda. Si dice ...\.minecraft, los mods
   van en .minecraft\mods; si dice ...\.minecraft\versions\<perfil>, van en la subcarpeta
   mods de ese perfil. Pasa esa misma ruta a --mc-dir y comprueba que --check da 0 faltan.
8. Copia panel-del-reino.zip a saves/<mundo>/datapacks/ SOLO si soy yo quien abre el mundo,
   y dimelo claro: al segundo jugador no le hace falta.
9. Al terminar, dame este resumen:
   - version de NeoForge que hay que usar (debe ser 21.1.x),
   - RAM recomendada y donde se cambia en mi launcher,
   - lista final de .jar en la carpeta mods,
   - que dentro del juego /function swr:panel/libro da el libro con los pasos de la serie,
   - lo que NO se ha podido instalar y por que.

Reglas:
- No inventes descargas, versiones ni enlaces. Si algo no tiene build 1.21.1, dilo y saltalo.
- No borres ni muevas nada fuera de la carpeta mods.
- Nada de instalar OptiFine: es incompatible con NeoForge.
- Si el usuario usa TLauncher, el perfil se crea en TL MODS con loader NeoForge 1.21.1;
  el .zip de CurseForge NO se importa ahi.
```

## 4. Lo que el agente no puede hacer (y esta bien que lo sepas)

| Cosa | Por que | Quien la hace |
|---|---|---|
| Redistribuir los .jar | Las licencias de los mods no lo permiten: se enlazan, no se copian | Nadie: el script los baja del origen |
| Crear el perfil en TLauncher | Es un programa cerrado, sin linea de comandos | Tu: TL MODS → NeoForge → 1.21.1 |
| Subir la RAM | Ajuste del launcher | Tu: Configuracion → 6144 MB |
| Probar que el juego arranca | Hace falta abrir Minecraft | Tu: menu **Mods** |

## 5. Comprobarlo sin creerte a nadie

El script es la unica fuente de verdad y se puede ejecutar a mano:

```bash
node herramientas/instalar.mjs --check
```

- Sale `0 faltan` y termina con codigo `0` → estan todos.
- Sale una lista de `FALTA` y codigo `1` → eso es lo que queda.
- Tambien avisa si detecta jars de 1.20/1.19 o OptiFine en la carpeta.

Y para revisar que el datapack esta donde toca: el propio `--check` mira `saves/*/datapacks` y dice en que mundos esta puesto.

## 6. Aviso honesto

El script y el pack estan probados con el juego abierto: instalacion desde cero (33 jars), servidor NeoForge 21.1.262 con el datapack cargado y cliente hasta el menu principal con los 33 mods. Lo que sigue sin probarse es **dentro de un mundo** (HUD del panel, graficos, fps). Si el agente se atasca, el log util es `logs/latest.log` de la instancia, y lo que hay que mirar es el primer `Caused by` de arriba abajo.
