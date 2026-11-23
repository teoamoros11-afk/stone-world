# El campo del pueblo: rotación y rendimiento

Cuatro parcelas de cultivo con su acequia. El campo **lo cosecha el datapack**: cada 10 segundos
mira qué hay plantado, y lo que esté maduro lo recoge y lo reparte. Lo que cambia de una cosecha a
otra no es el cultivo, es **cuánto da**: repetir el mismo cultivo en la misma parcela cansa la
tierra y baja el rendimiento; cambiarlo lo recupera. Eso es la rotación.

## Montarlo

```bash
/function swr:campo/montar    # 4 parcelas y acequia, hacia el este de quien lo ejecuta
/function swr:campo/estado    # qué hay plantado y con qué rendimiento
/function swr:campo/reglas    # las reglas, en el chat
/function swr:campo/reset     # vacía el campo y las cuentas
```

`montar` deja cuatro marcadores `swr_parcela_1..4` encima de cada parcela. El ciclo del campo
(`swr:campo/ciclo`) se arranca solo desde `swr:load` y se reprograma cada 200 ticks; también se
puede forzar una vuelta con `/function swr:campo/revisar`.

## La regla

| Situación | Rendimiento |
|---|---|
| Primera cosecha de una parcela | se queda como está (empieza en 3) |
| Repetir el mismo cultivo en esa parcela | **−1**, mínimo 1 |
| Cambiar de cultivo | **+1**, máximo 3 |

El rendimiento son las piezas que reparte la cosecha: **3 es campo cuidado, 1 es campo cansado**.
Cultivos que entiende: trigo (`age=7`), patatas (`age=7`), zanahorias (`age=7`) y remolacha
(`age=3`). Cualquier otra cosa en la parcela no cuenta y no toca la rotación.

Ejemplo con trigo, trigo, patata en la misma parcela y empezando en 3:

| Cosecha | Cultivo | Antes | Reparto | Después |
|---|---|---|---|---|
| 1 | trigo | 3 | 3 trigo | 3 (no había anterior) |
| 2 | trigo | 3 | 3 trigo | **2** (repetido) |
| 3 | patata | 2 | 2 patata | **3** (cambió) |

## Cómo está hecho

- `swr:campo/montar` construye las parcelas (tierra, `farmland[moisture=7]`, agua y valla) y los
  cuatro marcadores.
- `swr:campo/parcela1..4`: una por parcela. Detecta el cultivo con `execute if block`, comprueba la
  edad, borra el bloque, reparte `R` piezas con `give`, y actualiza `P<n>` (último cultivo) y
  `R<n>` (rendimiento) con `scoreboard players add/remove` y los topes `1..` y `..3`.
- `swr:campo/revisar` pasa por las cuatro; `swr:campo/ciclo` la llama y se reprograma.
- Las cuentas viven en el objetivo `campo`, así que **sobreviven al `/reload`**: el `load` solo
  rellena lo que falte.

## Probado

- **En servidor, por RCON** (23/11/2026): parcela de prueba con trigo maduro y sin cultivo anterior
  → `ULTIMA_COSECHA` = 3; se repite trigo → `R1` = 2. Es la sexta comprobación del arnés:
  `python3 herramientas/probar_servidor.py --servidor /var/tmp/sw3` → **6/6**.
- `tests/test_campo.py`: existen las diez funciones, las cuatro parcelas llevan su cuenta, la resta
  y la suma tienen sus topes, el `load` crea el objetivo y arranca el reloj, y el arnés comprueba
  la rotación.

## Límites, dichos antes de que se pregunten

- **Cosechar a mano no cuenta.** Si rompes el cultivo tú, recoges lo de vanilla y la parcela no
  apunta nada. El rendimiento solo lo aplica el campo cuando cosecha él.
- **No cambia el crecimiento.** El rendimiento afecta a lo que reparte la cosecha, no a la
  velocidad de crecimiento del cultivo (eso no se puede tocar por bloque sin mod).
- **El reparto va a los jugadores conectados** (`give`); sin nadie dentro no se entrega nada.
- **Sin capturas**: cómo se ve el campo montado no se ha mirado, no hay cliente en este entorno.
