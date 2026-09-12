-- Crear base para Huella Thaqu en el Postgres de EasyPanel.
-- Ejecutar conectado como superusuario / dueño del cluster.
-- Ajustá el OWNER si tu usuario de app no es el default.

CREATE DATABASE huella_thaqu;

-- Opcional: usuario dedicado (descomentar y adaptar)
-- CREATE USER huella_app WITH PASSWORD 'CAMBIAR';
-- GRANT ALL PRIVILEGES ON DATABASE huella_thaqu TO huella_app;
