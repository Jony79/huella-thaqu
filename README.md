# Huella Thaqu

PWA para protagonistas de la etapa **Caminante** (Scouts de Argentina).

## Local

```bash
docker compose up --build -d
docker compose exec web node src/cli/migrate-schema.js
docker compose exec web node src/cli/seed-catalog.js
docker compose exec web node src/cli/seed-nomina.js
```

Abrí [http://localhost:3000](http://localhost:3000).

El proceso `web` **solo sirve la app**. Esquema, catálogo y nómina se aplican con los scripts de arriba (no al deploy).

- **Nómina:** DNI + nombre (+ tipo educador). Sin cuentas previas.
- **Registro:** alias + contraseña la primera vez.
- Smoke: `node scripts/smoke-stages.mjs`

## EasyPanel

Ver [`docs/EASYPANEL.md`](docs/EASYPANEL.md).

## Scripts de base

| Script | Qué hace |
|--------|----------|
| `node src/cli/migrate-schema.js` | Crea/actualiza tablas |
| `node src/cli/seed-catalog.js` | Áreas, fichas y actividades |
| `node src/cli/seed-nomina.js` | Personas del padrón |

También: `scripts/easypanel-init-db.sql` (solo `CREATE DATABASE`).
