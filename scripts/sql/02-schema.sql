-- Esquema Huella Thaqu (idempotente).
-- Uso: psql "$DATABASE_URL" -f scripts/sql/02-schema.sql

BEGIN;

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

ALTER TABLE users ADD COLUMN IF NOT EXISTS role TEXT NOT NULL DEFAULT 'protagonista';
ALTER TABLE action_progress ADD COLUMN IF NOT EXISTS locked_stage INTEGER;

COMMIT;
