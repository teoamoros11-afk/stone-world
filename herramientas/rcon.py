#!/usr/bin/env python3
"""Cliente RCON minimo (sin dependencias) para el arnes de pruebas.

El tiempo de espera es largo a proposito: un `reload` con 40 mods bloquea el hilo
del servidor y tarda mas que un comando normal.
"""
from __future__ import annotations

import socket
import struct
import sys


class Rcon:
    def __init__(self, host: str = "127.0.0.1", port: int = 25575,
                 clave: str = "", timeout: float = 180.0):
        self.s = socket.create_connection((host, port), timeout=timeout)
        self.ident = 0
        self._enviar(3, clave)
        self._recibir()

    def _enviar(self, tipo: int, cuerpo: str) -> None:
        self.ident += 1
        datos = struct.pack("<ii", self.ident, tipo) + cuerpo.encode("utf8") + b"\x00\x00"
        self.s.sendall(struct.pack("<i", len(datos)) + datos)

    def _recibir_n(self, n: int) -> bytes:
        trozos = b""
        while len(trozos) < n:
            trozo = self.s.recv(n - len(trozos))
            if not trozo:
                raise EOFError("conexion RCON cerrada")
            trozos += trozo
        return trozos

    def _recibir(self) -> str:
        largo = struct.unpack("<i", self._recibir_n(4))[0]
        return self._recibir_n(largo)[8:-2].decode("utf8", "replace")

    def cmd(self, orden: str) -> str:
        self._enviar(2, orden)
        return self._recibir()

    def cerrar(self) -> None:
        try:
            self.s.close()
        except OSError:
            pass


def main() -> int:
    if len(sys.argv) < 3:
        print(__doc__)
        return 2
    clave = sys.argv[1]
    orden = sys.argv[2]
    puerto = int(sys.argv[3]) if len(sys.argv) > 3 else 25575
    cliente = Rcon(port=puerto, clave=clave)
    print(cliente.cmd(orden))
    cliente.cerrar()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
