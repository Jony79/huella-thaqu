import { Link } from "react-router-dom";
import { Shell } from "../components/Shell";
import { useStore } from "../store";

export function HomeScreen() {
  const { session } = useStore();
  return (
    <Shell>
      <section className="hero-card">
        <h1>Hola, {session?.user.alias}</h1>
        <p>Tu huella en el camino. Marcá lo que te gusta, elegí objetivos y avanzá a tu ritmo.</p>
        <div className="home-actions">
          <Link className="big-link" to="/areas">Áreas</Link>
          <Link className="big-link" to="/progresion">Mi progresión</Link>
        </div>
      </section>
    </Shell>
  );
}
