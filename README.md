# Huella Thaqu

PWA para protagonistas de la etapa **Caminante** (Scouts de Argentina).

## Local

```bash
docker compose up --build -d
```

Inicializar la base (scripts SQL, en orden):

```bash
$env:PGPASSWORD='thaQu_local'
psql -h localhost -p 5433 -U thaQu -d huella_thaqu -f scripts/sql/02-schema.sql
psql -h localhost -p 5433 -U thaQu -d huella_thaqu -f scripts/sql/03-catalog.sql
psql -h localhost -p 5433 -U thaQu -d huella_thaqu -f scripts/sql/04-nomina.sql
```

Abrí [http://localhost:3000](http://localhost:3000).

La app **no** migra ni siembra la DB al arrancar.

## EasyPanel

Ver [`docs/EASYPANEL.md`](docs/EASYPANEL.md).

## Scripts SQL

| Archivo | Uso |
|---------|-----|
| `scripts/sql/01-create-database.sql` | Crear la base |
| `scripts/sql/02-schema.sql` | Esquema |
| `scripts/sql/03-catalog.sql` | Catálogo (fichas) |
| `scripts/sql/04-nomina.sql` | Padrón de personas |

Regenerar 03/04 desde fuentes: `node scripts/generate-sql-seeds.mjs`
