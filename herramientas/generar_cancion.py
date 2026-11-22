#!/usr/bin/env python3
"""Genera la cancion de Lilian como OGG para el pack de recursos.

No reproduce ninguna melodia real ni con derechos: es una pieza corta compuesta aqui,
para el hito del disco de Lilian de la serie (cap. 101-140). Salida:

    pack-inmersion/assets/swr/sounds/lilian.ogg

Uso: python3 herramientas/generar_cancion.py
Requiere ffmpeg con libvorbis. Sin dependencias de Python.
"""
import math
import pathlib
import shutil
import subprocess
import sys
import tempfile
import wave

RAIZ = pathlib.Path(__file__).resolve().parent.parent
DESTINO = RAIZ / "pack-inmersion/assets/swr/sounds/lilian.ogg"
FRECUENCIA = 44100

NOTAS = {
    "C4": 261.63, "D4": 293.66, "E4": 329.63, "F4": 349.23,
    "G4": 392.00, "A4": 440.00, "B4": 493.88,
    "C5": 523.25, "D5": 587.33, "E5": 659.25, "F5": 698.46,
    "G5": 783.99, "A5": 880.00,
}

# 20 compases cortos: sube, se calma y vuelve a casa. Sin azar: siempre suena igual.
MELODIA = [
    ("E4", 0.4), ("G4", 0.4), ("A4", 0.4), ("G4", 0.4),
    ("E4", 0.4), ("D4", 0.4), ("C4", 0.8),
    ("E4", 0.4), ("G4", 0.4), ("C5", 0.8),
    ("B4", 0.4), ("A4", 0.4), ("G4", 0.8),
    ("A4", 0.4), ("G4", 0.4), ("E4", 0.4), ("D4", 0.4),
    ("C4", 1.2), ("G4", 0.4), ("E4", 0.8),
]


def muestras(freq, duracion, amplitud=0.26):
    total = int(FRECUENCIA * duracion)
    ataque = max(1, int(0.015 * FRECUENCIA))
    caida = max(1, int(0.06 * FRECUENCIA))
    for i in range(total):
        t = i / FRECUENCIA
        envolvente = min(1.0, i / ataque) * min(1.0, (total - i) / caida)
        valor = (
            math.sin(2 * math.pi * freq * t)
            + 0.32 * math.sin(4 * math.pi * freq * t)
            + 0.10 * math.sin(6 * math.pi * freq * t)
        )
        yield amplitud * envolvente * valor


def main():
    if shutil.which("ffmpeg") is None:
        raise SystemExit("ffmpeg no esta instalado: no se puede generar el OGG")
    DESTINO.parent.mkdir(parents=True, exist_ok=True)

    # ffmpeg mete un numero de serie aleatorio en cada OGG, asi que el fichero no sale
    # byte a byte igual en dos pasadas. Para que regenerar no cambie nada, si el OGG ya
    # es mas nuevo que este script no se recodifica; con --forzar se rehace igual.
    forzar = "--forzar" in sys.argv
    if DESTINO.exists() and not forzar and DESTINO.stat().st_mtime >= pathlib.Path(__file__).stat().st_mtime:
        print(f"{DESTINO.relative_to(RAIZ)}: sin cambios ({DESTINO.stat().st_size} B, usa --forzar para rehacer)")
        return
    with tempfile.TemporaryDirectory() as tmp:
        wav = pathlib.Path(tmp) / "lilian.wav"
        with wave.open(str(wav), "wb") as salida:
            salida.setnchannels(1)
            salida.setsampwidth(2)
            salida.setframerate(FRECUENCIA)
            for nota, duracion in MELODIA:
                for valor in muestras(NOTAS[nota], duracion):
                    entero = max(-32767, min(32767, int(valor * 32767)))
                    salida.writeframesraw(entero.to_bytes(2, "little", signed=True))
        subprocess.run(
            ["ffmpeg", "-y", "-loglevel", "error", "-i", str(wav),
             "-c:a", "libvorbis", "-q:a", "4",
             "-metadata", "title=Cancion de Lilian",
             str(DESTINO)],
            check=True,
        )
    print(f"{DESTINO.relative_to(RAIZ)}: {DESTINO.stat().st_size} B")


if __name__ == "__main__":
    main()
