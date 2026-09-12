# Despliegue EasyPanel — Huella Thaqu

El contenedor **solo corre la app**. No toca la base al arrancar.

## 1. Crear la base (admin Postgres)

```bash
psql "$ADMIN_DATABASE_URL" -f scripts/sql/01-create-database.sql
```

## 2. Servicio Web

- Repo: `Jony79/huella-thaqu`, branch `main`
- Builder: Dockerfile
- Puerto: `3000`
- Volumen: `/srv/uploads`

| Variable | Notas |
|----------|--------|
| `DATABASE_URL` | `postgres://USER:PASS@HOST:5432/huella_thaqu` |
| `JWT_SECRET` | secreto largo |
| `PUBLIC_URL` | URL pública HTTPS |
| `PORT` | `3000` |
| `ADMIN_SECRET` | alta DNI por API |
| `UPLOADS_DIR` | `/srv/uploads` |

## 3. Scripts SQL de inicialización

Correr contra `huella_thaqu` (en orden), **una vez** o cuando actualices datos:

```bash
psql "$DATABASE_URL" -f scripts/sql/02-schema.sql
psql "$DATABASE_URL" -f scripts/sql/03-catalog.sql
psql "$DATABASE_URL" -f scripts/sql/04-nomina.sql
```

| Archivo | Qué hace |
|---------|----------|
| `01-create-database.sql` | `CREATE DATABASE` |
| `02-schema.sql` | Tablas / esquema |
| `03-catalog.sql` | Áreas, fichas y actividades |
| `04-nomina.sql` | Personas del padrón (sin cuentas login) |

Si cambiás `content/areas.json` o `material/Nomina/`, regenerá 03/04:

```bash
node scripts/generate-sql-seeds.mjs
```

## 4. Verificar

```bash
curl https://TU_DOMINIO/api/health
```

## 5. Local

Con Postgres en el puerto `5433` (`docker compose up --build -d`):

```powershell
$env:PGPASSWORD='thaQu_local'
psql -h localhost -p 5433 -U thaQu -d huella_thaqu -f scripts/sql/02-schema.sql
psql -h localhost -p 5433 -U thaQu -d huella_thaqu -f scripts/sql/03-catalog.sql
psql -h localhost -p 5433 -U thaQu -d huella_thaqu -f scripts/sql/04-nomina.sql
```
