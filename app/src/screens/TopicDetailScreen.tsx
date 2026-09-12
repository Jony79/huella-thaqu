import { useParams } from "react-router-dom";
import { IconHeart } from "../components/Icons";
import { Shell } from "../components/Shell";
import { topicHasGreen } from "../stages";
import { useStore } from "../store";
import { topicHeading } from "../topicLabel";

export function TopicDetailScreen() {
  const { areaId, topicId } = useParams();
  const { catalog, likes, topicStageEvals, toggleLike, setError } = useStore();
  const area = catalog?.areas.find((item) => item.id === areaId);
  const topic = area?.topics.find((item) => item.id === topicId);

  if (!topic || !area) {
    return (
      <Shell title="Tema">
        <p>Este tema todavía no está en el celular. Abrí la app con datos para bajar el catálogo.</p>
      </Shell>
    );
  }

  const liked = likes[topic.id]?.liked;

  return (
    <Shell title={area.name}>
      <div className="stack">
        <div className="topic-row">
          <h2 style={{ margin: 0, flex: 1 }}>{topicHeading(topic)}</h2>
          <button
            type="button"
            className={`heart ${liked ? "on" : ""}`}
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
        <p className="topic-body">{topic.body}</p>
        <h3>Actividades sugeridas</h3>
        {topic.activities.map((activity) => (
          <div key={activity.id} className="activity">{activity.title}</div>
        ))}
      </div>
    </Shell>
  );
}
