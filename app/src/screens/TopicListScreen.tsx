import { Link, useParams } from "react-router-dom";
import { IconHeart } from "../components/Icons";
import { Shell } from "../components/Shell";
import { topicHasGreen } from "../stages";
import { useStore } from "../store";
import { topicHeading } from "../topicLabel";

export function TopicListScreen() {
  const { areaId } = useParams();
  const { catalog, likes, topicStageEvals, toggleLike, setError } = useStore();
  const area = catalog?.areas.find((item) => item.id === areaId);

  return (
    <Shell title={area?.name || "Área"}>
      <div className="stack">
        {area?.topics.map((topic) => {
          const liked = likes[topic.id]?.liked;
          return (
            <div key={topic.id} className="topic-row">
              <Link to={`/areas/${area.id}/temas/${topic.id}`}>{topicHeading(topic)}</Link>
              <button
                type="button"
                className={`heart ${liked ? "on" : ""}`}
                aria-label="Me gusta"
                title={
                  liked && topicHasGreen(topicStageEvals, topic.id)
                    ? "Ficha completada: no se puede quitar"
                    : "Me gusta"
                }
                onClick={() => {
                  void toggleLike(topic.id).catch((err) =>
                    setError(err instanceof Error ? err.message : "No se pudo actualizar"),
                  );
                }}
              >
                <IconHeart on={liked} />
              </button>
            </div>
          );
        })}
      </div>
    </Shell>
  );
}
