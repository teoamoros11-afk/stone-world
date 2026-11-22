# Cómo contribuir

Gracias por mirar. Esto es un proyecto de aficionado sobre *Dr. Stone* para
Minecraft 1.21.1 + NeoForge, y cualquier ayuda con el datapack, la documentación
o el validador se agradece. Antes de mandar nada, cuatro cosas.

## 1. Comprueba antes de enviar

```bash
./comprobar_todo.sh
```

Hace tres cosas y **el zip no se regenera si alguna falla**:

1. `python3 -m pytest` — 61 casos del validador.
2. `python3 -m validador` — estructura, JSON, mcfunctions y referencias del
   datapack (`panel/`) y del pack de recursos (`pack-inmersion/`).
3. Regenera `panel-del-reino.zip`.

Si el validador se queja de algo en un archivo que has tocado, arréglalo en el
archivo, no en el validador. Los **avisos** (comandos de mods como `drstonekos`)
no rompen nada; solo los **errores** devuelven código 1.

Para los mods Java, cada carpeta trae su wrapper: `cd optics-mod && ./gradlew build`
(necesita un JDK 21 con `javac`).

## 2. Reglas del datapack

- Las funciones van en `panel/data/swr/function/...`, en minúsculas y sin
  espacios: un nombre con mayúsculas o guion bajo raro ya no carga.
- Nada de `/` al principio de una línea de `.mcfunction`.
- Cada `function`, `predicate`, tag y objetivo de `scoreboard` que nombres tiene
  que existir. El validador lo comprueba; si no existe, error.
- Los textos largos van en `tellraw`/`title` con JSON válido, y ojo con las
  comillas: el validador ignora lo que va entre comillas al buscar referencias,
  pero no puede adivinar un JSON mal cerrado.

## 3. Lo que no se acepta

- **Descargas automáticas de CurseForge.** El instalador solo baja de Modrinth
  (API pública). Los mods que solo están en CurseForge se enlazan para que cada
  uno los coja de su página: son obra de sus autores y varios son "todos los
  derechos reservados". Un PR que añada `cfwidget`, el CDN de Forge o cualquier
  truco equivalente se rechaza.
- **Assets de terceros.** Nada de imágenes del manga, del anime, del juego ni
  de otros packs. Si dibujas algo, va con la licencia del repo.
- **Recompilar el zip a mano.** Se genera con `comprobar_todo.sh`; si lo tocas
  suelto, el siguiente que lo regenere lo pisará.

## 4. Licencia de lo que mandas

Al abrir un PR aceptas que tu aportación se publique bajo las licencias del
repo: **MIT** para el código (ver `LICENSE`) y **CC BY 4.0** para textos, arte,
datapacks y pack de recursos (ver `LICENSE-CONTENIDO.md`). Y que se te acredite
como autor de esa parte.

## Dudas y fallos

Abre un *issue* con: qué esperabas, qué pasó, y el `logs/latest.log` o la salida
de `./comprobar_todo.sh` si es un fallo del pack. Sin log es muy difícil
reproducir nada, y este proyecto prefiere decir "no lo sé" antes que adivinar.
