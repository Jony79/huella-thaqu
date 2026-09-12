import { useCallback, useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { api } from "../../api";
import { ConfirmModal } from "../../components/ConfirmModal";
import { EducatorShell } from "../../components/EducatorShell";
import { IconDisable, IconEnable, IconKey, IconView } from "../../components/Icons";
import { Pagination } from "../../components/Pagination";
import { useStore } from "../../store";
import type { EducatorProtagonist } from "../../types";

function formatAccess(iso: string | null) {
  if (!iso) return "—";
  const date = new Date(iso);
  return date.toLocaleString("es-AR", {
    day: "2-digit",
    month: "2-digit",
    year: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  });
}

export function EducatorProtagonistsScreen() {
  const { session } = useStore();
  const [q, setQ] = useState("");
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [total, setTotal] = useState(0);
  const [items, setItems] = useState<EducatorProtagonist[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [tempPass, setTempPass] = useState<{ alias: string; password: string } | null>(null);
  const [busyId, setBusyId] = useState<number | null>(null);
  const [confirmToggle, setConfirmToggle] = useState<EducatorProtagonist | null>(null);
  const [confirmReset, setConfirmReset] = useState<EducatorProtagonist | null>(null);

  const load = useCallback(async () => {
    if (!session) return;
    setError(null);
    try {
      const result = await api.educatorProtagonists(session.token, { q: search, page });
      setItems(result.items);
      setTotal(result.total);
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo cargar");
    }
  }, [session, search, page]);

  useEffect(() => {
    void load();
  }, [load]);

  async function doResetPassword() {
    if (!session || !confirmReset?.userId) return;
    setBusyId(confirmReset.userId);
    try {
      const result = await api.educatorResetPassword(session.token, confirmReset.userId);
      setTempPass({ alias: confirmReset.alias || confirmReset.dni, password: result.temporaryPassword });
      setConfirmReset(null);
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo resetear");
    } finally {
      setBusyId(null);
    }
  }

  async function doToggleEnabled() {
    if (!session || !confirmToggle) return;
    setBusyId(confirmToggle.personId);
    try {
      await api.educatorToggleEnabled(session.token, confirmToggle.personId);
      setConfirmToggle(null);
      await load();
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo cambiar el estado");
    } finally {
      setBusyId(null);
    }
  }

  return (
    <EducatorShell title="Protagonistas">
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
          placeholder="Buscar por DNI, nombre o alias"
        />
        <button className="primary" type="submit">Buscar</button>
      </form>

      {error && <p className="error">{error}</p>}

      <div className="edu-table-wrap">
        <table className="edu-table">
          <thead>
            <tr>
              <th>DNI</th>
              <th>Nombre</th>
              <th>Alias</th>
              <th>Progresión</th>
              <th>Ult. Acceso</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            {items.map((item) => (
              <tr key={item.personId} className={item.habilitado ? "" : "is-disabled"}>
                <td>{item.dni}</td>
                <td>{item.nombre || "—"}</td>
                <td>{item.alias || "Sin cuenta"}</td>
                <td>{item.progressionLabel || "Integración"}</td>
                <td>{formatAccess(item.lastAccess)}</td>
                <td>
                  <div className="edu-actions">
                    <Link
                      className="edu-icon-btn"
                      to={`/educador/protagonistas/${item.personId}`}
                      title="Ver progresión"
                      aria-label="Ver"
                    >
                      <IconView />
                    </Link>
                    <button
                      type="button"
                      className="edu-icon-btn"
                      title="Reset password"
                      aria-label="Reset password"
                      disabled={!item.userId || busyId === item.userId}
                      onClick={() => setConfirmReset(item)}
                    >
                      <IconKey />
                    </button>
                    <button
                      type="button"
                      className={`edu-icon-btn ${item.habilitado ? "warn" : "ok"}`}
                      title={item.habilitado ? "Deshabilitar" : "Habilitar"}
                      aria-label={item.habilitado ? "Deshabilitar" : "Habilitar"}
                      disabled={busyId === item.personId}
                      onClick={() => setConfirmToggle(item)}
                    >
                      {item.habilitado ? <IconDisable /> : <IconEnable />}
                    </button>
                  </div>
                </td>
              </tr>
            ))}
            {items.length === 0 && (
              <tr>
                <td colSpan={6}>No hay protagonistas para mostrar.</td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <Pagination page={page} pageSize={20} total={total} onPage={setPage} />

      <ConfirmModal
        open={Boolean(confirmReset)}
        title="Resetear contraseña"
        message={`¿Resetear la contraseña de ${confirmReset?.alias || confirmReset?.dni}? Se cerrarán sus sesiones.`}
        confirmLabel="Resetear"
        busy={busyId === confirmReset?.userId}
        onConfirm={() => void doResetPassword()}
        onCancel={() => setConfirmReset(null)}
      />

      <ConfirmModal
        open={Boolean(confirmToggle)}
        title={confirmToggle?.habilitado ? "Deshabilitar" : "Habilitar"}
        message={`¿Querés ${confirmToggle?.habilitado ? "deshabilitar" : "habilitar"} a ${confirmToggle?.alias || confirmToggle?.nombre || confirmToggle?.dni}?`}
        confirmLabel={confirmToggle?.habilitado ? "Deshabilitar" : "Habilitar"}
        busy={busyId === confirmToggle?.personId}
        onConfirm={() => void doToggleEnabled()}
        onCancel={() => setConfirmToggle(null)}
      />

      {tempPass && (
        <div className="overlay" onClick={() => setTempPass(null)}>
          <div className="auth-card" onClick={(event) => event.stopPropagation()}>
            <h2 style={{ marginTop: 0 }}>Contraseña temporal</h2>
            <p>
              Para <strong>{tempPass.alias}</strong>. Anotala: no se vuelve a mostrar.
            </p>
            <p className="edu-temp-pass">{tempPass.password}</p>
            <button className="primary" type="button" onClick={() => setTempPass(null)}>Listo</button>
          </div>
        </div>
      )}
    </EducatorShell>
  );
}
