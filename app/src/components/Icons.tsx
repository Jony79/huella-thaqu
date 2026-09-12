import type { Status } from "../types";

export function IconMenu() {
  return (
    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" strokeWidth="2">
      <path d="M4 7h16M4 12h16M4 17h16" />
    </svg>
  );
}

export function IconHeart({ on }: { on?: boolean }) {
  return (
    <svg viewBox="0 0 24 24" width="26" height="26" fill={on ? "currentColor" : "none"} stroke="currentColor" strokeWidth="2">
      <path d="M12 20s-7-4.4-9.2-8.2C1.2 9 2.4 6 5.4 5.4 7.2 5 8.8 5.8 12 8.6c3.2-2.8 4.8-3.6 6.6-3.2 3 .6 4.2 3.6 2.6 6.4C19 15.6 12 20 12 20z" />
    </svg>
  );
}

export function IconPeople() {
  return (
    <svg viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" strokeWidth="2">
      <circle cx="9" cy="8" r="3" />
      <path d="M3 19c.5-3 2.8-5 6-5s5.5 2 6 5" />
      <circle cx="17" cy="9" r="2.4" />
      <path d="M16 14.2c2.4.4 4.2 2 4.7 4.3" />
    </svg>
  );
}

export function IconGoal() {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
      <circle cx="12" cy="12" r="8" />
      <circle cx="12" cy="12" r="4" />
      <circle cx="12" cy="12" r="1.2" fill="currentColor" />
    </svg>
  );
}

export function IconDoing() {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
      <path d="M8 6.5v11L19 12 8 6.5z" fill="currentColor" stroke="none" />
    </svg>
  );
}

export function IconDone() {
  return (
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.4">
      <path d="M5 12.5 10 17.5 19 7" />
    </svg>
  );
}

export function IconView() {
  return (
    <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" strokeWidth="2">
      <path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" />
      <circle cx="12" cy="12" r="3" />
    </svg>
  );
}

export function IconKey() {
  return (
    <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" strokeWidth="2">
      <circle cx="8" cy="14" r="3.5" />
      <path d="M11 12.5 20 3.5M16.5 4.5l3 3" />
    </svg>
  );
}

export function IconDisable() {
  return (
    <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" strokeWidth="2">
      <circle cx="12" cy="12" r="8" />
      <path d="M7 7l10 10" />
    </svg>
  );
}

export function IconEnable() {
  return (
    <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" strokeWidth="2">
      <path d="M5 12.5 10 17.5 19 7" />
    </svg>
  );
}

export function StatusGlyph({ status }: { status: Status }) {
  if (status === "goal") return <IconGoal />;
  if (status === "doing") return <IconDoing />;
  if (status === "done") return <IconDone />;
  return <IconHeart />;
}

export function statusLabel(status: Status) {
  if (status === "goal") return "Objetivo";
  if (status === "doing") return "Haciendo";
  if (status === "done") return "Alcanzado";
  return "Sin marcar";
}
