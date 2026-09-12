/** Insignias de etapa Caminantes (rombo + elementos). */

export const INSIGNIAS = [
  {
    id: "sur",
    place: "top",
    cardinal: "Sur",
    element: "Tierra",
    colorHint: "verde",
    src: "/insignias/sur.png",
  },
  {
    id: "oeste",
    place: "right",
    cardinal: "Oeste",
    element: "Aire",
    colorHint: "violeta",
    src: "/insignias/oeste.png",
  },
  {
    id: "norte",
    place: "bottom",
    cardinal: "Norte",
    element: "Fuego",
    colorHint: "rojo",
    src: "/insignias/norte.png",
  },
  {
    id: "este",
    place: "left",
    cardinal: "Este",
    element: "Agua",
    colorHint: "azul",
    src: "/insignias/este.png",
  },
] as const;

export type InsigniaId = (typeof INSIGNIAS)[number]["id"];

export function getInsignia(id: string) {
  return INSIGNIAS.find((item) => item.id === id) || null;
}

export function stageFromAwardCount(count: number) {
  const n = Math.max(0, Math.min(4, Number(count) || 0));
  if (n === 0) {
    return { stage: 0, label: "Integración", shortLabel: "Integración" };
  }
  return { stage: n, label: `Etapa ${n}`, shortLabel: `Etapa ${n}` };
}
