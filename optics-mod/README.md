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

Necesitas **Gradle 8.8 o superior** (aquí no está instalado):

```bash
cd minecraft/stone-world/optics-mod
gradle wrapper --gradle-version 8.10     # solo la primera vez
./gradlew build                          # jar en build/libs/
./gradlew runClient                      # probar en el juego
```

La primera compilación descarga NeoForge y descompila Minecraft: tarda y pide RAM. No es un error.

## Qué está verificado y qué no

- **Verificado**: JSON válido, TOML válido, texturas PNG 16×16 generadas, ids de ítem coincidentes entre código y recetas, estructura Gradle estándar.
- **NO compilado**: aquí no hay Gradle ni el entorno de NeoForge. Los puntos con más riesgo de API, en orden de probabilidad de fallo:
  1. `ComputeFovModifierEvent` (`net.neoforged.neoforge.client.event`) — si cambió de nombre en 21.1, el fallo es solo del cliente y el mod sigue funcionando sin zoom.
  2. `getUseDuration(ItemStack, LivingEntity)` — la firma cambió en 1.20.5; si el compilador pide otra, es cuestión de ajustar el override.
  3. `DeferredRegister.Items` y `registerSimpleItem` — existen en NeoForge moderno, pero confirma el nombre si el IDE se queja.

## Lo que falta para que sea fiel a la serie

- **Arenisca/pulidor como bloque**: hoy el pulido es una receta shapeless; en la serie es un banco de trabajo con corindón y agua. Un bloque `polishing_table` obligaría a un proceso real.
- **Lentes de aumento para curar**: las gafas de Suika y las lentes cóncavas de la serie son el siguiente ítem.
- **Telescopio con niveles**: lente de fluorita (era 5) con más zoom y menos aberración.
- **Integración con el pack**: cuando compile, añadirlo a `mods.txt` y meter las recetas en el libro de FTB Quests como gate de la era 2.
