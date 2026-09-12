import { existsSync } from "node:fs";
import { readFile } from "node:fs/promises";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { query } from "./db.js";
import { seedNomina } from "./seedNomina.js";

const here = dirname(fileURLToPath(import.meta.url));
const catalogCandidates = [
  join(here, "../content/areas.json"),
  join(here, "../../content/areas.json"),
];

const SCHEMA = `
CREATE TABLE IF NOT EXISTS people (
  id SERIAL PRIMARY KEY,
  dni TEXT UNIQUE NOT NULL,
  nombre TEXT,
  habilitado BOOLEAN NOT NULL DEFAULT TRUE,
  tipo TEXT NOT NULL DEFAULT 'protagonista'
    CHECK (tipo IN ('protagonista', 'educador'))
);

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  person_id INTEGER UNIQUE NOT NULL REFERENCES people(id),
  alias TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  avatar TEXT,
  role TEXT NOT NULL DEFAULT 'protagonista'
    CHECK (role IN ('protagonista', 'educador')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS devices (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token TEXT UNIQUE NOT NULL,
  last_seen TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS areas (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  color TEXT NOT NULL,
  badge TEXT NOT NULL,
  sort_order INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS topics (
  id TEXT PRIMARY KEY,
  area_id TEXT NOT NULL REFERENCES areas(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  sort_order INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS activities (
  id TEXT PRIMARY KEY,
  topic_id TEXT NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  sort_order INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS likes (
  person_id INTEGER NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  topic_id TEXT NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
  liked BOOLEAN NOT NULL,
  updated_at TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (person_id, topic_id)
);

CREATE TABLE IF NOT EXISTS action_progress (
  person_id INTEGER NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  activity_id TEXT NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
  status TEXT NOT NULL CHECK (status IN ('none', 'goal', 'doing', 'done')),
  locked_stage INTEGER CHECK (locked_stage IS NULL OR locked_stage BETWEEN 1 AND 4),
  updated_at TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (person_id, activity_id)
);

CREATE TABLE IF NOT EXISTS topic_notes (
  person_id INTEGER NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  topic_id TEXT NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
  text TEXT NOT NULL DEFAULT '',
  updated_at TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (person_id, topic_id)
);

CREATE TABLE IF NOT EXISTS badge_awards (
  person_id INTEGER NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  insignia_id TEXT NOT NULL,
  awarded_by TEXT,
  awarded_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (person_id, insignia_id)
);

CREATE TABLE IF NOT EXISTS topic_stage_evals (
  person_id INTEGER NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  topic_id TEXT NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
  stage INTEGER NOT NULL CHECK (stage BETWEEN 1 AND 4),
  status TEXT NOT NULL CHECK (status IN ('in_progress', 'done')),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_by TEXT,
  PRIMARY KEY (person_id, topic_id, stage)
);

CREATE TABLE IF NOT EXISTS stage_closures (
  person_id INTEGER NOT NULL REFERENCES people(id) ON DELETE CASCADE,
  stage INTEGER NOT NULL CHECK (stage BETWEEN 1 AND 4),
  closed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  closed_by TEXT,
  PRIMARY KEY (person_id, stage)
);

CREATE TABLE IF NOT EXISTS content_meta (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
`;

async function tableColumns(table) {
  const cols = await query(
    `SELECT column_name FROM information_schema.columns
     WHERE table_schema = 'public' AND table_name = $1`,
    [table],
  );
  return new Set(cols.rows.map((row) => row.column_name));
}

/** Pasa datos de progresión/insignias de user_id → person_id. */
async function migrateUserScopedToPerson(table, extraColumnsSql, selectExtra) {
  const names = await tableColumns(table);
  if (!names.size || !names.has("user_id")) return;

  const temp = `${table}_person`;
  await query(`DROP TABLE IF EXISTS ${temp}`);
  await query(`
    CREATE TABLE ${temp} (
      person_id INTEGER NOT NULL REFERENCES people(id) ON DELETE CASCADE,
      ${extraColumnsSql}
    )
  `);
  await query(`
    INSERT INTO ${temp} (person_id, ${selectExtra.columns})
    SELECT u.person_id, ${selectExtra.select}
    FROM ${table} t
    JOIN users u ON u.id = t.user_id
    ON CONFLICT DO NOTHING
  `);
  await query(`DROP TABLE ${table}`);
  await query(`ALTER TABLE ${temp} RENAME TO ${table}`);
}

export async function migrate() {
  const cols = await query(
    `SELECT column_name FROM information_schema.columns
     WHERE table_name = 'badge_awards' AND column_name = 'area_id'`,
  );
  if (cols.rowCount > 0) {
    await query(`DROP TABLE badge_awards`);
  }
  await query(SCHEMA);

  await query(
    `ALTER TABLE users ADD COLUMN IF NOT EXISTS role TEXT NOT NULL DEFAULT 'protagonista'`,
  );

  // Progresión e insignias viven en la persona del padrón, no en la cuenta login.
  await migrateUserScopedToPerson(
    "likes",
    `topic_id TEXT NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
     liked BOOLEAN NOT NULL,
     updated_at TIMESTAMPTZ NOT NULL,
     PRIMARY KEY (person_id, topic_id)`,
    { columns: "topic_id, liked, updated_at", select: "t.topic_id, t.liked, t.updated_at" },
  );
  await migrateUserScopedToPerson(
    "action_progress",
    `activity_id TEXT NOT NULL REFERENCES activities(id) ON DELETE CASCADE,
     status TEXT NOT NULL CHECK (status IN ('none', 'goal', 'doing', 'done')),
     updated_at TIMESTAMPTZ NOT NULL,
     PRIMARY KEY (person_id, activity_id)`,
    {
      columns: "activity_id, status, updated_at",
      select: "t.activity_id, t.status, t.updated_at",
    },
  );
  await migrateUserScopedToPerson(
    "topic_notes",
    `topic_id TEXT NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
     text TEXT NOT NULL DEFAULT '',
     updated_at TIMESTAMPTZ NOT NULL,
     PRIMARY KEY (person_id, topic_id)`,
    { columns: "topic_id, text, updated_at", select: "t.topic_id, t.text, t.updated_at" },
  );
  await migrateUserScopedToPerson(
    "badge_awards",
    `insignia_id TEXT NOT NULL,
     awarded_by TEXT,
     awarded_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
     PRIMARY KEY (person_id, insignia_id)`,
    {
      columns: "insignia_id, awarded_by, awarded_at",
      select: "t.insignia_id, t.awarded_by, t.awarded_at",
    },
  );

  await query(`
    CREATE TABLE IF NOT EXISTS topic_stage_evals (
      person_id INTEGER NOT NULL REFERENCES people(id) ON DELETE CASCADE,
      topic_id TEXT NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
      stage INTEGER NOT NULL CHECK (stage BETWEEN 1 AND 4),
      status TEXT NOT NULL CHECK (status IN ('in_progress', 'done')),
      updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
      updated_by TEXT,
      PRIMARY KEY (person_id, topic_id, stage)
    )
  `);
  await query(`
    CREATE TABLE IF NOT EXISTS stage_closures (
      person_id INTEGER NOT NULL REFERENCES people(id) ON DELETE CASCADE,
      stage INTEGER NOT NULL CHECK (stage BETWEEN 1 AND 4),
      closed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
      closed_by TEXT,
      PRIMARY KEY (person_id, stage)
    )
  `);

  const apCols = await tableColumns("action_progress");
  if (apCols.size && !apCols.has("locked_stage")) {
    await query(
      `ALTER TABLE action_progress
       ADD COLUMN locked_stage INTEGER
       CHECK (locked_stage IS NULL OR locked_stage BETWEEN 1 AND 4)`,
    );
  }

  await seedNomina();

  const catalogPath = catalogCandidates.find((path) => existsSync(path));
  if (!catalogPath) {
    throw new Error("No se encontró content/areas.json");
  }
  const catalog = JSON.parse(await readFile(catalogPath, "utf8"));

  let order = 0;
  for (const area of catalog.areas) {
    await query(
      `INSERT INTO areas (id, name, color, badge, sort_order)
       VALUES ($1, $2, $3, $4, $5)
       ON CONFLICT (id) DO UPDATE SET
         name = EXCLUDED.name,
         color = EXCLUDED.color,
         badge = EXCLUDED.badge,
         sort_order = EXCLUDED.sort_order`,
      [area.id, area.name, area.color, area.badge || "", order++],
    );

    let topicOrder = 0;
    for (const topic of area.topics) {
      await query(
        `INSERT INTO topics (id, area_id, title, body, sort_order)
         VALUES ($1, $2, $3, $4, $5)
         ON CONFLICT (id) DO UPDATE SET
           area_id = EXCLUDED.area_id,
           title = EXCLUDED.title,
           body = EXCLUDED.body,
           sort_order = EXCLUDED.sort_order`,
        [topic.id, area.id, topic.title, topic.body, topicOrder++],
      );

      let actOrder = 0;
      for (const activity of topic.activities) {
        await query(
          `INSERT INTO activities (id, topic_id, title, sort_order)
           VALUES ($1, $2, $3, $4)
           ON CONFLICT (id) DO UPDATE SET
             topic_id = EXCLUDED.topic_id,
             title = EXCLUDED.title,
             sort_order = EXCLUDED.sort_order`,
          [activity.id, topic.id, activity.title, actOrder++],
        );
      }
    }
  }

  const keep = catalog.areas.map((area) => area.id);
  await query(
    `DELETE FROM likes WHERE topic_id IN (SELECT id FROM topics WHERE NOT (area_id = ANY($1::text[])))`,
    [keep],
  );
  await query(
    `DELETE FROM topic_notes WHERE topic_id IN (SELECT id FROM topics WHERE NOT (area_id = ANY($1::text[])))`,
    [keep],
  );
  await query(
    `DELETE FROM action_progress WHERE activity_id IN (
      SELECT a.id FROM activities a JOIN topics t ON t.id = a.topic_id
      WHERE NOT (t.area_id = ANY($1::text[]))
    )`,
    [keep],
  );
  await query(
    `DELETE FROM activities WHERE topic_id IN (SELECT id FROM topics WHERE NOT (area_id = ANY($1::text[])))`,
    [keep],
  );
  await query(`DELETE FROM topics WHERE NOT (area_id = ANY($1::text[]))`, [keep]);
  await query(`DELETE FROM areas WHERE NOT (id = ANY($1::text[]))`, [keep]);

  await query(
    `INSERT INTO content_meta (key, value) VALUES ('version', $1)
     ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value`,
    [String(catalog.version)],
  );
}
