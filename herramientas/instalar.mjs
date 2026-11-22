#!/usr/bin/env node
/**
 * Stone World Reborn - instalador y comprobador del pack.
 *
 * No tiene dependencias: solo Node 18 o superior (el mismo que necesitas para Freebuff).
 *
 * Uso:
 *   node herramientas/instalar.mjs                  dice que hay que hacer, no toca nada
 *   node herramientas/instalar.mjs --check          revisa la carpeta mods y dice que falta
 *   node herramientas/instalar.mjs --download       baja los de Modrinth y lista los de CurseForge
 *   node herramientas/instalar.mjs --mc-dir "RUTA"  usa otra carpeta de Minecraft
 *   node herramientas/instalar.mjs --download --forzar  baja aunque haya mods de otra instancia
 *
 * Codigos de salida: 0 = todo listo, 1 = faltan mods, 2 = error, 3 = no mezclo packs (usa --forzar).
 */
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { spawnSync } from 'node:child_process';

const GAME = '1.21.1';
const LOADER = 'neoforge';
const API = 'https://api.modrinth.com/v2';
const UA = 'stone-world-installer/1.0 (github.com/teoamoros11-afk/stone-world)';

// Mods con build en Modrinth para 1.21.1 + neoforge: se pueden descargar solos.
const MODRINTH = [
  { slug: 'geckolib',              nombre: 'GeckoLib',            clave: /geckolib/i,                  version: null },
  { slug: 'architectury-api',      nombre: 'Architectury API',    clave: /architectury/i,              version: null },
  { slug: 'glitchcore',            nombre: 'GlitchCore',          clave: /glitchcore/i,                version: null },
  { slug: 'create',                nombre: 'Create',              clave: /^create-/i,                  version: '6.0.10+mc1.21.1' },
  // la 1.121.0 exige NeoForge >= 21.1.265 y el pack fija 21.1.262 (comprobado en el jar)
  { slug: 'cc-tweaked',            nombre: 'CC: Tweaked',         clave: /cc-?tweaked/i,               version: '1.120.2' },
  { slug: 'mekanism',              nombre: 'Mekanism',            clave: /^mekanism-/i,                version: '10.7.19.85' },
  { slug: 'mekanism-generators',   nombre: 'Mekanism Generators', clave: /mekanismgenerators/i,        version: null },
  { slug: 'jei',                   nombre: 'JEI',                 clave: /^jei-/i,                     version: null },
  { slug: 'jade',                  nombre: 'Jade',                clave: /^jade-/i,                    version: null },
  { slug: 'appleskin',             nombre: 'AppleSkin',           clave: /appleskin/i,                 version: null },
  { slug: 'modernfix',             nombre: 'ModernFix',           clave: /modernfix/i,                 version: null },
  { slug: 'ferrite-core',          nombre: 'FerriteCore',         clave: /ferritecore/i,               version: null },
  { slug: 'thirst-was-taken',      nombre: 'Thirst Was Taken',    clave: /thirstwastaken/i,            version: '1.21.1-2.1.5' },
  { slug: 'tough-as-nails',        nombre: 'Tough as Nails',      clave: /toughasnails/i,              version: '10.1.0.13' },
  // el libro de War 'N Taxes es un libro de Patchouli: sin esto su receta no carga
  { slug: 'patchouli',             nombre: 'Patchouli',           clave: /patchouli/i,                 version: '1.21.1-93-neoforge' },
  { slug: 'embeddium',             nombre: 'Embeddium',           clave: /embeddium/i,                 version: '1.0.15+mc1.21.1' },
  // Era 5 (espacio): Ad Astra 1.21.1 neoforge y las tres librerias que pide su mods.toml
  { slug: 'ad-astra',              nombre: 'Ad Astra',            clave: /^adastra-/i,                 version: '1.16.26' },
  { slug: 'resourceful-lib',       nombre: 'Resourceful Lib',     clave: /resourcefullib/i,            version: null },
  { slug: 'resourceful-config',    nombre: 'Resourceful Config',  clave: /resourcefulconfig/i,         version: null },
  { slug: 'common-storage-lib',    nombre: 'Common Storage Lib',  clave: /common.?storage/i,           version: null },
];

// Solo en CurseForge: NO se descargan solos, a proposito. La mayoria son "todos los
// derechos reservados" y bajar sus archivos por el CDN saltandose su pagina no es
// algo que este proyecto deba hacer por ti. Aqui solo viven el nombre, el patron con
// el que se reconocen en la carpeta mods/ y la pagina donde se cogen a mano.
const MANUAL = [
  { nombre: 'MineColonies',              version: '1.1.1403', clave: /minecolonies/i,        url: 'https://www.curseforge.com/minecraft/mc-mods/minecolonies' },
  { nombre: 'Structurize',               version: '',         clave: /structurize/i,         url: 'https://www.curseforge.com/minecraft/mc-mods/structurize' },
  { nombre: 'Domum Ornamentum',          version: '',         clave: /domum.?ornamentum/i,    url: 'https://www.curseforge.com/minecraft/mc-mods/domum-ornamentum' },
  { nombre: 'BlockUI',                   version: '',         clave: /blockui/i,              url: 'https://www.curseforge.com/minecraft/mc-mods/blockui' },
  { nombre: 'Multi-Piston',              version: '',         clave: /multi.?piston/i,        url: 'https://www.curseforge.com/minecraft/mc-mods/multi-piston' },
  { nombre: 'Dr. Stone: Kingdom of Science', version: '2.0.4', clave: /dr.?stone/i, url: 'https://www.curseforge.com/minecraft/mc-mods/dr-stone-kingdom-of-science' },
  { nombre: "Kleider's Custom Renderer", version: '',         clave: /kleider/i,              url: 'https://www.curseforge.com/minecraft/mc-mods/kleiders-custom-renderer' },
  { nombre: 'Millenaire',                version: '9.1.0',    clave: /mill[eé]naire/i,          url: 'https://www.curseforge.com/minecraft/mc-mods/millenaire' },
  { nombre: 'Colony Autopilot',          version: '1.3.4',    clave: /colony.?autopilot/i,     url: 'https://www.curseforge.com/minecraft/mc-mods/colonyautopilot' },
  { nombre: 'Autonomous Colonies',       version: '0.4.3',    clave: /autonomous.?colonies/i, url: 'https://www.curseforge.com/minecraft/mc-mods/autonomous-colonies' },
  // War 'N Taxes: sin este, Autonomous Colonies impide arrancar el servidor
  { nombre: "MineColonies: War 'N Taxes", version: '5.1.1',    clave: /warntaxes|minecolonytax/i, url: 'https://www.curseforge.com/minecraft/mc-mods/minecolonies-war-n-taxes' },
  { nombre: 'Colony Dashboard',          version: '0.2.0',    clave: /colony.?dashboard/i,    url: 'https://www.curseforge.com/minecraft/mc-mods/colony-dashboard' },
  // el jar se llama createaddition-*, sin "craft"
  { nombre: 'Create: Crafts & Additions', version: '',        clave: /craft.*additions|createaddition/i,  url: 'https://www.curseforge.com/minecraft/mc-mods/create-crafts-additions' },
  { nombre: 'Immersive Engineering',     version: '',         clave: /immersive.?engineering/i, url: 'https://www.curseforge.com/minecraft/mc-mods/immersive-engineering' },
  { nombre: 'FTB Quests',                version: '',         clave: /ftb.?quests/i,              url: 'https://www.curseforge.com/minecraft/mc-mods/ftb-quests-forge' },
  { nombre: 'FTB Library (NeoForge)',    version: '2101.1.39', clave: /ftb.?library/i,              url: 'https://www.curseforge.com/minecraft/mc-mods/ftb-library-forge' },
  { nombre: 'FTB Teams (NeoForge)',      version: '2101.1.12', clave: /ftb.?teams/i,              url: 'https://www.curseforge.com/minecraft/mc-mods/ftb-teams-forge' },
  { nombre: 'Serene Seasons',            version: '',         clave: /serene.?seasons/i,      url: 'https://www.curseforge.com/minecraft/mc-mods/serene-seasons' },
];

// ---------------------------------------------------------------- utilidades

const args = process.argv.slice(2);
const flag = (nombre) => args.includes(nombre);
const valor = (nombre) => {
  const i = args.indexOf(nombre);
  return i >= 0 ? args[i + 1] : undefined;
};

function carpetaMinecraft() {
  if (valor('--mc-dir')) return path.resolve(valor('--mc-dir'));
  if (process.env.MC_DIR) return path.resolve(process.env.MC_DIR);
  if (process.platform === 'win32') {
    return path.join(process.env.APPDATA || path.join(os.homedir(), 'AppData', 'Roaming'), '.minecraft');
  }
  if (process.platform === 'darwin') return path.join(os.homedir(), 'Library', 'Application Support', 'minecraft');
  return path.join(os.homedir(), '.minecraft');
}

const MC = carpetaMinecraft();
const MODS = path.join(MC, 'mods');
const TODOS = [...MODRINTH, ...MANUAL];

function jars() {
  if (!fs.existsSync(MODS)) return [];
  return fs.readdirSync(MODS).filter((f) => f.toLowerCase().endsWith('.jar'));
}

async function resolver(mod) {
  const q = new URLSearchParams({
    loaders: JSON.stringify([LOADER]),
    game_versions: JSON.stringify([GAME]),
  });
  const r = await fetch(`${API}/project/${mod.slug}/version?${q}`, { headers: { 'User-Agent': UA } });
  if (!r.ok) throw new Error(`HTTP ${r.status}`);
  const vs = await r.json();
  if (!Array.isArray(vs) || vs.length === 0) throw new Error('sin build 1.21.1/neoforge');
  let v = vs.find((x) => x.version_type === 'release') || vs[0];
  if (mod.version) v = vs.find((x) => x.version_number === mod.version) || v;
  const f = v.files.find((x) => x.primary) ||
    v.files.find((x) => !/(sources|javadoc|dev|api)\.jar$/i.test(x.filename)) || v.files[0];
  return { version: v.version_number, file: f };
}

async function bajar(url, destino) {
  const r = await fetch(url, { headers: { 'User-Agent': UA } });
  if (!r.ok) throw new Error(`HTTP ${r.status}`);
  const total = Number(r.headers.get('content-length') || 0);
  let hecho = 0;
  const buffer = [];
  for await (const trozo of r.body) {
    buffer.push(trozo);
    hecho += trozo.length;
    if (total) process.stdout.write(`\r    ${Math.round((hecho / total) * 100)}%   `);
  }
  fs.writeFileSync(destino, Buffer.concat(buffer));
  if (total) process.stdout.write('\r');
  if (fs.statSync(destino).size < 1024) throw new Error('archivo vacio');
}

function javaVersion() {
  // `java -version` escribe en stderr, no en stdout.
  const r = spawnSync('java', ['-version'], { encoding: 'utf8' });
  if (r.error) return null;
  return `${r.stderr || ''}${r.stdout || ''}`.trim() || null;
}

// ---------------------------------------------------------------- modos

function comprobar() {
  const lista = jars();
  const ajenos = lista.filter((f) => !TODOS.some((m) => m.clave.test(f)));
  console.log(`Carpeta: ${MODS}`);

  // Con TLauncher los mods no van en la carpeta global: cada perfil tiene la suya.
  const carpetaGlobal = /[\\/]\.minecraft[\\/]mods$/i.test(MODS) && !/[\\/]versions[\\/]/i.test(MODS);
  const dirVersiones = path.join(MC, 'versions');
  if (carpetaGlobal && fs.existsSync(dirVersiones)) {
    const perfiles = fs.readdirSync(dirVersiones)
      .filter((d) => fs.existsSync(path.join(dirVersiones, d, 'mods')));
    if (perfiles.length) {
      console.log('PISTA: parece la carpeta global. Con TLauncher cada perfil tiene la suya:');
      for (const p of perfiles.slice(0, 3)) console.log(`  --mc-dir "${path.join(dirVersiones, p)}"`);
      console.log('');
    }
  }

  if (ajenos.length) {
    console.log(`AVISO: ${ajenos.length} jar(s) que no son de este pack (otra version u otro loader):`);
    for (const j of ajenos.slice(0, 6)) console.log(`  ${j}`);
    console.log('  Si esa carpeta es de otra instancia, no mezcles: usa --mc-dir con una carpeta propia.\n');
  }
  console.log(`Jars encontrados: ${lista.length}\n`);
  let faltan = 0;

  const revisar = (mod, deModrinth) => {
    // se prueba jar a jar: las claves con ^ tienen que anclar al nombre del archivo, no a la lista
    const ok = lista.some((f) => mod.clave.test(f));
    if (!ok) faltan++;
    const donde = deModrinth ? 'Modrinth' : 'CurseForge';
    const v = mod.version ? ` ${mod.version}` : '';
    console.log(`${ok ? 'OK   ' : 'FALTA'}  ${mod.nombre}${v}  (${donde})`);
    return ok;
  };

  console.log('-- mods --');
  for (const m of MODRINTH) revisar(m, true);
  for (const m of MANUAL) revisar(m, false);

  const sospechosos = lista.filter((j) => /1\.20|1\.19|1\.18|optifine|forge-1\.20/i.test(j));
  if (sospechosos.length) {
    console.log('\n-- cuidado, parece de otra version --');
    for (const j of sospechosos) console.log(`  ${j}`);
  }

  console.log('\n-- datapack (solo en el mundo del anfitrion) --');
  const saves = path.join(MC, 'saves');
  const conPanel = [];
  if (fs.existsSync(saves)) {
    for (const mundo of fs.readdirSync(saves)) {
      const d = path.join(saves, mundo, 'datapacks');
      if (fs.existsSync(d) && fs.readdirSync(d).some((f) => /panel/i.test(f))) conPanel.push(mundo);
    }
  }
  console.log(conPanel.length
    ? `  puesto en: ${conPanel.join(', ')}`
    : '  no hay panel-del-reino.zip en ningun saves/*/datapacks (normal si no eres el anfitrion)');

  // el total va en la salida: si alguien edita la lista y la doc no, se ve al instante
  console.log(`\nResultado: ${faltan === 0 ? '0 faltan' : faltan + ' faltan'} (${TODOS.length} mods en la lista)`);
  return faltan;
}

async function descargar() {
  const ajenos = jars().filter((f) => !TODOS.some((m) => m.clave.test(f)));
  if (ajenos.length && !flag('--forzar')) {
    console.error(`Paro: hay ${ajenos.length} jar(s) de otra instancia en ${MODS}.`);
    console.error(`  ${ajenos.slice(0, 5).join('\n  ')}`);
    console.error('No mezclo packs. Usa --mc-dir con una carpeta propia, o --forzar si sabes lo que haces.');
    process.exit(3);
  }
  fs.mkdirSync(MODS, { recursive: true });
  console.log(`Descargando en ${MODS}\n`);
  const fallos = [];

  for (const mod of MODRINTH) {
    try {
      const { version, file } = await resolver(mod);
      const destino = path.join(MODS, file.filename);
      if (fs.existsSync(destino)) {
        console.log(`ya esta      ${file.filename}`);
        continue;
      }
      process.stdout.write(`bajando      ${file.filename} (${version})\n`);
      await bajar(file.url, destino);
      console.log('             ok');
    } catch (e) {
      fallos.push({ mod, error: e.message });
      console.log(`no se pudo   ${mod.nombre} -> ${e.message}`);
    }
  }

  console.log(`\n-- a mano: ${MANUAL.length} mods solo estan en CurseForge --`);
  console.log('No se bajan solos porque sus licencias no lo permiten. Entra, pulsa Download');
  console.log(`y elige la version para ${GAME} + ${LOADER}:`);
  for (const mod of MANUAL) {
    console.log(`  ${mod.nombre}${mod.version ? ' ' + mod.version : ''}\n    ${mod.url}`);
  }

  if (fallos.length) {
    console.log('\nDe Modrinth no se pudo bajar:');
    for (const f of fallos) {
      console.log(`  ${f.mod.nombre}: ${f.error}\n    https://modrinth.com/mod/${f.mod.slug}`);
    }
  }
}

async function principal() {
  console.log('Stone World Reborn - ' + GAME + ' + ' + LOADER + '\n');

  if (flag('--download')) {
    await descargar();
    const faltan = comprobar();
    process.exit(faltan === 0 ? 0 : 1);
  }

  const jv = javaVersion();
  const linea = (jv || '').split('\n').find((l) => /version/i.test(l)) || '';
  const m = /"(\d+)(?:\.(\d+))?/.exec(linea);
  const java = m ? Number(m[1]) : null;
  console.log(`Java: ${linea.trim() || 'no encontrado en el PATH'}`);
  if (java !== null && java !== 21) console.log(`  AVISO: NeoForge 1.21.1 necesita Java 21, tienes ${java}.`);

  const faltan = comprobar();

  if (!flag('--check')) {
    console.log('\nQue hacer ahora:');
    console.log('  node herramientas/instalar.mjs --download   baja los de Modrinth y lista los de CurseForge');
    console.log('  node herramientas/instalar.mjs --check      vuelve a mirar que falta');
    console.log('\nLos que hay que bajar a mano, con su pagina:');
    for (const m2 of MANUAL) console.log(`  ${m2.nombre}${m2.version ? ' ' + m2.version : ''}\n    ${m2.url}`);
  }

  process.exit(faltan === 0 ? 0 : 1);
}

principal().catch((e) => {
  console.error('Error:', e.message);
  process.exit(2);
});
