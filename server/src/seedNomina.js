import { existsSync } from "node:fs";
import { readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { query } from "./db.js";

const here = dirname(fileURLToPath(import.meta.url));

const NOMINA_DIRS = [
  join(here, "../../material/Nomina"),
  join(here, "../material/Nomina"),
];

function cleanDni(value) {
  return String(value || "").replace(/\D/g, "");
}

function cleanName(value) {
  return String(value || "").replace(/\s+/g, " ").trim();
}

async function parseNomina(filePath) {
  if (!existsSync(filePath)) return [];
  const text = await readFile(filePath, "utf8");
  const rows = [];
  for (const raw of text.split(/\r?\n/)) {
    const line = raw.trim();
    if (!line || /^dni\b/i.test(line)) continue;
    const [dniRaw, ...rest] = line.split("\t");
    const dni = cleanDni(dniRaw);
    const nombre = cleanName(rest.join("\t") || rest.join(" "));
    if (!/^\d{7,8}$/.test(dni)) continue;
    rows.push({ dni, nombre: nombre || null });
  }
  return rows;
}

export async function seedNomina() {
  const base = NOMINA_DIRS.find((dir) => existsSync(dir));
  if (!base) {
    console.warn("No se encontró material/Nomina; se omite la semilla de padrón.");
    return;
  }

  await query(
    `ALTER TABLE people ADD COLUMN IF NOT EXISTS tipo TEXT NOT NULL DEFAULT 'protagonista'`,
  );

  const protagonistas = await parseNomina(join(base, "Protagonistas.txt"));
  const educadores = await parseNomina(join(base, "Educadores.txt"));

  for (const person of protagonistas) {
    await query(
      `INSERT INTO people (dni, nombre, habilitado, tipo)
       VALUES ($1, $2, TRUE, 'protagonista')
       ON CONFLICT (dni) DO UPDATE SET
         nombre = COALESCE(EXCLUDED.nombre, people.nombre),
         habilitado = TRUE,
         tipo = 'protagonista'`,
      [person.dni, person.nombre],
    );
  }

  for (const person of educadores) {
    await query(
      `INSERT INTO people (dni, nombre, habilitado, tipo)
       VALUES ($1, $2, TRUE, 'educador')
       ON CONFLICT (dni) DO UPDATE SET
         nombre = COALESCE(EXCLUDED.nombre, people.nombre),
         habilitado = TRUE,
         tipo = 'educador'`,
      [person.dni, person.nombre],
    );
  }

  // Una sola vez: sacar cuentas de educador de la semilla vieja,
  // para que entren por el mismo alta (alias + contraseña).
  const flag = await query(
    `SELECT value FROM content_meta WHERE key = 'educator_self_register_v1'`,
  );
  if (flag.rowCount === 0) {
    await query(
      `DELETE FROM devices WHERE user_id IN (
         SELECT u.id FROM users u
         JOIN people p ON p.id = u.person_id
         WHERE COALESCE(p.tipo, 'protagonista') = 'educador'
       )`,
    );
    await query(
      `DELETE FROM users WHERE person_id IN (
         SELECT id FROM people WHERE COALESCE(tipo, 'protagonista') = 'educador'
       )`,
    );
    await query(
      `INSERT INTO content_meta (key, value) VALUES ('educator_self_register_v1', '1')
       ON CONFLICT (key) DO NOTHING`,
    );
  }

  const keep = [...protagonistas, ...educadores].map((p) => p.dni);
  if (keep.length) {
    await query(
      `UPDATE people SET habilitado = FALSE
       WHERE NOT (dni = ANY($1::text[]))`,
      [keep],
    );
  }

  console.log(
    `Nómina sembrada: ${protagonistas.length} protagonistas, ${educadores.length} educadores (sin cuentas previas; se registran al entrar)`,
  );
}
