# Los personajes del pueblo

Cada estatua que pones con `/function swr:pueblo/estatua` sale con **una ficha fija**: nombre,
aldea de Minecraft (que cambia ropa y tono de piel del aldeano), oficio, nivel y un objeto en
la mano. No es un sorteo: el indice de estatua (`ESTATUAS mod 12`) elige la ficha, siempre en
el mismo orden, y lo que ves petrificado es lo que revive.

El porque de que sea fijo y no al azar: un aldeano aleatorio con el nombre de Kohaku no es
Kohaku. Si el aspecto lo decide el dado, al revivir te sale un bibliotecario con delantal y el
nombre de la cazadora, y el pueblo deja de parecer el de la serie. Aqui cada uno tiene su
papel, y su oficio no lo cambia el reparto de oficios (`swr_canon` los protege).

## La ficha

| # | Personaje | Aldea (Minecraft) | Oficio | Nivel | En la mano |
|---|---|---|---|---|---|
| 1 | Kohaku | llanura | flechera | 4 | hacha de piedra |
| 2 | Chrome | taiga | bibliotecario | 3 | frasco de vidrio |
| 3 | Ruri | llanura | clerigo | 3 | amatista |
| 4 | Kaseki | sabana | cantero | 5 | pico de hierro |
| 5 | Suika | jungla | ninguna (es una nina) | 1 | sandia |
| 6 | Ginro | desierto | pescador | 1 | bacalao |
| 7 | Kinro | pantano | armero | 4 | espada de hierro |
| 8 | Magma | sabana | carnicero | 2 | hacha de piedra |
| 9 | Kokuyo | taiga | cartografo | 4 | mapa |
| 10 | Jasper | nieve | pastor | 2 | lana |
| 11 | Turquoise | desierto | granjera | 2 | trigo |
| 12 | Sapphire | nieve | peletera | 2 | cuero |

Las seis primeras fichas coinciden con los seis puestos de oficio del pueblo (cantero,
granjero, pastor, pescador, flechero, bibliotecario), asi que esos personajes se van a trabajar
a su puesto en el horario. Los que tienen oficio sin puesto (clerigo, armero, carnicero,
cartografo, peletera) se quedan en la plaza o en su casa: su oficio existe, pero el pueblo no
tiene mesa para el.

## Lo que se ve de cada uno

**No hay skins.** Un aldeano de Minecraft no acepta una textura propia: el juego tiene **siete
ropas**, una por tipo de aldea, y encima el delantal del oficio. Eso, el color del nombre y el
objeto de la mano es todo lo que se puede cambiar, y un resource pack no lo arregla porque
cambia a todos los aldeanos a la vez, no a uno. La ficha es, por tanto, una eleccion de ropa
entre siete, no un traje a medida.

| # | Personaje | Ropa (aldea) | Delantal (oficio) | Nivel | En la mano | Nombre |
|---|---|---|---|---|---|---|
| 1 | Kohaku | llanura | flechera | 4 | hacha de piedra | dorado |
| 2 | Chrome | taiga | bibliotecario | 3 | frasco de vidrio | aguamarina |
| 3 | Ruri | llanura | clerigo | 3 | amatista | lila |
| 4 | Kaseki | sabana | cantero | 5 | pico de hierro | gris |
| 5 | Suika | jungla | ninguno | 1 | trozo de sandia | verde |
| 6 | Ginro | desierto | pescador | 1 | bacalao | amarillo |
| 7 | Kinro | pantano | armero | 4 | espada de hierro | azul |
| 8 | Magma | sabana | carnicero | 2 | hacha de piedra | rojo |
| 9 | Kokuyo | taiga | cartografo | 4 | mapa | blanco |
| 10 | Jasper | nieve | pastor | 2 | lana | azul oscuro |
| 11 | Turquoise | desierto | granjera | 2 | trigo | turquesa |
| 12 | Sapphire | nieve | peletera | 2 | cuero | azul claro |

Solo dos parejas comparten ropa, y se distinguen sin problema por el delantal, el objeto y el
color del nombre: Kohaku y Ruri (llanura) son cazadora y sacerdotisa, y Jasper y Sapphire
(nieve) son pastor y peletera. Jungla y pantano quedan para una sola persona cada uno, que es
lo mas cerca que se puede estar de un traje distinto sin salirse del juego.

Lo que **no** se puede poner en el aldeano, y conviene saberlo antes de pedirlo: nada de ropa
encima. Las gafas de Kinro y el casco de sandia de Suika existen como objetos de mod
(`stoneoptics:kinro_glasses` y `suikacasco:watermelon_helmet`), pero los lleva el jugador, no
el aldeano: un aldeano no renderiza armadura. El casco ocupa la cabeza entera, que es el
tamano de la cabeza del jugador; una cascara mas grande pide un renderer propio. Un traje de
verdad pide un mod con renderer propio o cabezas de jugador con textura, y las cabezas
necesitan un PNG alojado; esta apuntado en `PENDIENTE.md`.

## Rutinas propias

El horario comun pone a todo el mundo en su sitio; `swr:pueblo/horario/rutinas` (lo ultimo que
corre `.../cambiar`, para mandar sobre el reparto general) da a cada uno lo suyo dentro de ese
turno:

| Personaje | Turno | Que hace |
|---|---|---|
| Ruri | Amanecer | Abre el dia al lado de la campana, que es la que toca ella. |
| Kohaku | Manana | Sale a cazar: arco en la mano y 8 flechas en la otra. |
| Kohaku | Tarde | Vuelve a su hacha de piedra, la de tallar lanzas en la mesa de flechas. |
| Suika | Manana a tarde | Se pone en la mesa de flechas, al lado de Kohaku, con su sandia. |
| Kinro | Manana a tarde | Monta guardia en la boca de la calle norte; come alli, sin dejar la entrada. |
| Chrome | Comida | No come: se queda en el atril con el frasco en la mano. |
| Kokuyo | Reunion | Se pone junto a la campana, no entre los demas. |

Dos cosas que se aprendieron probandolo en el servidor y estan en el archivo:

- **Un aldeano con la IA encendida se vuelve solo a la campana de la plaza** (o a su mesa de
  trabajo), asi que la rutina duraba dos segundos. Quien tiene que quedarse quieto en su sitio
  lleva `NoAI:1b` hasta el amanecer, y al amanecer se le devuelve el movimiento.
- **Poner a Suika al lado de Kohaku no sirve**: la cazadora sigue andando hasta su mesa y la deja
  atras. Se la pone en la mesa de flechas, que es donde Kohaku acaba.

Los otros seis (Kaseki, Ginro, Jasper, Magma, Turquoise, Sapphire) siguen el horario comun: su
oficio ya tiene puesto y no hay nada que contar de ellos que el pueblo no haga ya. Cada ficha lleva su tag
`swr_es_<nombre>`, que es lo que usan las rutinas para encontrarlos.

## Como esta hecho

- `swr:personajes/asignar` calcula `SUERTE = ESTATUAS mod 12` y llama a la ficha que toca.
- Cada ficha es un archivo pequeño (`swr:personajes/kohaku`, `.../chrome`, …) con tres cosas:
  `data merge entity @s` con el nombre (y su color), `VillagerData` (tipo de aldea, oficio y
  nivel), el tag `swr_canon` y el objeto en la mano.
- El tag `swr_canon` hace dos cosas: `swr:pueblo/oficios/asignar` y `.../vestir` lo respetan (no
  le cambian el oficio) y `swr:pueblo/oficios/reparto_uno` no lo elige para reequilibrar; y
  `swr:pueblo/horario/trabajo` no le cambia el objeto de la mano por la herramienta del oficio.
- El nombre lo pone el merge, no un `tellraw`: al revivir el aldeano conserva el mismo nombre,
  el mismo tipo y el mismo oficio, porque nada de eso se vuelve a tirar.

## Anadir uno

1. Copia una ficha, cambia nombre, `type` (plains, taiga, savanna, desert, snow, swamp, jungle),
   `profession`, `level` y el objeto.
2. Súmala al final de `swr:personajes/asignar` y sube el divisor (`DOCE` en `load`) a 13, o
   cambia la ficha que quieras sustituir.
3. Anade la fila a la tabla de arriba y pasa `./comprobar_todo.sh`: el validador comprueba que
   la funcion existe y que el JSON del nombre esta bien cerrado.

Ojo con el nivel: los oficios sin puesto (`none`, `cleric`, `weaponsmith`…) aceptan nivel, pero
un `none` con nivel 4 no significa nada; Suika se queda en 1 a proposito.
