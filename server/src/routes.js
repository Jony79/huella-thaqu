import { randomUUID } from "node:crypto";
import { mkdir, writeFile } from "node:fs/promises";
import { dirname, extname, join } from "node:path";
import { fileURLToPath } from "node:url";
import bcrypt from "bcryptjs";
import multer from "multer";
import { query } from "./db.js";
import { authMiddleware, createDevice, publicUser } from "./auth.js";
import { topicStatus } from "./progress.js";
import { registerEducatorRoutes } from "./educator.js";
import {
  clearOpenEvalsForTopic,
  loadClosedStages,
  loadTopicStageEvals,
  topicHasGreenEval,
} from "./stages.js";

const uploadsDir =
  process.env.UPLOADS_DIR || join(dirname(fileURLToPath(import.meta.url)), "../uploads");
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 1_500_000 },
  fileFilter: (_req, file, cb) => {
    if (!/^image\/(jpeg|png|webp|gif)$/.test(file.mimetype)) {
      cb(new Error("Usá una imagen JPG, PNG o WebP"));
      return;
    }
    cb(null, true);
  },
});

function cleanDni(value) {
  return String(value || "").replace(/\D/g, "");
}

function validDni(dni) {
  return /^\d{7,8}$/.test(dni);
}

function validAlias(alias) {
  return /^[a-zA-Z0-9_]{3,20}$/.test(alias);
}

function validPassword(password) {
  return typeof password === "string" && password.length >= 6;
}

function parseTime(value) {
  const date = new Date(value);
  return Number.isNaN(date.getTime()) ? null : date;
}

async function loadCatalog() {
  const [areas, topics, activities, version] = await Promise.all([
    query(`SELECT id, name, color, badge, sort_order FROM areas ORDER BY sort_order`),
    query(`SELECT id, area_id, title, body, sort_order FROM topics ORDER BY sort_order`),
    query(`SELECT id, topic_id, title, sort_order FROM activities ORDER BY sort_order`),
    query(`SELECT value FROM content_meta WHERE key = 'version'`),
  ]);

  return {
    version: Number(version.rows[0]?.value || 1),
    areas: areas.rows.map((area) => ({
      id: area.id,
      name: area.name,
      color: area.color,
      badge: area.badge,
      topics: topics.rows
        .filter((topic) => topic.area_id === area.id)
        .map((topic) => ({
          id: topic.id,
          title: topic.title,
          body: topic.body,
          activities: activities.rows
            .filter((activity) => activity.topic_id === topic.id)
            .map((activity) => ({
              id: activity.id,
              title: activity.title,
            })),
        })),
    })),
  };
}

export function registerRoutes(app) {
  app.get("/api/health", (_req, res) => {
    res.json({ ok: true });
  });

  app.post("/api/auth/check-dni", async (req, res) => {
    const dni = cleanDni(req.body?.dni);
    if (!validDni(dni)) {
      res.status(400).json({ error: "El DNI debe tener 7 u 8 números" });
      return;
    }

    const person = await query(
      `SELECT p.id, p.habilitado, COALESCE(p.tipo, 'protagonista') AS tipo, u.id AS user_id
       FROM people p
       LEFT JOIN users u ON u.person_id = p.id
       WHERE p.dni = $1`,
      [dni],
    );

    if (person.rowCount === 0 || !person.rows[0].habilitado) {
      res.status(404).json({ error: "Este DNI no está habilitado" });
      return;
    }

    res.json({
      dni,
      registered: Boolean(person.rows[0].user_id),
      tipo: person.rows[0].tipo,
    });
  });

  app.post("/api/auth/register", async (req, res) => {
    const dni = cleanDni(req.body?.dni);
    const alias = String(req.body?.alias || "").trim();
    const password = req.body?.password;

    if (!validDni(dni) || !validAlias(alias) || !validPassword(password)) {
      res.status(400).json({
        error:
          "Revisá los datos: DNI de 7-8 números, alias de 3-20 letras/números y contraseña de 6 o más.",
      });
      return;
    }

    const person = await query(
      `SELECT p.id, p.habilitado, COALESCE(p.tipo, 'protagonista') AS tipo, u.id AS user_id
       FROM people p
       LEFT JOIN users u ON u.person_id = p.id
       WHERE p.dni = $1`,
      [dni],
    );

    if (person.rowCount === 0 || !person.rows[0].habilitado) {
      res.status(404).json({ error: "Este DNI no está habilitado" });
      return;
    }
    if (person.rows[0].user_id) {
      res.status(409).json({ error: "Este DNI ya tiene cuenta. Usá tu contraseña." });
      return;
    }

    const taken = await query(`SELECT 1 FROM users WHERE lower(alias) = lower($1)`, [alias]);
    if (taken.rowCount > 0) {
      res.status(409).json({ error: "Ese alias ya está en uso" });
      return;
    }

    const role = person.rows[0].tipo === "educador" ? "educador" : "protagonista";
    const hash = await bcrypt.hash(password, 10);
    const created = await query(
      `INSERT INTO users (person_id, alias, password_hash, role)
       VALUES ($1, $2, $3, $4)
       RETURNING id, alias, avatar, role`,
      [person.rows[0].id, alias, hash, role],
    );

    const token = await createDevice(created.rows[0].id);
    res.json({
      token,
      user: publicUser({ ...created.rows[0], dni }),
    });
  });

  app.post("/api/auth/login", async (req, res) => {
    const dni = cleanDni(req.body?.dni);
    const password = req.body?.password;
    if (!validDni(dni) || !password) {
      res.status(400).json({ error: "Ingresá DNI y contraseña" });
      return;
    }

    const found = await query(
      `SELECT u.id, u.alias, u.avatar, u.password_hash, COALESCE(u.role, 'protagonista') AS role,
              p.dni, p.habilitado
       FROM users u
       JOIN people p ON p.id = u.person_id
       WHERE p.dni = $1`,
      [dni],
    );

    if (found.rowCount === 0 || !found.rows[0].habilitado) {
      res.status(401).json({ error: "DNI o contraseña incorrectos" });
      return;
    }

    const ok = await bcrypt.compare(password, found.rows[0].password_hash);
    if (!ok) {
      res.status(401).json({ error: "DNI o contraseña incorrectos" });
      return;
    }

    const token = await createDevice(found.rows[0].id);
    res.json({
      token,
      user: publicUser(found.rows[0]),
    });
  });

  app.post("/api/auth/logout", authMiddleware, async (req, res) => {
    await query(`DELETE FROM devices WHERE token = $1`, [req.user.token]);
    res.json({ ok: true });
  });

  app.get("/api/me", authMiddleware, async (req, res) => {
    const awards = await query(
      `SELECT insignia_id FROM badge_awards WHERE person_id = $1`,
      [req.user.person_id],
    );
    res.json({
      user: publicUser(req.user),
      awardedInsigniaIds: awards.rows.map((row) => row.insignia_id),
    });
  });

  app.patch("/api/profile", authMiddleware, async (req, res) => {
    const password = req.body?.password;
    if (password != null) {
      if (!validPassword(password)) {
        res.status(400).json({ error: "La contraseña debe tener 6 o más caracteres" });
        return;
      }
      const hash = await bcrypt.hash(password, 10);
      await query(`UPDATE users SET password_hash = $1 WHERE id = $2`, [
        hash,
        req.user.user_id,
      ]);
    }
    const me = await query(
      `SELECT alias, avatar, COALESCE(role, 'protagonista') AS role FROM users WHERE id = $1`,
      [req.user.user_id],
    );
    res.json({ user: publicUser({ ...me.rows[0], dni: req.user.dni }) });
  });

  app.post("/api/profile/avatar", authMiddleware, (req, res) => {
    upload.single("avatar")(req, res, async (err) => {
      if (err) {
        res.status(400).json({ error: err.message || "No se pudo subir la foto" });
        return;
      }
      if (!req.file) {
        res.status(400).json({ error: "Elegí una foto" });
        return;
      }

      await mkdir(uploadsDir, { recursive: true });
      const ext = extname(req.file.originalname || "").toLowerCase() || ".jpg";
      const safeExt = [".jpg", ".jpeg", ".png", ".webp", ".gif"].includes(ext) ? ext : ".jpg";
      const filename = `${req.user.user_id}-${randomUUID()}${safeExt}`;
      await writeFile(join(uploadsDir, filename), req.file.buffer);
      const avatar = `/uploads/${filename}`;
      await query(`UPDATE users SET avatar = $1 WHERE id = $2`, [avatar, req.user.user_id]);
      res.json({ avatar });
    });
  });

  app.get("/api/catalog", authMiddleware, async (_req, res) => {
    res.json(await loadCatalog());
  });

  app.get("/api/sync", authMiddleware, async (req, res) => {
    const personId = req.user.person_id;
    const userId = req.user.user_id;
    const [likes, progress, notes, awards, me, topicStageEvals, closedStages] = await Promise.all([
      query(`SELECT topic_id, liked, updated_at FROM likes WHERE person_id = $1`, [personId]),
      query(
        `SELECT activity_id, status, locked_stage, updated_at FROM action_progress WHERE person_id = $1`,
        [personId],
      ),
      query(`SELECT topic_id, text, updated_at FROM topic_notes WHERE person_id = $1`, [personId]),
      query(`SELECT insignia_id FROM badge_awards WHERE person_id = $1`, [personId]),
      query(
        `SELECT alias, avatar, COALESCE(role, 'protagonista') AS role FROM users WHERE id = $1`,
        [userId],
      ),
      loadTopicStageEvals(personId),
      loadClosedStages(personId),
    ]);

    res.json({
      user: publicUser({ ...me.rows[0], dni: req.user.dni }),
      awardedInsigniaIds: awards.rows.map((row) => row.insignia_id),
      closedStages,
      topicStageEvals,
      likes: likes.rows.map((row) => ({
        topicId: row.topic_id,
        liked: row.liked,
        updatedAt: row.updated_at.toISOString(),
      })),
      progress: progress.rows.map((row) => ({
        activityId: row.activity_id,
        status: row.status,
        lockedStage: row.locked_stage || null,
        updatedAt: row.updated_at.toISOString(),
      })),
      notes: notes.rows.map((row) => ({
        topicId: row.topic_id,
        text: row.text,
        updatedAt: row.updated_at.toISOString(),
      })),
    });
  });

  app.post("/api/sync", authMiddleware, async (req, res) => {
    const personId = req.user.person_id;
    const likes = Array.isArray(req.body?.likes) ? req.body.likes : [];
    const progress = Array.isArray(req.body?.progress) ? req.body.progress : [];
    const notes = Array.isArray(req.body?.notes) ? req.body.notes : [];

    for (const item of likes) {
      const updatedAt = parseTime(item.updatedAt);
      if (!item.topicId || !updatedAt) continue;
      const liked = Boolean(item.liked);
      if (!liked) {
        const locked = await topicHasGreenEval(personId, item.topicId);
        if (locked) {
          res.status(400).json({
            error: "No se puede quitar una ficha con evaluación completada (bolita verde)",
          });
          return;
        }
        await clearOpenEvalsForTopic(personId, item.topicId);
      }
      await query(
        `INSERT INTO likes (person_id, topic_id, liked, updated_at)
         VALUES ($1, $2, $3, $4)
         ON CONFLICT (person_id, topic_id) DO UPDATE SET
           liked = EXCLUDED.liked,
           updated_at = EXCLUDED.updated_at
         WHERE likes.updated_at <= EXCLUDED.updated_at`,
        [personId, item.topicId, liked, updatedAt.toISOString()],
      );
    }

    for (const item of progress) {
      const updatedAt = parseTime(item.updatedAt);
      const status = ["none", "goal", "doing", "done"].includes(item.status)
        ? item.status
        : null;
      if (!item.activityId || !updatedAt || !status) continue;

      const locked = await query(
        `SELECT locked_stage FROM action_progress WHERE person_id = $1 AND activity_id = $2`,
        [personId, item.activityId],
      );
      if (locked.rowCount > 0 && locked.rows[0].locked_stage != null) {
        // Acción fijada a una etapa: no se puede cambiar.
        continue;
      }

      await query(
        `INSERT INTO action_progress (person_id, activity_id, status, locked_stage, updated_at)
         VALUES ($1, $2, $3, NULL, $4)
         ON CONFLICT (person_id, activity_id) DO UPDATE SET
           status = EXCLUDED.status,
           updated_at = EXCLUDED.updated_at
         WHERE action_progress.updated_at <= EXCLUDED.updated_at
           AND action_progress.locked_stage IS NULL`,
        [personId, item.activityId, status, updatedAt.toISOString()],
      );
    }

    for (const item of notes) {
      const updatedAt = parseTime(item.updatedAt);
      if (!item.topicId || !updatedAt) continue;
      await query(
        `INSERT INTO topic_notes (person_id, topic_id, text, updated_at)
         VALUES ($1, $2, $3, $4)
         ON CONFLICT (person_id, topic_id) DO UPDATE SET
           text = EXCLUDED.text,
           updated_at = EXCLUDED.updated_at
         WHERE topic_notes.updated_at <= EXCLUDED.updated_at`,
        [personId, item.topicId, String(item.text || ""), updatedAt.toISOString()],
      );
    }

    res.json({ ok: true });
  });

  app.get("/api/topics/:topicId/likes", authMiddleware, async (req, res) => {
    const topicId = req.params.topicId;
    const people = await query(
      `SELECT COALESCE(u.alias, p.nombre, p.dni) AS alias,
              COALESCE(
                (
                  SELECT CASE
                    WHEN bool_or(ap.status = 'doing') THEN 'doing'
                    WHEN bool_or(ap.status = 'goal') THEN 'goal'
                    WHEN bool_or(ap.status = 'done') THEN 'done'
                    ELSE 'none'
                  END
                  FROM action_progress ap
                  JOIN activities a ON a.id = ap.activity_id
                  WHERE ap.person_id = p.id AND a.topic_id = $1
                ),
                'none'
              ) AS status
       FROM likes l
       JOIN people p ON p.id = l.person_id
       LEFT JOIN users u ON u.person_id = p.id
       WHERE l.topic_id = $1 AND l.liked = TRUE
         AND COALESCE(p.tipo, 'protagonista') = 'protagonista'
       ORDER BY lower(COALESCE(u.alias, p.nombre, p.dni))`,
      [topicId],
    );

    res.json({
      topicId,
      people: people.rows.map((row) => ({
        alias: row.alias,
        status: topicStatus([row.status]),
      })),
    });
  });

  app.post("/api/admin/people", async (req, res) => {
    if (!process.env.ADMIN_SECRET || req.headers["x-admin-secret"] !== process.env.ADMIN_SECRET) {
      res.status(401).json({ error: "No autorizado" });
      return;
    }
    const dni = cleanDni(req.body?.dni);
    const nombre = String(req.body?.nombre || "").trim() || null;
    if (!validDni(dni)) {
      res.status(400).json({ error: "DNI inválido" });
      return;
    }
    await query(
      `INSERT INTO people (dni, nombre, habilitado)
       VALUES ($1, $2, TRUE)
       ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE`,
      [dni, nombre],
    );
    res.json({ ok: true, dni });
  });

  registerEducatorRoutes(app);
}
