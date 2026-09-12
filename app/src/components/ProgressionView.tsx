import { useMemo, useState } from "react";
import { IconDoing, IconDone, IconGoal, statusLabel } from "./Icons";
import { ballsForTopic, STAGE_NUMBERS, stageTag } from "../stages";
import { topicHeading } from "../topicLabel";
import type {
  Area,
  LikeRow,
  NoteRow,
  ProgressRow,
  StageNumber,
  Status,
  TopicStageEval,
} from "../types";

type Props = {
  catalog: { areas: Area[] } | null;
  likes: Record<string, LikeRow>;
  progress: Record<string, ProgressRow>;
  notes: Record<string, NoteRow>;
  topicStageEvals?: TopicStageEval[];
  closedStages?: StageNumber[];
  evaluationEnabled?: boolean;
  readOnly?: boolean;
  emptyText?: string;
  onCycleStage?: (topicId: string, stage: StageNumber) => void | Promise<void>;
};

export function ProgressionView({
  catalog,
  likes,
  progress,
  notes,
  topicStageEvals = [],
  closedStages = [],
  evaluationEnabled = false,
  readOnly = false,
  emptyText = "Todavía no hay fichas en progresión.",
  onCycleStage,
}: Props) {
  const [openId, setOpenId] = useState<string | null>(null);
  const closed = useMemo(() => new Set(closedStages), [closedStages]);

  const items = useMemo(() => {
    if (!catalog) return [];
    return catalog.areas.flatMap((area) =>
      area.topics
        .filter((topic) => likes[topic.id]?.liked)
        .map((topic) => ({ area, topic })),
    );
  }, [catalog, likes]);

  return (
    <div className="stack">
      {items.length === 0 && <p>{emptyText}</p>}
      {items.map(({ area, topic }) => {
        const open = openId === topic.id;
        const topicEvals = topicStageEvals.filter((e) => e.topicId === topic.id);
        const balls = ballsForTopic(topicEvals);
        return (
          <div key={topic.id} className="card accordion">
            <button type="button" className="accordion-head" onClick={() => setOpenId(open ? null : topic.id)}>
              <span style={{ color: area.color }}>●</span>
              {topicHeading(topic)}
            </button>

            <div className="stage-balls" role="group" aria-label="Evaluación por etapa">
              {STAGE_NUMBERS.map((stage) => {
                const color = balls[stage];
                const stageClosed = closed.has(stage);
                const disabled = !evaluationEnabled || stageClosed || !onCycleStage;
                return (
                  <button
                    key={stage}
                    type="button"
                    className={`stage-ball ${color} ${disabled ? "is-disabled" : ""}`}
                    title={
                      stageClosed
                        ? `Etapa ${stage} cerrada`
                        : !evaluationEnabled
                          ? "Disponible desde Etapa 1"
                          : `Etapa ${stage}: ${color === "green" ? "completada" : color === "yellow" ? "en progreso" : "sin marcar"}`
                    }
                    disabled={disabled}
                    onClick={(event) => {
                      event.stopPropagation();
                      void onCycleStage?.(topic.id, stage);
                    }}
                  >
                    <span className={`edu-ball ${color}`} />
                    <span>E{stage}</span>
                  </button>
                );
              })}
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
                          <div
                            key={value}
                            className={`status-btn ${current === value ? "on" : ""} ${frozen ? "is-locked" : ""}`}
                            aria-disabled={readOnly || frozen}
                          >
                            {value === "goal" ? <IconGoal /> : value === "doing" ? <IconDoing /> : <IconDone />}
                            {statusLabel(value)}
                          </div>
                        ))}
                      </div>
                    </div>
                  );
                })}
                <label>
                  Notas
                  <textarea value={notes[topic.id]?.text || ""} readOnly={readOnly} placeholder={readOnly ? "Sin notas" : ""} />
                </label>
              </div>
            )}
          </div>
        );
      })}
    </div>
  );
}
