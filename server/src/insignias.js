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
];

export const INSIGNIA_IDS = INSIGNIAS.map((item) => item.id);

export function isInsigniaId(value) {
  return INSIGNIA_IDS.includes(value);
}

export function getInsignia(id) {
  return INSIGNIAS.find((item) => item.id === id) || null;
}

/** 0 = Integración; 1–4 = Etapa N según cantidad de insignias otorgadas. */
export function stageFromAwardCount(count) {
  const n = Math.max(0, Math.min(4, Number(count) || 0));
  if (n === 0) {
    return { stage: 0, label: "Integración", shortLabel: "Integración" };
  }
  return { stage: n, label: `Etapa ${n}`, shortLabel: `Etapa ${n}` };
}
