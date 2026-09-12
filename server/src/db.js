import pg from "pg";

const connectionString = process.env.DATABASE_URL;
if (!connectionString) {
  console.error("Falta DATABASE_URL");
  process.exit(1);
}

export const pool = new pg.Pool({
  connectionString,
  max: 10,
});

export function query(text, params) {
  return pool.query(text, params);
}
