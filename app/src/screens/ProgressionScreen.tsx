import { useMemo, useState } from "react";
import { api } from "../api";
import { IconDoing, IconDone, IconGoal, IconPeople, statusLabel, StatusGlyph } from "../components/Icons";
import { Shell } from "../components/Shell";
import { topicStatus } from "../progress";
import { stageTag, topicHasGreen } from "../stages";
import { topicHeading } from "../topicLabel";
import { useStore } from "../store";
import type { SocialPerson, Status } from "../types";

export function ProgressionScreen() {
  const {
    catalog,
    likes,
    progress,
    notes,
    topicStageEvals,
    toggleLike,
    setStatus,
    setNote,
    session,
    online,
  } = useStore();
  const [openId, setOpenId] = useState<string | null>(null);
  const [social, setSocial] = useState<SocialPerson[] | null>(null);
  const [socialTitle, setSocialTitle] = useState("");
  const [socialError, setSocialError] = useState<string | null>(null);
  const [lockMsg, setLockMsg] = useState<string | null>(null);

  const items = useMemo(() => {
    if (!catalog) return [];
    return catalog.areas.flatMap((area) =>
      area.topics
        .filter((topic) => likes[topic.id]?.liked)
        .map((topic) => ({ area, topic })),
    );
  }, [catalog, likes]);

  async function openSocial(topicId: string, title: string) {
    setSocialTitle(title);
    setSocialError(null);
    if (!online || !session) {
      setSocial([]);
      setSocialError("Para ver quién más lo marcó necesitás datos.");
      return;
    }
    try {
      const result = await api.topicLikes(session.token, topicId);
      setSocial(result.people);
    } catch {
      setSocial([]);
      setSocialError("No se pudo cargar la lista.");
    }
  }

  async function tryRemove(topicId: string) {
    setLockMsg(null);
    try {
      await toggleLike(topicId);
    } catch (err) {
      setLockMsg(err instanceof Error ? err.message : "No se pudo quitar la ficha");
    }
  }

  return (
    <Shell title="Mi progresión">
      <div className="stack">
        {items.length === 0 && (
          <p>Todavía no marcaste temas con me gusta. En Áreas podés elegir los que te interesan.</p>
        )}
        {lockMsg && <p className="error">{lockMsg}</p>}
        {items.map(({ area, topic }) => {
          const open = openId === topic.id;
          const lockedTopic = topicHasGreen(topicStageEvals, topic.id);
          return (
            <div key={topic.id} className="card accordion">
              <div style={{ display: "flex", alignItems: "center" }}>
                <button type="button" className="accordion-head" onClick={() => setOpenId(open ? null : topic.id)}>
                  <span style={{ color: area.color }}>●</span>
                  {topicHeading(topic)}
                </button>
                <button
                  type="button"
                  className="people-btn"
                  aria-label="Quién más lo marcó"
                  onClick={() => openSocial(topic.id, topicHeading(topic))}
                >
                  <IconPeople />
                </button>
              </div>
              {open && (
                <div className="accordion-body">
                  {topic.activities.map((activity) => {
                    const row = progress[activity.id];
                    const current = row?.status || "none";
                    const locked = row?.lockedStage || null;
                    const frozen = Boolean(locked);
                    return (
                      <div key={activity.id} className={`activity ${frozen ? "is-locked" : ""}`}>
                        <div className="activity-title-row">
                          <div>{activity.title}</div>
                          {locked && <span className="stage-tag">{stageTag(locked)}</span>}
                        </div>
                        <div className="status-row" style={{ marginTop: 8 }}>
                          {(["goal", "doing", "done"] as Status[]).map((value) => (
                            <button
                              key={value}
                              type="button"
                              className={`status-btn ${current === value ? "on" : ""} ${frozen ? "is-locked" : ""}`}
                              disabled={frozen}
                              onClick={() => {
                                if (frozen) return;
                                void setStatus(activity.id, current === value ? "none" : value);
                              }}
                            >
                              {value === "goal" ? <IconGoal /> : value === "doing" ? <IconDoing /> : <IconDone />}
                              {statusLabel(value)}
                            </button>
                          ))}
                        </div>
                      </div>
                    );
                  })}
                  <label>
                    Notas
                    <textarea
                      value={notes[topic.id]?.text || ""}
                      onChange={(event) => setNote(topic.id, event.target.value)}
                      placeholder="Lo que quieras dejar asentado"
                    />
                  </label>
                  <button
                    type="button"
                    className="ghost"
                    disabled={lockedTopic}
                    onClick={() => void tryRemove(topic.id)}
                  >
                    Quitar de mi progresión
                  </button>
                  <p style={{ color: "var(--muted)", margin: 0, fontSize: 13 }}>
                    {lockedTopic
                      ? "Esta ficha tiene una etapa completada (verde): no se puede quitar."
                      : "Se oculta de esta lista, pero no se pierde lo que marcaste o escribiste."}
                  </p>
                </div>
              )}
            </div>
          );
        })}
      </div>

      {social && (
        <div className="overlay" onClick={() => setSocial(null)}>
          <div className="auth-card" onClick={(event) => event.stopPropagation()}>
            <h2 style={{ marginTop: 0 }}>{socialTitle}</h2>
            {socialError && <p>{socialError}</p>}
            <div className="social-list">
              {social.map((person) => (
                <div key={person.alias} className="social-row">
                  <strong>{person.alias}</strong>
                  <span title={statusLabel(person.status)} style={{ display: "flex", alignItems: "center", gap: 6 }}>
                    <StatusGlyph status={topicStatus([person.status])} />
                    {statusLabel(person.status)}
                  </span>
                </div>
              ))}
              {!socialError && social.length === 0 && <p>Todavía no hay otros protagonistas en este tema.</p>}
            </div>
            <button className="primary" type="button" onClick={() => setSocial(null)}>Cerrar</button>
          </div>
        </div>
      )}
    </Shell>
  );
}
