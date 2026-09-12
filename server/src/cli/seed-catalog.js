import { pool } from "../db.js";
import { seedCatalog } from "../migrate.js";

await seedCatalog();
await pool.end();
