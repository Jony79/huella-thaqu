import { useCallback, useEffect, useMemo, useState } from "react";
import { Link, useParams } from "react-router-dom";
import { api } from "../../api";
import { ConfirmModal } from "../../components/ConfirmModal";
import { EducatorShell } from "../../components/EducatorShell";
import { ProgressionView } from "../../components/ProgressionView";
import { INSIGNIAS, type InsigniaId } from "../../insignias";
import { STAGE_NUMBERS } from "../../stages";
import { useStore } from "../../store";
import type {
  LikeRow,
  NoteRow,
  ProgressRow,
  StageNumber,
  TopicStageEval,
} from "../../types";

export function EducatorProtagonistProgressionScreen() {
  const { personId } = useParams();
  const { session, catalog } = useStore();
  const [alias, setAlias] = useState("");
  const [likes, setLikes] = useState<Record<string, LikeRow>>({});
  const [progress, setProgress] = useState<Record<string, ProgressRow>>({});
  const [notes, setNotes] = useState<Record<string, NoteRow>>({});
  const [awarded, setAwarded] = useState<string[]>([]);
  const [stageLabel, setStageLabel] = useState("Integración");
  const [progressionStage, setProgressionStage] = useState(0);
  const [topicStageEvals, setTopicStageEvals] = useState<TopicStageEval[]>([]);
  const [closedStages, setClosedStages] = useState<StageNumber[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [pending, setPending] = useState<InsigniaId | null>(null);
  const [pendingClose, setPendingClose] = useState<StageNumber | null>(null);
  const [busy, setBusy] = useState(false);

  const load = useCallback(async () => {
    if (!session || !personId) return;
    setError(null);
    try {
      const data = await api.educatorProgression(session.token, Number(personId));
      setAlias(data.user.alias);
      setLikes(Object.fromEntries(data.likes.map((row) => [row.topicId, row])));
      setProgress(Object.fromEntries(data.progress.map((row) => [row.activityId, row])));
      setNotes(Object.fromEntries(data.notes.map((row) => [row.topicId, row])));
      setAwarded(data.awardedInsigniaIds || []);
      setStageLabel(data.progression?.label || "Integración");
      setProgressionStage(data.progression?.stage || 0);
      setTopicStageEvals(data.topicStageEvals || []);
      setClosedStages(data.closedStages || []);
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo cargar");
    }
  }, [session, personId]);

  useEffect(() => {
    void load();
  }, [load]);

  const title = useMemo(() => (alias ? `Progresión · ${alias}` : "Progresión"), [alias]);
  const pendingMeta = pending ? INSIGNIAS.find((item) => item.id === pending) : null;
  const pendingAwarded = pending ? awarded.includes(pending) : false;
  const evaluationEnabled = progressionStage > 0;

  async function confirmToggle() {
    if (!session || !personId || !pending) return;
    setBusy(true);
    try {
      const result = await api.educatorToggleInsignia(session.token, Number(personId), pending);
      setAwarded(result.awardedInsigniaIds);
      setStageLabel(result.progression.label);
      setProgressionStage(result.progression.stage);
      setPending(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo actualizar la insignia");
    } finally {
      setBusy(false);
    }
  }

  async function cycleStage(topicId: string, stage: StageNumber) {
    if (!session || !personId) return;
    setError(null);
    try {
      const result = await api.educatorCycleTopicStage(
        session.token,
        Number(personId),
        topicId,
        stage,
      );
      setTopicStageEvals((prev) => {
        const others = prev.filter((e) => !(e.topicId === topicId && e.stage === stage));
        if (!result.status) return others;
        return [
          ...others,
          { topicId, stage, status: result.status, updatedAt: new Date().toISOString() },
        ];
      });
      setProgress((prev) => {
        const next = { ...prev };
        for (const row of result.progress) {
          next[row.activityId] = row;
        }
        return next;
      });
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo actualizar la bolita");
    }
  }

  async function confirmCloseStage() {
    if (!session || !personId || !pendingClose) return;
    setBusy(true);
    try {
      const result = await api.educatorCloseStage(session.token, Number(personId), pendingClose);
      setClosedStages(result.closedStages);
      setPendingClose(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo cerrar la etapa");
    } finally {
      setBusy(false);
    }
  }

  return (
    <EducatorShell title={title}>
      <div className="edu-toolbar">
        <Link className="ghost" to="/educador/protagonistas">← Volver</Link>
        <span className="edu-readonly">{stageLabel} · fichas solo lectura</span>
      </div>

      <div className="edu-insignia-bar" role="group" aria-label="Insignias de etapa">
        {(["sur", "este", "norte", "oeste"] as InsigniaId[]).map((id) => {
          const badge = INSIGNIAS.find((item) => item.id === id)!;
          const on = awarded.includes(badge.id);
          return (
            <button
              key={badge.id}
              type="button"
              className={`edu-insignia-btn ${on ? "awarded" : ""}`}
              title={`${badge.element} (${badge.cardinal})`}
              aria-label={`${on ? "Quitar" : "Otorgar"} ${badge.element}`}
              onClick={() => setPending(badge.id)}
            >
              <img src={badge.src} alt="" />
              <span>{badge.element}</span>
            </button>
          );
        })}
      </div>

      <div className="edu-close-stages">
        <span className="edu-close-label">Cerrar etapa</span>
        {STAGE_NUMBERS.map((stage) => {
          const closed = closedStages.includes(stage);
          return (
            <button
              key={stage}
              type="button"
              className={`ghost ${closed ? "is-off" : ""}`}
              disabled={!evaluationEnabled || closed}
              title={closed ? `Etapa ${stage} ya cerrada` : `Cerrar Etapa ${stage}`}
              onClick={() => setPendingClose(stage)}
            >
              {closed ? `E${stage} ✓` : `E${stage}`}
            </button>
          );
        })}
      </div>

      {!evaluationEnabled && (
        <p className="edu-hint">En Integración las bolitas de fichas están deshabilitadas.</p>
      )}

      {error && <p className="error">{error}</p>}

      <ProgressionView
        catalog={catalog}
        likes={likes}
        progress={progress}
        notes={notes}
        topicStageEvals={topicStageEvals}
        closedStages={closedStages}
        evaluationEnabled={evaluationEnabled}
        readOnly
        emptyText="Sin fichas elegidas. Cuando marque me gusta en Áreas, van a aparecer acá."
        onCycleStage={cycleStage}
      />

      <ConfirmModal
        open={Boolean(pendingMeta)}
        title={pendingAwarded ? `Quitar ${pendingMeta?.element}` : `Otorgar ${pendingMeta?.element}`}
        message={
          pendingAwarded
            ? `¿Estás seguro de que querés deshabilitar ${pendingMeta?.element} (${pendingMeta?.cardinal}) para ${alias}? La etapa se recalcula sola.`
            : `¿Estás seguro de que querés marcar ${pendingMeta?.element} (${pendingMeta?.cardinal}) para ${alias}? La etapa se recalcula sola.`
        }
        confirmLabel={pendingAwarded ? "Deshabilitar" : "Marcar"}
        busy={busy}
        onConfirm={() => void confirmToggle()}
        onCancel={() => setPending(null)}
      />

      <ConfirmModal
        open={Boolean(pendingClose)}
        title={`Cerrar Etapa ${pendingClose}`}
        message={`¿Cerrar la Etapa ${pendingClose} para ${alias}? No se podrá volver a abrir ni cambiar bolitas de esa etapa.`}
        confirmLabel="Cerrar etapa"
        busy={busy}
        onConfirm={() => void confirmCloseStage()}
        onCancel={() => setPendingClose(null)}
      />
    </EducatorShell>
  );
}
