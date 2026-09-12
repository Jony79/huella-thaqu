import { randomBytes } from "node:crypto";
import { query } from "./db.js";

export function newDeviceToken() {
  return randomBytes(32).toString("hex");
}

export async function createDevice(userId) {
  const token = newDeviceToken();
  await query(
    `INSERT INTO devices (user_id, token, last_seen) VALUES ($1, $2, NOW())`,
    [userId, token],
  );
  return token;
}

export async function authMiddleware(req, res, next) {
  const header = req.headers.authorization || "";
  const token = header.startsWith("Bearer ") ? header.slice(7) : "";
  if (!token) {
    res.status(401).json({ error: "Necesitás iniciar sesión" });
    return;
  }

  const result = await query(
    `SELECT d.id AS device_id, d.token, u.id AS user_id, u.person_id, u.alias, u.avatar,
            COALESCE(u.role, 'protagonista') AS role, p.dni, p.habilitado
     FROM devices d
     JOIN users u ON u.id = d.user_id
     JOIN people p ON p.id = u.person_id
     WHERE d.token = $1`,
    [token],
  );

  if (result.rowCount === 0) {
    res.status(401).json({ error: "Sesión vencida. Entrá de nuevo." });
    return;
  }

  if (!result.rows[0].habilitado) {
    await query(`DELETE FROM devices WHERE token = $1`, [token]);
    res.status(401).json({ error: "Esta cuenta está deshabilitada" });
    return;
  }

  await query(`UPDATE devices SET last_seen = NOW() WHERE id = $1`, [
    result.rows[0].device_id,
  ]);

  req.user = result.rows[0];
  next();
}

export function publicUser(row) {
  return {
    alias: row.alias,
    avatar: row.avatar || null,
    dni: row.dni,
    role: row.role || "protagonista",
  };
}
