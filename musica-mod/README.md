# Stone Musica — el sonido y el disco de Lilian

Pieza propia del pack Stone World Reborn (Dr. Stone). Existe por un motivo concreto que costo un
arranque fallido: **un `jukebox_song` del datapack resuelve su sonido contra el registro del
servidor, y un resource pack no registra nada**. Con el sonido solo en `pack-inmersion/`, el
servidor moria con:

```
Failed to parse swr:jukebox_song/lilian.json ... Failed to get element ResourceKey[minecraft:sound_event / swr:lilian]
```

## Que incluye

| Pieza | Id | Para que |
|---|---|---|
| Sound event | `swrmusica:lilian` | el `.ogg` viaja en el mod (`assets/swrmusica/sounds/lilian.ogg`) |
| Disco | `swrmusica:disco_lilian` | `music_disc` con el componente `jukebox_playable` por defecto |

El disco tiene que ser un **item del mod**, no un `give` con componente dentro de una funcion: al
cargar las funciones el registro de `jukebox_song` todavia no tiene la entrada y el comando no se
parsea (`Cannot parse as key without registry`). `EitherHolder` guarda solo la clave y la resuelve
al usarla.

El datapack sigue trayendo `data/swr/jukebox_song/lilian.json` (sonido, descripcion, 10,4 s y
salida de comparador 3) y `swr:serie/disco` solo entrega el item.

## Que esta verificado y que no

- **Compilado**: `BUILD SUCCESSFUL` contra NeoForge 21.1.262.
- **En servidor, por RCON** (23/11/2026): `give @a swrmusica:disco_lilian` responde `No player was
  found` (el item existe y el comando se parsea) y `give @a swrmusica:no_existe` responde
  `Unknown item` (control); `function swr:serie/disco` responde `Running function` y sale sin
  errores; el log no tiene `Failed to load function`.
- **Sin probar**: que suene en un tocadiscos de verdad y el icono en el inventario (no hay cliente).
