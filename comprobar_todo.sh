#!/usr/bin/env bash
# Comprueba el datapack y el resourcepack del proyecto entero.
#
#   ./comprobar_todo.sh            todo
#   ./comprobar_todo.sh --solo-errores
#
# Lo que hace, en orden:
#   1. los tests del propio validador (pytest);
#   2. valida panel/ y pack-inmersion/ (estructura, JSON, mcfunctions, ids);
#   3. confirma que el zip del datapack se puede regenerar y coincide.
#
# Sale con 0 solo si todo pasa. Pensado para lanzarlo antes de empaquetar.

set -euo pipefail
cd "$(dirname "$0")"

python3 -m pytest -q
python3 -m validador "$@"

# El zip es lo que se juega: se regenera y se comprueba que el generador no se
# ha roto (sobrescribe panel-del-reino.zip, que está ignorado en git).
if [ "${1:-}" != "--solo-errores" ]; then
    python3 herramientas/generar_mapa.py >/dev/null
    echo "zip: panel-del-reino.zip regenerado"
fi

echo "Todo comprobado."
