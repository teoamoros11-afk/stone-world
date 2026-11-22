#!/usr/bin/env python3
"""Simulador fisico del Perseus: flotacion, estabilidad y velocidad.

Metodo (teoria de franjas / strip theory, el mismo esquema que usan los programas
de estabilidad para cascos sencillos):
  1. El casco es el modelo geometrico de perseus_modelo.py, discretizado en celdas
     de 0,2 m.
  2. Para cada angulo de escora se gira el casco, se busca la flotacion que deja
     el volumen desplazado igual al peso y se calcula el centro de carena.
  3. El brazo adrizante es GZ = y_B - y_G en coordenadas del mundo: la separacion
     horizontal entre las verticales de empuje y de peso. Es la definicion exacta
     del par adrizante, sin aproximaciones de pared vertical.
  4. Criterios: IS Code 2008 (GM >= 0,15 m; GZ >= 0,20 m a 30 grados; area bajo la
     curva hasta 30 grados >= 0,055 m·rad) y velocidad limite de casco de Froude.

Uso: python3 herramientas/simular_perseus.py
Salida: tabla por consola y PERSEUS_FISICA.md
"""
import bisect
import math
import pathlib
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
import perseus_modelo as M  # noqa: E402

RAIZ = pathlib.Path(__file__).resolve().parent.parent
RHO_AGUA = 1025.0     # kg/m3, agua de mar
G = 9.81
CELL = 0.25           # m, resolucion del casco discretizado

# ---------------------------------------------------------------- pesos (kg)
# (nombre, masa, altura del centro de gravedad sobre la quilla)
# El casco no son solo tablones: forro exterior + cuadernas, baos y mamparos + forro
# interior (ceiling). Es lo que hace que un bergantin de 30 m pese lo que pesa.
PESOS = [
    ("forro exterior de roble", None, 1.10),
    ("cuadernas, baos y mamparos", None, 1.30),   # 160 % del forro
    ("forro interior y sollados", None, 1.40),     # 50 % de la superficie, 6 cm
    ("cubierta y toldilla", 168.0 * 0.10 * 650, 3.90),
    ("palos, vergas y jarcia", 2600.0, 10.0),
    ("velas y cabos", 140.0, 8.50),
    ("motor, ejes y dos helices", 3800.0, 0.90),
    ("combustible y tanques", 2800.0, 0.80),
    ("agua dulce", 1600.0, 0.90),
    ("viveres y cocina", 1300.0, 1.80),
    ("tripulacion (12 personas)", M.CREW * 78.0, 1.80),
    ("equipo cientifico y carga", 16000.0, 2.40),
    ("hierros, clavazon y herrajes", 1900.0, 1.50),
    ("lastre de piedra", 22000.0, 0.35),
]

ESPESOR_FORRO = 0.12     # m de tablon
RHO_MADERA = 700.0       # kg/m3 roble curado


def masa_casco():
    sup = M.superficie_casco()
    forro = sup * ESPESOR_FORRO * RHO_MADERA
    return forro, forro * 0.45, sup


def presupuesto():
    forro, estructura, sup = masa_casco()
    techo = sup * 0.50 * 0.06 * 650
    filas = []
    for nombre, masa, zg in PESOS:
        if nombre.startswith("forro exterior"):
            masa = forro
        elif nombre.startswith("cuadernas"):
            masa = estructura
        elif nombre.startswith("forro interior"):
            masa = techo
        filas.append((nombre, masa, zg))
    total = sum(m for _, m, _ in filas)
    kg = sum(m * z for _, m, z in filas) / total
    return filas, total, kg, sup


def calado_de_equilibrio(masa_total):
    lo, hi = 0.05, 4.0
    for _ in range(60):
        mid = (lo + hi) / 2
        if M.volumen_inmersion(mid) * RHO_AGUA < masa_total:
            lo = mid
        else:
            hi = mid
    return (lo + hi) / 2


# ---------------------------------------------------------------- celdas del casco
def celdas_casco():
    celdas = []
    x = 0.5
    while x < M.LOA:
        zk, zd = M.keel_z(x), M.deck_z(x)
        pts = []
        z = zk + CELL / 2
        while z < zd:
            y = -M.BEAM / 2
            while y < M.BEAM / 2:
                yc = y + CELL / 2
                if abs(yc) <= M.half_breadth(x, z):
                    pts.append((yc, z, CELL * CELL))
                y += CELL
            z += CELL
        celdas.append((1.0, pts))   # dx = 1 m entre estaciones de la malla
        x += 1.0
    return celdas


def gz(theta_grados, area_objetivo, celdas):
    """Brazo adrizante a una escora. area_objetivo = volumen / dx (m2 por estacion)."""
    th = math.radians(theta_grados)
    c, s = math.cos(th), math.sin(th)
    items = []
    for dx, pts in celdas:
        for (y, z, a) in pts:
            y2 = y * c + z * s
            z2 = -y * s + z * c
            items.append((z2, y2, a * dx))
    items.sort()
    zs = [it[0] for it in items]
    pref_a, pref_y = [0.0], [0.0]
    for _, y2, a in items:
        pref_a.append(pref_a[-1] + a)
        pref_y.append(pref_y[-1] + a * y2)
    lo, hi = zs[0] - 1.0, zs[-1] + 1.0
    for _ in range(80):
        mid = (lo + hi) / 2
        i = bisect.bisect_right(zs, mid)
        if pref_a[i] < area_objetivo:
            lo = mid
        else:
            hi = mid
    sh = (lo + hi) / 2
    i = bisect.bisect_right(zs, sh)
    a_total = pref_a[i]
    yb = pref_y[i] / a_total if a_total else 0.0
    return yb


def curva_gz(masa_total, kg, celdas):
    v = masa_total / RHO_AGUA
    area = v  # dx = 1 m
    filas = []
    for th in range(0, 71, 5):
        yb = gz(th, area, celdas)
        yg = kg * math.sin(math.radians(th))
        filas.append((th, yb - yg))
    return filas


def escora_inundacion(draft):
    """Escora a la que la borda baja al agua: a partir de ahi el agua entra por cubierta.

    Es la regla que limita de verdad la escora de un barco abierto: el GZ de formas
    sigue subiendo, pero en cuanto la cubierta toca el agua el buque se inunda.
    """
    peor = 90.0
    estacion = None
    x = 0.5
    while x < M.LOA:
        franco = M.deck_z(x) - draft
        borde = M.half_breadth(x, M.deck_z(x) - 0.01)
        if borde > 0.3 and franco > 0:
            ang = math.degrees(math.asin(max(0.0, min(1.0, franco / borde))))
            if ang < peor:
                peor, estacion = ang, x
        x += 1.0
    return peor, estacion


def area_bajo_curva(curva, hasta):
    a = 0.0
    for (t0, g0), (t1, g1) in zip(curva, curva[1:]):
        if t1 > hasta:
            t1 = hasta
            g1 = g0 + (g1 - g0) * (hasta - t0) / 5.0
        a += math.radians(t1 - t0) * (g0 + g1) / 2
        if t1 >= hasta:
            break
    return a


def escribir_plano(total, kg, gm, draft, franco, inundacion, avs_real, a30, v_kn, a_vela, sad, curva):
    capas = M.plan_por_capas()
    est = M.estaciones()
    lineas = [
        "# El Perseus: plano y comprobacion fisica",
        "",
        "Modelo y simulacion propios, escala **1 bloque = 1 m**. Nada de imagenes de la serie: la forma se",
        "reconstruye a partir de lo que el manga y el anime dicen y se comprueba con hidrostaticas.",
        "",
        "## Lo que dice la serie (cap. 84-100, anime Dr. Stone Ryusui)",
        "",
        "- Bergantin **modificado**: dos palos cuadros con **tres velas** cada uno y **dos foques**.",
        "- Sin vela cangreja: en su sitio, la torre de escapes; el palo de proa gira con un engranaje movido por el motor.",
        "- Cubierta plana, **toldilla** a popa con sala de comunicaciones y escapes, **invernadero** a crujia,",
        "  **tres escalones** en proa, timon, **dos helices** y bote motor en las gruas.",
        "- Proa pintada como una cara (figura de proa) y **nueve portillas** por banda.",
        "- **Mas de 20 m de eslora** (Ryusui: minimo para que despegue un avion). Kaseki trabaja sobre un modelo 1:48.",
        "",
        "## Dimensiones elegidas",
        "",
        "| Parametro | Valor | Por que |",
        "|---|---|---|",
        f"| Eslora total | {M.LOA:.0f} m | El minimo documentado (20 m) con margen para el bote y el invernadero |",
        f"| Eslora en flotacion | {M.LWL:.1f} m | 87 % de la total: overhangs de bergantin |",
        f"| Manga | {M.BEAM:.1f} m | Proporcion 4,2:1, la de un bergantin de la epoca |",
        f"| Puntal | {M.DEPTH:.1f} m | Para dos cubiertas y el invernadero |",
        f"| Calado de diseno | {draft:.2f} m | El que pide el peso; barco de agua somera |",
        f"| Tripulacion | {M.CREW} | Ryusui, Sai, Francois, Senku, Kohaku y guardia |",
        "",
        "## Cuadernas (replanteo en bloques)",
        "",
        "| x | quilla | cubierta | semimanga a calado | semimanga media | semimanga cubierta |",
        "|---|---|---|---|---|---|",
    ]
    for f in est:
        lineas.append(f"| {f['x']:.1f} | {f['quilla']:.2f} | {f['cubierta']:.2f} | {f['semimanga_calado']:.2f} | {f['semimanga_media']:.2f} | {f['semimanga_cubierta']:.2f} |")
    lineas += [
        "",
        "## Bloques por capa (casco)",
        "",
        "|" + "|".join(f"capa {z}" for z in sorted(capas)) + "|",
        "|" + "|".join("---" for _ in capas) + "|",
        "|" + "|".join(str(capas[z]) for z in sorted(capas)) + "|",
        "",
        f"Total del casco: **{sum(capas.values())} bloques** de madera (forro de 1 bloque de grosor, hueco por dentro).",
        "",
        "## Estructura de cubierta",
        "",
        "| Elemento | x | semimanga | altura |",
        "|---|---|---|---|",
    ]
    for nombre, x0, x1, sm, z0, z1 in M.ESTRUCTURA:
        lineas.append(f"| {nombre} | {x0:.1f}-{x1:.1f} | {sm:.1f} | {z0:.1f}-{z1:.1f} |")
    lineas += [
        "",
        "Palos: trinquete en x=8,6 con 16 m de altura; mesana en x=20,2 con 18 m. Tres vergas por palo",
        "(anchuras 3,6 / 3,05 / 2,5 m de semiverga) y dos foques al bauprés.",
        "",
        "## Como construirlo en el juego",
        "",
        "**Los aldeanos no construyen.** En este pack no hay ningun aldeano que coloque bloques:",
        "`swr:tripulacion/reclutar/*` solo hace `summon villager` con nombre, profesion y `Tags`,",
        "y el barco se construye antes de botarlo. La tripulacion es decorado y guion (son los que",
        "suben a bordo al zarpar), no un sistema de construccion. Un aldeano de Minecraft no puede",
        "picar ni poner bloques ni con datapack: eso solo lo hacen jugadores, goles o mods.",
        "",
        "### Metodo 1: colocar la estructura (recomendado)",
        "",
        "El barco ya esta modelado bloque a bloque en `panel/data/swr/structure/perseus.nbt`",
        "(32 x 24 x 9, 792 bloques solidos; se regenera con",
        "`python3 herramientas/generar_estructura_perseus.py`). El origen es la esquina de popa",
        "a la altura de la quilla, asi que hay que dejar agua (o aire) y 4 bloques de calado libre debajo:",
        "",
        "```",
        "/place template swr:perseus <x> <y> <z>",
        "```",
        "",
        "Con el barco ya en el mundo, la quilla queda en `y`, la cubierta en `y+4` y el agua de",
        "flotacion ronda `y+2`: unos 2 bloques de obra muerta por encima de la linea de flotacion, como",
        "pide el modelo. El comando exige que el chunk este cargado: en un mundo nuevo usa antes",
        "`/forceload add <x> <z>` o coloca el barco cerca del spawn. Comprobado en un servidor 1.21.1",
        "con este pack: cubierta, vela de trinquete, invernadero, escalon de proa y helice aparecen",
        "donde dice el plano.",
        "",
        "### Metodo 2: a mano con las tablas de arriba",
        "",
        "1. Marca la quilla en la capa 0 con el rocker de la tabla (sube 1 bloque en proa y 0,5 en popa).",
        "2. Levanta las cuadernas cada 2 bloques usando las semimangas; el casco es hueco.",
        "3. Cubre la cubierta en la capa 4 y deja los huecos de las tres escotillas.",
        "4. Toldilla en x 2-7, invernadero de cristal en x 13-18, escalones en x 27-29, timon en x 0-1.",
        "5. Palos y vergas donde dice la tabla; velas de lana blanca, tres por palo, y dos foques.",
        "6. Nueve portillas por banda entre x=6 y x=24, a media altura de la obra muerta.",
        "7. Dos helices bajo el espejo de popa y el bote motor colgando de las gruas de cubierta.",
        "",
        "### Metodo 3: un mod de construccion",
        "",
        "Si prefieres verlo crecer solo, cualquier mod de constructores (Create con sus brazos,",
        "MineColonies o similares) puede poner los bloques del plano, pero ninguno viene en el pack y",
        "habria que anadirlo. Para navegar de verdad hace falta ademas un mod de barcos (Small Ships",
        "o similar): la estructura por si sola es un barco quieto, coherente con la fisica pero sin",
        "flotacion propia, porque Minecraft no la tiene.",
        "",
        "El perfil longitudinal, la planta y las estructuras estan dibujados en `PERSEUS_PERFIL.svg`",
        "(se regenera con `python3 herramientas/perseus_modelo.py`).",
        "",
        "## Resultado del simulador",
        "",
        "| Medida | Valor |",
        "|---|---|",
        f"| Masa total | {total/1000:.1f} t |",
        f"| Calado de equilibrio | {draft:.2f} m |",
        f"| Francobordo minimo | {franco:.2f} m |",
        f"| GM inicial | {gm:.2f} m |",
        f"| GZ a 30 grados | {dict(curva)[30]:.2f} m |",
        f"| Area bajo GZ hasta 30 grados | {a30:.3f} m·rad |",
        f"| Borda al agua | {inundacion:.0f} grados |",
        f"| AVS real (inundacion) | {avs_real:.0f} grados |",
        f"| Velocidad limite de casco | {v_kn:.1f} nudos |",
        f"| Superficie velica | {a_vela:.0f} m2 (SA/D {sad:.2f}) |",
        "",
        "Detalle por escora en `PERSEUS_FISICA.md`.",
        "",
        "## Limites honestos del modelo",
        "",
        "- Es teoria de franjas con casco discretizado: no modela olas, viento racheado ni la maniobra.",
        "- La inundacion se detecta cuando la borda toca el agua; no simula el agua entrando poco a poco.",
        "- Los pesos son un presupuesto de ingenieria, no un pesaje: forro de 12 cm, cuadernas al 160 %,",
        "  techo interior, cubierta, motor, tanques y lastre de 22 t.",
        "- Un Minecraft no tiene flotacion: esto valida que el barco **seria** coherente en el agua real.",
        "",
    ]
    (RAIZ / "PERSEUS.md").write_text("\n".join(lineas), encoding="utf-8")


def main():
    filas, total, kg, sup = presupuesto()
    draft = calado_de_equilibrio(total)
    hid = M.hidrostaticas(draft)
    volumen = total / RHO_AGUA
    bm = hid["ixx"] / volumen
    gm = hid["kb"] + bm - kg
    celdas = celdas_casco()
    curva = curva_gz(total, kg, celdas)
    max_gz = max(g for _, g in curva)
    ang_max = [t for t, g in curva if g == max_gz][0]
    avs = next((t for t, g in curva if t > ang_max and g <= 0), None)
    inundacion, estacion = escora_inundacion(draft)
    avs_real = min(inundacion, avs if avs else 90.0)
    a30 = area_bajo_curva(curva, 30)
    a40 = area_bajo_curva(curva, 40)
    v_kn = 2.43 * math.sqrt(M.LWL)
    a_vela = round(5.6 * volumen ** (2 / 3))  # SA/D 5,6: bergantin rapido, no un crucero
    sad = a_vela / (volumen ** (2 / 3))
    franco = min(M.deck_z(x) for x in (x / 10 for x in range(0, 301))) - draft

    print(f"Perseus: {M.LOA:.0f} m de eslora, {M.BEAM:.1f} m de manga, {M.CREW} de tripulacion")
    print(f"  superficie del casco {sup:.0f} m2 | masa total {total/1000:.1f} t")
    print(f"  calado de equilibrio {draft:.2f} m | francobordo minimo {franco:.2f} m")
    print(f"  KB {hid['kb']:.2f} m | BM {bm:.2f} m | KG {kg:.2f} m | GM {gm:.2f} m")
    print(f"  volumen desplazado {volumen:.1f} m3 | reserva de flotabilidad {(M.volumen_inmersion(M.DEPTH)-volumen)/volumen*100:.0f} %")
    print("  escora  GZ (m)")
    for t, g in curva:
        print(f"   {t:3d}    {g:+.3f}")
    print(f"  GZ maximo {max_gz:.2f} m a {ang_max} grados | AVS de formas {avs if avs else '>70'} grados")
    print(f"  borda al agua a {inundacion:.0f} grados (estacion x={estacion:.1f}) -> AVS real {avs_real:.0f} grados")
    print(f"  area bajo la curva: 30 grados {a30:.3f} m·rad | 40 grados {a40:.3f} m·rad")
    print(f"  velocidad limite de casco {v_kn:.1f} nudos ({v_kn*1.852:.1f} km/h) con LWL {M.LWL} m")
    print(f"  superficie velica {a_vela:.0f} m2 | SA/D {sad:.2f} (tipico 4,5-6,5)")

    criterios = [
        ("GM inicial >= 0,15 m", gm >= 0.15, f"{gm:.2f} m"),
        ("GZ >= 0,20 m a 30 grados", dict(curva)[30] >= 0.20, f"{dict(curva)[30]:.2f} m"),
        ("GM <= 1,60 m (no excesivamente rigido)", gm <= 1.60, f"{gm:.2f} m"),
        ("AVS real (borda al agua) >= 30 grados", avs_real >= 30, f"{avs_real:.0f} grados"),
        ("la borda no se inunda antes de 30 grados", inundacion >= 30, f"{inundacion:.0f} grados"),
        ("area hasta 30 grados >= 0,055 m·rad", a30 >= 0.055, f"{a30:.3f}"),
        ("francobordo >= 0,90 m", franco >= 0.90, f"{franco:.2f} m"),
        ("SA/D en rango de bergantin (4,5-6,5)", 4.5 <= sad <= 6.5, f"{sad:.2f}"),
        ("calado <= 2,20 m (agua somera)", draft <= 2.20, f"{draft:.2f} m"),
    ]
    print("\ncriterios:")
    for nombre, ok, valor in criterios:
        print(f"  [{'OK ' if ok else 'NO '}] {nombre}: {valor}")

    lineas = [
        "# El Perseus en el simulador fisico",
        "",
        f"Modelo geometrico en `herramientas/perseus_modelo.py`, simulacion en `herramientas/simular_perseus.py`.",
        "Escala 1 bloque = 1 m. Cascada de calculo: casco discretizado en celdas de 0,20 m, giro del casco por",
        "angulo de escora, busqueda de la flotacion que iguala el peso y calculo del brazo `GZ = y_B - y_G`",
        "en coordenadas del mundo (separacion horizontal entre la vertical de empuje y la de peso).",
        "",
        "## Pesos",
        "",
        "| Partida | kg |",
        "|---|---|",
    ]
    for nombre, masa, zg in filas:
        lineas.append(f"| {nombre} | {masa:,.0f} |".replace(",", "."))
    lineas += [
        f"| **Total** | **{total:,.0f}** |".replace(",", "."),
        "",
        "## Resultado",
        "",
        f"- Calado de equilibrio: **{draft:.2f} m**",
        f"- Francobordo minimo: **{franco:.2f} m**",
        f"- Volumen desplazado: **{volumen:.1f} m3**; reserva de flotabilidad: **{(M.volumen_inmersion(M.DEPTH)-volumen)/volumen*100:.0f} %**",
        f"- KB **{hid['kb']:.2f} m**, BM **{bm:.2f} m**, KG **{kg:.2f} m**, **GM {gm:.2f} m**",
        f"- GZ maximo **{max_gz:.2f} m** a {ang_max} grados; AVS de formas **{avs if avs else '>70'} grados**",
        f"- La borda baja al agua a **{inundacion:.0f} grados** (estacion x={estacion:.1f}): AVS real **{avs_real:.0f} grados**",
        f"- Area bajo la curva: {a30:.3f} m·rad hasta 30 grados, {a40:.3f} m·rad hasta 40",
        f"- Velocidad limite de casco: **{v_kn:.1f} nudos** ({v_kn*1.852:.1f} km/h)",
        f"- Superficie velica {a_vela:.0f} m2, SA/D {sad:.2f}",
        "",
        "## Criterios",
        "",
        "| Criterio | Valor | Estado |",
        "|---|---|---|",
    ]
    for nombre, ok, valor in criterios:
        lineas.append(f"| {nombre} | {valor} | {'cumple' if ok else 'NO cumple'} |")
    lineas += [
        "",
        "## Curva de estabilidad",
        "",
        "| Escora (grados) | GZ (m) |",
        "|---|---|",
    ]
    for t, g in curva:
        lineas.append(f"| {t} | {g:+.3f} |")
    lineas += [
        "",
        "## Por que estos numeros son los del Perseus y no otros",
        "",
        "- La serie da: bergantin modificado, dos palos cuadros con tres velas cada uno, dos foques,",
        "  cubierta plana, toldilla con sala de comunicaciones, invernadero, tres escalones de proa,",
        "  timon y dos helices, y 'mas de 20 m de eslora' (lo que Ryusui pide para que despegue un avion).",
        "- Lo que no da, y aqui se elige con criterio de ingenieria: 30 m de eslora total, 7 de manga,",
        "  3,6 de puntal, 1,85 de calado, 12 de tripulacion y lastre de piedra de 34 t.",
        "- El lastre es lo que hace que un casco de madera de 30 m no vuelque: sin esas 34 t bajas el KG",
        "  sube y el GM se vuelve negativo. Es exactamente lo que Kaseki aprende a base de lastrar.",
        "",
    ]
    (RAIZ / "PERSEUS_FISICA.md").write_text("\n".join(lineas), encoding="utf-8")
    escribir_plano(total, kg, gm, draft, franco, inundacion, avs_real, a30, v_kn, a_vela, sad, curva)
    print(f"\nescrito {RAIZ / 'PERSEUS_FISICA.md'}")
    print(f"escrito {RAIZ / 'PERSEUS.md'}")


if __name__ == "__main__":
    main()
