import { useCallback, useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import { api } from "../../api";
import { EducatorShell } from "../../components/EducatorShell";
import { Pagination } from "../../components/Pagination";
import { useStore } from "../../store";
import type { BallColor, StageBalls } from "../../types";

type Row = {
  personId: number;
  alias: string;
  balls: StageBalls;
};

const LABELS = [
  { key: "e1" as const, label: "E1" },
  { key: "e2" as const, label: "E2" },
  { key: "e3" as const, label: "E3" },
  { key: "e4" as const, label: "E4" },
];

export function EducatorTopicDetailScreen() {
  const { topicId } = useParams();
  const { session } = useStore();
  const [title, setTitle] = useState("Ficha");
  const [q, setQ] = useState("");
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [total, setTotal] = useState(0);
  const [items, setItems] = useState<Row[]>([]);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!session || !topicId) return;
    setError(null);
    try {
      const result = await api.educatorTopicProtagonists(session.token, topicId, {
        q: search,
        page,
      });
      setTitle(result.topic.title);
      setItems(result.items);
      setTotal(result.total);
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo cargar");
    }
  }, [session, topicId, search, page]);

  useEffect(() => {
    void load();
  }, [load]);

  return (
    <EducatorShell title="Detalle de ficha">
      <div className="edu-toolbar">
        <Link className="ghost" to="/educador/fichas">← Volver</Link>
      </div>
      <h2 className="edu-h2">{title}</h2>

      <form
        className="edu-toolbar"
        onSubmit={(event) => {
          event.preventDefault();
          setPage(1);
          setSearch(q.trim());
        }}
      >
        <input
          value={q}
          onChange={(event) => setQ(event.target.value)}
          placeholder="Buscar alias"
        />
        <button className="primary" type="submit">Buscar</button>
      </form>

      {error && <p className="error">{error}</p>}

      <div className="edu-table-wrap">
        <table className="edu-table">
          <thead>
            <tr>
              <th>Alias</th>
              {LABELS.map((item) => (
                <th key={item.key}>{item.label}</th>
              ))}
            </tr>
          </thead>
          <tbody>
            {items.map((item) => (
              <tr key={item.personId}>
                <td>
                  <Link to={`/educador/protagonistas/${item.personId}`}>{item.alias}</Link>
                </td>
                {LABELS.map(({ key }) => {
                  const color = (item.balls[key] || "gray") as BallColor;
                  return (
                    <td key={key} className="edu-ball-cell">
                      <span className={`edu-ball ${color}`} title={`${key}: ${color}`} />
                    </td>
                  );
                })}
              </tr>
            ))}
            {items.length === 0 && (
              <tr>
                <td colSpan={5}>Nadie tiene esta ficha en progresión todavía.</td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <Pagination page={page} pageSize={20} total={total} onPage={setPage} />
      <p className="edu-hint">
        Bolitas E1–E4: gris (sin marcar), amarillo (en progreso), verde (completada).
      </p>
    </EducatorShell>
  );
}
