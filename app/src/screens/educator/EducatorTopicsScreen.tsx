import { useCallback, useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { api } from "../../api";
import { EducatorShell } from "../../components/EducatorShell";
import { IconView } from "../../components/Icons";
import { Pagination } from "../../components/Pagination";
import { useStore } from "../../store";
import type { EducatorTopic } from "../../types";

export function EducatorTopicsScreen() {
  const { session, catalog } = useStore();
  const [q, setQ] = useState("");
  const [search, setSearch] = useState("");
  const [areaId, setAreaId] = useState("");
  const [page, setPage] = useState(1);
  const [total, setTotal] = useState(0);
  const [items, setItems] = useState<EducatorTopic[]>([]);
  const [error, setError] = useState<string | null>(null);

  const load = useCallback(async () => {
    if (!session) return;
    setError(null);
    try {
      const result = await api.educatorTopics(session.token, {
        q: search,
        page,
        areaId: areaId || undefined,
      });
      setItems(result.items);
      setTotal(result.total);
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo cargar");
    }
  }, [session, search, page, areaId]);

  useEffect(() => {
    void load();
  }, [load]);

  return (
    <EducatorShell title="Fichas">
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
          placeholder="Buscar ficha"
        />
        <select
          value={areaId}
          onChange={(event) => {
            setPage(1);
            setAreaId(event.target.value);
          }}
        >
          <option value="">Todas las áreas</option>
          {(catalog?.areas || []).map((area) => (
            <option key={area.id} value={area.id}>{area.name}</option>
          ))}
        </select>
        <button className="primary" type="submit">Buscar</button>
      </form>

      {error && <p className="error">{error}</p>}

      <div className="edu-table-wrap">
        <table className="edu-table">
          <thead>
            <tr>
              <th>Ficha</th>
              <th>Área</th>
              <th>En progresión</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            {items.map((item) => (
              <tr key={item.id}>
                <td>{item.title}</td>
                <td>
                  <span className="edu-area-dot" style={{ background: item.areaColor }} />
                  {item.areaName}
                </td>
                <td>{item.protagonistas}</td>
                <td>
                  <Link
                    className="edu-icon-btn"
                    to={`/educador/fichas/${item.id}`}
                    title="Ver detalle"
                    aria-label="Ver detalle"
                  >
                    <IconView />
                  </Link>
                </td>
              </tr>
            ))}
            {items.length === 0 && (
              <tr>
                <td colSpan={4}>No hay fichas para mostrar.</td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <Pagination page={page} pageSize={20} total={total} onPage={setPage} />
    </EducatorShell>
  );
}
