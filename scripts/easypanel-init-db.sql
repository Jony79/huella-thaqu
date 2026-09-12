-- Crear solo la base vacía (EasyPanel / Postgres admin).
-- NO crea tablas ni datos: eso va con los CLI del contenedor.

CREATE DATABASE huella_thaqu;

-- Opcional:
-- CREATE USER huella_app WITH PASSWORD 'CAMBIAR';
-- GRANT ALL PRIVILEGES ON DATABASE huella_thaqu TO huella_app;
