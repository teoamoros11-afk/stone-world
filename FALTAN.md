# Lo que sale en la serie y no está en el juego

Lista de todo lo que aparece en *Dr. Stone* y hoy no se puede hacer en este pack, ordenada **de lo
más factible a lo menos**. «Falta» significa que no lo da ni el datapack (249 funciones), ni los
cinco mods propios (`optics-mod`, `crank-dynamo`, `pharmacy-mod`, `suika-mod`, `musica-mod`), ni
ninguno de los 38 mods de `mods.txt` (Create, Immersive Engineering, Mekanism, CC: Tweaked,
Ad Astra, Dr. Stone: KoS, MineColonies...). Si algo ya está, no aparece aquí.

El orden no es «lo que más me gusta», es **cuánto cuesta y qué hace falta para comprobarlo**:

| Tramo | Qué pide | Se comprueba sin cliente | Coste típico |
|---|---|---|---|
| **A** | Solo datapack: funciones, marcadores, estructuras, `setblock`, `summon` | Sí, por RCON o con `probar_servidor.py` | S: una tarde · M: dos o tres |
| **B** | Datapack más texturas 2D en el resource pack (ya existe uno) | El dato sí; el aspecto no | S-M |
| **C** | Un mod propio pequeño, con el patrón de los cinco que ya hay (ítem o bloque registrado) | Sí: el servidor registra el ítem | M |
| **D** | Un mod mediano: entidad con IA, vehículo, máquina con estado | A medias: existe la entidad, no se ve | L |
| **E** | Cliente: modelo 3D, renderer, animación, shader o arte que no existe | No | L, y con cliente delante |
| **F** | Fuera del alcance de Minecraft, o sería otro juego | No | — |

Coste **S** = una función o un puñado, con lo que ya hay. **M** = sistema nuevo con estado que
sobreviva a `/reload`. **L** = arte, entidad o renderer nuevos.

Antes de la lista, lo que **sí** está, para que no se confunda con un hueco: petrificación y fluido
(Dr. Stone: KoS), cueva del milagro, bar del Perseus con póker de 52 cartas y bolos, campo con
rotación de cuatro parcelas, pueblo con 16 solares, calles, plaza, obra por capas, horario y seis
rutinas, 38 personajes con ficha, tripulación del Perseus con zarpe, ocho destinos de viaje,
libro de campo por eras, las cien historias, el disco de Lilian, el casco de sandía, la medusa como
trofeo, el destello del 1 de abril, el epílogo *TERRAFORMING*, gafas de Kinro, telescopio, banco de
pulido, dinamo de manivela, sulfamida y jeringa, panel, reglas duras, 34 misiones y 14 avances.

---

## Tramo A — solo datapack, hoy y sin arte nuevo (29 piezas)

> El 25/11/2026 se hicieron A1 (medusa con cuenta atras), A2 (fluido como frasco) y A26-A29 (los
> cuatro planos colocables). Siguen en la tabla con el estado «hecho» para no renumerar el resto.

Todo esto se escribe en `panel/data/swr/function/` y se prueba por consola. Es el tramo donde el
pack tiene más margen: la serie es, sobre todo, **sistemas con estado**, y eso es exactamente lo que
un datapack hace bien.

| # | Qué falta | Dónde sale | Estado hoy | Cómo se haría | Coste |
|---|---|---|---|---|---|
| A1 | Medusa con cuenta atrás, radio y activación por voz | T3 (ep. 53-55), T4 (ep. 93) | **Hecho**: `serie/medusa/iniciar`, `ciclo`, `disparar` (30 s, radio 12, 3 cargas), `voz`, `estado` y `desactivar` | `serie/medusa/*`: `schedule` para la cuenta atrás, petrificar a quien esté en un radio, frase clave por chat («¿Quieres morir?»), batería que se gasta | M |
| A2 | Fluido milagroso como frasco, no como contador | T1 (ep. 1), T3 (ep. 55) | **Hecho**: `reino/fluido` da el frasco y `revivir`/`despetrificar` lo gastan antes del cupo | Frasco con nombre propio, receta de nítalo, frasco vacío al gastar; el `give` con componentes va por comando, no dentro de la función (ya se comprobó que ahí no parsea) | S |
| A3 | La cueva del milagro como yacimiento vivo | T1 (ep. 1) | Escena y coordenadas | Guano que se regenera cada X, agua con nítalo, cartel con la fórmula | S |
| A4 | Arranque desnudo y sin memoria | T1 (ep. 1) | Nada: se empieza con lo que tengas | Quitar inventario al entrar, dar el libro, fijar el punto de aparición en la costa, contador de días | S |
| A5 | Estatuas del prólogo: Byakuya, Lillian, Taiju, Yuzuriha | T1 (ep. 24), T3 (ep. 55) | 38 fichas de aldeanos del pueblo | Estatuas con nombre y el disco de Lillian a los pies de Byakuya | S |
| A6 | Revivir a un millón de personas | T4 (ep. 69-81) | Cupo de 60 revividos | Contador global, hitos por miles, cifra en el panel | S |
| A7 | La biblioteca de las cien historias | T1 (ep. 17) | `serie/historias` entrega el libro | Estantería con los cien tomos, índice y la campana como catálogo | M |
| A8 | El torneo Grand Bout | T1 (ep. 20-24) | Nada | Sorteo de parejas, rondas, reglas sin armas letales, premio y título | M |
| A9 | El juicio de Magma y la elección de la novia | T1 (ep. 22), T3 (ep. 48) | Nada | Escena con títulos, turnos de palabra y resultado por votos | S |
| A10 | Política de la aldea: jefa, guardián y decretos | T1 (ep. 9-24) | Ruri y Kokuyo como personajes | Votaciones en chat, decretos con efecto real (precio, turno, obra) | M |
| A11 | Consejo de guerra con mapa y órdenes | T2-T3 (ep. 51-53) | Nada | Mesa con marcadores, órdenes por chat y cuenta atrás | M |
| A12 | Radio con alcance, canal e interferencia | T3-T4 (ep. 62-65) | Viajes por teleport | Canal por marcador, alcance por distancia, interferencia si Stanley está cerca, mensajes en clave | M |
| A13 | Teléfono móvil que llama | T1 (ep. 19-20), T2 (ep. 31) | Nada | Llamada = mensaje directo a un jugador a distancia, con «timbre» y coste de batería | M |
| A14 | Fax: mandar un mapa dibujado | T4 (ep. 73, 85) | Nada | Copiar un mapa lleno a otro jugador, con papel y tinta gastados | S |
| A15 | Imprenta y periódico | T2-T4 (papel, tinta y prensa) | Nada | Libro escrito generado por función con las noticias del día y tirada limitada | M |
| A16 | Cámara de seguridad | T4 (ep. 88) | Nada | Al activarse, cuenta entidades en un radio y avisa por chat; la imagen real es tramo E | S |
| A17 | Casino: ruleta y blackjack | T4 (ep. 58) | Póker completo | Ruleta con `random`, blackjack con baraja existente, banca con préstamo | M |
| A18 | Moneda y precios | T4 (ep. 58) | Fichas de póker | Moneda con valor, precios en el bar y en el mercado | S |
| A19 | Mercado y trueque con la aldea | T1 (ep. 12-14) | Puestos que producen | Puesto con stock, demanda y trueque por oficio | M |
| A20 | Escuela y examen | T4 (ep. 86-87) | Nada | Pizarra, preguntas por chat, aprobado que da avance | S |
| A21 | Hospital con camas y triaje | T1 (arco de las sulfamidas), T4 (ep. 66) | Sulfamida y jeringa del mod | Camas, heridos con efecto, cola de pacientes y cura | M |
| A22 | Rutina propia para los seis personajes que no la tienen | Serie entera | Seis de doce la tienen | Copiar el patrón de `pueblo/horario/rutinas` para Kaseki, Ginro, Jasper, Magma, Turquoise y Sapphire | S |
| A23 | Fotos del equipo y del pasado | T4 (ep. 85) | Nada | Mapas de 1x1 generados con el retrato; el arte, tramo B | S |
| A24 | Carteles, nombres de calles y rótulos | Serie entera | Plaza y calles sin nombre | Letreros con texto y mapa de la aldea | S |
| A25 | Cementerio y tumba de Byakuya | T1 (ep. 1), T3 (ep. 55) | Nada | Lápidas con nombre, el disco y una escena de visita | S |
| A26 | La isla del tesoro jugable | T3 (ep. 47-56) | **Hecho**: `swr:isla_tesoro` y `serie/colocar/isla_tesoro` | Ciudadela, puente, altar, celda, muelle y noria | M |
| A27 | Corn City y Superalloy City | T4 (ep. 82-94) | **Hecho Corn City**: `swr:corn_city`; Superalloy City sigue pendiente | Dos asentamientos con su plano y sus puestos | M |
| A28 | La base Haber-Bosch de Xeno | T4 (ep. 65) | **Hecho**: `swr:haber_bosch` y `serie/colocar/haber_bosch` | Torre, reactores, maizal y pista de aterrizaje | M |
| A29 | Araxá, el santuario de piedra | T4 (ep. 76) | **Hecho**: `swr:araxa` y `serie/colocar/araxa` | Recinto amurallado con la torre de la medusa | S |
| A30 | Estatuas de todo el mundo | T4 (ep. 79-81) | Nada | Reparto de estatuas por biomas, con contador | M |
| A31 | La onda petrificadora desde Sudamérica | T4 (ep. 69-78) | Solo el destello del 1 de abril | Onda por distancia con partículas y efecto, y su origen marcado | M |
| A32 | Petrificar y revivir a un jugador | T4 (ep. 79, 92) | Solo aldeanos | Efecto, congelación, inventario aparte y vuelta con fluido | M |
| A33 | «¿Quieres morir?» por radio | T4 (ep. 82) | Nada | Mensaje programado cada X días, con voz y ruido | S |
| A34 | El valle Taurus-Littrow y la colonia de medusas | T4 (ep. 92-93) | Ad Astra da la Luna, no el yacimiento | Zona marcada, cápsula y colonia como estructuras | S |
| A35 | El satélite Senku-1 y sus siete intentos | T4 (ep. 89) | Ad Astra da el lanzamiento | Contador de intentos con su causa de fallo y el parte de cada uno | S |

**Detalles pequeños del tramo A** que van en el mismo saco y no merecen fila propia: el nombre de
los días, el parte meteorológico, la lista de la compra del bar, el libro de visitas de la aldea,
el reloj de sol, la báscula de la feria, las salinas, la carbonera, el jabón, la tinta y el papel,
los fuegos artificiales del epílogo de la isla, el aviso de Dunbar al pasar de 150 vecinos y el
«gracias» de los agradecidos.

## Tramo B — datapack más texturas 2D (12 piezas)

El resource pack ya existe y cambia el menú, los cuadros y tres texturas propias. Aquí solo hace
falta dibujar; el comportamiento es del tramo A o ya está.

| # | Qué falta | Dónde sale | Estado hoy | Cómo se haría | Coste |
|---|---|---|---|---|---|
| B1 | Medusa con textura propia | T3-T4 | Corazón del mar renombrado | Textura 16x16 de piedra tallada y modelo de ítem | S |
| B2 | Baraja y fichas con arte | T4 (ep. 58) | Nombres y palos por marcador | 52 texturas de carta y ficha | M |
| B3 | Móvil con pantalla | T1 (ep. 19-20) | Nada | Textura de ítem y de pantalla encendida | S |
| B4 | Dron, globo y submarino como iconos | T3-T4 | Nada | Iconos de ítem; el modelo 3D es tramo E | S |
| B5 | Uniforme del reino | Serie entera | Ropa por tipo de aldea | Cambiar la ropa de los aldeanos en el pack (afecta a todos) | M |
| B6 | Estandartes y banderas | T3-T4 | Nada | Diseños de estandarte por facción | S |
| B7 | Iconos de los 14 avances | Ya existen los avances | Icono genérico | Un icono por avance | S |
| B8 | Retratos en cuadro | T4 (ep. 85) | Tres cuadros propios | Cuatro retratos más | M |
| B9 | Mapa de la isla dibujado a mano | T1 | `mapa-isla.png` generado | Versión «de época» para el libro | S |
| B10 | Libro de campo ilustrado | T1-T4 | Texto plano | Ilustraciones por era | M |
| B11 | Moneda y billetes | T4 (ep. 58) | Nada | Dos texturas | S |
| B12 | Traje espacial (textura) | T4 (ep. 91) | Nada | Textura de armadura; el ítem es tramo C | S |

## Tramo C — un mod propio pequeño (24 piezas)

El patrón ya está probado cinco veces: registrar ítem o bloque, textura, receta, `gradlew build`,
jar y servidor. Cada pieza de aquí es un `DeferredRegister` y unas pocas clases.

| # | Qué falta | Dónde sale | Estado hoy | Cómo se haría | Coste |
|---|---|---|---|---|---|
| C1 | Medusa como ítem con estado | T3-T4 | Trofeo sin comportamiento | Ítem con componentes: carga, radio, dueño, temporizador | M |
| C2 | Teléfono | T1 (ep. 19-20), T2 (ep. 31) | Nada | Ítem con lista de contactos y llamada a distancia | M |
| C3 | Cámara fotográfica | T4 (ep. 88) | Nada | Ítem que gasta papel y genera un mapa con la vista | M |
| C4 | Traje espacial y casco | T4 (ep. 91) | Nada | Armadura con resistencia y oxígeno; el casco de sandía ya es el patrón | M |
| C5 | Traje de buceo, aletas y gafas | T3 (ep. 47) | Nada | Armadura con respiración acuática y velocidad en agua | S |
| C6 | Armadura de fibra de carbono | T3 (ep. 50) | Nada | Material con dureza alta y ligereza | S |
| C7 | Katana de Hyoga y lanza flexible de Kinro | T2-T3 | Nada | Dos armas con alcance y daño propios | S |
| C8 | Pistola, rifle y balas | T3 (ep. 50), T4 (ep. 65) | Pólvora de vanilla | Arma con cargador, bala como ítem y retroceso | M |
| C9 | Ametralladora y torreta | T4 (ep. 60) | Nada | Bloque que dispara a quien se acerque | L |
| C10 | Arpón-red antimedusa | T4 (ep. 90) | Nada | Ítem que inmoviliza y luego explota | S |
| C11 | Reloj de resurrección | T4 (ep. 90-92) | Nada | Ítem con temporizador que aplica fluido a su dueño | M |
| C12 | Diamante sintético y batería de diamante | T4 (ep. 75-78) | Nada | Dos ítems y su receta con alcohol | S |
| C13 | Ácido sulfúrico y nítrico como reactivos | T1-T2 | Solo el resultado (sulfamida) | Dos ítems corrosivos con su receta | S |
| C14 | Nitroglicerina y acetileno | T4 (ep. 61, 77) | Nada | Dos explosivos con receta y daño | S |
| C15 | Jabón, tinta y papel | T1-T2 | Nada | Tres ítems de taller | S |
| C16 | Goma, látex y neumático | T3 (ep. 71-72) | Nada | Cadena de tres ítems desde el caucho | S |
| C17 | Aluminio, titanio, tungsteno y superaleación | T4 (ep. 82-86) | Mekanism cubre parte | Comprobar qué falta y añadir solo eso | M |
| C18 | Fluorita, calcita solar y bauxita | T3-T4 (ep. 83-86) | Nada | Tres minerales con su mena | S |
| C19 | Vinilo, plástico y cristal líquido | T4 (ep. 91) | Nada | Tres materiales de la recta final | S |
| C20 | Tubos Nixie y parametrón | T4 (ep. 85-86) | CC: Tweaked da computación | Dos bloques decorativos con luz y sonido | S |
| C21 | Nevera, microondas y lavadora | T4 (ep. 91) | Nada | Tres bloques con función simple | M |
| C22 | Pan de larga duración | T4 (ep. 90) | Nada | Comida que no caduca y pesa poco | S |
| C23 | Comida de la serie: ramen, curry, sushi, helado, algodón, cerveza, cola | T1-T4 | Solo lo que da el bar | Siete comidas con su efecto | M |
| C24 | Semillas de arroz, maíz, soja, algodón, café y caucho | T3-T4 | Trigo, patata, zanahoria y remolacha | Seis cultivos nuevos con su bloque | L |

## Tramo D — mod mediano: entidad, IA o vehículo (14 piezas)

Aquí ya no basta un ítem: hace falta entidad, IA o física. El pack no tiene ningún vehículo
propio; todo lo que se mueve hoy lo mueve Create.

| # | Qué falta | Dónde sale | Estado hoy | Cómo se haría | Coste |
|---|---|---|---|---|---|
| D1 | Dron que vuela y lleva carga | T3 (ep. 48-50) | Nada | Entidad con vuelo, seguimiento y un cofre | L |
| D2 | Globo aerostático pilotable | T3 (especial Ryusui) | Nada | Entidad o contraption de Create con ascenso | L |
| D3 | Submarino que bucea | T3-T4 | Barco de Create que no bucea | Entidad con inmersión, oxígeno y torpedo | L |
| D4 | Moto | T3 (ep. 71-73) | Nada | Entidad con ruedas, derrape y dos plazas | L |
| D5 | Coche y autobús | T4 (ep. 82) | Nada | Entidad con motor y combustible | L |
| D6 | Avión y portaaviones | T4 (ep. 67-68) | Nada | Entidad con sustentación y aterrizaje | L |
| D7 | Tren y vías | T4 (ep. 82) | Create tiene trenes | Usar Create; falta la ruta y las estaciones | M |
| D8 | Teleférico de los Andes | T4 (ep. 73-74) | Nada | Contraption de Create con cable y polea | M |
| D9 | Planta Haber-Bosch | T4 (ep. 62) | Nada | Bloque multibloque que produce pólvora | L |
| D10 | Refinería y motor de combustión | T4 (ep. 82) | Create e IE cubren parte | Enlazar biodiésel con la turbina | M |
| D11 | Computadora con programas | T4 (ep. 85) | CC: Tweaked | Programa de parametrones y memoria | M |
| D12 | SAL 9000 con Tetris, Pac-Man y Galaga | T4 (ep. 88) | Nada | Tres juegos en Lua sobre CC | L |
| D13 | Internet entre ciudades | T4 (ep. 89) | Nada | Red de módems y foro por chat | M |
| D14 | Why-Man y la colonia de medusas | T4 (ep. 93) | Nada | Entidad con voz y diálogo; la colonia, tramo A | L |

**Fichas de personajes**: las 26 que faltaban ya están hechas; con las doce de la aldea suman 38 fichas,
una por personaje con su nombre, su oficio y su objeto. No queda ninguna pendiente y una prueba
comprueba que cada ficha sigue documentada en `PERSONAJES.md`.

## Tramo E — cliente: modelo, renderer, animación o shader (11 piezas)

Sin cliente delante no se puede ni mirar. No es que sea imposible: es que no se puede **comprobar**
aquí, y el repo no da por hecho lo que no ve.

| # | Qué falta | Dónde sale | Estado hoy | Qué haría falta |
|---|---|---|---|---|
| E1 | Estatuas con la cara de cada personaje | T1-T4 | Aldeanos petrificados genéricos | Modelo o renderer propio por estatua |
| E2 | Ropa a medida de cada personaje | Serie entera | Tipo de aldea | Skins o capas por entidad; el resource pack viste a todos igual |
| E3 | Animaciones de combate de Tsukasa, Hyoga y Moz | T2-T3 | Nada | Animación por entidad y sincronización con el golpe |
| E4 | La medusa flotando y girando | T3 (ep. 53) | Ítem en la mano | Entidad con modelo y partículas |
| E5 | Traje espacial con modelo 3D | T4 (ep. 91) | Nada | Modelo de armadura |
| E6 | Cohete con modelo y humo | T4 | Ad Astra | Modelo propio y etapa de separación visible |
| E7 | Perseus con aparejo, velas y bandera animada | T3-T4 | Estructura de 814 bloques | Renderer o animación de bloques |
| E8 | Onda de petrificación global | T1 (ep. 1), T4 (ep. 78) | Partículas del destello | Shader o secuencia de partículas a escala de mundo |
| E9 | La Tierra vista desde la Luna | T4 (ep. 92) | Cielo de Ad Astra | Skybox propio |
| E10 | Interfaz de la medusa | T3-T4 | Nada | GUI con cuenta atrás y radio |
| E11 | Escenas cinemáticas de los momentos clave | Serie entera | Títulos y sonidos | Cámara, animación y montaje |

## Tramo F — fuera del alcance de Minecraft (7 piezas)

No es pereza: es que el juego no simula eso. Se pueden **contar** (texto, escena, avance), no jugar.

| # | Qué falta | Dónde sale | Por qué no |
|---|---|---|---|
| F1 | La máquina del tiempo del final | T4 (ep. 94) | Cambiar el pasado no es un sistema de juego; sería otro juego |
| F2 | Inmortalidad y envejecimiento | T4 (ep. 81) | Minecraft no tiene vejez ni muerte natural que revertir |
| F3 | Revivir de verdad a los muertos | T4 (ep. 77-81) | Solo se puede simular con estatuas y fluido |
| F4 | Revivir a un millón de personas a la vez | T4 (ep. 69-81) | El mundo no aguanta esa población; se queda en contador (A6) |
| F5 | Química exacta, paso a paso | Serie entera | La serie enseña el proceso; el juego da el resultado |
| F6 | Reformar el planeta entero | Epílogo *TERRAFORMING* | Cambiar el worldgen a escala de mundo no es jugable |
| F7 | Las voces y la música de la serie | Serie entera | Solo hay piezas originales propias (Lilian), no material de la serie |

---

## Por dónde empezar, si hay que elegir

1. **A1 (medusa con estado)** y **A2 (fluido por frasco)**: son las dos piezas que la serie usa en
   cada arco y hoy son un trofeo y un contador. Con ellas, media lista de arriba se puede contar.
2. **A26-A29 (isla del tesoro, Corn City, Haber-Bosch, Araxá)**: sin sitios no hay escenas; son
   estructuras y se comprueban con `setblock`.
3. **C4 y C5 (traje espacial y de buceo)**: el patrón del casco de sandía ya está escrito y probado.
4. **D1-D6 (vehículos)**: lo más vistoso y lo más caro; no empezar por ahí.

Lo que **no** va a entrar nunca en esta lista porque ya está y funciona: el bar, el campo, el pueblo,
la tripulación, el cuaderno, el disco, el casco, las gafas, el telescopio, la dinamo, la sulfamida y
el epílogo. Si algo de eso se rompe, es un fallo, no un hueco.
