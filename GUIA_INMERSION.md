# GUÍA DE INMERSIÓN — jugar como si estuvieras dentro de Dr. Stone

Esta guía es el camino completo, en orden, desde «tengo el pack en un zip» hasta «entro en mi aldea y parece que estoy en la serie». Está escrita para **tu equipo concreto**, no para un PC genérico.

**Leyenda** — cada cosa que hagas lleva su etiqueta:

- 🟩 **Serie**: está en Dr. Stone y se puede hacer tal cual.
- 🟦 **Juego**: lo añade Minecraft o un mod; la serie no lo tiene.
- 🟨 **Adaptación**: se parece a lo de la serie, pero aquí funciona a su manera.

---

## 0. Tu equipo, medido

Estos son los números reales de la máquina (sacados del sistema, no de la caja):

| Componente | Lo que hay | Qué significa para Minecraft |
|---|---|---|
| CPU | 4 hilos, hasta 3,9 GHz | Bien para el juego base; justo con colonias grandes (MineColonies piensa en un solo hilo) |
| RAM | 15 GB totales, ~8 usables | Puedes dar 4 GB al juego sin ahogar el sistema |
| Gráfica | **Intel HD Graphics 620** (integrada, sin VRAM propia) | Es el techo real: 720p-1080p, poca distancia de render, **sin shaders** |
| Disco | 111 GB, **4,2 GB libres** | Aviso serio: antes de instalar hay que liberar 3 GB |

**Consecuencias directas** (y por qué):

1. **Sin shaders.** Una HD 620 comparte memoria con el sistema (~1,7 GB/s de ancho de banda efectivo). Complementary o BSL a 720p dan 5-10 fps y suben la temperatura del portátil. El presupuesto de fotograma se gasta mejor en distancia de render y en Embeddium.
2. **Sin Distant Horizons ni Earth Platform.** Duplican o triplican el trabajo de geometría; no hay margen.
3. **Sin texturas 128x.** Un pack HD multiplica la memoria de textura; con gráfica integrada eso son tirones al girar la cámara.
4. **Sí a Embeddium**, sí a FerriteCore y ModernFix: son gratis en FPS y en RAM.

**Objetivo realista:** 55-70 fps a 1280x720 con distancia de render 8, y mínimos por encima de 40 al pasar cerca de una colonia. Si consigues eso, el juego se siente fluido y no hay que tocar nada más.

---

## 1. Paso 1 — Hacer sitio en el disco

Con 4,2 GB libres no cabe todo: los 34 mods pesan unos 900 MB-1,1 GB, el mundo crece rápido y Minecraft necesita espacio temporal al arrancar.

```bash
# qué está ocupando (tarda unos segundos)
du -sh ~/.minecraft/* 2>/dev/null | sort -h | tail -15

# copias de versiones viejas del pack y zips sueltos: lo primero que se puede borrar
ls -lh ~/Descargas/*.zip ~/Downloads/*.zip 2>/dev/null
```

Antes de borrar nada: **mira la lista**. Lo seguro de quitar son zips ya descomprimidos, instaladores de NeoForge viejos (`.jar` en Descargas) y `logs/` antiguos. Los `saves/` no se tocan sin copia.

**Meta:** dejar al menos **3 GB libres** después de instalar.

---

## 2. Paso 2 — Instalar el pack (34 mods)

```bash
cd ~/stone-world          # o donde tengas el repo clonado
node herramientas/instalar.mjs --check     # dice qué falta, no descarga nada
node herramientas/instalar.mjs --download  # baja los 34
node herramientas/instalar.mjs --check     # ahora debe salir en verde
```

- 🟦 El instalador baja también los mods que solo están en CurseForge (MineColonies, Dr. Stone, FTB Quests…), así que no hay que abrir 25 pestañas.
- **Nuevo en esta versión: Embeddium 1.0.15** (`embeddium-1.0.15+mc1.21.1.jar`). Es un mod de render: reescribe cómo se dibujan los chunks y en gráficas integradas suele **duplicar los fps**. Si algún día ves pantalla negra al entrar a un mundo con Create, quita Embeddium antes que Create.
- Arranca **una vez** y cierra: así se generan las carpetas `config/` que luego se ajustan.

**Comprobación de que está bien:** el menú principal debe decir **NeoForge 21.1.262** abajo a la izquierda y la lista de mods (Mods, en el menú) debe tener los 34 sin ningún nombre en rojo.

---

## 3. Paso 3 — RAM y argumentos de Java

El pack con colonias y Mekanism no vive con 2 GB. Con 15 GB totales, **4 GB** es el punto correcto: suficiente para el heap y deja 10 GB al sistema.

En TLauncher: **Configuración → Java → Argumentos JVM** (si no ves el campo, usa «Argumentos adicionales»). Pega exactamente esto:

```text
-Xms3G -Xmx4G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:+UseStringDeduplication -Dfile.encoding=UTF-8
```

Por qué cada bloque, en una línea:

- `-Xms3G -Xmx4G`: empieza con memoria reservada (menos tirones al cargar chunks) y no pasa de 4 GB.
- `G1GC` + `MaxGCPauseMillis=200`: recolector pensado para pausas cortas, no para throughput máximo.
- `AlwaysPreTouch`: reserva la memoria al arrancar; el juego tarda un poco más en abrir y luego no tropieza.
- `UseStringDeduplication`: MineColonies y FTB Quests crean muchas cadenas iguales; esto ahorra RAM real.

**No subas a 6-8 GB.** Con 4 núcleos, pausas más largas de GC y un disco al 97% el resultado es peor: el juego empieza a usar swap.

🟨 Si el juego va a 30 fps con el disco trabajando, casi siempre es RAM/GC, no la gráfica. Mira en F3 la memoria usada (arriba a la derecha): si está pegada al máximo, sube `-Xmx` a `4G` → `5G` solo si tienes más de 7 GB libres.

---

## 4. Paso 4 — Opciones de vídeo, valor por valor

**Opciones → Opciones de vídeo.** No hay que adivinar: esta es la base.

| Ajuste | Valor | Motivo |
|---|---|---|
| Resolución | 1280x720 en ventana | La HD 620 mueve 1,7 veces menos píxeles que 1080p |
| Distancia de renderizado | **8 chunks** | Cada chunk es geometría + texturas; 8 ya se ve lejos con niebla |
| Distancia de simulación | **5 chunks** | Aquí es donde van las colonias; 5 evita que MineColonies ahogue la CPU |
| Distancia de entidades | **50 %** | Menos aldeanos y animales dibujados a lo lejos |
| Gráficos | **Rápidos** para empezar | Hojas y agua simples; sube a Fabulosos en el paso 9 |
| Suavizado de iluminación | **Mínimo** | Cálculo por bloque; en integrada se nota |
| Oclusión ambiental | Activada | Cuesta poco y da profundidad, que es lo que buscas |
| Nubes | **Desactivadas** | Nadie las mira y cuestan relleno de píxeles |
| Partículas | **Mínimas** | Con colonias y Create hay partículas por todas partes |
| Sombras de entidades | **Desactivadas** | Es un shadow map: lo más caro que hay activado por defecto con Fabulosos |
| Mipmap | 2 | 4 brilla más pero pide más memoria de textura |
| Mezcla de biomas | 1x1 | 5x5 recalcula color de hierba por bloque |
| Sincronización vertical | **Desactivada** | El vsync de Java añade latencia; mejor límite de fps |
| Límite de FPS | **60** (portátil: 40) | Limitar baja temperatura y evita el tirón de los 100 % |
| Escala de interfaz | 2 | Legible a 720p sin comerse la pantalla |
| Campo de visión | 70 | Más FOV = más chunks en pantalla = menos fps |

Después de aplicar: entra al mundo, camina 60 segundos y mira el número de F3. Ese número es tu punto de partida; el paso 9 explica cuándo subir.

---

## 5. Paso 5 — El pack de recursos: cuadros y textos

Aquí está la parte «dibujos»: en lugar de texturas HD, el pack cambia **8 cuadros** por ilustraciones propias de la serie y reescribe los textos del menú.

**Instalar:**

```bash
cp pack-inmersion/ReinoDeLaCiencia.zip ~/.minecraft/resourcepacks/
# Windows: copiar a %APPDATA%\.minecraft\resourcepacks\
```

Luego en el juego: **Opciones → Pack de recursos → Reino de la Ciencia → Flecha para activarlo → Hecho**.

**Qué cambia:**

| Cuadro vanilla | Tamaño | Lo que se ve |
|---|---|---|
| `kebab` | 1x1 | El matraz con líquido milagroso 🟩 |
| `aztec` | 1x1 | La rueda dentada del reino 🟨 |
| `plants` | 1x1 | Un brote entre piedra 🟩 |
| `wasteland` | 1x1 | Piedra agrietada, el mundo tras la petrificación 🟩 |
| `scene` | 2x2 | La aldea Ishigami con la hoguera 🟩 |
| `wanderer` | 1x2 | El telescopio apuntando al cielo 🟩 |
| `bust` | 2x4 | Retrato de Senku, bata y pelo de punta 🟩 |
| `skull` | 4x4 | La cara que se vuelve piedra con grietas verdes 🟩 |

Y en el menú principal, las frases de la esquina cambian («No es magia, es química», «¡Despetrifícate!», «Modo supervivencia, siempre»…).

**Cómo conseguir cuadros 🟦:** 8 palos + 1 lana del color que quieras. El cuadro que sale es aleatorio entre los tamaños que caben; si no te gusta, rompe y vuelve a poner.

**Detalle que importa:** pon los cuadros **dentro** de la base, no en el exterior. La serie vive en interiores de madera y piedra; un retrato de Senku en la pared del taller cambia por completo la sensación.

---

## 6. Paso 6 — El libro de misiones (5 eras, 25 misiones)

El árbol de FTB Quests ya está generado y validado. Se copia tal cual:

```bash
mkdir -p ~/.minecraft/config/ftbquests
cp -r quests ~/.minecraft/config/ftbquests/
# debe quedar: ~/.minecraft/config/ftbquests/quests/data.snbt
#              ~/.minecraft/config/ftbquests/quests/chapters/era1..5.snbt
```

**Abrir el libro:** por defecto no tiene tecla. Ve a **Opciones → Controles → FTB Quests** y asigna, por ejemplo, `B`. También puedes conseguir el objeto con `/give @s ftbquests:book`.

**Qué hay dentro:**

| Capítulo | Misión inicial | Misión final |
|---|---|---|
| Era 1 — No morir | Sobrevivir la primera noche | Primer revivido |
| Era 2 — Ganarse la aldea | Diez revividos | Primera luz eléctrica |
| Era 3 — Stone Wars | Hierro a escala | Radio entre colonias |
| Era 4 — New World | Brújula | Dron y radar |
| Era 5 — Science Future | Computadora | Cierre del reino |

Cada misión da XP y desbloquea la siguiente. **No son obligatorias**: son la guía para no perderse, que es exactamente lo que hace Senku con Chrome al principio 🟩.

---

## 7. Paso 7 — Los primeros 90 minutos, minuto a minuto

Esto es el arranque tal y como lo viviría la serie. Si lo sigues en orden, la primera hora se siente como un capítulo.

### Minuto 0-10 — Despertar 🟩
1. No corras. Mira el horizonte y localiza **una montaña o una cascada** (hay puntos de viaje con `/function swr:viaje/...`).
2. Coge madera a mano: 20 troncos bastan.
3. Crafting: mesa, pico de madera, hacha de madera.
4. 🟦 El juego te da un mapa si lo activas; úsalo para no perder el spawn.

### Minuto 10-25 — El refugio 🟩
1. Pico de piedra → 20 de piedra.
2. Un hueco de 3x3 en una ladera, con puerta.
3. Antorcha con carbón (o palos + carbón vegetal de un horno).
4. Cama: 3 lana + 3 tablas. 🟨 En la serie no hay camas; aquí dormir es la forma de saltar la noche sin morir.

### Minuto 25-45 — La cueva 🟩
1. Baja con 8 antorchas y un cubo de agua.
2. Busca **hierro** (20 unidades) y **carbón**.
3. 🟩 Primer invento real: horno + hierro → pico de hierro. Ese es el salto de la serie.
4. Si encuentras **arcilla**, guarda 10 bloques: era 1 pide cerámica.

### Minuto 45-70 — La aldea 🟩
1. Localiza una aldea (o el punto `aldea` del pack).
2. No saquees: **habla** con los aldeanos y mira qué oficios hay.
3. Construye una hoguera y una cama extra en el borde.
4. 🟦 Con MineColonies colocarás después el **Town Hall**; aún no, eso es era 2.

### Minuto 70-90 — Cerrar la era 1 🟩
1. Abre el libro (B) y marca «Sobrevivir la primera noche».
2. Pon **dos cuadros** en la pared del refugio: el matraz y el retrato.
3. Escribe un libro (pluma + libro) con una línea: el día que llegaste. 🟨 Detalle de inmersión puro.
4. Guarda la partida en un mundo llamado `Ishigami`.

---

## 8. Paso 8 — Era por era: qué haces y qué es de la serie

| Era | Qué construyes | 🟩 Serie | 🟦 Juego |
|---|---|---|---|
| 1 | Refugio, horno, cerámica, primer hierro | Vivir sin nada, cocer barro | Camas, antorchas de carbón |
| 2 | Colonia, granja, leñador, primer cable | Despetrificar y organizar la aldea | MineColonies: Town Hall, ciudadanos |
| 3 | Horno alto, baterías, central hidroeléctrica | Dinamo y red eléctrica | Create: ejes, engranajes, alternador |
| 4 | Puerto, barco de vapor, brújula, mapa | Zarpar a por el platino | Create: barcos; brújula vanilla |
| 5 | Circuito, radio, telescopio, pan duradero | Teléfono y radio de Senku | CC: Tweaked (modems), Mekanism |

**Las tres cosas que la serie tiene y el pack no:** las sulfamidas (se representan con pociones 🟨), el submarino (solo barco 🟨) y el cohete (pendiente de Ad Astra 🟨). Están así documentadas en `ERAS.md` para no prometer lo que no hay.

---

## 9. Paso 9 — Llevar el equipo al límite (sin que se caiga)

El límite de una HD 620 no es un número fijo: es el punto donde **el mínimo** baja de 50 fps. Se sube de escalón solo cuando el escalón actual aguanta.

**Cómo medir (2 minutos, honesto):**
1. Entra al mundo, pon F3 y camina 60 segundos: primero en campo abierto, luego **dentro de la colonia**.
2. Anota el número **más bajo** que veas, no el más alto.
3. Solo si el mínimo es **> 50**, sube un escalón.
4. 🟨 Los tirones de un segundo no son fps: son carga de chunks. Si aparecen al girar, el problema es la distancia de render o el disco, no la gráfica.

| Escalón | Resolución | Render / Simulación | Gráficos | Esperado |
|---|---|---|---|---|
| A (base) | 1280x720 | 8 / 5 | Rápidos | 55-70 fps, mínimos ~45 |
| B | 1600x900 | 10 / 6 | Fabulosos | 45-60 fps, mínimos ~40 |
| C (techo) | 1920x1080 | 12 / 8 | Fabulosos | 35-50 fps; solo si B va sobrado |

**Qué subir primero si quieres más belleza:** 1) Gráficos a Fabulosos (agua y hojas), 2) resolución, 3) distancia de render. **Nunca** subas primero la distancia de simulación: es lo que más CPU consume y lo que hace que las colonias se atranquen.

**Lo que NO vale la pena en este equipo:** shaders, packs de texturas HD, Distant Horizons, 32 chunks, sombras de entidades, partículas altas. Cualquiera de esos te deja en 15-25 fps y con el ventilador a tope.

**Truco de portátil 🟦:** si la temperatura sube, baja el límite de FPS a 40 antes de bajar la distancia de render. Menos calor = menos throttling = fps más estables.

---

## 10. Paso 10 — Problemas típicos y su arreglo

| Síntoma | Causa probable | Arreglo |
|---|---|---|
| Pantalla negra al entrar a un mundo con Create | Embeddium + Flywheel en algún build | Quita `embeddium-*.jar`, reinicia; si se arregla, ese era |
| El servidor no arranca: error de `minecolonytax` | Falta War 'N Taxes o versión | Instala `minecolonies-war-n-taxes` 5.1.1 |
| Tirones al abrir el libro de misiones | FTB Quests cargando imágenes | Espera 2 s; se arregla solo |
| La colonia no construye | Falta constructor, herramientas o materiales | Revisa la choza de constructor y el almacén |
| Muertes por sed o calor en bucle | Thirst Was Taken / Tough as Nails | Botella de agua + ropa; o baja la dificultad del mod en `config/` |
| El libro no abre con ninguna tecla | Sin tecla asignada | Controles → FTB Quests → asigna `B` |
| Los cuadros siguen siendo los vanilla | Pack no activado o desordenado | Actívalo arriba del todo en Pack de recursos y reinicia |
| Se queda en «Cargando el mundo» y no avanza | Poca RAM o disco lleno | Sube `-Xmx4G` a `5G` si hay RAM libre; libera disco |
| 20 fps constantes sin motivo | Texturas HD o shaders activos | Quítalos: esta gráfica no los sostiene |
| El juego usa swap y va a tirones | `-Xmx` demasiado alto | Vuelve a 4 GB |

---

## Anexo A — 40 detalles pequeños que hacen la diferencia

Ninguno cuesta fps. Todos cuestan cinco minutos. Están ordenados como se hacen.

**En la base**
1. Camino de piedra desde la puerta hasta el agua.
2. Antorchas cada 8 bloques en el camino (marca la ruta de noche).
3. Un cartel con el nombre de la aldea en la entrada.
4. Los cuadros de la serie dentro, nunca fuera.
5. Co fre con los primeros materiales separados: «día 1», «día 2»…
6. Herramientas renombradas (yunque): «pico de Senku», «hacha de Taiju».
7. Un libro escrito con el diario de la partida.
8. Un reloj de pared (ítem reloj en marco) para saber la hora sin F3.
9. Cama con el color de la lana de tu zona.
10. Un horno dedicado solo a vidrio, otro solo a hierro.

**En la aldea**
11. Granja cercada, con puerta, no a cielo abierto.
12. Pozo o canal de agua limpia (sed).
13. Hoguera central con bancos.
14. Almacén con el doble de cofres de los que crees que necesitas.
15. Camino entre la granja y el almacén (los ciudadanos lo agradecen).
16. Un puesto de herrero visible.
17. Farolas en las esquinas.
18. Huerto de flores: no sirve para nada y cambia el paisaje.
19. Valla en el perímetro: las razzias de Millénaire son reales.
20. Un mirador alto para ver la colonia entera.

**En el mundo**
21. Puente de madera en el río (el de la serie).
22. Señales en las bifurcaciones.
23. Un refugio pequeño cada 200 bloques en la ruta larga.
24. Marcar la cueva del milagro con un farol.
25. Dejar el spawn limpio y con un cartel de bienvenida.
26. Nombrar los biomas que descubres en el mapa.
27. Un muelle, aunque no haya barco todavía.
28. Un observatorio en la colina más alta.

**En la rutina**
29. Dormir todas las noches, sin excepción.
30. Comer cocinado siempre (no crudo).
31. Guardar la partida con nombre de capítulo.
32. No usar creativo, ni para «probar una cosa».
33. Cerrar el juego antes de instalar mods.
34. Un cofre de «chatarra» para no llenar el inventario.
35. Revisar el libro de misiones al empezar cada sesión.
36. Hacer una captura del antes y el después de cada era.
37. Escribir una línea en el diario al terminar.
38. No construir dos cosas a la vez: la serie va invento por invento.
39. Si algo falla, buscar el eslabón anterior (ver `SERIE.md`, apéndice J).
40. Apagar el juego con el botón, no con la X: se corrompen menos chunks.

---

## Anexo B — Serie contra juego, invento por invento

| Lo de la serie 🟩 | En el juego 🟦/🟨 | Cómo queda |
|---|---|---|
| Petrificación y despetrificación | Mod Dr. Stone: Kingdom of Science | 🟩 Directo |
| Cueva del milagro y fluido | Mod Dr. Stone | 🟩 Directo |
| Ácido para despetrificar | No existe el nítalo | 🟨 Se sustituye por el fluido del mod |
| Sulfamidas | Pociones | 🟨 Efecto parecido, química distinta |
| Vidrio soplado | Horno + arena | 🟩 Directo |
| Dinamo y bombillas | Create + lámparas de redstone | 🟨 Mismo principio, otra máquina |
| Central hidroeléctrica | Create: ruedas de agua | 🟨 |
| Teléfono y radio | CC: Tweaked con modems | 🟨 Misma idea, otro cable |
| Barcos de vapor | Create: barcos | 🟨 |
| Globo aerostático | Create: contraptions | 🟨 |
| Submarino | No hay | 🟨 Barco normal |
| Cohete y Luna | Pendiente (Ad Astra) | 🟨 Fuera del pack |
| Aldea organizada | MineColonies | 🟨 Ciudadanos reales |
| Aldeas del año 1000 | Millénaire | 🟦 No está en la serie |
| Sed y temperatura | Thirst Was Taken, Tough as Nails | 🟦 Realismo añadido |
| Estaciones | Serene Seasons | 🟩 Senku cuenta con ellas |

---

## Anexo C — Rutina de 20 minutos por sesión

Para que la partida avance sin quemarte:

1. **2 min** — abre el libro, mira la siguiente misión, anota el material que falta.
2. **10 min** — consigue ese material y nada más.
3. **5 min** — construye o monta la pieza de la misión.
4. **2 min** — una línea en el diario y captura.
5. **1 min** — cierra el juego (no dejes la sesión abierta con la colonia trabajando: come CPU y calor).

Con esa rutina, las cinco eras se cierran en unas 25-30 sesiones, que es más o menos el ritmo al que avanza la serie.

---

*Documento del proyecto Stone World Reborn. Dr. Stone es de Riichiro Inagaki, Boichi y Shueisha; este texto es una guía de juego sin ánimo de lucro.*
