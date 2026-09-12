import { useRef, useState, type FormEvent } from "react";
import { useNavigate } from "react-router-dom";
import { Avatar } from "../components/Avatar";
import { EducatorShell } from "../components/EducatorShell";
import { Shell } from "../components/Shell";
import { useStore } from "../store";

export function ProfileScreen() {
  const { session, changePassword, changeAvatar, setError, error } = useStore();
  const [password, setPassword] = useState("");
  const [message, setMessage] = useState<string | null>(null);
  const fileRef = useRef<HTMLInputElement>(null);
  const navigate = useNavigate();

  if (!session) return null;

  const isEducator = session.user.role === "educador";
  const Wrapper = isEducator ? EducatorShell : Shell;

  async function save(event: FormEvent) {
    event.preventDefault();
    setError(null);
    setMessage(null);
    try {
      if (password) await changePassword(password);
      setPassword("");
      setMessage(password ? "Contraseña actualizada." : "No había cambios de contraseña.");
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo guardar");
    }
  }

  return (
    <Wrapper title="Perfil">
      <form className="stack" onSubmit={save}>
        <div style={{ display: "grid", justifyItems: "center", gap: 10 }}>
          <Avatar
            alias={session.user.alias}
            avatar={session.user.avatar}
            onClick={() => fileRef.current?.click()}
          />
          <strong>{session.user.alias}</strong>
          <span>{isEducator ? "Educador" : "Protagonista"}</span>
        </div>
        {error && <p className="error">{error}</p>}
        {message && <p>{message}</p>}
        <label>
          Nueva contraseña
          <input
            type="password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="Dejala vacía para no cambiarla"
            minLength={6}
          />
        </label>
        <div className="actions">
          <button className="primary" type="submit">Guardar</button>
          <button className="ghost" type="button" onClick={() => navigate(-1)}>Cancelar</button>
        </div>
        <input
          ref={fileRef}
          className="hidden-file"
          type="file"
          accept="image/*"
          onChange={(event) => {
            const file = event.target.files?.[0];
            if (file) void changeAvatar(file).catch((err) => setError(err.message));
          }}
        />
      </form>
    </Wrapper>
  );
}
