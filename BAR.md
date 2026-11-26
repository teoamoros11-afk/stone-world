# El bar del Perseus

Un salon en la cubierta del Perseus: la barra con Francois detras, dos mesas de poker y una
mesa de bolos. Y una regla que se cumple en el codigo: **en la despensa no aparece comida de la
nada**. Lo que se sirve lo han traido los puestos del pueblo o lo habeis entregado vosotros.

## Antes de programar: que hay para basarse

Se busco en CurseForge y Modrinth antes de escribir una linea. Resumen:

| Que | Existe | Sirve aqui |
|---|---|---|
| Cartas y poker | **Playing Cards & Chips** (OmbreMoon), 1.21.1 **NeoForge**, GPLv3, CurseForge: barajas de 52, fichas de 5 colores, mesas de poker y taburetes. | Si, es la referencia buena. **No se ha añadido** al pack: obligaria a otra dependencia y el juego ya se resuelve con datapack. |
| Cartas (datapack) | *Playing Cards and Tables*, minigame con resource pack obligatorio. | No: pide resource pack y no es 1.21.1. |
| Poker (plugin) | *Poker* de Modrinth: solo Paper/Spigot. | No: el pack es NeoForge. |
| Bolos | *In Your Lane*: solo decorado (moqueta, tablones resbaladizos), 1.20.1 y Forge; *MC Bowling*: mapa con resource pack. | No hay nada jugable para 1.21.1 NeoForge. Los bolos se programan aqui. |

Conclusiones: el poker es una baraja de verdad repartida por el datapack (52 cartas, sin mods) y
los bolos son una mesa con diez bolos y una bola que rueda. Si algun dia se añade *Playing Cards
& Chips*, las mesas y las fichas del datapack siguen valiendo y sus cartas se pueden usar encima.

## Montarlo

```
/function swr:bar/montar          # barra, dos mesas, carteles y Francois
/function swr:bar/bolos/montar    # la mesa de bolos, aparte (pide 5x12 libre)
/function swr:bar/despensa        # lo que hay
/function swr:bar/estado          # montado, Francois, despensa, fichas y ultima tirada
/function swr:bar/carta           # la carta, con clic en cada plato
/function swr:bar/entregar        # dejar comida en la despensa
```

**El bar ya viene dentro del barco.** El `perseus.nbt` trae la barra de cinco barriles con su losa,
los cinco taburetes, una mesa de poker de 3x3 con dos taburetes y el farol: con `/place template
swr:perseus <x> <y> <z>` ya estan puestos, sin ejecutar nada mas. `/function swr:bar/montar` queda
para la segunda mesa, para remontar el salon en otro sitio o para poner los carteles y a Francois
detras de la barra.

La **mesa de bolos no cabe a bordo**: pide 12 bloques de largo y la cubierta tiene 7 de manga, asi
que se monta aparte, en el muelle o en la orilla.

Los dos montajes se hacen **alrededor de quien ejecuta** y miran al sur (+z). En el Perseus hay
que colocarse en la cubierta con sitio libre delante: el salon pide 7x9 y la mesa de bolos 5x12.
No se coloca solo por coordenadas porque el barco se pone donde quiera el jugador
(`/place template swr:perseus`).

Francois tiene que estar a bordo (`/function swr:tripulacion/reclutar/cocinero`). Si no esta, el
bar se monta igual y avisa. Cuando esta, se la coloca detras de la barra con `NoAI:1b`: un aldeano
con la IA encendida se vuelve a la campana y se lleva el salon por delante.

## La despensa: de donde sale cada cosa

Dos fuentes, y solo dos:

1. **Los puestos del pueblo**, una vez al dia (lo llama `swr:pueblo/horario/noche` ->
   `swr:bar/acopio`): el granjero (oficio 1) deja **6 panes** y el pescador (oficio 3) deja
   **6 bacalaos**. Son los dos unicos oficios que producen comida; el pastor hace lana, el cantero
   ladrillos, el flechero flechas y el bibliotecario libros, asi que no repostan el bar.
2. **Vosotros**, con `/function swr:bar/entregar`: se entregan **8 unidades** de un ingrediente y
   se gastan del inventario (no se duplican). Hay diez: pan, pescado, patata, zanahoria, bayas,
   leche, miel, huevo, trigo y carne.

La despensa tiene **tope de 64** por ingrediente y empieza a cero. No hay generador, no hay
"infinito" y no hay plato gratis salvo el agua del barril.

## La carta

| # | Plato | Se cobra | Sale |
|---|---|---|---|
| 1 | Pan del pueblo | 1 pan | 2 panes |
| 2 | Pescado a la brasa | 1 pescado | 1 bacalao asado |
| 3 | Tortilla del barco | 1 huevo + 1 patata | 1 tarta de calabaza |
| 4 | Estofado de la bodega | 1 carne + 1 zanahoria | 1 estofado |
| 5 | Tarta de miel | 1 trigo + 1 huevo + 1 miel | 1 tarta |
| 6 | Agua del barril | gratis | 1 botella de agua |
| 7 | Zumo de bayas | 2 bayas | 1 botella de agua con nombre |
| 8 | Leche de la granja | 1 leche | 1 cubo de leche |
| 9 | Agua de miel | 1 miel | 1 botella de miel |

Cada pedido comprueba el stock **antes** de cobrar: si falta algo, no se cobra nada y se avisa.
Los nombres de los platos son de la casa; el valor nutritivo es el del objeto de vainilla que se
entrega, no se inventan efectos.

La sed la lleva **Thirst Was Taken**, no este datapack: aqui se sirve de beber, pero no se toca la
sed. Decirlo es mas honesto que fingir que una botella con nombre cura la sed.

## El poker

```
/function swr:bar/poker/comprar    # 1 lingote de oro = 25 fichas (no hay fichas gratis)
/function swr:bar/poker/iniciar    # una mano: 10 fichas al bote
/function swr:bar/poker/reglas     # las reglas, en el chat
```

Lo que hace `iniciar`, en orden:

1. Cobra 10 fichas y las pone en el bote (`BOTE`). Sin 10 fichas no se juega.
2. Vacía las cartas usadas y reparte **cinco cartas al jugador** (se dicen por el chat) y **cinco a
   la banca** (se guardan hasta el recuento). La baraja es de 52 y no se repite carta: cada tirada
   es `/random value 1..52` y se reintenta si ya habia salido.
3. Evalua las dos manos con los nueve tipos de siempre: escalera de color, poker, full, color,
   escalera, trio, doble pareja, pareja y carta alta.
4. Compara y paga: gana el jugador -> se lleva el bote; gana la banca -> se lo queda; empate ->
   se devuelven las 10 fichas.

**Lo que esta simplificado, y se dice:** no hay rondas de apuesta (es una apuesta fija de 10), la
banca no descarta (juega a ciegas) y la comparacion **no mira los kickers**: dos parejas iguales
con distinto acompanante empatan y se devuelve la apuesta. Con un datapack se puede hacer mas,
pero sin poder probarlo en un cliente no se promete.

## Los bolos

```
/function swr:bar/bolos/montar     # mesa de 5x12 con los diez bolos al fondo
/function swr:bar/bolos/tirar      # una tirada
/function swr:bar/bolos/marcador   # lo que lleva cada uno
/function swr:bar/bolos/reglas
```

La bola no es una entidad con fisica: es un marcador que avanza 0,7 bloques por tick (16 pasos)
con chispas y sonido de madera. En cada paso tumba el bolo mas cercano a menos de 1,5 bloques y
los demas se quedan de pie. Al final se cuentan los diez y se apunta al jugador que tiro
(`BOLOS_TIRADOS` -> marcador `bolos`). Diez de diez es **PLENO**.

Se hace asi porque una bola de nieve o un huevo se rompen al tocar el suelo y un armor stand no
recibe el impacto: la tirada saldria mal la mitad de las veces. El marcador de cada jugador no se
borra.

## Pruebas

`tests/test_bar.py` (104 casos), `tests/test_barco.py` (4 casos) y `tests/test_servidor.py` (3 casos)
comprueban, sin cliente:

- que el salon tenga barra, dos mesas, Francois quieta detras y no haya comandos destructivos;
- que la despensa empiece a cero y que el acopio solo traiga pan y pescado (los oficios que de
  verdad producen comida) y con tope;
- que cada entrega gaste 8 del inventario y sume 8;
- que cada plato de la carta cobre exactamente lo que dice y que no haya platos sin carta;
- que la baraja tenga 52 cartas distintas y el reparto cinco y cinco sin repetir;
- que la evaluacion cubra los nueve tipos y que el bote se pague y el empate se devuelva;
- que haya diez bolos, que la bola avance y que el marcador se apunte al que tiro;
- que el bar este enganchado al tick (bolos) y a la noche (acopio);
- que remontar no duplique marcadores ni bolos y que avise si no hay cubierta;
- que la carta ensene el stock al pasar el raton y que el poker diga que mano es;
- que la barra, la mesa de poker y los taburetes esten de verdad en el `.nbt` del barco, que no pisen
  el invernadero ni los escalones y que el NBT guardado lleve esos bloques;
- que el arnes de servidor exista, no traiga dependencias y sepa listar sus pruebas sin arrancar nada.

## Lo que no se ha podido comprobar

- **El aspecto**: no hay cliente en este entorno. La barra, las mesas y los bolos son bloques y
  armor stands; como quedan de bonito no se ha visto.
- **La mesa de bolos en la cubierta**: no cabe (12 de largo para 7 de manga) y se ha probado por
  estructura, no colocada. La barra y una mesa de poker si van dentro del `.nbt`, asi que aparecen
  con el barco; su aspecto sigue sin verse.
- **El arnes de servidor**: arranca Minecraft entero (unos 4 minutos con 40 mods) y espera a RCON.
  El 23/11/2026 paso **6/6** contra el mundo de pruebas: el datapack carga, `CIEN` vale 100, un
  poker de reyes suma 813, `bolos/montar` deja diez bolos y `swr:bar/estado` responde. Lo que no
  puede probar es nada que pida jugador conectado.
- **El reparto en cliente**: `/random` y los marcadores se pueden probar por consola; el `give` de
  las cartas y los platos necesita jugador.
