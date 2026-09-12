import { Link } from "react-router-dom";
import { Shell } from "../components/Shell";
import { useStore } from "../store";

export function AreasScreen() {
  const { catalog } = useStore();
  return (
    <Shell title="Áreas">
      <div className="stack">
        {(catalog?.areas || []).map((area) => (
          <Link key={area.id} className="area-btn" to={`/areas/${area.id}`} style={{ background: area.color }}>
            {area.name}
          </Link>
        ))}
      </div>
    </Shell>
  );
}
