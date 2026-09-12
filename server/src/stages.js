import { query } from "./db.js";

export const STAGES = [1, 2, 3, 4];

export function isStage(value) {
  const n = Number(value);
  return STAGES.includes(n) ? n : null;
}

export function nextBallStatus(current) {
  if (current === "in_progress") return "done";
  if (current === "done") return null; // gris / sin fila
  return "in_progress";
}

export function ballColorFromStatus(status) {
  if (status === "done") return "green";
  if (status === "in_progress") return "yellow";
  return "gray";
}

export async function loadClosedStages(personId) {
  const rows = await query(
    `SELECT stage FROM stage_closures WHERE person_id = $1 ORDER BY stage`,
    [personId],
  );
  return rows.rows.map((row) => row.stage);
}

export async function loadTopicStageEvals(personId, topicId = null) {
  const result = topicId
    ? await query(
        `SELECT topic_id, stage, status, updated_at
         FROM topic_stage_evals
         WHERE person_id = $1 AND topic_id = $2
         ORDER BY topic_id, stage`,
        [personId, topicId],
      )
    : await query(
        `SELECT topic_id, stage, status, updated_at
         FROM topic_stage_evals
         WHERE person_id = $1
         ORDER BY topic_id, stage`,
        [personId],
      );

  return result.rows.map((row) => ({
    topicId: row.topic_id,
    stage: row.stage,
    status: row.status,
    updatedAt: row.updated_at.toISOString(),
  }));
}

export async function topicHasGreenEval(personId, topicId) {
  const found = await query(
    `SELECT 1 FROM topic_stage_evals
     WHERE person_id = $1 AND topic_id = $2 AND status = 'done'
     LIMIT 1`,
    [personId, topicId],
  );
  return found.rowCount > 0;
}

/** Al pasar a verde: fija acciones alcanzadas de la ficha a esa etapa. */
export async function lockDoneActionsForTopicStage(personId, topicId, stage) {
  await query(
    `UPDATE action_progress ap
     SET locked_stage = $3
     FROM activities a
     WHERE ap.activity_id = a.id
       AND a.topic_id = $2
       AND ap.person_id = $1
       AND ap.status = 'done'
       AND ap.locked_stage IS NULL`,
    [personId, topicId, stage],
  );
}

/** Al salir de verde: libera acciones fijadas a esa etapa en esa ficha. */
export async function unlockActionsForTopicStage(personId, topicId, stage) {
  await query(
    `UPDATE action_progress ap
     SET locked_stage = NULL
     FROM activities a
     WHERE ap.activity_id = a.id
       AND a.topic_id = $2
       AND ap.person_id = $1
       AND ap.locked_stage = $3`,
    [personId, topicId, stage],
  );
}

/** Al quitar ficha de progresión: borra evals no verdes de etapas abiertas. */
export async function clearOpenEvalsForTopic(personId, topicId) {
  await query(
    `DELETE FROM topic_stage_evals tse
     WHERE tse.person_id = $1
       AND tse.topic_id = $2
       AND tse.status <> 'done'
       AND NOT EXISTS (
         SELECT 1 FROM stage_closures sc
         WHERE sc.person_id = tse.person_id AND sc.stage = tse.stage
       )`,
    [personId, topicId],
  );
}

export function ballsForTopic(evalsForTopic) {
  const byStage = Object.fromEntries(evalsForTopic.map((e) => [e.stage, e.status]));
  return {
    e1: ballColorFromStatus(byStage[1]),
    e2: ballColorFromStatus(byStage[2]),
    e3: ballColorFromStatus(byStage[3]),
    e4: ballColorFromStatus(byStage[4]),
  };
}
