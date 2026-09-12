import bcrypt from "bcryptjs";
import { query } from "./src/db.js";

const eduHash = await bcrypt.hash("educador1", 10);
const protoHash = await bcrypt.hash("proto123", 10);
await query(`UPDATE users SET password_hash = $1 WHERE id = 8`, [eduHash]);
await query(`UPDATE users SET password_hash = $1 WHERE alias = 'Test'`, [protoHash]);
console.log("passwords reset");
process.exit(0);
