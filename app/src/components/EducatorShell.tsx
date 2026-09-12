import { useEffect, useRef, useState, type ReactNode } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useStore } from "../store";
import { Avatar } from "./Avatar";
import { IconMenu } from "./Icons";

export function EducatorShell({ title, children }: { title?: string; children: ReactNode }) {
  const { session, logout, changeAvatar, setError, error } = useStore();
  const [menuOpen, setMenuOpen] = useState(false);
  const [photoOpen, setPhotoOpen] = useState(false);
  const fileRef = useRef<HTMLInputElement>(null);
  const navigate = useNavigate();

  useEffect(() => {
    if (!menuOpen && !photoOpen) return;
    const onKey = (event: KeyboardEvent) => {
      if (event.key === "Escape") {
        setMenuOpen(false);
        setPhotoOpen(false);
      }
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [menuOpen, photoOpen]);

  if (!session) return null;
  const { user } = session;

  async function onPickAvatar(file: File | undefined) {
    if (!file) return;
    try {
      await changeAvatar(file);
      setPhotoOpen(false);
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo cambiar la foto");
    }
  }

  return (
    <div className="edu-shell">
      <header className="edu-topbar">
        <button className="icon-btn" type="button" aria-label="Menú" onClick={() => setMenuOpen(true)}>
          <IconMenu />
        </button>
        <div className="brand">{title || "Educador"}</div>
        <Avatar alias={user.alias} avatar={user.avatar} onClick={() => setPhotoOpen(true)} />
      </header>
      <main className="edu-page">
        {error && <p className="error">{error}</p>}
        {children}
      </main>

      {menuOpen && (
        <>
          <div className="menu-backdrop" onClick={() => setMenuOpen(false)} />
          <aside className="menu" role="dialog" aria-label="Menú educador">
            <div className="menu-user">
              <Avatar
                alias={user.alias}
                avatar={user.avatar}
                onClick={() => {
                  setMenuOpen(false);
                  setPhotoOpen(true);
                }}
              />
              <div>
                <strong>{user.alias}</strong>
                <div>Educador</div>
              </div>
            </div>
            <nav>
              <Link to="/educador" onClick={() => setMenuOpen(false)}>Inicio</Link>
              <Link to="/educador/protagonistas" onClick={() => setMenuOpen(false)}>Protagonistas</Link>
              <Link to="/educador/fichas" onClick={() => setMenuOpen(false)}>Fichas</Link>
              <Link to="/educador/perfil" onClick={() => setMenuOpen(false)}>Perfil</Link>
              <button
                type="button"
                className="menu-link"
                onClick={async () => {
                  setMenuOpen(false);
                  await logout();
                  navigate("/");
                }}
              >
                Cerrar sesión
              </button>
            </nav>
          </aside>
        </>
      )}

      {photoOpen && (
        <div className="overlay" onClick={() => setPhotoOpen(false)}>
          <div onClick={(event) => event.stopPropagation()}>
            <div className="overlay-photo">
              {user.avatar ? (
                <img src={user.avatar} alt={user.alias} />
              ) : (
                <span style={{ fontSize: 72 }}>{user.alias.slice(0, 1).toUpperCase()}</span>
              )}
            </div>
            <button className="primary" type="button" onClick={() => fileRef.current?.click()}>
              Cambiar foto
            </button>
            <input
              ref={fileRef}
              className="hidden-file"
              type="file"
              accept="image/*"
              onChange={(event) => onPickAvatar(event.target.files?.[0])}
            />
          </div>
        </div>
      )}
    </div>
  );
}
