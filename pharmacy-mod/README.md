# Stone Pharmacy (0.1.0)

La **farmacia del Reino de la Ciencia**: el hueco que la serie cubre en la era 2 y que ningún mod del pack resolvía. Sin sulfamidas, la historia de Ruri no se puede jugar; con pociones no se parece a nada.

## Qué añade

| Objeto | Qué hace |
|---|---|
| **Sulfamida** | Principio activo. Receta sin forma: 2 pólvora (azufre), 1 azúcar y 1 frasco → 2 sulfamidas. |
| **Jeringa con sulfamida** | Se usa con clic derecho: quita **veneno, podredumbre, náusea y debilidad**, cura 6 de vida si había infección (2 si no) y se gasta. Receta: 5 pepitas de hierro alrededor de una sulfamida. |

No cura la petrificación: eso es el fluido milagroso de Dr. Stone KoS. Esta jeringa cura lo que mataba a la gente **antes** de la penicilina, que es exactamente lo que la serie resuelve con sulfamidas.

## Química que dice el cuaderno

`C6H8N2O2S` — sulfanilamida. El grupo `-SO2NH2` imita al ácido para-aminobenzoico y corta la síntesis de ácido fólico de la bacteria: se queda sin multiplicarse y el sistema inmune la remata. Es bacteriostática, no bactericida.

## Compilar

Igual que `optics-mod` y `crank-dynamo`: hace falta **un JDK 21 con `javac`**, nada más (Gradle va en el wrapper).

```bash
cd pharmacy-mod
./gradlew build          # Windows: gradlew.bat build
```

El jar sale en `build/libs/stonepharmacy-0.1.0.jar` (8,7 KB) y se copia a `mods/`. Si Gradle se queja de que no encuentra el JDK, tienes un JRE y no un JDK: `export JAVA_HOME=/ruta/al/jdk-21`.

## Estado verificado

- Compilado contra NeoForge **21.1.262** (MC 1.21.1), sin errores ni avisos de código.
- Cargado en servidor dedicado: `Stone Pharmacy 0.1.0 (stonepharmacy)` en la lista de mods.
- Su item `stonepharmacy:sulfamida` se usa desde el datapack (`swr:ficha/sulfa`), así que si el mod falta esa ficha no carga: es dependencia del pack, no adorno.
- Las texturas son 16×16 dibujadas por código en `herramientas/generar_texturas_mod.py`, sin material de terceros.

## Lo que no hace (a propósito)

- No añade árbol de farmacia ni cadenas de fabricación: solo el objeto y su uso.
- No toca la petrificación ni el fluido: eso es del mod de Dr. Stone.
- No añade efectos nuevos: reutiliza los que ya existen para que el jugador entienda qué cura.
