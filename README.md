# Huella Thaqu

PWA para protagonistas de la etapa **Caminante** (Scouts de Argentina). Se instala en el celular, funciona sin datos y sincroniza al volver a tener red.

## Cómo correrla en local

```bash
docker compose up --build
```

Abrí [http://localhost:3000](http://localhost:3000).

El arranque **migra el esquema**, siembra la **nómina** (`material/Nomina/`) y carga el **catálogo** (`content/areas.json`).

- **Protagonistas / educadores:** padrón por DNI. La primera vez eligen alias y contraseña.
- Smoke de bolitas/etapas: `node scripts/smoke-stages.mjs`

## EasyPanel

Guía completa: [`docs/EASYPANEL.md`](docs/EASYPANEL.md).

Resumen:

1. `CREATE DATABASE huella_thaqu` (ver `scripts/easypanel-init-db.sql`).
2. Servicio Web con este `Dockerfile`.
3. Variables: `DATABASE_URL`, `JWT_SECRET`, `PUBLIC_URL`, `ADMIN_SECRET`.

## Material

- `material/Nomina/` — padrón (se copia al contenedor).
- `material/insignias/` — fuentes de las insignias (las de la app están en `app/public/insignias/`).
- `content/` — catálogo e documentación de progresión.

## Alta de DNI (API admin)

```bash
curl -X POST http://localhost:3000/api/admin/people \
  -H "x-admin-secret: local-admin" \
  -H "Content-Type: application/json" \
  -d "{\"dni\":\"12345678\",\"nombre\":\"Nombre\"}"
```
