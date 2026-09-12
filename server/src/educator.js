import bcrypt from "bcryptjs";
import { query } from "./db.js";
import { authMiddleware, publicUser } from "./auth.js";
import { getInsignia, isInsigniaId, stageFromAwardCount } from "./insignias.js";
import {
  ballsForTopic,
  isStage,
  loadClosedStages,
  loadTopicStageEvals,
  lockDoneActionsForTopicStage,
  nextBallStatus,
  unlockActionsForTopicStage,
} from "./stages.js";

const PAGE_SIZE = 20;

function pageParams(req) {
  const page = Math.max(1, Number(req.query.page) || 1);
  const q = String(req.query.q || "").trim();
  return { page, q, offset: (page - 1) * PAGE_SIZE, pageSize: PAGE_SIZE };
}

function educatorMiddleware(req, res, next) {
  authMiddleware(req, res, () => {
    if (req.user.role !== "educador") {
      res.status(403).json({ error: "Solo educadores" });
      return;
    }
    next();
  });
}

async function loadAwards(personId) {
  const awards = await query(
    `SELECT insignia_id FROM badge_awards WHERE person_id = $1 ORDER BY insignia_id`,
    [personId],
  );
  const awardedInsigniaIds = awards.rows.map((row) => row.insignia_id);
  return {
    awardedInsigniaIds,
    progression: stageFromAwardCount(awardedInsigniaIds.length),
  };
}

async function assertProtagonistPerson(personId) {
  const found = await query(
    `SELECT p.id, p.dni, p.nombre, u.id AS user_id, u.alias, u.avatar
     FROM people p
     LEFT JOIN users u ON u.person_id = p.id
     WHERE p.id = $1 AND COALESCE(p.tipo, 'protagonista') = 'protagonista'`,
    [personId],
  );
  return found.rowCount ? found.rows[0] : null;
}

export function registerEducatorRoutes(app) {
  app.get("/api/educator/protagonists", educatorMiddleware, async (req, res) => {
    const { page, q, offset, pageSize } = pageParams(req);
    const like = q ? `%${q}%` : null;

    const where = `
      WHERE COALESCE(p.tipo, 'protagonista') = 'protagonista'
      ${like ? "AND (p.dni ILIKE $1 OR COALESCE(p.nombre, '') ILIKE $1 OR COALESCE(u.alias, '') ILIKE $1)" : ""}
    `;
    const params = like ? [like] : [];

    const total = await query(
      `SELECT COUNT(*)::int AS n
       FROM people p
       LEFT JOIN users u ON u.person_id = p.id
       ${where}`,
      params,
    );

    const listParams = like ? [like, pageSize, offset] : [pageSize, offset];
    const rows = await query(
      `SELECT p.id AS person_id, p.dni, p.nombre, p.habilitado,
              u.id AS user_id, u.alias, u.avatar,
              (SELECT MAX(d.last_seen) FROM devices d WHERE d.user_id = u.id) AS last_access,
              COALESCE(
                (SELECT COUNT(*)::int FROM badge_awards ba WHERE ba.person_id = p.id),
                0
              ) AS award_count
       FROM people p
       LEFT JOIN users u ON u.person_id = p.id
       ${where}
       ORDER BY COALESCE(u.alias, p.nombre, p.dni)
       LIMIT $${like ? 2 : 1} OFFSET $${like ? 3 : 2}`,
      listParams,
    );

    res.json({
      page,
      pageSize,
      total: total.rows[0].n,
      items: rows.rows.map((row) => {
        const progression = stageFromAwardCount(row.award_count);
        return {
          personId: row.person_id,
          userId: row.user_id,
          dni: row.dni,
          nombre: row.nombre || "",
          alias: row.alias || null,
          avatar: row.avatar || null,
          habilitado: row.habilitado,
          lastAccess: row.last_access ? row.last_access.toISOString() : null,
          awardCount: row.award_count,
          progressionLabel: progression.label,
          progressionStage: progression.stage,
        };
      }),
    });
  });

  app.post("/api/educator/protagonists/:userId/reset-password", educatorMiddleware, async (req, res) => {
    const userId = Number(req.params.userId);
    const found = await query(
      `SELECT u.id FROM users u
       WHERE u.id = $1 AND COALESCE(u.role, 'protagonista') = 'protagonista'`,
      [userId],
    );
    if (found.rowCount === 0) {
      res.status(404).json({ error: "Protagonista no encontrado" });
      return;
    }

    const temporaryPassword = `Thaq${Math.floor(100000 + Math.random() * 900000)}`;
    const hash = await bcrypt.hash(temporaryPassword, 10);
    await query(`UPDATE users SET password_hash = $1 WHERE id = $2`, [hash, userId]);
    await query(`DELETE FROM devices WHERE user_id = $1`, [userId]);

    res.json({ temporaryPassword });
  });

  app.post("/api/educator/protagonists/:personId/toggle-enabled", educatorMiddleware, async (req, res) => {
    const personId = Number(req.params.personId);
    const found = await query(
      `SELECT p.id, p.habilitado, u.id AS user_id
       FROM people p
       LEFT JOIN users u ON u.person_id = p.id
       WHERE p.id = $1
         AND (u.id IS NULL OR COALESCE(p.tipo, 'protagonista') = 'protagonista')`,
      [personId],
    );
    if (found.rowCount === 0) {
      res.status(404).json({ error: "Protagonista no encontrado" });
      return;
    }

    const next = !found.rows[0].habilitado;
    await query(`UPDATE people SET habilitado = $1 WHERE id = $2`, [next, personId]);
    if (!next && found.rows[0].user_id) {
      await query(`DELETE FROM devices WHERE user_id = $1`, [found.rows[0].user_id]);
    }

    res.json({ habilitado: next });
  });

  app.get("/api/educator/protagonists/:personId/progression", educatorMiddleware, async (req, res) => {
    const personId = Number(req.params.personId);
    const row = await assertProtagonistPerson(personId);
    if (!row) {
      res.status(404).json({ error: "Protagonista no encontrado" });
      return;
    }

    const [likes, progress, notes, awards, topicStageEvals, closedStages] = await Promise.all([
      query(`SELECT topic_id, liked, updated_at FROM likes WHERE person_id = $1 AND liked = TRUE`, [
        personId,
      ]),
      query(
        `SELECT activity_id, status, locked_stage, updated_at FROM action_progress WHERE person_id = $1`,
        [personId],
      ),
      query(`SELECT topic_id, text, updated_at FROM topic_notes WHERE person_id = $1`, [personId]),
      loadAwards(personId),
      loadTopicStageEvals(personId),
      loadClosedStages(personId),
    ]);

    const displayName = row.alias || row.nombre || row.dni;
    res.json({
      personId,
      userId: row.user_id || null,
      user: {
        alias: displayName,
        avatar: row.avatar || null,
        dni: row.dni,
        nombre: row.nombre || "",
        role: "protagonista",
      },
      awardedInsigniaIds: awards.awardedInsigniaIds,
      progression: awards.progression,
      closedStages,
      topicStageEvals,
      likes: likes.rows.map((item) => ({
        topicId: item.topic_id,
        liked: item.liked,
        updatedAt: item.updated_at.toISOString(),
      })),
      progress: progress.rows.map((item) => ({
        activityId: item.activity_id,
        status: item.status,
        lockedStage: item.locked_stage || null,
        updatedAt: item.updated_at.toISOString(),
      })),
      notes: notes.rows.map((item) => ({
        topicId: item.topic_id,
        text: item.text,
        updatedAt: item.updated_at.toISOString(),
      })),
    });
  });

  app.post(
    "/api/educator/protagonists/:personId/topics/:topicId/stages/:stage",
    educatorMiddleware,
    async (req, res) => {
      const personId = Number(req.params.personId);
      const topicId = String(req.params.topicId || "");
      const stage = isStage(req.params.stage);
      if (!stage) {
        res.status(400).json({ error: "Etapa inválida" });
        return;
      }

      const person = await assertProtagonistPerson(personId);
      if (!person) {
        res.status(404).json({ error: "Protagonista no encontrado" });
        return;
      }

      const awards = await loadAwards(personId);
      if (awards.progression.stage === 0) {
        res.status(400).json({ error: "En Integración no se evalúan fichas por etapa" });
        return;
      }

      const closed = await query(
        `SELECT 1 FROM stage_closures WHERE person_id = $1 AND stage = $2`,
        [personId, stage],
      );
      if (closed.rowCount > 0) {
        res.status(400).json({ error: `La Etapa ${stage} está cerrada` });
        return;
      }

      const liked = await query(
        `SELECT 1 FROM likes WHERE person_id = $1 AND topic_id = $2 AND liked = TRUE`,
        [personId, topicId],
      );
      if (liked.rowCount === 0) {
        res.status(400).json({ error: "La ficha tiene que estar en la progresión del protagonista" });
        return;
      }

      const topic = await query(`SELECT id FROM topics WHERE id = $1`, [topicId]);
      if (topic.rowCount === 0) {
        res.status(404).json({ error: "Ficha no encontrada" });
        return;
      }

      const current = await query(
        `SELECT status FROM topic_stage_evals WHERE person_id = $1 AND topic_id = $2 AND stage = $3`,
        [personId, topicId, stage],
      );
      const prev = current.rowCount ? current.rows[0].status : null;
      const next = nextBallStatus(prev);

      if (prev === "done" && next !== "done") {
        await unlockActionsForTopicStage(personId, topicId, stage);
      }

      if (!next) {
        await query(
          `DELETE FROM topic_stage_evals WHERE person_id = $1 AND topic_id = $2 AND stage = $3`,
          [personId, topicId, stage],
        );
      } else {
        await query(
          `INSERT INTO topic_stage_evals (person_id, topic_id, stage, status, updated_at, updated_by)
           VALUES ($1, $2, $3, $4, NOW(), $5)
           ON CONFLICT (person_id, topic_id, stage) DO UPDATE SET
             status = EXCLUDED.status,
             updated_at = EXCLUDED.updated_at,
             updated_by = EXCLUDED.updated_by`,
          [personId, topicId, stage, next, req.user.alias],
        );
        if (next === "done") {
          await lockDoneActionsForTopicStage(personId, topicId, stage);
        }
      }

      const [evals, progress] = await Promise.all([
        loadTopicStageEvals(personId, topicId),
        query(
          `SELECT ap.activity_id, ap.status, ap.locked_stage, ap.updated_at
           FROM action_progress ap
           JOIN activities a ON a.id = ap.activity_id
           WHERE ap.person_id = $1 AND a.topic_id = $2`,
          [personId, topicId],
        ),
      ]);

      res.json({
        topicId,
        stage,
        status: next,
        balls: ballsForTopic(evals),
        topicStageEvals: evals,
        progress: progress.rows.map((item) => ({
          activityId: item.activity_id,
          status: item.status,
          lockedStage: item.locked_stage || null,
          updatedAt: item.updated_at.toISOString(),
        })),
      });
    },
  );

  app.post(
    "/api/educator/protagonists/:personId/stages/:stage/close",
    educatorMiddleware,
    async (req, res) => {
      const personId = Number(req.params.personId);
      const stage = isStage(req.params.stage);
      if (!stage) {
        res.status(400).json({ error: "Etapa inválida" });
        return;
      }

      const person = await assertProtagonistPerson(personId);
      if (!person) {
        res.status(404).json({ error: "Protagonista no encontrado" });
        return;
      }

      const awards = await loadAwards(personId);
      if (awards.progression.stage === 0) {
        res.status(400).json({ error: "En Integración no se cierran etapas de fichas" });
        return;
      }

      const existing = await query(
        `SELECT 1 FROM stage_closures WHERE person_id = $1 AND stage = $2`,
        [personId, stage],
      );
      if (existing.rowCount > 0) {
        res.status(400).json({ error: `La Etapa ${stage} ya está cerrada` });
        return;
      }

      await query(
        `INSERT INTO stage_closures (person_id, stage, closed_at, closed_by)
         VALUES ($1, $2, NOW(), $3)`,
        [personId, stage, req.user.alias],
      );

      const closedStages = await loadClosedStages(personId);
      res.json({ stage, closedStages });
    },
  );

  app.post(
    "/api/educator/protagonists/:personId/insignias/:insigniaId",
    educatorMiddleware,
    async (req, res) => {
      const personId = Number(req.params.personId);
      const insigniaId = String(req.params.insigniaId || "");
      if (!isInsigniaId(insigniaId)) {
        res.status(400).json({ error: "Insignia inválida" });
        return;
      }

      const found = await query(
        `SELECT p.id, COALESCE(u.alias, p.nombre, p.dni) AS label
         FROM people p
         LEFT JOIN users u ON u.person_id = p.id
         WHERE p.id = $1 AND COALESCE(p.tipo, 'protagonista') = 'protagonista'`,
        [personId],
      );
      if (found.rowCount === 0) {
        res.status(404).json({ error: "Protagonista no encontrado" });
        return;
      }

      const existing = await query(
        `SELECT 1 FROM badge_awards WHERE person_id = $1 AND insignia_id = $2`,
        [personId, insigniaId],
      );

      if (existing.rowCount > 0) {
        await query(`DELETE FROM badge_awards WHERE person_id = $1 AND insignia_id = $2`, [
          personId,
          insigniaId,
        ]);
      } else {
        await query(
          `INSERT INTO badge_awards (person_id, insignia_id, awarded_by, awarded_at)
           VALUES ($1, $2, $3, NOW())`,
          [personId, insigniaId, req.user.alias],
        );
      }

      const awards = await loadAwards(personId);
      const meta = getInsignia(insigniaId);
      res.json({
        insigniaId,
        element: meta?.element,
        awarded: existing.rowCount === 0,
        awardedInsigniaIds: awards.awardedInsigniaIds,
        progression: awards.progression,
      });
    },
  );

  app.get("/api/educator/topics", educatorMiddleware, async (req, res) => {
    const { page, q, offset, pageSize } = pageParams(req);
    const areaId = String(req.query.areaId || "").trim() || null;
    const like = q ? `%${q}%` : null;

    const filters = [];
    const params = [];
    if (like) {
      params.push(like);
      filters.push(`t.title ILIKE $${params.length}`);
    }
    if (areaId) {
      params.push(areaId);
      filters.push(`t.area_id = $${params.length}`);
    }
    const where = filters.length ? `WHERE ${filters.join(" AND ")}` : "";

    const total = await query(`SELECT COUNT(*)::int AS n FROM topics t ${where}`, params);

    const listParams = [...params, pageSize, offset];
    const rows = await query(
      `SELECT t.id, t.title, t.area_id, a.name AS area_name, a.color AS area_color,
              (
                SELECT COUNT(*)::int FROM likes l
                JOIN people p ON p.id = l.person_id
                WHERE l.topic_id = t.id AND l.liked = TRUE
                  AND COALESCE(p.tipo, 'protagonista') = 'protagonista'
              ) AS protagonistas
       FROM topics t
       JOIN areas a ON a.id = t.area_id
       ${where}
       ORDER BY a.sort_order, t.sort_order
       LIMIT $${params.length + 1} OFFSET $${params.length + 2}`,
      listParams,
    );

    res.json({
      page,
      pageSize,
      total: total.rows[0].n,
      items: rows.rows.map((row) => ({
        id: row.id,
        title: row.title,
        areaId: row.area_id,
        areaName: row.area_name,
        areaColor: row.area_color,
        protagonistas: row.protagonistas,
      })),
    });
  });

  app.get("/api/educator/topics/:topicId/protagonists", educatorMiddleware, async (req, res) => {
    const topicId = req.params.topicId;
    const topic = await query(
      `SELECT t.id, t.title, a.name AS area_name, a.color AS area_color
       FROM topics t JOIN areas a ON a.id = t.area_id WHERE t.id = $1`,
      [topicId],
    );
    if (topic.rowCount === 0) {
      res.status(404).json({ error: "Ficha no encontrada" });
      return;
    }

    const { page, q, offset, pageSize } = pageParams(req);
    const like = q ? `%${q}%` : null;
    const params = like ? [topicId, like] : [topicId];
    const aliasFilter = like
      ? `AND (COALESCE(u.alias, p.nombre, p.dni) ILIKE $2)`
      : "";

    const total = await query(
      `SELECT COUNT(*)::int AS n
       FROM likes l
       JOIN people p ON p.id = l.person_id
       LEFT JOIN users u ON u.person_id = p.id
       WHERE l.topic_id = $1 AND l.liked = TRUE
         AND COALESCE(p.tipo, 'protagonista') = 'protagonista'
         ${aliasFilter}`,
      params,
    );

    const listParams = like ? [topicId, like, pageSize, offset] : [topicId, pageSize, offset];
    const rows = await query(
      `SELECT p.id AS person_id, COALESCE(u.alias, p.nombre, p.dni) AS alias, u.avatar
       FROM likes l
       JOIN people p ON p.id = l.person_id
       LEFT JOIN users u ON u.person_id = p.id
       WHERE l.topic_id = $1 AND l.liked = TRUE
         AND COALESCE(p.tipo, 'protagonista') = 'protagonista'
         ${aliasFilter}
       ORDER BY lower(COALESCE(u.alias, p.nombre, p.dni))
       LIMIT $${like ? 3 : 2} OFFSET $${like ? 4 : 3}`,
      listParams,
    );

    const personIds = rows.rows.map((row) => row.person_id);
    let evalsByPerson = new Map();
    if (personIds.length) {
      const evals = await query(
        `SELECT person_id, topic_id, stage, status
         FROM topic_stage_evals
         WHERE topic_id = $1 AND person_id = ANY($2::int[])`,
        [topicId, personIds],
      );
      for (const row of evals.rows) {
        const list = evalsByPerson.get(row.person_id) || [];
        list.push({ topicId: row.topic_id, stage: row.stage, status: row.status });
        evalsByPerson.set(row.person_id, list);
      }
    }

    res.json({
      topic: {
        id: topic.rows[0].id,
        title: topic.rows[0].title,
        areaName: topic.rows[0].area_name,
        areaColor: topic.rows[0].area_color,
      },
      page,
      pageSize,
      total: total.rows[0].n,
      items: rows.rows.map((row) => ({
        personId: row.person_id,
        alias: row.alias,
        avatar: row.avatar,
        balls: ballsForTopic(evalsByPerson.get(row.person_id) || []),
      })),
    });
  });
}
