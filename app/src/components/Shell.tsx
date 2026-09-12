import { useEffect, useRef, useState, type ReactNode } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useStore } from "../store";
import { Avatar } from "./Avatar";
import { BadgeDiamond } from "./BadgeDiamond";
import { IconMenu } from "./Icons";

export function Shell({ title, children }: { title?: string; children: ReactNode }) {
  const { session, online, syncing, logout, changeAvatar, setError, error } = useStore();
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
    <div className="app-shell">
      <BadgeDiamond />
      <header className="topbar">
        <button className="icon-btn" type="button" aria-label="Menú" onClick={() => setMenuOpen(true)}>
          <IconMenu />
        </button>
        <div className="brand">{title || "Huella Thaqu"}</div>
        <Avatar alias={user.alias} avatar={user.avatar} onClick={() => setPhotoOpen(true)} />
      </header>
      <div className="status-pill">
        {!online ? "Sin conexión: tus marcas se guardan en el celular" : syncing ? "Sincronizando…" : "En línea"}
      </div>
      <main className="page">
        {error && <p className="error">{error}</p>}
        {children}
      </main>

      {menuOpen && (
        <>
          <div className="menu-backdrop" onClick={() => setMenuOpen(false)} />
          <aside className="menu" role="dialog" aria-label="Menú">
            <div className="menu-user">
              <Avatar alias={user.alias} avatar={user.avatar} onClick={() => { setMenuOpen(false); setPhotoOpen(true); }} />
              <div>
                <strong>{user.alias}</strong>
                <div>{user.role === "educador" ? "Educador" : "Protagonista"}</div>
              </div>
            </div>
            <nav>
              <Link to="/" onClick={() => setMenuOpen(false)}>Inicio</Link>
              <Link to="/areas" onClick={() => setMenuOpen(false)}>Áreas</Link>
              <Link to="/progresion" onClick={() => setMenuOpen(false)}>Mi progresión</Link>
              <Link to="/perfil" onClick={() => setMenuOpen(false)}>Perfil</Link>
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
              {user.avatar ? <img src={user.avatar} alt={user.alias} /> : <span style={{ fontSize: 72 }}>{user.alias.slice(0, 1).toUpperCase()}</span>}
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
