/**
 * Regenera scripts/sql/03-catalog.sql y 04-nomina.sql desde content/ y material/Nomina/.
 * Uso: node scripts/generate-sql-seeds.mjs
 */
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = join(dirname(fileURLToPath(import.meta.url)), "..");
const outDir = join(root, "scripts", "sql");
mkdirSync(outDir, { recursive: true });

function sqlStr(value) {
  return `'${String(value ?? "").replace(/'/g, "''")}'`;
}

function parseNomina(filePath) {
  const text = readFileSync(filePath, "utf8");
  const rows = [];
  for (const raw of text.split(/\r?\n/)) {
    const line = raw.trim();
    if (!line || /^dni\b/i.test(line)) continue;
    const [dniRaw, ...rest] = line.split("\t");
    const dni = String(dniRaw || "").replace(/\D/g, "");
    const nombre = rest.join("\t").replace(/\s+/g, " ").trim();
    if (!/^\d{7,8}$/.test(dni)) continue;
    rows.push({ dni, nombre: nombre || null });
  }
  return rows;
}

// --- schema (static) already in 02-schema.sql ---

// --- catalog ---
const catalog = JSON.parse(readFileSync(join(root, "content", "areas.json"), "utf8"));
const catalogLines = [
  "-- Catálogo de áreas, fichas y actividades (generado desde content/areas.json)",
  `-- Versión ${catalog.version}`,
  "-- Regenerar: node scripts/generate-sql-seeds.mjs",
  "",
  "BEGIN;",
  "",
];

let areaOrder = 0;
for (const area of catalog.areas) {
  catalogLines.push(
    `INSERT INTO areas (id, name, color, badge, sort_order) VALUES (${sqlStr(area.id)}, ${sqlStr(area.name)}, ${sqlStr(area.color)}, ${sqlStr(area.badge || "")}, ${areaOrder})`,
    `ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, color = EXCLUDED.color, badge = EXCLUDED.badge, sort_order = EXCLUDED.sort_order;`,
    "",
  );
  let topicOrder = 0;
  for (const topic of area.topics) {
    catalogLines.push(
      `INSERT INTO topics (id, area_id, title, body, sort_order) VALUES (${sqlStr(topic.id)}, ${sqlStr(area.id)}, ${sqlStr(topic.title)}, ${sqlStr(topic.body)}, ${topicOrder})`,
      `ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;`,
      "",
    );
    let actOrder = 0;
    for (const activity of topic.activities) {
      catalogLines.push(
        `INSERT INTO activities (id, topic_id, title, sort_order) VALUES (${sqlStr(activity.id)}, ${sqlStr(topic.id)}, ${sqlStr(activity.title)}, ${actOrder})`,
        `ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;`,
      );
      actOrder += 1;
    }
    catalogLines.push("");
    topicOrder += 1;
  }
  areaOrder += 1;
}

const keepIds = catalog.areas.map((a) => sqlStr(a.id)).join(", ");
catalogLines.push(
  `-- Limpieza de áreas/fichas que ya no están en el catálogo`,
  `DELETE FROM likes WHERE topic_id IN (SELECT id FROM topics WHERE area_id NOT IN (${keepIds}));`,
  `DELETE FROM topic_notes WHERE topic_id IN (SELECT id FROM topics WHERE area_id NOT IN (${keepIds}));`,
  `DELETE FROM topic_stage_evals WHERE topic_id IN (SELECT id FROM topics WHERE area_id NOT IN (${keepIds}));`,
  `DELETE FROM action_progress WHERE activity_id IN (SELECT a.id FROM activities a JOIN topics t ON t.id = a.topic_id WHERE t.area_id NOT IN (${keepIds}));`,
  `DELETE FROM activities WHERE topic_id IN (SELECT id FROM topics WHERE area_id NOT IN (${keepIds}));`,
  `DELETE FROM topics WHERE area_id NOT IN (${keepIds});`,
  `DELETE FROM areas WHERE id NOT IN (${keepIds});`,
  "",
  `INSERT INTO content_meta (key, value) VALUES ('version', ${sqlStr(String(catalog.version))})`,
  `ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;`,
  "",
  "COMMIT;",
  "",
);
writeFileSync(join(outDir, "03-catalog.sql"), catalogLines.join("\n"), "utf8");

// --- nomina ---
const protagonistas = parseNomina(join(root, "material", "Nomina", "Protagonistas.txt"));
const educadores = parseNomina(join(root, "material", "Nomina", "Educadores.txt"));
const nominaLines = [
  "-- Padrón de personas (generado desde material/Nomina/)",
  "-- No crea cuentas de login (users); solo people.",
  "-- Regenerar: node scripts/generate-sql-seeds.mjs",
  "",
  "BEGIN;",
  "",
];

for (const p of protagonistas) {
  nominaLines.push(
    `INSERT INTO people (dni, nombre, habilitado, tipo) VALUES (${sqlStr(p.dni)}, ${sqlStr(p.nombre)}, TRUE, 'protagonista')`,
    `ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';`,
  );
}
nominaLines.push("");
for (const p of educadores) {
  nominaLines.push(
    `INSERT INTO people (dni, nombre, habilitado, tipo) VALUES (${sqlStr(p.dni)}, ${sqlStr(p.nombre)}, TRUE, 'educador')`,
    `ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'educador';`,
  );
}

const keepDnis = [...protagonistas, ...educadores].map((p) => sqlStr(p.dni)).join(", ");
nominaLines.push(
  "",
  `-- Deshabilitar DNIs que ya no están en la nómina`,
  `UPDATE people SET habilitado = FALSE WHERE NOT (dni IN (${keepDnis}));`,
  "",
  "COMMIT;",
  "",
);
writeFileSync(join(outDir, "04-nomina.sql"), nominaLines.join("\n"), "utf8");

console.log(
  `OK: 03-catalog.sql + 04-nomina.sql (${protagonistas.length} protagonistas, ${educadores.length} educadores)`,
);
