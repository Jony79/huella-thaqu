import { INSIGNIAS } from "../insignias";
import { useStore } from "../store";

export function BadgeDiamond() {
  const { awardedInsigniaIds } = useStore();

  return (
    <div className="badge-bg" aria-hidden="true">
      <div className="diamond">
        {/* Base siempre en gris: las no otorgadas se ven así */}
        <div className="badge-base">
          <img src="/insignias/completa.png" alt="" />
        </div>
        {/* Solo las otorgadas se superponen a color natural */}
        {INSIGNIAS.map((badge) => {
          if (!awardedInsigniaIds.includes(badge.id)) return null;
          return (
            <div key={badge.id} className={`badge-slot ${badge.place} awarded`}>
              <img src="/insignias/completa.png" alt={`${badge.element} (${badge.cardinal})`} />
            </div>
          );
        })}
      </div>
    </div>
  );
}
