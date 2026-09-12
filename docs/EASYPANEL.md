# Despliegue EasyPanel — Huella Thaqu

## 1. Base de datos (Postgres existente)

Creá la base (una sola vez):

```sql
CREATE DATABASE huella_thaqu;
```

O con el script:

```bash
psql "$ADMIN_DATABASE_URL" -f scripts/easypanel-init-db.sql
```

El esquema, la nómina (`material/Nomina`) y el catálogo (`content/areas.json`) se aplican **solos al arrancar** el contenedor web (`migrate` + `seedNomina`).

## 2. Servicio Web en EasyPanel

- **Build:** este repo, `Dockerfile` en la raíz.
- **Puerto:** `3000`
- **Volumen persistente (recomendado):** `/srv/uploads` para avatares.

### Variables de entorno

| Variable | Ejemplo | Notas |
|----------|---------|--------|
| `DATABASE_URL` | `postgres://USER:PASS@HOST:5432/huella_thaqu` | Obligatoria |
| `JWT_SECRET` | string largo aleatorio | Obligatoria |
| `PUBLIC_URL` | `https://huella.tudominio.com` | URL pública HTTPS |
| `PORT` | `3000` | |
| `ADMIN_SECRET` | string secreto | Alta de DNI vía API admin |
| `UPLOADS_DIR` | `/srv/uploads` | Opcional |

## 3. Primera verificación

```bash
curl https://TU_DOMINIO/api/health
```

Debería responder `{"ok":true}`.

Educadores y protagonistas se registran con DNI del padrón + alias + contraseña la primera vez.

## 4. Local (referencia)

```bash
docker compose up --build
```

Smoke de bolitas/etapas:

```bash
node scripts/smoke-stages.mjs
```
