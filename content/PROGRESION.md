# Progresión e insignias (Caminantes)

Resumen operativo. Fuente: Guía Caminantes + decisiones de producto Huella Thaqu.

## Modelo de datos

**Todo lo de progresión está atado a la persona del padrón (`people`), no a la cuenta (`users`).**

| Tabla | Clave / notas |
|-------|----------------|
| `likes` | `(person_id, topic_id)` — fichas en progresión |
| `action_progress` | `(person_id, activity_id)` + `locked_stage` (1–4 o null) |
| `topic_notes` | `(person_id, topic_id)` |
| `badge_awards` | `(person_id, insignia_id)` — insignias del rombo |
| `topic_stage_evals` | `(person_id, topic_id, stage)` status `in_progress` \| `done` |
| `stage_closures` | `(person_id, stage)` — etapa cerrada (no se reabre) |

## Insignias / etapa “oficial”

| Insignias | Etiqueta |
|-----------|----------|
| 0 | Integración |
| 1–4 | Etapa N |

Relación con fichas: **opción C** — cerrar etapa de fichas ≠ otorgar insignia automático. Hoy se otorgan insignias a mano (atraso).

## Bolitas E1–E4 (educador)

Bajo cada ficha en Ver progresión: gris / amarillo / verde.

- Solo si la ficha está en progresión (me gusta).
- En **Integración**: deshabilitadas.
- Ciclo libre mientras la etapa no esté cerrada: gris → amarillo → verde → gris.
- Al pasar a **verde**: fija acciones en **alcanzado** a esa etapa (`locked_stage`).
- Al salir de verde: libera esas acciones.
- **Cualquier verde** ⇒ el protagonista no puede quitar la ficha.
- **Cerrar etapa**: acción explícita; bolitas de esa etapa quedan solo lectura.

## Acciones del protagonista

- Autoevaluación: objetivo / haciendo / alcanzado.
- Si la ficha está **amarilla**: puede cambiar todo (incluso alcanzado).
- Si está **verde**: las alcanzadas fijadas quedan grises + tag `E1`…`E4` (también en vista educador); objetivo/haciendo siguen editables.
- Misma ficha puede usarse en E1 (verde), no en E2 (gris) y sí en E3 (amarilla).

## Rombo

| ID | Cardinal | Elemento | Posición |
|----|----------|----------|----------|
| `norte` | Norte | Fuego | abajo |
| `sur` | Sur | Tierra | arriba |
| `este` | Este | Agua | izquierda |
| `oeste` | Oeste | Aire | derecha |

Catálogo: [`insignias.json`](insignias.json).
