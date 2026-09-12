type Props = {
  open: boolean;
  title: string;
  message: string;
  confirmLabel?: string;
  cancelLabel?: string;
  busy?: boolean;
  onConfirm: () => void;
  onCancel: () => void;
};

export function ConfirmModal({
  open,
  title,
  message,
  confirmLabel = "Confirmar",
  cancelLabel = "Cancelar",
  busy = false,
  onConfirm,
  onCancel,
}: Props) {
  if (!open) return null;
  return (
    <div className="overlay" onClick={onCancel}>
      <div className="auth-card" onClick={(event) => event.stopPropagation()} role="dialog" aria-modal="true">
        <h2 style={{ marginTop: 0 }}>{title}</h2>
        <p>{message}</p>
        <div className="actions">
          <button className="primary" type="button" disabled={busy} onClick={onConfirm}>
            {busy ? "Guardando…" : confirmLabel}
          </button>
          <button className="ghost" type="button" disabled={busy} onClick={onCancel}>
            {cancelLabel}
          </button>
        </div>
      </div>
    </div>
  );
}
