-- Padrón de personas (generado desde material/Nomina/)
-- No crea cuentas de login (users); solo people.
-- Regenerar: node scripts/generate-sql-seeds.mjs

BEGIN;

INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50331442', 'Adris Demo, Lucia Nur', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50029796', 'Alonso Arrigo, Santiago', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50628640', 'Aramayo Grasso, Ramiro Nicolas', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50419351', 'Arrieta, Guadalupe', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50627426', 'Barcelona Caparros, Alina Milagros', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50421073', 'Barcelona, Victoria', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50591968', 'Barrionuevo Manchento, Ignacio', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50745956', 'Basualdo Díaz, Francisco', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('49557886', 'Beltrán, Julieta Muriel', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50629778', 'Bilic Gudiño, Emma', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('48534121', 'Bordon, Pablo Martín Miguel', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50630843', 'Brandan Altamirano, Martina Dora', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50635512', 'Brusco, Maria Guadalupe', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('48599220', 'Bustos, Agustina', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('49078029', 'Carrizo, Ignacio Leonel', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('48531833', 'Constabel, Pia', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('51297691', 'Cuello, Morena', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50329225', 'Curetti, Maximiliano Luis', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('48669957', 'Di Lello, Lucia', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('48723024', 'Epifano, Juliana', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('49406348', 'Garay, Francisco Ernesto', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('49952508', 'Gorosito Del Olmo, Agustina', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('49460915', 'Hayden, Mia', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50626919', 'Layús, Anna Sofía', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50327992', 'Layus, Eva', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('52228172', 'Layus, Julia', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('48533803', 'Lupiañez Baya, Valentina', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50937105', 'Monti, Valentin Gabriel', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('52158590', 'Morales Marcolini, Julián', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('51363201', 'Moreno Perinetti, Bernardita', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50863284', 'Nigro, Marcos Joaquín', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50462675', 'Noguera Dovis, Joaquin Andres', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50630974', 'OROME, Valentina Milagros', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50936150', 'Ponce, Héctor Lautaro', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50419385', 'Reynoso, Santiago', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50628683', 'Rocchiccioli Glorioso, Joaquín Santiago', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('49497136', 'Rodríguez Della Puppa, Matías', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50629862', 'Rojo, Santiago', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('50419964', 'Ruggeri, Thiago Ismael', TRUE, 'protagonista')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'protagonista';

INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('27361408', 'Cantarelli, Julian', TRUE, 'educador')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'educador';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('34455780', 'Ciccioli, Emiliano Dario', TRUE, 'educador')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'educador';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('34689436', 'Dominguez Cuaglia, Daniela', TRUE, 'educador')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'educador';
INSERT INTO people (dni, nombre, habilitado, tipo) VALUES ('23212459', 'Lóndero, Roger', TRUE, 'educador')
ON CONFLICT (dni) DO UPDATE SET nombre = COALESCE(EXCLUDED.nombre, people.nombre), habilitado = TRUE, tipo = 'educador';

-- Deshabilitar DNIs que ya no están en la nómina
UPDATE people SET habilitado = FALSE WHERE NOT (dni IN ('50331442', '50029796', '50628640', '50419351', '50627426', '50421073', '50591968', '50745956', '49557886', '50629778', '48534121', '50630843', '50635512', '48599220', '49078029', '48531833', '51297691', '50329225', '48669957', '48723024', '49406348', '49952508', '49460915', '50626919', '50327992', '52228172', '48533803', '50937105', '52158590', '51363201', '50863284', '50462675', '50630974', '50936150', '50419385', '50628683', '49497136', '50629862', '50419964', '27361408', '34455780', '34689436', '23212459'));

COMMIT;
