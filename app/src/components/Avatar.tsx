type Props = {
  alias: string;
  avatar?: string | null;
  onClick?: () => void;
  className?: string;
};

export function Avatar({ alias, avatar, onClick, className }: Props) {
  const initial = alias.trim().slice(0, 1).toUpperCase() || "P";
  const inner = avatar ? <img src={avatar} alt={alias} /> : <span>{initial}</span>;
  if (onClick) {
    return (
      <button type="button" className={`avatar ${className || ""}`} onClick={onClick} aria-label="Ver foto">
        {inner}
      </button>
    );
  }
  return <div className={`avatar ${className || ""}`}>{inner}</div>;
}
