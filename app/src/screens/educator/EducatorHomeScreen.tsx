import { Link } from "react-router-dom";
import { EducatorShell } from "../../components/EducatorShell";
import { useStore } from "../../store";

export function EducatorHomeScreen() {
  const { session } = useStore();
  return (
    <EducatorShell title="Educador">
      <section className="hero-card">
        <h1>Hola, {session?.user.alias}</h1>
        <p>Seguimiento de protagonistas y fichas de la Comunidad Caminante.</p>
        <div className="home-actions">
          <Link className="big-link" to="/educador/protagonistas">Protagonistas</Link>
          <Link className="big-link" to="/educador/fichas">Fichas</Link>
        </div>
      </section>
    </EducatorShell>
  );
}
