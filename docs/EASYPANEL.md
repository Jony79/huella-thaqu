# Despliegue EasyPanel — Huella Thaqu

El contenedor **solo corre la app**. No migra ni siembra la base al arrancar.

## 1. Crear la base (una vez)

En el Postgres de EasyPanel:

```sql
CREATE DATABASE huella_thaqu;
```

O: `scripts/easypanel-init-db.sql`

## 2. Servicio Web

- Source: `Jony79/huella-thaqu`, branch `main`
- Builder: **Dockerfile** (raíz)
- Puerto: `3000`
- Volumen: `/srv/uploads` (avatars)

### Variables

| Variable | Notas |
|----------|--------|
| `DATABASE_URL` | `postgres://USER:PASS@HOST:5432/huella_thaqu` |
| `JWT_SECRET` | secreto largo |
| `PUBLIC_URL` | URL pública HTTPS |
| `PORT` | `3000` |
| `ADMIN_SECRET` | alta de DNI por API |
| `UPLOADS_DIR` | `/srv/uploads` (opcional) |

## 3. Scripts de base (manuales, desde el shell del contenedor)

Correr **después** del primer deploy, o cuando cambie el esquema / nómina / catálogo:

```bash
# 1) Esquema / migraciones estructurales
node src/cli/migrate-schema.js

# 2) Catálogo de áreas y fichas (content/areas.json)
node src/cli/seed-catalog.js

# 3) Padrón de personas (material/Nomina) — no crea cuentas login
node src/cli/seed-nomina.js
```

Orden recomendado la primera vez: **migrate → catalog → nomina**.

Las cuentas (alias/contraseña) las crea cada persona al registrarse; la nómina solo habilita el DNI.

## 4. Verificar

```bash
curl https://TU_DOMINIO/api/health
```

## 5. Local

```bash
docker compose up --build -d
docker compose exec web node src/cli/migrate-schema.js
docker compose exec web node src/cli/seed-catalog.js
docker compose exec web node src/cli/seed-nomina.js
```
