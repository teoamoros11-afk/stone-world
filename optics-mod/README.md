# Stone Optics — mod de óptica para NeoForge 1.21.1

Primera pieza del pack Stone World Reborn. Cierra el hueco de la **era 2 (Aldea Ishigami)**: vidrio → lentes → telescopio.

## Qué incluye

| Ítem | Receta | Papel en la serie |
|---|---|---|
| **Lente sin pulir** (`rough_lens`) | 2 vidrio + 1 pedernal (shapeless, da 2) | vidrio fundido con forma, todavía turbio |
| **Lente pulida** (`polished_lens`) | 1 lente sin pulir + 3 arena (shapeless) | el pulido con arena es el paso que enfoca |
| **Telescopio** (`telescope`) | patrón 3×3: lente pulida + 2 lingotes de cobre | el de la era 5, aquí como primer instrumento |

El telescopio se usa como el catalejo de vanilla: mantener clic derecho y el FOV baja a 0.15. No gasta durabilidad.

## Estructura

```
optics-mod/
├── build.gradle / settings.gradle / gradle.properties   ModDevGradle 2.0.78, Java 21
└── src/main/
    ├── java/com/teo/stoneoptics/
    │   ├── StoneOptics.java            @Mod, registro y pestaña creativa
    │   ├── item/ModItems.java          DeferredRegister.Items
    │   ├── item/TelescopeItem.java     uso tipo catalejo (UseAnim.SPYGLASS)
    │   └── client/ClientFov.java       zoom por ComputeFovModifierEvent (solo cliente)
    └── resources/
        ├── META-INF/neoforge.mods.toml  metadatos y dependencias
        ├── assets/stoneoptics/          modelos, texturas PNG 16×16 y lang en/es
        └── data/stoneoptics/recipe/     las tres recetas (formato 1.21: "id", no "item")
```

## Compilar

Solo hace falta **un JDK 21 que tenga `javac`**: Gradle va dentro del repo, en el wrapper.

```bash
cd optics-mod
./gradlew build          # Windows: gradlew.bat build
```

El jar sale en `build/libs/stoneoptics-0.2.0.jar` (unos 18 KB). La primera compilación descarga NeoForge y descompila Minecraft (1,5 GB de caché en `~/.gradle`); tarda y pide RAM, no es un error.

Si `java -version` dice 21 pero Gradle se queja de que no encuentra un JDK, es que tienes un **JRE** y no un JDK: apunta a uno completo con `export JAVA_HOME=/ruta/al/jdk-21` (Temurin, por ejemplo) antes de lanzar el wrapper.

## Qué está verificado y qué no

- **Verificado**: JSON válido, TOML válido, texturas PNG 16×16 generadas, ids de ítem coincidentes entre código y recetas, estructura Gradle estándar.
- **Compilado**: `BUILD SUCCESSFUL` con Gradle 8.10 + Temurin 21.0.13 contra NeoForge 21.1.262. Los tres puntos de riesgo de la versión anterior (`ComputeFovModifierEvent`, `getUseDuration(ItemStack, LivingEntity)`, `DeferredRegister.Items`) compilaron sin tocar una línea; los únicos avisos son dos de deprecación por `EventBusSubscriber.Bus`, que no rompen nada.
- **Cargado en servidor**: el jar en `mods/` y el servidor arranca sin errores del mod; los ítems y las tres recetas se registran.
- **Sin probar**: el zoom en un cliente real y el aspecto de las texturas dentro del juego.

## v0.2.0 (17/11/2026): banco de pulido y gafas de Kinro

| Añadido | Receta | Papel en la serie |
|---|---|---|
| **Banco de pulido** (`polishing_table`, bloque) | 2 piedra arriba con una lente pulida en medio + 3 piedra (`SPS / SSS`) | en la serie el pulido es un banco con abrasivo, no una receta de mesa: le das la lente turbia y devuelve la pulida |
| **Gafas de Kinro** (`kinro_glasses`) | 2 lentes pulidas arriba y 1 lingote de oro (`L L / G`) | el guardia miope ve por primera vez: vision clara 60 s y 12 s de enfriamiento "limpiando los cristales" |

El banco da la lente pulida al usarlo con una lente sin pulir en la mano (no consume en creativo) y suena a arena. Compilado y probado en servidor: `Stone Optics 0.2.0`, bloque colocado con `/setblock`, gafas invocadas con `/summon item`, tres recetas registradas.

## Lo que falta para que sea fiel a la serie

- **Arenisca/pulidor como bloque**: hoy el pulido es una receta shapeless; en la serie es un banco de trabajo con corindón y agua. Un bloque `polishing_table` obligaría a un proceso real.
- **Lentes de aumento para curar**: las gafas de Suika y las lentes cóncavas de la serie son el siguiente ítem.
- **Telescopio con niveles**: lente de fluorita (era 5) con más zoom y menos aberración.
- **Integración con el pack**: cuando compile, añadirlo a `mods.txt` y meter las recetas en el libro de FTB Quests como gate de la era 2.
