import { useState, type FormEvent } from "react";
import { ApiError } from "../api";
import { useStore } from "../store";

type Step = "dni" | "register" | "login";
type Tipo = "protagonista" | "educador";

export function AuthScreen() {
  const { checkDni, register, login, error, setError } = useStore();
  const [step, setStep] = useState<Step>("dni");
  const [dni, setDni] = useState("");
  const [tipo, setTipo] = useState<Tipo>("protagonista");
  const [alias, setAlias] = useState("");
  const [password, setPassword] = useState("");
  const [busy, setBusy] = useState(false);

  const rolLabel = tipo === "educador" ? "educador" : "protagonista";

  async function onDni(event: FormEvent) {
    event.preventDefault();
    setBusy(true);
    setError(null);
    try {
      const result = await checkDni(dni);
      setDni(result.dni);
      setTipo(result.tipo || "protagonista");
      setStep(result.registered ? "login" : "register");
    } catch (err) {
      setError(err instanceof ApiError ? err.message : "No se pudo validar el DNI. ¿Tenés datos?");
    } finally {
      setBusy(false);
    }
  }

  async function onRegister(event: FormEvent) {
    event.preventDefault();
    setBusy(true);
    setError(null);
    try {
      await register(dni, alias, password);
    } catch (err) {
      setError(err instanceof ApiError ? err.message : "No se pudo crear el perfil");
    } finally {
      setBusy(false);
    }
  }

  async function onLogin(event: FormEvent) {
    event.preventDefault();
    setBusy(true);
    setError(null);
    try {
      await login(dni, password);
    } catch (err) {
      setError(err instanceof ApiError ? err.message : "No se pudo entrar");
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="auth-wrap">
      <div className="auth-card">
        <h1>Huella Thaqu</h1>
        <p>Caminantes. En este dispositivo te vamos a recordar.</p>

        {error && <p className="error">{error}</p>}

        {step === "dni" && (
          <form className="stack" onSubmit={onDni}>
            <label>
              DNI
              <input
                inputMode="numeric"
                autoComplete="username"
                value={dni}
                onChange={(e) => setDni(e.target.value)}
                placeholder="Solo números"
                required
              />
            </label>
            <button className="primary" type="submit" disabled={busy}>
              {busy ? "Validando…" : "Continuar"}
            </button>
          </form>
        )}

        {step === "register" && (
          <form className="stack" onSubmit={onRegister}>
            <p>
              DNI habilitado como <strong>{rolLabel}</strong>. Elegí tu alias y una contraseña
              (la vas a necesitar en otro dispositivo).
            </p>
            <label>
              Alias
              <input value={alias} onChange={(e) => setAlias(e.target.value)} minLength={3} maxLength={20} required />
            </label>
            <label>
              Contraseña
              <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} minLength={6} required />
            </label>
            <button className="primary" type="submit" disabled={busy}>
              {busy ? "Guardando…" : "Crear perfil"}
            </button>
            <button className="ghost" type="button" onClick={() => setStep("dni")}>Volver</button>
          </form>
        )}

        {step === "login" && (
          <form className="stack" onSubmit={onLogin}>
            <p>Este DNI ya tiene perfil. En un dispositivo nuevo pedimos la contraseña.</p>
            <label>
              Contraseña
              <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} required />
            </label>
            <button className="primary" type="submit" disabled={busy}>
              {busy ? "Entrando…" : "Entrar"}
            </button>
            <button className="ghost" type="button" onClick={() => setStep("dni")}>Volver</button>
            <p>
              {tipo === "educador"
                ? "Si la olvidaste, pedile el reset a otro educador o al administrador."
                : "Si la olvidaste, pedile el reset a un educador."}
            </p>
          </form>
        )}
      </div>
    </div>
  );
}
