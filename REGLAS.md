# REGLAS, BUCLE Y RECORRIDO COMPLETO

Lo que hay que saber antes de crear el mundo y el orden exacto para completarlo todo.
Para el detalle de mapa: [`ISLA.md`](ISLA.md). Para la serie, era por era: [`ERAS.md`](ERAS.md); para el estudio completo (arcos, personajes y ciencia): [`SERIE.md`](SERIE.md).

---

## 1. La idea

Dos personas despiertan 3.700 anos despues en una isla vacia. No hay pueblo, no hay herramientas y no hay civilizacion: solo piedra, un fluido que revierte la petrificacion y gente dormida bajo la piedra.

El objetivo **no** es matar al otro ni llegar al End. Es **reconstruir la civilizacion entera, era por era**, y que las colonias sigan en pie cuando os vayais a dormir. Se juega en cooperacion competitiva: los dos sois el Reino de la Ciencia, pero cada uno lleva su propia colonia y compite por el mismo bambu y el mismo hierro.

**Se considera completado** cuando estan cerradas las cinco eras, las dos colonias se sostienen solas y la isla del tesoro esta explorada. Unas 50-90 h de partida.

---

## 2. Reglas de la partida

Se fijan al crear el mundo y no se cambian a mitad.

| Regla | Como se aplica |
|---|---|
| Dificultad **Hard** | `/difficulty hard` |
| **Sin keepInventory**: morir cuesta el inventario | `/gamerule keepInventory false` |
| **PvP desactivado** salvo evento acordado | `/gamerule pvp false` |
| **Modo de juego Survival siempre**. El creativo se sale en el acto con `/gamemode survival`; `F3+F4` cambia de modo y puede dejar la partida en trampa sin querer | `/gamemode survival` |
| **Sin creativo para jugar**. Solo se usa para decorar el mapa (fase 1) y se sale | creativo puntual, avisando |
| **Eras cerradas**: no se usa un objeto de la era N+1 hasta cerrar la mision de la era N | FTB Quests |
| **Una colonia por jugador** | MineColonies |
| **Petrificar por tandas**: 40-60 estatuas como maximo | rendimiento y mano de obra |
| **El panel manda**: al empezar cada sesion, `/function swr:panel/informe` | era, ciudadanos, aldeas |
| **Un mundo, dos colonias**: no se funda una tercera sin cerrar la era 5 | MineColonies |
| **Copias de seguridad** antes de la fase 1 y al cerrar cada era | carpeta `saves` |
| **Los viajes** (`/function swr:viaje/*`) solo para desplazarse, no para huir de una pelea | uso razonable |

---

## 3. Como funciona el bucle

```
petrificar -> revivir -> oficio -> la colonia crece sola -> paga la siguiente era -> la rival reacciona
```

- **Dr. Stone KoS** pone la petrificacion, la cueva del milagro y el fluido. Revivir no es decorado: convierte una estatua en un aldeano utilizable.
- **MineColonies** convierte ese aldeano en ciudadano con oficio (leñador, minero, granjero, cocinero...). Los ciudadanos trabajan solos si hay encargos y materiales.
- **Autonomous Colonies + Colony Autopilot** mantienen viva la colonia cuando nadie esta conectado: caminos, iluminacion, seguridad, crecimiento. En LAN solo avanza mientras juega el anfitrion; en servidor dedicado, siempre.
- **Millenaire** aporta "los otros": aldeas que generan, comercian y a veces hacen razzia.
- **FTB Quests** es el candado de las eras: si la mision de la era no esta cerrada, el siguiente escalon tecnologico no se usa.

Regla mental: **la mano de obra es el recurso escaso**, no el hierro. Cada muerte y cada estatua malgastada se nota una hora despues.

### La lista de la derecha del inventario

El listado de todos los objetos que sale a la derecha es **JEI**. Es un **visor de recetas**: sirve para buscar como se fabrica algo, no para regalarlo. Solo deja sacar objetos si estas en **creativo**; en survival, pinchar un objeto solo abre su receta.

Si puedes coger lo que quieras, mira arriba en el inventario: si pone **Creativo**, estas en creativo. Sal con `/gamemode survival` (o pulsa `F3+F4` hasta Survival). Es la causa numero uno de "me lo he saltado todo sin querer".

### Sobre las eras cerradas

El pack trae **FTB Quests** con arbol real: **5 capitulos y 34 misiones** encadenadas era por era (el servidor dice `Loaded 5 chapters, 34 quests`). El candado de eras es doble: `/function swr:era/N` exige cerrar la anterior con `/function swr:era/cerrar`, y ademas **avanza en equipo**: hacen falta los dos jugadores conectados y a menos de 80 bloques (MODO 2, el de fabrica; `/function swr:reino/modo` lo pasa a solitario). Para que el progreso de las quests sea compartido, montad una fiesta de FTB Teams (`/ftbteams party create`, `/ftbteams party invite`) y haced las misiones desde ella.

---

## 4. Preparacion (30-45 min, antes de jugar en serio)

1. Instalar el pack (NeoForge 21.1.262): [`IA.md`](IA.md) o [`GUIA_TLAUNCHER.md`](GUIA_TLAUNCHER.md).
2. RAM 6144 MB y los ajustes de rendimiento de `GUIA_TLAUNCHER.md` seccion 2.5.
3. Crear el mundo en Hard y aplicar las reglas de la seccion 2.
4. Copiar `panel-del-reino.zip` a `saves/<mundo>/datapacks/` y entrar.
5. `/function swr:panel/informe` debe responder.
6. `/function swr:panel/libro` da el libro con estos mismos pasos, dentro del juego.

✅ **Terminado cuando** el panel responde y las reglas estan puestas.

---

## 5. Recorrido, era por era

Cada era tiene un objetivo, unos pasos y una prueba. **No se pasa a la siguiente sin la prueba.**

### ERA 1 — No morir (1-2 h)

**Objetivo:** sobrevivir y conseguir el primer revivido.

1. Piedra y madera: pico, hacha, espada, horno y cofre.
2. Fuego y refugio cerrado antes de la primera noche.
3. Cuerda, ceramica y cuero: cama, vajilla, ropa.
4. Cesta de mimbre y taladro de arco (o su equivalente: hierro y palo).
5. Cueva del milagro: consigue el fluido y **revive a tu primer aldeano**.

✅ **Terminado cuando** hay un aldeano vivo, despetrificado y con oficio asignable.

### ERA 2 — Ganarse la aldea (6-12 h)

**Objetivo:** pasar de "un revivido" a "una colonia que produce".

1. Reunir 10-15 revividos antes de fundar nada.
2. Colocar el **Town Hall de MineColonies** en suelo llano y fundar la aldea.
3. Choza de constructor, almacen, granja y leñador: lo minimo para que no se pare.
4. Cerrar la mision de la era 2 en FTB Quests (equivale a las sulfamidas de la serie).
5. Vidrio y lentes con el mod de optica; primera bombilla cuando llegue la electricidad.
6. Electricidad basica: cobre, imanes, dinamo, pararrayos.

✅ **Terminado cuando** la colonia sube de nivel sola y hay luz en la plaza de noche.

### ERA 3 — Stone Wars (8-15 h)

**Objetivo:** aguantar una guerra con logistica.

1. Hierro a escala: horno nivel 3 y mina organizada.
2. Baterias de plomo-acido y red de cobre (Immersive Engineering).
3. Central hidroelectrica en el salto de agua de la zona 4, con tendido hasta la aldea.
4. Papel, tinta y polvora: municion y libros.
5. "Telefono": CC:Tweaked con modems inalambricos para hablaros entre colonias.

✅ **Terminado cuando** las dos colonias estan enlazadas por electricidad o radio y una razzia de Millenaire no os borra del mapa.

### ERA 4 — New World (10-20 h)

**Objetivo:** salir de la isla.

1. Brujula y cartografia de la isla.
2. Puerto y astillero en la zona 5: casco, cubierta, palo y velas. La botadura se firma con `/function swr:tripulacion/botadura`, y solo dentro del puerto.
3. Tripulacion, con nombre y oficio: `/function swr:tripulacion/reclutar/navegante` (Ryusui), `/contable` (Sai) y `/cocinero` (Francois).
3. Globo aerostatico y taladro de Create.
4. Isla del tesoro, 3.000 al este, **en bote** (el casco no navega solo): platino, cofres y la medusa.
5. Dron y radar (Create contraptions / Create Radars) para vigilar la costa.

✅ **Terminado cuando** zarpáis con los tres a bordo (`/function swr:tripulacion/zarpar`), llegáis a la isla en bote y volvéis con platino.

### ERA 5 — Science Future (Ad Astra instalado)

**Objetivo:** computacion y espacio.

1. Circuito impreso y computadora con CC:Tweaked.
2. Telescopio de fluorita (mod de optica).
3. Pan de larga duracion para expediciones.
4. Cohete, satelite y base lunar: **jugable** con Ad Astra 1.16.26 (cohete de nivel 1, satelite y base presurizada en Luna/Marte). Se cierra la era con el cierre del reino, ya fuera de la Tierra.

✅ **Terminado cuando** hay una computadora en la aldea leyendo el estado del reino y el telescopio montado.

---

## 6. El mapa, en orden

El diseno completo con coordenadas esta en [`ISLA.md`](ISLA.md). Resumen de fases y su prueba:

| Fase | Que se hace | Terminado cuando |
|---|---|---|
| 0 | Reglas, datapack, copia de seguridad | el panel responde |
| 1 | La isla: contorno, rio, salto de agua | recorres el rio sin salir del cauce |
| 2 | Aldea de Ishigami (Town Hall primero) | 10 ciudadanos trabajando |
| 3 | Cueva del milagro y campo de estatuas | 3 revividos con oficio |
| 4 | Caminos, puente, granjas | 20 min sin jugar y la colonia avanza |
| 5 | Cascada y central electrica | luz en la plaza a medianoche |
| 6 | Puerto y astillero | el barco sale y vuelve |
| 7 | Colonia rival e isla del tesoro | las dos colonias compiten |

**Atajo honesto:** fases 0-3 (25-40 h) ya son Dr. Stone jugable. El resto es la parte larga.

---

## 7. Cuando esta completado

- [ ] Las cinco eras cerradas en FTB Quests.
- [ ] Dos colonias de nivel alto, una por jugador, sin ti y sin tu amigo delante.
- [ ] Isla del tesoro explorada y platino en casa.
- [ ] Panel con la era 5 y las aldeas registradas (`/scoreboard players set <Aldea> aldeas <poblacion>`).
- [ ] Libro de la serie repartido entre los dos (`/function swr:panel/libro`).

Lo que **no** se puede completar hoy: solo el **submarino** (solo se aproxima con barco). Optica fina y dinamo son mods propios (`optics-mod`, `crank-dynamo`), las sulfamidas son `pharmacy-mod` y el espacio lo cubre Ad Astra 1.16.26. Esta todo anotado en `ERAS.md`.

---

## 8. Comandos de bolsillo

```
/function swr:panel/informe      era, ciudadanos, aldeanos, aldeas
/function swr:panel/libro        libro con el recorrido (item)
/function swr:panel/on | off     barra lateral
/function swr:era/1 .. /era/5    fijar la era
/function swr:viaje/aldea        y cueva, estatuas, cascada, puerto, bambu, rival, spawn
/function swr:panel/diagnostico  recuento de ciudadanos
/colonyautopilot menu            alcalde automatico, colonia por colonia
```

---

## 9. Si algo va mal

| Sintoma | Causa probable | Arreglo |
|---|---|---|
| Todo transparente y caes al vacio | entraste en un mundo nuevo que aun no genero chunks, o en otro mundo | sal al titulo y abre el mundo correcto; espera unos segundos quieto |
| La colonia no avanza | nadie conectado en LAN, o faltan materiales | deja un servidor dedicado; revisa encargos |
| `/function` no existe | datapack no cargado o no eres OP | `/reload` y `/datapack list` |
| Se reviven menos de los esperados | petrificaste de mas | petrifica por tandas y guarda 10 libres |
| Va a tirones | distancia de render y RAM | `GUIA_TLAUNCHER.md` seccion 2.5 |
