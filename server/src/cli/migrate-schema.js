import { pool } from "../db.js";
import { migrateSchema } from "../migrate.js";

await migrateSchema();
await pool.end();
