import { pool } from "../db.js";
import { seedNomina } from "../seedNomina.js";

await seedNomina();
await pool.end();
