#!/usr/bin/env node
/**
 * Smoke test de progresión: insignias, bolitas E1–E4, cierre de etapa, locks.
 * Uso: node scripts/smoke-stages.mjs
 * Requiere docker compose arriba en http://localhost:3000
 */
const BASE = process.env.PUBLIC_URL || "http://localhost:3000";

async function req(path, { method = "GET", token, body } = {}) {
  const headers = { "Content-Type": "application/json" };
  if (token) headers.Authorization = `Bearer ${token}`;
  const res = await fetch(`${BASE}${path}`, {
    method,
    headers,
    body: body ? JSON.stringify(body) : undefined,
  });
  const data = await res.json().catch(() => ({}));
  if (!res.ok) {
    const err = new Error(data.error || `${res.status} ${path}`);
    err.status = res.status;
    err.data = data;
    throw err;
  }
  return data;
}

function assert(cond, msg) {
  if (!cond) throw new Error(msg);
}

async function ensureEducator() {
  const dni = "27361408";
  const check = await req("/api/auth/check-dni", { method: "POST", body: { dni } });
  if (!check.registered) {
    return req("/api/auth/register", {
      method: "POST",
      body: { dni, alias: "EduTest", password: "educador1" },
    });
  }
  // probar claves conocidas
  for (const password of ["educador1", "Puma", "27361408", "educador"]) {
    try {
      return await req("/api/auth/login", { method: "POST", body: { dni, password } });
    } catch {
      /* next */
    }
  }
  throw new Error("No se pudo entrar como educador 27361408");
}

async function ensureProtagonist() {
  const dni = "50331442";
  const check = await req("/api/auth/check-dni", { method: "POST", body: { dni } });
  if (!check.registered) {
    return req("/api/auth/register", {
      method: "POST",
      body: { dni, alias: "ProtoTest", password: "proto123" },
    });
  }
  for (const password of ["proto123", "Test", "50331442"]) {
    try {
      return await req("/api/auth/login", { method: "POST", body: { dni, password } });
    } catch {
      /* next */
    }
  }
  throw new Error("No se pudo entrar como protagonista 50331442");
}

async function main() {
  console.log("Smoke stages @", BASE);
  const edu = await ensureEducator();
  const proto = await ensureProtagonist();
  const eduTok = edu.token;
  const protoTok = proto.token;

  const list = await req("/api/educator/protagonists?page=1&q=50331442", { token: eduTok });
  const person = list.items.find((p) => p.dni === "50331442");
  assert(person, "protagonista 50331442 en listado");
  const personId = person.personId;

  // Otorgar 1 insignia si está en integración
  let prog = await req(`/api/educator/protagonists/${personId}/progression`, { token: eduTok });
  if (prog.progression.stage === 0) {
    await req(`/api/educator/protagonists/${personId}/insignias/sur`, {
      method: "POST",
      token: eduTok,
    });
    prog = await req(`/api/educator/protagonists/${personId}/progression`, { token: eduTok });
  }
  assert(prog.progression.stage >= 1, "debe estar al menos en Etapa 1");

  const catalog = await req("/api/catalog", { token: protoTok });
  const topic = catalog.areas[0].topics[0];
  const activity = topic.activities[0];
  assert(topic && activity, "catálogo con ficha y acción");

  // Like + acción alcanzada
  const now = new Date().toISOString();
  await req("/api/sync", {
    method: "POST",
    token: protoTok,
    body: {
      likes: [{ topicId: topic.id, liked: true, updatedAt: now }],
      progress: [{ activityId: activity.id, status: "done", updatedAt: now }],
      notes: [],
    },
  });

  // Amarillo E1
  let ball = await req(
    `/api/educator/protagonists/${personId}/topics/${topic.id}/stages/1`,
    { method: "POST", token: eduTok },
  );
  assert(ball.status === "in_progress", "E1 amarillo");
  assert(ball.balls.e1 === "yellow", "ball e1 yellow");

  // Verde E1 → lock acción
  ball = await req(
    `/api/educator/protagonists/${personId}/topics/${topic.id}/stages/1`,
    { method: "POST", token: eduTok },
  );
  assert(ball.status === "done", "E1 verde");
  assert(ball.balls.e1 === "green", "ball e1 green");
  const locked = ball.progress.find((p) => p.activityId === activity.id);
  assert(locked?.lockedStage === 1, "acción fijada a E1");

  // No se puede quitar like
  let blocked = false;
  try {
    await req("/api/sync", {
      method: "POST",
      token: protoTok,
      body: {
        likes: [{ topicId: topic.id, liked: false, updatedAt: new Date().toISOString() }],
        progress: [],
        notes: [],
      },
    });
  } catch (err) {
    blocked = err.status === 400;
  }
  assert(blocked, "unlike bloqueado con verde");

  // Sync pull incluye lockedStage y evals
  const sync = await req("/api/sync", { token: protoTok });
  assert(
    sync.topicStageEvals.some((e) => e.topicId === topic.id && e.stage === 1 && e.status === "done"),
    "evals en sync",
  );
  assert(
    sync.progress.some((p) => p.activityId === activity.id && p.lockedStage === 1),
    "lockedStage en sync",
  );

  // Cerrar etapa 1
  const closed = await req(`/api/educator/protagonists/${personId}/stages/1/close`, {
    method: "POST",
    token: eduTok,
  });
  assert(closed.closedStages.includes(1), "etapa 1 cerrada");

  // No se puede ciclar bolita de etapa cerrada
  let closedBlock = false;
  try {
    await req(`/api/educator/protagonists/${personId}/topics/${topic.id}/stages/1`, {
      method: "POST",
      token: eduTok,
    });
  } catch (err) {
    closedBlock = err.status === 400;
  }
  assert(closedBlock, "bolita bloqueada en etapa cerrada");

  console.log("OK — smoke stages passed");
}

main().catch((err) => {
  console.error("FAIL:", err.message);
  process.exit(1);
});
