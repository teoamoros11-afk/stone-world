#!/usr/bin/env python3
"""Modelo geometrico del Perseus (Dr. Stone) a escala 1 bloque = 1 m.

Lo que esta documentado en la serie (fandom, capitulos 84-100):
  - bergantin modificado, dos palos cuadros con TRES velas cada uno y dos foques
  - cubierta plana, toldilla a popa con sala de comunicaciones y escapes
  - invernadero en cubierta a crujia, tres escalones en proa
  - timon y dos helices, bote motor en las gruas, proa pintada como una cara
  - "mas de 20 metros de eslora" (Ryusui: minimo para que despegue un avion)
  - construido con un modelo a escala 1:48 como referencia (Kaseki)

Lo que la serie NO da y aqui se elige con criterio de ingenieria naval de la epoca:
  LOA 30 m, manga 7 m, puntal 3,6 m, calado de diseno 1,85 m, 12 de tripulacion.

Uso:
    python3 herramientas/perseus_modelo.py      # escribe PERSEUS_PERFIL.svg y saca el plano

Todo es geometria propia: sin imagenes ni material de terceros.
"""
import math
import pathlib

RAIZ = pathlib.Path(__file__).resolve().parent.parent

# ------------------------------------------------------------------ dimensiones
LOA = 30.0          # eslora total (m)
LWL = 26.2          # eslora en flotacion
BEAM = 7.2          # manga maxima
DEPTH = 4.2         # puntal a crujia (quilla a cubierta)
DRAFT_DISENO = 2.00  # calado de diseno
CREW = 12

# Palos: (x desde popa, altura sobre cubierta, nombre)
PALO_MESANA = (20.2, 18.0, "mesana")
PALO_TRINQUETE = (8.6, 16.0, "trinquete")

# estructura de cubierta: (nombre, x0, x1, semimanga, z0, z1)
ESTRUCTURA = [
    ("toldilla / sala de comunicaciones", 2.0, 7.2, 2.4, DEPTH, DEPTH + 1.6),
    ("invernadero", 13.0, 18.2, 2.2, DEPTH, DEPTH + 1.1),
    ("escalones de proa", 27.0, 29.0, 1.4, DEPTH, DEPTH + 0.8),
    ("timon", 0.2, 1.0, 0.35, 0.2, DEPTH),
]

# control de formas (u = x / LOA)
CTRL_MANGA = [(0.00, 0.62), (0.15, 0.88), (0.40, 1.00), (0.62, 0.97), (0.82, 0.70), (1.00, 0.16)]
CTRL_QUILLA = [(0.00, 0.51), (0.18, 0.19), (0.55, 0.00), (0.80, 0.23), (1.00, 1.40)]
CTRL_CUBIERTA = [(0.00, 4.22), (0.25, 3.90), (0.55, 3.78), (0.80, 4.08), (1.00, 4.72)]


def _interp(control, u):
    """Interpolacion coseno entre puntos de control."""
    if u <= control[0][0]:
        return control[0][1]
    if u >= control[-1][0]:
        return control[-1][1]
    for i in range(len(control) - 1):
        u0, v0 = control[i]
        u1, v1 = control[i + 1]
        if u0 <= u <= u1:
            t = (u - u0) / (u1 - u0)
            s = (1 - math.cos(math.pi * t)) / 2
            return v0 + (v1 - v0) * s
    return control[-1][1]


def manga_factor(u):
    return _interp(CTRL_MANGA, u)


def keel_z(x):
    """Altura de la quilla sobre el plano base (rocker): sube en proa y popa."""
    return _interp(CTRL_QUILLA, x / LOA)


def deck_z(x):
    return _interp(CTRL_CUBIERTA, x / LOA)


def half_breadth(x, z):
    """Semimanga de la carena a la altura z (0 si esta fuera del casco)."""
    zk = keel_z(x)
    zd = deck_z(x)
    if z < zk or z > zd:
        return 0.0
    t = (z - zk) / max(zd - zk, 1e-6)
    perfil = (1.0 - (1.0 - t) ** 1.8) ** 0.55   # cuaderna redonda llena
    return 0.5 * BEAM * manga_factor(x / LOA) * perfil


def volumen_inmersion(draft, dx=0.02):
    """Volumen de carena sumergido hasta `draft` (m3)."""
    v = 0.0
    x = 0.0
    while x <= LOA:
        area = 0.0
        z = keel_z(x)
        while z < min(draft, deck_z(x)):
            area += 2 * half_breadth(x, z) * dx
            z += dx
        v += area * dx
        x += dx
    return v


def hidrostaticas(draft):
    """Volumen, area de flotacion, inercia transversal y centro de carena."""
    dx = 0.02
    v = aw = ixx = mz = 0.0
    x = 0.0
    while x <= LOA:
        zk, zd = keel_z(x), deck_z(x)
        area = 0.0
        mz_local = 0.0
        z = zk
        while z < min(draft, zd):
            b = half_breadth(x, z)
            area += 2 * b * dx
            mz_local += 2 * b * z * dx
            z += dx
        v += area * dx
        mz += mz_local * dx
        if draft > zk:
            w = half_breadth(x, draft)
            aw += 2 * w * dx
            ixx += (2.0 / 3.0) * w ** 3 * dx
        x += dx
    return {"volumen": v, "aw": aw, "ixx": ixx, "kb": (mz / v) if v else 0.0,
            "lcw": 0.0, "calado": draft}


def area_mojada(draft):
    p = 0.0
    x = 0.0
    dx = 0.05
    while x <= LOA:
        if draft > keel_z(x):
            for z in (draft,):
                p += 2 * half_breadth(x, z) * dx
        x += dx
    # casco lateral: perimetro de la seccion hasta el calado
    x = 0.0
    while x <= LOA:
        z = keel_z(x)
        prev = None
        while z < min(draft, deck_z(x)):
            b = half_breadth(x, z)
            if prev is not None:
                p += 2 * math.hypot(b - prev[0], dx) * dx
            prev = (b, z)
            z += dx
            x += 0  # sin efecto: solo recorre profundidad
        x += dx
    return p


def superficie_casco():
    """Superficie aproximada del casco (mojada + obra muerta)."""
    dx = 0.05
    s = 0.0
    x = 0.0
    while x <= LOA:
        zk, zd = keel_z(x), deck_z(x)
        per = 0.0
        z = zk
        prev = None
        while z < zd:
            b = half_breadth(x, z)
            if prev is not None:
                per += 2 * math.hypot(b - prev, dx)
            prev = b
            z += dx
        s += (per + 2 * half_breadth(x, zd)) * dx
        x += dx
    return s


def manga_en_cubierta(x):
    return half_breadth(x, deck_z(x) - 0.01)


def plan_por_capas():
    """Bloques por capa (1 m) para construir el casco en Minecraft."""
    capas = {}
    for z in range(0, int(DEPTH) + 1):
        bloques = 0
        x = 0.5
        while x < LOA:
            ancho = manga_en_cubierta(x) if z == int(DEPTH) else half_breadth(x, z + 0.5)
            bloques += max(1, int(round(2 * ancho)))
            x += 1
        capas[z] = bloques
    return capas


def estaciones(n=11):
    """Tabla de cuadernas: semimanga a tres alturas, para replantear el casco."""
    filas = []
    for i in range(n):
        x = LOA * i / (n - 1)
        zk, zd = keel_z(x), deck_z(x)
        filas.append({
            "x": round(x, 2),
            "quilla": round(zk, 2),
            "cubierta": round(zd, 2),
            "semimanga_calado": round(half_breadth(x, min(DRAFT_DISENO, zd - 0.01)), 2),
            "semimanga_media": round(half_breadth(x, zk + 0.5 * (zd - zk)), 2),
            "semimanga_cubierta": round(half_breadth(x, zd - 0.01), 2),
        })
    return filas


def perfil_desplazamiento(draft):
    """Semimanga sumergida por estacion: la silueta del barco en el agua."""
    filas = []
    x = 0.5
    while x < LOA:
        filas.append((x, half_breadth(x, min(draft, deck_z(x) - 0.01))))
        x += 1.0
    return filas


# ------------------------------------------------------------------ dibujo SVG
def svg():
    W, H = 1100, 760
    esc = 22.0
    ox, oy = 60, 400

    def X(x):
        return ox + x * esc

    def Y(z):
        return oy - z * esc

    partes = [f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">',
              '<rect width="100%" height="100%" fill="#0f1720"/>',
              '<text x="24" y="34" fill="#f0c53a" font-family="monospace" font-size="20">PERSEUS - 30 m x 7 m, escala 1 bloque = 1 m</text>']

    # perfil longitudinal
    perfil = [(X(x / 20.0), Y(keel_z(x / 20.0))) for x in range(0, 601)]
    cubierta = [(X(x / 20.0), Y(deck_z(x / 20.0))) for x in range(0, 601)]
    partes.append('<path d="M ' + " L ".join(f"{a:.1f},{b:.1f}" for a, b in perfil) +
                  " L " + " L ".join(f"{a:.1f},{b:.1f}" for a, b in reversed(cubierta)) +
                  ' Z" fill="#7b4b26" stroke="#c98b4b" stroke-width="2"/>')
    partes.append(f'<line x1="{X(0)}" y1="{Y(DRAFT_DISENO)}" x2="{X(LOA)}" y2="{Y(DRAFT_DISENO)}" stroke="#4fa3d1" stroke-dasharray="6 4"/>')
    partes.append(f'<text x="{X(0)}" y="{Y(DRAFT_DISENO) + 16}" fill="#4fa3d1" font-family="monospace" font-size="12">flotacion (calado 1,85 m)</text>')
    for x, h, nombre in (PALO_TRINQUETE, PALO_MESANA):
        partes.append(f'<line x1="{X(x)}" y1="{Y(deck_z(x))}" x2="{X(x)}" y2="{Y(deck_z(x) + h)}" stroke="#d8c9a3" stroke-width="4"/>')
        for k in range(3):
            y = deck_z(x) + h * (0.35 + 0.19 * k)
            ancho = (3.6 - 0.55 * k)
            partes.append(f'<line x1="{X(x - ancho)}" y1="{Y(y)}" x2="{X(x + ancho)}" y2="{Y(y)}" stroke="#e8e2cf" stroke-width="2"/>')
        partes.append(f'<text x="{X(x) - 20}" y="{Y(deck_z(x) + h) - 10}" fill="#d8c9a3" font-family="monospace" font-size="11">{nombre}</text>')
    for nombre, x0, x1, sm, z0, z1 in ESTRUCTURA:
        partes.append(f'<rect x="{X(x0)}" y="{Y(z1)}" width="{(x1 - x0) * esc}" height="{(z1 - z0) * esc}" fill="#39546b" stroke="#8fb8d8"/>')
    partes.append(f'<text x="24" y="{oy + 120}" fill="#9fb4c7" font-family="monospace" font-size="13">Perfil: quilla con rocker, toldilla a popa, invernadero a crujia, escalones en proa y timon.</text>')

    # planta de cubierta
    py = 560
    partes.append(f'<text x="24" y="{py - 26}" fill="#f0c53a" font-family="monospace" font-size="16">Planta de cubierta</text>')
    izq = [(X(x / 10.0), py - manga_en_cubierta(x / 10.0) * esc * 0.9) for x in range(0, 301)]
    der = [(X(x / 10.0), py + manga_en_cubierta(x / 10.0) * esc * 0.9) for x in range(300, -1, -1)]
    partes.append('<path d="M ' + " L ".join(f"{a:.1f},{b:.1f}" for a, b in izq) +
                  " L " + " L ".join(f"{a:.1f},{b:.1f}" for a, b in der) +
                  ' Z" fill="#5d3a1f" stroke="#c98b4b" stroke-width="2"/>')
    for x, h, nombre in (PALO_TRINQUETE, PALO_MESANA):
        partes.append(f'<circle cx="{X(x)}" cy="{py}" r="6" fill="#d8c9a3"/>')
    for nombre, x0, x1, sm, z0, z1 in ESTRUCTURA[:3]:
        partes.append(f'<rect x="{X(x0)}" y="{py - sm * esc * 0.9}" width="{(x1 - x0) * esc}" height="{2 * sm * esc * 0.9}" fill="#39546b" opacity="0.85"/>')
    # portillas: 9 por banda
    for k in range(9):
        xk = 6.0 + k * 2.2
        for s in (-1, 1):
            partes.append(f'<circle cx="{X(xk)}" cy="{py + s * manga_en_cubierta(xk) * esc * 0.55}" r="3" fill="#0f1720" stroke="#8fb8d8"/>')
    partes.append(f'<text x="24" y="{py + 150}" fill="#9fb4c7" font-family="monospace" font-size="13">Planta: toldilla (x 2-7), invernadero (x 13-18), escalones (x 27-29), palos en x 8,6 y 20,2, nueve portillas por banda.</text>')
    partes.append("</svg>")
    return "\n".join(partes)


def main():
    v = volumen_inmersion(DRAFT_DISENO)
    h = hidrostaticas(DRAFT_DISENO)
    print(f"Perseus: LOA {LOA} m, manga {BEAM} m, puntal {DEPTH} m, calado {DRAFT_DISENO} m")
    print(f"  volumen de carena sumergido: {v:.1f} m3")
    print(f"  area de flotacion: {h['aw']:.1f} m2 | inercia transversal Ixx: {h['ixx']:.1f} m4")
    print(f"  centro de carena KB: {h['kb']:.2f} m")
    print(f"  superficie del casco: {superficie_casco():.0f} m2")
    print("\ncuadernas (x, quilla, cubierta, semimangas a calado / media / cubierta):")
    for f in estaciones():
        print(f"  {f['x']:5.1f}  {f['quilla']:4.2f}  {f['cubierta']:4.2f}   "
              f"{f['semimanga_calado']:4.2f}  {f['semimanga_media']:4.2f}  {f['semimanga_cubierta']:4.2f}")
    print("\nbloques por capa (1 m) para el casco:", plan_por_capas())
    print(f"  total casco: {sum(plan_por_capas().values())} bloques de madera")
    (RAIZ / "PERSEUS_PERFIL.svg").write_text(svg(), encoding="utf-8")
    print(f"\nescrito {RAIZ / 'PERSEUS_PERFIL.svg'}")


if __name__ == "__main__":
    main()
