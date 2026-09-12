-- Catálogo de áreas, fichas y actividades (generado desde content/areas.json)
-- Versión 2
-- Regenerar: node scripts/generate-sql-seeds.mjs

BEGIN;

INSERT INTO areas (id, name, color, badge, sort_order) VALUES ('salud-bienestar', 'Salud y bienestar', '#1d4e89', '', 0)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, color = EXCLUDED.color, badge = EXCLUDED.badge, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-01', 'salud-bienestar', '1. Adopto y promuevo hábitos de alimentación e higiene saludables', 'Adopto y promuevo hábitos de alimentación e higiene saludables

Preguntas orientadoras:
• ¿Por qué debe importarme lo que como? ¿Cuáles son los beneficios de mantener una alimentación equilibrada?
• ¿Cuál es la importancia de aprender a cocinar? ¿Quién puede ayudarme en esto?
• ¿Tengo hábitos que pueden afectar negativamente a mi salud? ¿Qué cambios, aunque sean pequeños, puedo hacer en mi rutina diaria para mejorar mis hábitos de alimentación e higiene?
• ¿Por qué es importante la higiene personal y la de los lugares en donde habito?', 0)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-01-a1', 'salud-bienestar-01', 'Mantengo el ambiente limpio y ordenado, en mi hogar, en mi espacio de reunión con el equipo, en mis actividades al aire libre y en todos los entornos donde habito.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-01-a8', 'salud-bienestar-01', 'Asumo la responsabilidad de la cocina en un campamento, investigando recetas y adecuándolas a los gustos o restricciones alimenticias de mi equipo.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-01-a2', 'salud-bienestar-01', 'Leo las etiquetas de los alimentos y tomo decisiones informadas consultando fuentes validadas sobre los productos que consumo para evitar enfermedades y fomentar la salud.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-01-a3', 'salud-bienestar-01', 'Tengo hábitos de higiene personal diaria.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-01-a4', 'salud-bienestar-01', 'Colaboro en mi hogar en la preparación de comidas para mi familia.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-01-a5', 'salud-bienestar-01', 'Identifico aquellos hábitos que pueden afectar negativamente mi salud y los evito.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-01-a6', 'salud-bienestar-01', 'Organizo un menú para un campamento para mi equipo o Comunidad Caminante, considerando aspectos tales como: una dieta equilibrada y acorde a las actividades, la época del año y el costo de los ingredientes.', 6)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-01-a7', 'salud-bienestar-01', 'Sostengo una alimentación equilibrada que incluya variedad de alimentos con recetas saludables y evito saltearme comidas.', 7)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-02', 'salud-bienestar', '2. Expreso mis emociones entendiendo cómo me afectan a mí e influyen en mi entorno', 'Expreso mis emociones entendiendo cómo me afectan a mí e influyen en mi entorno

Preguntas orientadoras:
• siento que puedo expresar y canalizar mis emociones?
• ¿Busco ayuda cuando la necesito? ¿A quiénes recurro
• cuando necesito ayuda?
• mi equipo y de mi Comunidad Caminante? ¿Qué ayuda
• necesito para poder hacerlo? ¿De quién o quiénes?
• ¿Qué hago cuando siento mucha presión o estrés?
• ¿Tengo alguna técnica o estrategia?', 1)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-02-a1', 'salud-bienestar-02', 'Busco actividades saludables y recreativas donde canalizar las emociones (a través del arte, música, deporte y cultura) para compartir con mi comunidad.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-02-a2', 'salud-bienestar-02', 'Promuevo la comunicación abierta y honesta en las relaciones personales de los entornos en los que participo, creando un ambiente seguro para expresar emociones.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-02-a3', 'salud-bienestar-02', 'Practico técnicas de relajación, como la respiración profunda y la meditación, para gestionar el estrés y las emociones intensas.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-02-a4', 'salud-bienestar-02', 'En caso de necesitarlo, busco ayuda en mis educadoras, educadores, familia, amistades y profesionales.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-02-a5', 'salud-bienestar-02', 'Escucho activamente a las demás personas, validando sus sentimientos, evitando juzgar o minimizar sus experiencias emocionales.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-03', 'salud-bienestar', '3. Adopto una mirada crítica sobre las imágenes y mensajes que los medios de comunicación y las redes sociales nos muestran acerca de los cuerpos y las apariencias.', 'Adopto una mirada crítica sobre las imágenes y mensajes que los medios de comunicación y las redes sociales nos muestran acerca de los cuerpos y las apariencias.

Preguntas orientadoras:
• medios de comunicación? ¿Por qué creo que existen
• esos estereotipos?
• autoestima? ¿Qué cosas hago cuando me pasa eso?
• ¿Cómo puedo ayudar a otras personas?
• personas?
• ¿Qué actividades puedo hacer con mi equipo o comunidad relacionadas con estos temas?', 2)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-03-a1', 'salud-bienestar-03', 'Reflexiono sobre mis propias creencias y percepciones sobre los cuerpos y las apariencias.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-03-a2', 'salud-bienestar-03', 'Realizo una campaña en redes contra estereotipos o sobre el amor propio y cuidado del cuerpo.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-03-a3', 'salud-bienestar-03', 'Converso con mis amistades sobre el tipo de imágenes, fotos y contenidos que publicamos y compartimos en nuestras propias redes sociales.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-03-a4', 'salud-bienestar-03', 'Identifico cuando tengo baja autoestima, buscando y generando espacios de apoyo.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-04', 'salud-bienestar', '4. Acepto mi cuerpo tal y como es, sin compararlo con el de las demás personas, entendiendo que es único y valioso.', 'Acepto mi cuerpo tal y como es, sin compararlo con el de las demás personas, entendiendo que es único y valioso.

Preguntas orientadoras:
• ¿Cuáles son las principales cualidades de mi cuerpo?
• ¿Celebro cuando logro objetivos personales relacionados al deporte, actividad física o rendimiento?
• pueden afectarlas?
• ¿Qué no puede hacer mi cuerpo? ¿Cómo aprendí a
• compensar la falta de ese sentido o habilidad motriz?
• ¿Conozco qué es la belleza hegemónica? ¿Qué pienso de
• esas ideas?', 3)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-04-a1', 'salud-bienestar-04', 'Identifico las cualidades de mi cuerpo, aprendiendo a ser amable conmigo mismo/a, celebrando mis logros y trabajando en lo que quiero mejorar.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-04-a2', 'salud-bienestar-04', 'Participo en una actividad en la que identificamos imágenes y mensajes sobre los cuerpos y las apariencias en los medios de comunicación.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-04-a3', 'salud-bienestar-04', 'Junto a mi equipo organizo charlas sobre cómo nos influyen las distintas ideas respecto a los cuerpos y cómo afectan nuestra autoestima.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-05', 'salud-bienestar', '5. Respeto y promuevo el respeto sobre la diversidad de identidades y géneros, sin prejuicios ni discriminación.', 'Respeto y promuevo el respeto sobre la diversidad de identidades y géneros, sin prejuicios ni discriminación.

Preguntas orientadoras:
• orientación y diversidad? ¿Con quien puedo corroborar la
• información con la que cuento? ¿Quién puede brindarme
• información correcta sobre estos conceptos?
• ¿Pesencié alguna situación en la que alguien sufre discriminación a causa de la identidad de género? ¿Cómo me
• sentí al respecto? ¿Qué acciones tomé en ese momento?
• ¿Sufro o sufrí algún tipo de discriminación? ¿Por qué
• pienso que suceden estas cosas?
• estos temas puedo realizar con mi equipo o mi comunidad?', 4)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-05-a1', 'salud-bienestar-05', 'Me informo y realizo una charla o debate con mi comunidad sobre identidad de género y diversidades.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-05-a2', 'salud-bienestar-05', 'Participo de acciones, descubiertas o proyectos en donde se promueve el respeto por la diversidad de identidades y géneros.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-05-a3', 'salud-bienestar-05', 'Intervengo en situaciones donde alguien sufre discriminación.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-06', 'salud-bienestar', '6. Comprendo que mi sexualidad es una parte importante de mi vida individual y junto a otras personas.', 'Comprendo que mi sexualidad es una parte importante de mi vida individual y junto a otras personas.

Preguntas orientadoras:
• preocupan? ¿A quién recurro para buscar información?
• ¿Qué significa aceptar mi sexualidad? ¿Cuáles fueron
• momento? ¿Cuáles son los aspectos positivos y desafíos
• de explorar y comprender mi propia sexualidad?
• personas?', 5)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-06-a1', 'salud-bienestar-06', 'Exploro y conozco mi cuerpo, mis preferencias, placeres y lo que me satisface.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-06-a2', 'salud-bienestar-06', 'No presupongo la sexualidad de las personas.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-06-a3', 'salud-bienestar-06', 'Acepto mi sexualidad como una parte natural y válida de mí.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-07', 'salud-bienestar', '7. Me informo y tomo decisiones responsables sobre mi salud sexual, cuidando de mí y de las demás personas, para disfrutar de relaciones sanas y seguras.', 'Me informo y tomo decisiones responsables sobre mi salud sexual, cuidando de mí y de las demás personas, para disfrutar de relaciones sanas y seguras.

Preguntas orientadoras:
• transmisión sexual? ¿Estoy seguro/a que es información
• confiable y no solo mitos y tradiciones?
• temas? ¿A quién puedo recurrir?
• caminante? Si no es así, y tenemos inconvenientes para hablarlos: ¿Qué cosas puedo hacer o proponer para que suceda?
• rodean?', 6)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-07-a1', 'salud-bienestar-07', 'Junto a mi equipo, participamos de un taller de educación sexual integral (ESI) con un especialista.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-07-a2', 'salud-bienestar-07', 'Utilizo las herramientas necesarias (buzones anónimos, juegos, aplicaciones y actividades) para hablar de los temas que nos incomoden o nos den vergüenza de tratar en la comunidad.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-07-a3', 'salud-bienestar-07', 'Actualizo frecuentemente mi información sobre métodos anticonceptivos y sobre prevención de enfermedades de transmisión sexual (ETS) y soy consciente sobre dónde conseguir materiales y recursos.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-08', 'salud-bienestar', '8. Valoro el diálogo y respeto mutuo para mantener relaciones de confianza y afecto', 'Valoro el diálogo y respeto mutuo para mantener relaciones de confianza y afecto

Preguntas orientadoras:
• ¿Cómo es mi relación con mi familia? ¿Deseo
• mejorar la relación? ¿Qué debería hacer?
• ¿Escuché hablar del “No es no”?
• ¿Qué comprendo de ello?
• emociones, lo que siento y lo que me gusta? ¿Qué puedo
• hacer para que esto suceda? ¿A quién puedo acudir?
• ¿Sé de qué se trata la escucha activa?', 7)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-08-a1', 'salud-bienestar-08', 'Fomento el diálogo y escucha activa con mis afectos, expresando mis pensamientos, gustos, emociones y límites.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-08-a2', 'salud-bienestar-08', 'Mantengo relaciones responsables afectivamente.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-08-a3', 'salud-bienestar-08', 'Busco una relación de comprensión y afecto con mi familia, promoviendo una actitud de diálogo.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-08-a4', 'salud-bienestar-08', 'Aprendo y comparto: No es no.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-09', 'salud-bienestar', '9. Sé a dónde recurrir para proteger mis derechos sexuales y reproductivos obteniendo los recursos necesarios para vivir mi sexualidad con responsabilidad', 'Sé a dónde recurrir para proteger mis derechos sexuales y reproductivos obteniendo los recursos necesarios para vivir mi sexualidad con responsabilidad

Preguntas orientadoras:
• reproductivos?¿Por qué es importante conocerlos?
• sexuales y reproductivos?
• con mi desarrollo sexual?
• ¿Qué actividades puedo hacer con mi equipo o Comunidad para mejorar mi información sobre estos temas?', 8)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-09-a1', 'salud-bienestar-09', 'Realizo una descubierta sobre las instituciones de promoción y defensa de los derechos sobre salud sexual.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-09-a2', 'salud-bienestar-09', 'Me informo sobre las implicancias del embarazo adolescente.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-09-a3', 'salud-bienestar-09', 'Consulto a profesionales sobre el desarrollo de mi sexualidad y comparto información referida al acceso a la salud.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-10', 'salud-bienestar', '10. Me involucro en actividades físicas y deportivas como parte fundamental de mi bienestar, explorando mi potencial y desafiándome a mí mismo/a.', 'Me involucro en actividades físicas y deportivas como parte fundamental de mi bienestar, explorando mi potencial y desafiándome a mí mismo/a.

Preguntas orientadoras:
• ¿Qué deportes o actividad física me interesan?
• mi equipo o Comunidad?
• mejorar? ¿Qué objetivos me propongo al respecto? ¿Qué
• cosas debería hacer para alcanzar esos objetivos? ¿Necesito
• ayuda para esto? ¿A quién puedo recurrir?', 9)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-10-a1', 'salud-bienestar-10', 'Exploro mi interés por los deportes y actividades físicas, practicándolas regularmente.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-10-a2', 'salud-bienestar-10', 'Acepto y comprendo los cambios físicos que suceden en mi cuerpo.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-10-a3', 'salud-bienestar-10', 'Reconozco y desarrollo mis capacidades físicas (fuerza, velocidad, resistencia, flexibilidad, ritmo, equilibrio).', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-10-a4', 'salud-bienestar-10', 'No sobre exijo a mi cuerpo.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-10-a5', 'salud-bienestar-10', 'Armo rutinas y planificación de ejercicios de manera consciente con apoyo de especialistas o profesionales.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-10-a6', 'salud-bienestar-10', 'Establezco objetivos relacionados a la actividad física o al deporte y registro los progresos, valorando el proceso y planificando cómo superarme.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-11', 'salud-bienestar', '11. Comparto actividades recreativas, deportivas y lúdicas, fomentando mi desarrollo social y emocional junto a mis amistades', 'Comparto actividades recreativas, deportivas y lúdicas, fomentando mi desarrollo social y emocional junto a mis amistades

Preguntas orientadoras:
• ¿Cómo es mi grupo de amigos y amigas? ¿En qué
• amistades o fortalecer los vínculos existentes?
• ¿Tengo información sobre cómo organizar un rally caminante? ¿Dónde puedo encontrar información? ¿A quién
• puedo recurrir para que me ayude?
• comunidad caminante? ¿A quién puedo recurrir para que me
• ayude?
• scouts, rovers, etc)? ¿Cómo puedo organizar esto?
• Qué cosas tengo que tener en cuenta?', 10)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-11-a1', 'salud-bienestar-11', 'Genero y mantengo amistades.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-11-a2', 'salud-bienestar-11', 'Propongo actividades lúdicas y deportivas para realizar junto a mi equipo o comunidad.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-11-a3', 'salud-bienestar-11', 'Busco desafíos o aprendizajes para llevar adelante (por ejemplo, que todo mi equipo sepa nadar).', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-11-a4', 'salud-bienestar-11', 'Realizo una tutoría referida a un deporte, juego o actividad recreativa de mi conocimiento.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-11-a5', 'salud-bienestar-11', 'Por ejemplo: enseño juegos o deportes a la Manada o la Unidad Scout.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-11-a6', 'salud-bienestar-11', 'Invito a mis amigas y amigos a participar de un día de juegos con la comunidad.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-11-a7', 'salud-bienestar-11', 'Organizo un rally caminante con mi equipo o comunidad.', 6)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-12', 'salud-bienestar', '12. Tomo decisiones responsables evitando acciones que puedan poner en riesgo mi seguridad y bienestar, así como el de las personas que me rodean.', 'Tomo decisiones responsables evitando acciones que puedan poner en riesgo mi seguridad y bienestar, así como el de las personas que me rodean.

Preguntas orientadoras:
• ¿Conozco las normas de seguridad de Scouts de Argentina para la realización de actividades y proyectos?
• de mis decisiones? ¿Recurro a ayuda para esto?
• íntimos en las redes?', 11)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-12-a1', 'salud-bienestar-12', 'Elaboro estrategias apoyándome en mi Diario de Marcha para evaluar los pro y contra de mis opciones, tomando así la decisión que considero más adecuada.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-12-a2', 'salud-bienestar-12', 'Conozco y replico las normas de seguridad, convivencia y bienestar de mi entorno (por ejemplo, normas de tránsito o seguridad en línea).', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-12-a3', 'salud-bienestar-12', 'Identifico y comprendo el daño que puede realizarse desde las redes sociales y me informo sobre medidas para prevenir el ciberbullying, grooming, sexting y viralización de imágenes y contenidos íntimos.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-12-a4', 'salud-bienestar-12', 'Elaboro los informes de factibilidad de mis proyectos en los que tengo en cuenta los riesgos y actividades preventivas correspondientes.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-12-a5', 'salud-bienestar-12', 'Me responsabilizo de mis decisiones, siendo consecuente con mis acciones y aceptando las consecuencias.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-13', 'salud-bienestar', '13. Me informo y preparo para enfrentar situaciones de emergencia.', 'Me informo y preparo para enfrentar situaciones de emergencia.

Preguntas orientadoras:
• ¿Por qué son importantes los simulacros de emergencias y los planes de riesgo y evacuación?
• necesito tener? ¿Dónde puedo obtenerlos? ¿Dónde
• buscar información? ¿Quién puede ayudarme con esto?
• esta competencia?', 12)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-13-a1', 'salud-bienestar-13', 'Realizo o participo en simulacros de emergencia y evacuación.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-13-a2', 'salud-bienestar-13', 'Conozco los planes de riesgo y evacuación de mi grupo scout y de los campamentos en los que participo.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-13-a3', 'salud-bienestar-13', 'Desarrollo conocimientos básicos de primeros auxilios: especialmente los procedimientos de reanimación cardiopulmonar.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-13-a4', 'salud-bienestar-13', 'Busco mantener la calma en situaciones de crisis.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-13-a5', 'salud-bienestar-13', 'Planifico las acciones que llevaremos adelante en caso de una emergencia, repartiendo roles de manera clara.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('salud-bienestar-14', 'salud-bienestar', '14. Conozco, construyo y promociono redes de apoyo y ayuda mutua junto a mis pares', 'Conozco, construyo y promociono redes de apoyo y ayuda mutua junto a mis pares

Preguntas orientadoras:
• ¿En qué me apoya mi familia? ¿En qué considero
• que yo soy apoyo para mi familia?
• caminantes de otros grupos scouts? ¿A quién puedo
• solicitar ayuda para esto?
• soy yo quien los apoya? ¿Qué temas tengo confianza de
• hablar con nadie más?', 13)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-14-a1', 'salud-bienestar-14', 'Comprendo los encuentros scouts como espacios de intercambio y generación de redes de apoyo.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-14-a2', 'salud-bienestar-14', 'Participo de los espacios de evaluación de la progresión personal de mis compañeras y compañeros de equipo.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-14-a3', 'salud-bienestar-14', 'Valoro a mi familia como red de apoyo, contención y ayuda mutua.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-14-a4', 'salud-bienestar-14', 'Genero amigas y amigos, en quienes confío y podemos apoyarnos mutuamente.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('salud-bienestar-14-a5', 'salud-bienestar-14', 'Participo de encuentros, actividades y reuniones con scouts de otros grupos scouts.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO areas (id, name, color, badge, sort_order) VALUES ('habilidades-vida', 'Habilidades para la vida', '#c45c26', '', 1)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, color = EXCLUDED.color, badge = EXCLUDED.badge, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-36', 'habilidades-vida', '36. Trabajo en mi superación personal, enfocándome en mis intereses personales.', 'Trabajo en mi superación personal, enfocándome en mis intereses personales.

Preguntas orientadoras:
• largo plazo? ¿Cómo puedo identificar aspectos en los
• que me gustaría mejorar o crecer personalmente?
• ¿Cómo evalúo mi progresión personal? ¿Comprendo los
• desafíos de la etapa en la que me encuentro?
• ¿Busco superarme a mí mismo?', 0)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-36-a1', 'habilidades-vida-36', 'Confecciono mi Diario de Marcha y lo reviso con regularidad.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-36-a2', 'habilidades-vida-36', 'Propongo actividades, proyectos y descubiertas que me ayudan a cumplir las metas propuestas en mi Diario de Marcha.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-36-a3', 'habilidades-vida-36', 'Evalúo mi avance en mi progresión personal al menos una vez por ciclo de programa, teniendo en cuenta las metas que me propuse y los plazos que definí.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-36-a4', 'habilidades-vida-36', 'Identifico en las actividades y proyectos aquellos temas sobre los que deseo aprender y los aprendizajes que obtuve por mi participación.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-36-a5', 'habilidades-vida-36', 'Exploro las oportunidades que me ofrecen las insignias especiales para desarrollar aquellos temas que me interesan.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-36-a6', 'habilidades-vida-36', 'Desarrollo una tutoría en la que ayudo a una compañera o un compañero de la Comunidad Caminante en algún tema de su progresión personal.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-36-a7', 'habilidades-vida-36', 'Me propongo metas para ampliar mis conocimientos planteándome desafíos personales.', 6)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-37', 'habilidades-vida', '37. Investigo y desarrollo distintas habilidades y tecnologías que me permitan adquirir experiencias prácticas y útiles para mi vida.', 'Investigo y desarrollo distintas habilidades y tecnologías que me permitan adquirir experiencias prácticas y útiles para mi vida.

Preguntas orientadoras:
• ¿Sobre qué temas me interesa aprender?
• vida en general?
• propongo? ¿A quién puedo solicitar ayuda para superar
• estas dificultades?
• para apoyar a otras personas o ser tutor/a?', 1)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-37-a1', 'habilidades-vida-37', 'Identifico las habilidades y saberes que me serán útiles en el futuro profesional y busco potenciarlas.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-37-a2', 'habilidades-vida-37', 'Realizo cursos o talleres que me acerquen o posibiliten adquirir habilidades y/o competencias que me serán útiles en el mundo laboral (ejemplo: programación, inteligencia artificial, oficios manuales, etc.) Enseño una habilidad como tutor/a o llevo adelante un breve curso en un centro comunitario (informática, redacción de currículum, preparación de entrevistas de trabajo, etc.).', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-37-a3', 'habilidades-vida-37', 'Aprendo técnicas que me permitan resolver problemas y realizar arreglos en mi casa, en el grupo, en las actividades y proyectos, etc.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-38', 'habilidades-vida', '38. Afronto creativamente los desafíos y problemas que se me presentan y aporto soluciones innovadoras', 'Afronto creativamente los desafíos y problemas que se me presentan y aporto soluciones innovadoras

Preguntas orientadoras:
• excursión o proyecto? ¿Propusimos alguna vez una lluvia
• de ideas o distintos modelos para solucionarlos?
• desafíos o problemas recientemente? ¿Qué estrategias
• creativa?
• las actividades o campamentos?', 2)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-38-a1', 'habilidades-vida-38', 'Realizo o participo en una tutoría sobre ciencia, tecnología, ingeniería, arte y matemáticas (STEAM) Investigo sobre distintas formas de realizar lluvias de ideas y procesos creativos para resolver problemas.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-38-a2', 'habilidades-vida-38', 'Pongo en práctica lo aprendido para resolver un problema del equipo o comunidad.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-38-a3', 'habilidades-vida-38', 'Propongo ideas de actividades y proyectos para realizar con mi equipo o Comunidad Caminante.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-38-a4', 'habilidades-vida-38', 'Busco soluciones innovadoras para aplicar a los proyectos y actividades que realizamos.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-38-a5', 'habilidades-vida-38', 'Aplico tecnología para mejorar las condiciones de un campamento y contribuir a la sustentabilidad, por ejemplo: cocina solar, ducha solar, potabilizador de agua, etc.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-39', 'habilidades-vida', '39. Me informo, exploro y experimento sobre las distintas opciones dentro del mundo del trabajo en función a mis intereses.', 'Me informo, exploro y experimento sobre las distintas opciones dentro del mundo del trabajo en función a mis intereses.

Preguntas orientadoras:
• en mi mismo? ¿Cuáles me gustaría tener
• o desarrollar en la vida?
• he planteado hasta ahora? ¿Cuáles son mis objetivos a
• puedo trabajar hacia ellos?
• ¿Qué me apasiona? Mis pasiones reales y verdaderas
• ¿Hay alguna profesión que se relacione con esa pasión?', 3)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-39-a1', 'habilidades-vida-39', 'Realizo una lista de mis habilidades, gustos e intereses y los relaciono con áreas de empleo.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-39-a2', 'habilidades-vida-39', 'Investigo sobre qué conocimientos son necesarios para las profesiones que llamaron mi atención.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-39-a3', 'habilidades-vida-39', 'Consulto a profesionales que trabajen en áreas que me interesan sobre su labor cotidiano y su experiencia como estudiante.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-39-a4', 'habilidades-vida-39', 'Utilizo recursos en línea (como sitios web, apps y plataformas de búsqueda de empleo) para investigar diferentes industrias, roles y oportunidades laborales (Tareas, oficios, profesiones).', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-39-a5', 'habilidades-vida-39', 'Realizo actividades sobre role play y simulacros de entrevistas laborales con mi equipo o comunidad.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-39-a6', 'habilidades-vida-39', 'Llevo adelante o participo de un proyecto del campo de acción vocación.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-40', 'habilidades-vida', '40. Motivo y oriento a otras personas a trabajar en conjunto para lograr objetivos comunes.', 'Motivo y oriento a otras personas a trabajar en conjunto para lograr objetivos comunes.

Preguntas orientadoras:
• alcanzar objetivos comunes? ¿Cuáles son algunas de las
• trabajar de manera individual?
• ¿Qué roles asumí en mi equipo? ¿Recibo apoyo para
• desempeñarlos cuando lo necesito? ¿A quién podría
• pedirle ayuda? ¿Ofrezco mi ayuda al resto del equipo?
• cada miembro del equipo? ¿Solemos reconocer y celebrar los logros y contribuciones individuales o colectivas
• del equipo durante el proceso de trabajo en conjunto?', 4)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-40-a1', 'habilidades-vida-40', 'Confecciono junto a mi comunidad un acuerdo de metas, objetivos claros y alcanzables para mejorar la convivencia.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-40-a2', 'habilidades-vida-40', 'Asumo responsabilidades y roles en mi equipo, en grupos de trabajo y en la Comunidad Caminante.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-40-a3', 'habilidades-vida-40', 'Asumo la responsabilidad de coordinar un grupo de trabajo durante un proyecto.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-40-a4', 'habilidades-vida-40', 'Realizo un proyecto en cualquiera de los campos de acción y tomo la responsabilidad de la delegación y seguimiento de tareas.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-41', 'habilidades-vida', '41. Apoyo a otras personas para colaborar en el desarrollo de su liderazgo.', 'Apoyo a otras personas para colaborar en el desarrollo de su liderazgo.

Preguntas orientadoras:
• ¿Qué entiendo por liderazgo? ¿Cuáles son las
• cualidades de un/a líder? ¿Cómo diferencio un liderazgo
• positivo de uno negativo?
• tanto como líder o como miembro de un equipo? ¿Cómo puedo
• liderazgo de mis compañeras y compañeros?
• compartir como inspiración?', 5)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-41-a1', 'habilidades-vida-41', 'Uso la tutoría para ayudar a otras y otros a reforzar sus liderazgos y a desarrollar sus aptitudes.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-41-a2', 'habilidades-vida-41', 'Animo a los miembros de mi comunidad o equipo a realizar proyectos que debatan, se posicionen y fomenten el empoderamiento de niñas y mujeres.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-41-a3', 'habilidades-vida-41', 'Participo en talleres, cursos o campamentos de liderazgo y replico los aprendizajes en mi comunidad.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-41-a4', 'habilidades-vida-41', 'Con mi equipo evaluamos regularmente el desempeño de mis compañeras y compañeros en los distintos roles dentro del equipo.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-41-a5', 'habilidades-vida-41', 'Valoro la función del coordinador/a de equipo como esencial para llevar adelante al equipo y apoyo su trabajo.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-41-a6', 'habilidades-vida-41', 'Fomento el liderazgo rotativo y participativo, a diferencia del permanente y personalista.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-42', 'habilidades-vida', '42. Aplico técnicas y tecnologías disponibles en la vida cotidiana', 'Aplico técnicas y tecnologías disponibles en la vida cotidiana

Preguntas orientadoras:
• conocido y aprendido? ¿Cómo puedo enseñar a otras
• considero útiles en mi vida diaria?
• aplicar? ¿Qué debo hacer para lograr esto?
• actualmente utilizo en mi vida cotidiana?', 6)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-42-a1', 'habilidades-vida-42', 'Conozco y aprendo a utilizar aplicaciones y programas informáticos, dominar herramientas de ofimática, gestión del tiempo, diseño, edición, entre otros.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-42-a2', 'habilidades-vida-42', 'Participo de cursos y talleres que me permitan adquirir habilidades y aprender sobre el uso de tecnología en mi vida diaria.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-42-a3', 'habilidades-vida-42', 'Conozco en profundidad los dispositivos que utilizo.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-42-a4', 'habilidades-vida-42', 'Aprendo a configurarlos y los adapto a mis necesidades.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-42-a5', 'habilidades-vida-42', 'Identifico problemas técnicos domésticos e investigo cómo resolverlos de manera autónoma, dentro de mis posibilidades.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-43', 'habilidades-vida', '43. Denuncio aquellas noticias que desinformen o sean falsas.', 'Denuncio aquellas noticias que desinformen o sean falsas.

Preguntas orientadoras:
• con mayor frecuencia en mi vida diaria? ¿Me importa
• las redes o que me comparte otra persona?
• ¿Cómo es mi relación con las redes sociales? ¿Para qué
• las utilizo? ¿Son mi fuente de información confiable?
• proyectos, etc.? ¿Cómo lo hago?', 7)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-43-a1', 'habilidades-vida-43', 'Utilizo las redes sociales para una investigación o descubierta sobre un tema a elección, evaluando la credibilidad de las fuentes de información, considero la autenticidad y la autoridad de la fuente.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-43-a2', 'habilidades-vida-43', 'Soy consciente del tiempo que utilizo el entorno digital y puedo limitarlo para que no me haga daño.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-43-a3', 'habilidades-vida-43', 'Programo tiempos límites diarios o recordatorios de descanso de ser necesarios.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-43-a4', 'habilidades-vida-43', 'Utilizo conscientemente los distintos canales informativos sobre temas actuales y de mi interés (portales, diarios en internet, redes sociales, servicios de mensajería) y valoro los recursos analógicos para adquirir conocimiento.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-43-a5', 'habilidades-vida-43', 'Explico a otras personas como encontrar fuentes de información de calidad y evaluar su fiabilidad, objetividad y actualidad.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-43-a6', 'habilidades-vida-43', 'Llevo adelante un proyecto del campo de acción arte y cultura relacionadas a las fuentes de información artísticas, populares, ancestrales y patrimoniales de mi comunidad local.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-44', 'habilidades-vida', '44. Planifico y administro responsablemente mis recursos, de forma ética.', 'Planifico y administro responsablemente mis recursos, de forma ética.

Preguntas orientadoras:
• recursos en la vida diaria?
• ¿Tengo problemas en la administración del dinero?
• ¿Cómo identifico esto? ¿Qué puedo hacer al respecto?
• ¿Cuáles son los principios éticos que guían mis decisiones sobre el uso de los recursos?
• administración de los recursos en mi vida?
• ¿Cuánta importancia le doy a los recursos?', 8)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-44-a1', 'habilidades-vida-44', 'Armo una planificación semanal o mensual para administrar mi dinero (ingresos, ahorros y gastos).', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-44-a2', 'habilidades-vida-44', 'Incorporo incluso aquellos servicios que utilizo pero no son mi responsabilidad (internet, luz, ropa, entre otros).', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-44-a3', 'habilidades-vida-44', 'Conozco y aprendo a usar las entidades financieras (apps, bancos, billeteras virtuales) que puedo utilizar.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-44-a4', 'habilidades-vida-44', 'Realizo acciones para solventar, en parte, mis actividades personales.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-44-a5', 'habilidades-vida-44', 'Me responsabilizo por la administración de los recursos económicos del equipo o de mi Comunidad al menos por un ciclo de programa, asegurando el uso eficiente de los recursos económicos y materiales.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-44-a6', 'habilidades-vida-44', 'Propongo ideas para el financiamiento de los proyectos de la Comunidad.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-44-a7', 'habilidades-vida-44', 'Uso mi dinero de manera responsable.', 6)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-44-a8', 'habilidades-vida-44', 'Comprendo el peligro del uso inconsciente del dinero en apps, juegos o apuestas en red y esquemas de negocios piramidales.', 7)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-45', 'habilidades-vida', '45. Establezco prioridades en las tareas administrando el uso del tiempo y los recursos disponibles para lograr los objetivos.', 'Establezco prioridades en las tareas administrando el uso del tiempo y los recursos disponibles para lograr los objetivos.

Preguntas orientadoras:
• tiempo? ¿Quién o quiénes pueden ayudarme con esto?
• ¿Cómo organizo mi tiempo? ¿Qué herramientas
• responsabilidades?
• ¿Cómo defino las prioridades en mi vida? ¿Qué estrategias utilizo para evitar la procrastinación y mantener el
• enfoque en mis objetivos?', 9)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-45-a1', 'habilidades-vida-45', 'Desarrollo al menos un proyecto en alguno de los campos de acción propuestos para la rama utilizando la metodología SMART (o similares) para identificar objetivos claros, específicos y medibles para un tiempo determinado.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-45-a2', 'habilidades-vida-45', 'Analizo estrategias de gestión del tiempo (como el método Pomodoro, principio de Pareto, listas de tareas, calendarios o aplicaciones) para administrar mis horarios y dividir los objetivos en tareas más pequeñas y alcanzables.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-45-a3', 'habilidades-vida-45', 'Participo activamente en la organización del calendario anual de actividades o la planificación del ciclo de programa.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-45-a4', 'habilidades-vida-45', 'Llevo adelante juegos o competencias (postas, concurso de nudos y amarres, concurso de armado de fuegos o claves, entre otros) donde la gestión del tiempo sea esencial para llevar adelante la actividad.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-46', 'habilidades-vida', '46. Encuentro momentos para descansar, distenderme, compartir con mis amistades y disfrutar de mi tiempo libre.', 'Encuentro momentos para descansar, distenderme, compartir con mis amistades y disfrutar de mi tiempo libre.

Preguntas orientadoras:
• en mi tiempo libre?
• ¿Qué siento cuando estoy estresada/o, ansiosa/o?
• dedico tiempo para mi mismo/a y para mis hobbies?
• descanso y recreación en mi vida diaria? ¿Qué actividades al aire libre son las que más me gustan?', 10)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-46-a1', 'habilidades-vida-46', 'Organizo mi tiempo para realizar actividades recreativas, de interés personal o momentos de desconexión.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-46-a2', 'habilidades-vida-46', 'No le quito importancia al estrés o la ansiedad, prestando atención a los síntomas y mensajes que mi cuerpo presenta.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-46-a3', 'habilidades-vida-46', 'Propongo salidas y excursiones a espacios naturales, acordando tiempos de descanso y de apreciación de la naturaleza y el aire libre.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-47', 'habilidades-vida', '47. Actúo de manera resiliente ante las dificultades, buscando la superación personal y colectiva.', 'Actúo de manera resiliente ante las dificultades, buscando la superación personal y colectiva.

Preguntas orientadoras:
• manera las dificultades y problemas?
• ¿Cómo procedo usualmente ante las dificultades? ¿Reviso
• las causas de algo que salió mal? ¿Cuál es mi fuente de
• con desafíos difíciles?
• importantes que enfrenté en mi vida hasta ahora? ¿Cómo
• superando esas situaciones?', 11)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-47-a1', 'habilidades-vida-47', 'Establezco metas en mi Diario de Marcha para aceptar los problemas y las dificultades como parte natural de mi crecimiento personal.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-47-a2', 'habilidades-vida-47', 'Pido ayuda o busco apoyo en mi familia, amistades o profesionales cuando es necesario.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-47-a3', 'habilidades-vida-47', 'Valoro el espacio de revisión del Diario de Marcha para buscar consejos entre mis pares (miembros del equipo) y mis educadoras y educadores.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-47-a4', 'habilidades-vida-47', 'Realizo evaluaciones y acepto ser evaluado por las actividades que realizamos, aportando comentarios constructivos y recibiendo oportunidades para mejorar y crecer.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-48', 'habilidades-vida', '48. Desarrollo habilidades para comunicarme de forma efectiva y respetuosa, influyendo positivamente en mi entorno y en la sociedad en general.', 'Desarrollo habilidades para comunicarme de forma efectiva y respetuosa, influyendo positivamente en mi entorno y en la sociedad en general.

Preguntas orientadoras:
• ¿Tengo dificultades para lograr una buena comunicación?
• ¿Qué tengo en cuenta para lograr una buena comunicación?
• superar las dificultades? ¿Por qué es importante participar y recibir evaluaciones de las cosas que hago con mi
• equipo o individualmente?
• comprendida/o y escuchada/o? ¿Hago esfuerzos
• en ese sentido?
• mis puntos de vista e ideas? ¿Qué tipo de dificultad
• encuentro? ¿Alguien puede ayudarme a superar esto?', 12)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-48-a1', 'habilidades-vida-48', 'Modero al menos una asamblea de mi Comunidad haciendo valer y respetar todas las opiniones, promoviendo la escucha activa.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-48-a2', 'habilidades-vida-48', 'Investigo sobre qué habilidades son necesarias para comunicarme de manera efectiva y las pongo en práctica.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-48-a3', 'habilidades-vida-48', 'Valoro los órganos de gobierno y el rol de representante juvenil como espacio de aprendizaje sobre la comunicación asertiva e influencia positiva en la toma de decisiones.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-48-a4', 'habilidades-vida-48', 'Participo en actividades o proyectos que prioricen la comunicación afectiva en debates, charlas, presentaciones, asambleas, etc.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('habilidades-vida-49', 'habilidades-vida', '49. Utilizo diferentes herramientas y tecnologías de comunicación para llegar a un público más amplio y diverso, promoviendo el diálogo y la colaboración entre las personas.', 'Utilizo diferentes herramientas y tecnologías de comunicación para llegar a un público más amplio y diverso, promoviendo el diálogo y la colaboración entre las personas.

Preguntas orientadoras:
• me gustaría aprender a utilizar?
• ¿Qué ideas, pensamientos, proyectos o creaciones artísticas deseo compartir? ¿Con quienes desearía
• compartirlas y para qué?', 13)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-49-a1', 'habilidades-vida-49', 'Organizo o participo de encuentros o actividades donde se manifiesten inquietudes, aspiraciones y creaciones artísticas de mi Comunidad.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-49-a2', 'habilidades-vida-49', 'Utilizo nuevas y diferentes tecnologías y herramientas de comunicación para conectarme con más personas y promover el diálogo.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-49-a3', 'habilidades-vida-49', 'Expreso en mi Diario de Marcha como será mi aprendizaje para comunicar mis opiniones y pensamientos de manera clara, respetuosa y constructiva.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-49-a4', 'habilidades-vida-49', 'Utilizo diferentes plataformas en línea (redes sociales, plataforma de videos y streaming o aplicaciones) para compartir pensamientos, proyectos y creaciones artísticas.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('habilidades-vida-49-a5', 'habilidades-vida-49', 'Participo del JOTA-JOTI (Jamboree en el aire - Jamboree en Internet), un evento para comunicarse y compartir información con scouts de todo el mundo utilizando la tecnología de radiofrecuencia como también del internet', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO areas (id, name, color, badge, sort_order) VALUES ('ambiente', 'Ambiente', '#2d6a4f', '', 2)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, color = EXCLUDED.color, badge = EXCLUDED.badge, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('ambiente-29', 'ambiente', '29. Adopto un estilo de vida responsable y sostenible en mi consumo y producción', 'Adopto un estilo de vida responsable y sostenible en mi consumo y producción

Preguntas orientadoras:
• producción sostenible?
• sostenible? ¿Qué prácticas sostenibles identifico en mi
• vida diaria?
• responsable y sostenible en tu consumo y producción? ¿Qué
• Comunidad para tener una conducta sostenible?', 0)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-29-a1', 'ambiente-29', 'Realizo una descubierta en mi comunidad local sobre problemáticas ambientales relacionadas a los desechos y consumos de plásticos.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-29-a2', 'ambiente-29', 'Propongo, organizo o participo al menos de un proyecto en el campo de acción ambiente que contribuya a la sostenibilidad y sustentabilidad en alianza con una organización.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-29-a3', 'ambiente-29', 'Incorporo hábitos responsables con el ambiente.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-29-a4', 'ambiente-29', 'Le doy un nuevo uso a la ropa y artículos que ya no utilizo.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-29-a5', 'ambiente-29', 'Evito plásticos de un solo uso en actividades, campamentos o salidas.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-29-a6', 'ambiente-29', 'Propongo el consumo sostenible en mi grupo scout, hogar o espacios donde participo (por ejemplo: productos y alimentos locales y de estación) Utilizo aplicaciones digitales para calcular el consumo energético o encontrar productos locales y ecológicos.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('ambiente-30', 'ambiente', '30. Me posiciono de manera crítica y responsable sobre las decisiones con impacto ambiental y realizo acciones al respecto.', 'Me posiciono de manera crítica y responsable sobre las decisiones con impacto ambiental y realizo acciones al respecto.

Preguntas orientadoras:
• ¿Qué entiendo por justicia ambiental? ¿Cómo puedo
• fomentarla? ¿Mediante qué acciones?
• Comunidad Caminante pueda trabajar en colaboración?
• ambiental negativo? ¿Existen posibilidades de cambiar
• esas acciones negativas?', 1)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-30-a1', 'ambiente-30', 'Realizo una descubierta sobre las principales causas de los problemas ambientales del lugar en donde vivo.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-30-a2', 'ambiente-30', 'Realizo al menos alguno de los desafíos ambientales que propone Scouts de Argentina y la Organización Mundial del Movimiento Scout.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-30-a3', 'ambiente-30', 'Propongo y realizo campañas de concientización y sensibilización sobre el cuidado del ambiente exponiendo las causas de los problemas.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('ambiente-31', 'ambiente', '31. Soy consciente sobre la conexión e interdependencia entre todos los seres vivos, esforzándome por vivir en armonía', 'Soy consciente sobre la conexión e interdependencia entre todos los seres vivos, esforzándome por vivir en armonía

Preguntas orientadoras:
• ¿Qué son los saberes ancestrales?
• de la interdependencia de los seres vivos?
• cotidiana? ¿Qué cosas deberíamos tener en cuenta para
• incorporar estos conocimientos de antepasados?', 2)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-31-a1', 'ambiente-31', 'Investigo sobre conocimientos o saberes ancestrales de las culturas originarias referidos a aspectos ecológicos, artesanales climáticos, medicinales, artístico, de casa, pesqueros, etc.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-31-a2', 'ambiente-31', 'Pongo en práctica en campamentos, excursiones y en mi vida cotidiana los conocimientos ancestrales para el cuidado de nuestra madre tierra.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-31-a3', 'ambiente-31', 'Discuto los impactos ambientales y éticos de las elecciones alimentarias y cómo reducir el consumo de productos de origen animal.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-31-a4', 'ambiente-31', 'Organizo actividades y talleres sobre construcción de refugios naturales, elaboración de medicamentos a base de plantas o la creación de arte inspirado en la naturaleza.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('ambiente-32', 'ambiente', '32. Entiendo que la Tierra es nuestra casa común y que tenemos la responsabilidad de protegerla para las generaciones presentes y futuras.', 'Entiendo que la Tierra es nuestra casa común y que tenemos la responsabilidad de protegerla para las generaciones presentes y futuras.

Preguntas orientadoras:
• ¿Cómo podemos proteger la tierra? ¿Qué fallas
• ambientales encuentro a mi alrededor?
• próximas generaciones?
• Scout para promover el cuidado de la casa común? ¿Y en
• mi casa, escuela o lugares que habito?', 3)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-32-a1', 'ambiente-32', 'Investigo sobre las fallas de cuidado ambiental en mi grupo scout y comunidad local y desarrollo actividades para reducirlas (por ejemplo, el uso o no de tachos diferenciados para los residuos).', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-32-a2', 'ambiente-32', 'Me involucro en iniciativas que fomenten la justicia ambiental, trabajando en colaboración para proteger nuestra casa común.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-32-a3', 'ambiente-32', 'Realizo una de las iniciativas o desafíos ambientales que propone Scouts de Argentina o la Organización Mundial del Movimiento Scout.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('ambiente-33', 'ambiente', '33. Descubro y valoro la belleza y diversidad de la naturaleza disfrutando de las aventuras que puedo vivir en ella.', 'Descubro y valoro la belleza y diversidad de la naturaleza disfrutando de las aventuras que puedo vivir en ella.

Preguntas orientadoras:
• hacer con mi equipo? ¿Qué lugares naturales me gustaría conocer?
• vivo? ¿Quién puede ayudarme a mejorar mi conocimiento sobre la biodiversidad de la región?
• años? ¿Qué aspectos se mantienen y cuáles se fueron
• perdiendo?', 4)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-33-a1', 'ambiente-33', 'Propongo, organizo y participo al menos en un proyecto del campo de acción viaje y aventura con mi equipo donde acampemos en un lugar nuevo.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-33-a2', 'ambiente-33', 'Con mi equipo propongo y organizo un Rally de descubierta o actividad sobre biodiversidad autóctona, identificando las principales especies de flora y fauna de la región donde vivo.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-33-a3', 'ambiente-33', 'Realizo mi Raid de Desafío o Compromiso en un campamento donde me desenvuelvo de forma autónoma', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('ambiente-34', 'ambiente', '34. Aprovecho toda oportunidad como un desafío para conectar con el mundo natural, cuidándolo y protegiéndolo.', 'Aprovecho toda oportunidad como un desafío para conectar con el mundo natural, cuidándolo y protegiéndolo.

Preguntas orientadoras:
• sobre la vida aire libre que necesito? ¿Cómo puedo ayudar
• a otras personas a aprender técnicas de vida al aire libre?
• actividades cada vez más desafiantes, atractivas y seguras?
• ¿Cuáles habilidades ya poseo y cuáles debo desarrollar?
• a nuestras actividades al aire libre? ¿Tenemos actividades
• de bajo impacto y contaminación?', 5)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-34-a1', 'ambiente-34', 'Desarrollo habilidades de campismo en actividades y/o campamentos (tipos de carpas, armado correcto de las mismas, elección del terreno para acampar, preparación para situaciones de tormentas, cocina al aire libre, tratamiento y conservación de alimentos, orientación, etc.) Diseño y realizo construcciones prácticas y sustentables en los campamentos de equipo o Comunidad.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-34-a2', 'ambiente-34', 'Me propongo asumir el rol del cuidado del fuego en campamentos, investigando el uso de fuegos, tipos de leñas y la aplicación adecuada de cada tipo de fuego.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-34-a3', 'ambiente-34', 'Aplico técnicas de bajo impacto (no dejando huellas) en mis actividades al aire libre.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-34-a4', 'ambiente-34', 'Participo regularmente de salidas, excursiones y campamentos en los que aplicamos técnicas de armado de vivacs y refugios improvisados y cocina rústica o sin utensilios.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('ambiente-35', 'ambiente', '35. Reconozco a la naturaleza como una fuente de bienestar para mí y de conexión con lo trascendente.', 'Reconozco a la naturaleza como una fuente de bienestar para mí y de conexión con lo trascendente.

Preguntas orientadoras:
• no me agradan tanto? ¿Cuáles son esas cosas?
• para la reflexión, la contemplación, la meditación, etc.?', 6)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-35-a1', 'ambiente-35', 'Realizo un Rally con instancias de reflexión y conexión conmigo mismo, en un entorno natural.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-35-a2', 'ambiente-35', 'Valoro las oportunidades que me propone la naturaleza (la brisa del viento, la fuerza del agua, la luz del fuego, el contacto con la tierra) para realizar actividades de introspección y reflexión.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-35-a3', 'ambiente-35', 'Practico actividades como meditación, oración, yoga o técnicas de relajación en la naturaleza.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('ambiente-35-a4', 'ambiente-35', 'Aprecio los momentos en que puedo disfrutar de la belleza y la serenidad del mundo natural y me esfuerzo por cultivar una relación armoniosa con él.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO areas (id, name, color, badge, sort_order) VALUES ('paz-desarrollo', 'Paz y desarrollo', '#6d3b7a', '', 3)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, color = EXCLUDED.color, badge = EXCLUDED.badge, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-15', 'paz-desarrollo', '15. Contribuyo pacíficamente a la resolución de conflictos evitando toda forma de intolerancia y violencia', 'Contribuyo pacíficamente a la resolución de conflictos evitando toda forma de intolerancia y violencia

Preguntas orientadoras:
• respetuosa? ¿Hay alguien a quien actualmente me
• gustaría pedirle perdón y no sé cómo hacerlo?
• problemas? ¿Busco recursos o apoyo externo para
• resolver conflictos de manera pacífica?
• del Movimiento Scout? ¿A quién le puedo pedir ayuda
• para conseguir más información?', 0)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-15-a1', 'paz-desarrollo-15', 'Realizo al menos un desafío sobre paz y diálogo que propone Scouts de Argentina o la Organización Mundial del Movimiento Scout.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-15-a2', 'paz-desarrollo-15', 'Realizo o participo de un proyecto enmarcado en la paz.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-15-a3', 'paz-desarrollo-15', 'Puedo buscar sobre las dimensiones de la paz que reconoce el Movimiento Scout (personal, comunidad y global).', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-15-a4', 'paz-desarrollo-15', 'Aplico los 10 principios del diálogo que promueve el Movimiento Scout para la promoción de culturas de paz.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-15-a5', 'paz-desarrollo-15', 'Me involucro en la resolución de situaciones de intolerancia y violencia dentro de mis espacios (equipo, comunidad, familia) posicionándome a favor de la paz.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-15-a6', 'paz-desarrollo-15', 'Sé pedir perdón cuando corresponde.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-16', 'paz-desarrollo', '16. Valoro mi historia e identidad y promuevo la herencia cultural de mi comunidad y país (costumbres, leyendas, danzas, mitos, artesanías, tradiciones)', 'Valoro mi historia e identidad y promuevo la herencia cultural de mi comunidad y país (costumbres, leyendas, danzas, mitos, artesanías, tradiciones)

Preguntas orientadoras:
• nuestra historia como país? ¿Cómo es mi participación
• en celebraciones y ceremonias patrias?
• ¿Cómo me defino a mí mismo/a? ¿Cómo se relaciona
• con mi comunidad o cultura? ¿Puedo reconocer alguna
• herencia cultural de mi familia?
• nombre de mi equipo y comunidad? ¿Me siento representado por los valores que nos describen? ¿Puedo
• reconstruir la historia de mi equipo o comunidad?', 1)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-16-a1', 'paz-desarrollo-16', 'Realizo un rally de descubierta con el objeto de conocer las manifestaciones folclóricas: historias, leyendas, personajes típicos, recetas de cocina, fiestas populares, bailes y otras manifestaciones artísticas y culturales propias de las comunidades visitadas.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-16-a2', 'paz-desarrollo-16', 'Expreso mi afecto por los valores de mi cultura por medio de alguna habilidad artística (música, danza, relato, pintura, artesanías, etc.).', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-16-a3', 'paz-desarrollo-16', 'Concientizo y me movilizo para preservar y promover la cultura de mi comunidad.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-16-a4', 'paz-desarrollo-16', 'Realizo al menos alguno de los desafíos de desarrollo comunitario y patrimonio que propone Scouts de Argentina o la Organización Mundial del Movimiento Scouts.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-16-a5', 'paz-desarrollo-16', 'Participo en eventos artísticos y culturales que se organizan en mi comunidad.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-16-a6', 'paz-desarrollo-16', 'Hago propio el nombre de mi equipo, comunidad caminante y grupo scout.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-16-a7', 'paz-desarrollo-16', 'Conozco su historia y tradiciones.', 6)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-16-a8', 'paz-desarrollo-16', 'Me apropio de los símbolos patrios de mi país y participo respetuosamente de ceremonias y celebraciones patrias.', 7)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-16-a9', 'paz-desarrollo-16', 'Conozco y acepto la historia de mi familia y herencia cultural.', 8)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-17', 'paz-desarrollo', '17. Desarrollo estrategias para promover y difundir los Derechos Humanos.', 'Desarrollo estrategias para promover y difundir los Derechos Humanos.

Preguntas orientadoras:
• nuestra historia como país? ¿Cómo es mi participación
• en celebraciones y ceremonias patrias?
• nuestra historia como país? ¿Cómo es mi participación
• en celebraciones y ceremonias patrias?
• nombre de mi equipo y comunidad? ¿Me siento representado por los valores que nos describen? ¿Puedo
• reconstruir la historia de mi equipo o comunidad?
• nombre de mi equipo y comunidad? ¿Me siento representado por los valores que nos describen? ¿Puedo
• reconstruir la historia de mi equipo o comunidad?', 2)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-17-a1', 'paz-desarrollo-17', 'Realizo un rally de descubierta para conocer los organismos de Derechos Humanos en mi comunidad local.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-17-a2', 'paz-desarrollo-17', 'Elijo, junto a mi equipo, al menos un Derecho Humano y llevamos adelante una actividad de promoción de ese derecho.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-17-a3', 'paz-desarrollo-17', 'Conozco mis Derechos.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-17-a4', 'paz-desarrollo-17', 'Observo y hago observar la Declaración de los niños, niñas y adolescentes; los Objetivos de Desarrollo Sostenible y aquellas leyes destinadas a proteger mis derechos.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-17-a5', 'paz-desarrollo-17', 'Utilizo herramientas como la Carta de comunidad o los foros y encuentros de juventudes para conversar sobre nuestros derechos a ser escuchados, a tener una identidad, al juego y a ser protegidos de la violencia.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-17-a6', 'paz-desarrollo-17', 'Denuncio vulneraciones de derechos utilizando los mecanismos apropiados de mi localidad y los propios de la asociación (Protocolos, teléfonos, organismos públicos y privados).', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-18', 'paz-desarrollo', '18. Ejercito plena y responsablemente mis derechos como ciudadano y los promuevo en todos los ámbitos en donde me desarrollo, con una mirada crítica de la realidad.', 'Ejercito plena y responsablemente mis derechos como ciudadano y los promuevo en todos los ámbitos en donde me desarrollo, con una mirada crítica de la realidad.

Preguntas orientadoras:
• obligaciones como miembro de Scouts de Argentina?
• ¿Quién puede ayudarme en esto? ¿Dónde obtengo
• información confiable al respecto?
• organismo de nuestra asociación? ¿Puedo yo asumir esa
• responsabilidad? ¿Sé cómo hacerlo, sus responsabilidades y obligaciones?
• Qué significa la política en mi vida y en la de mis compañeras y compañeros? ¿Me atrevo e intereso por participar
• vida? ¿Dónde y cómo me informo antes de participar de', 3)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-18-a1', 'paz-desarrollo-18', 'Participo en talleres, encuentros o experiencias relacionadas a mis derechos y obligaciones como ciudadano/a y como miembro de Scouts de Argentina.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-18-a2', 'paz-desarrollo-18', 'Realizo tutorías o genero actividades y debates sobre la democracia, las plataformas electorales y los espacios de participación.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-18-a3', 'paz-desarrollo-18', 'Participo activamente en la elaboración y revisión de la Carta de Comunidad Caminante.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-18-a4', 'paz-desarrollo-18', 'Acuerdo con las normas de convivencia de mi comunidad.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-18-a5', 'paz-desarrollo-18', 'Participo y promuevo la participación en las reuniones y órganos de gobierno de mi equipo y la Comunidad Caminante.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-18-a6', 'paz-desarrollo-18', 'Valoro la participación juvenil y la función de representante juvenil como experiencia de aprendizaje sobre la toma de decisiones y el consenso.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-18-a7', 'paz-desarrollo-18', 'Reconozco además distintos espacios de participación juvenil en las instituciones en las que participo (Por ejemplo, centro de estudiantes) Ejerzo mis votos de manera informada y consciente.', 6)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-19', 'paz-desarrollo', '19. Fomento ámbitos de participación democráticos, respetando las decisiones tomadas sin renunciar a mi derecho a luchar por su cambio.', 'Fomento ámbitos de participación democráticos, respetando las decisiones tomadas sin renunciar a mi derecho a luchar por su cambio.

Preguntas orientadoras:
• elegido lo que esperaba?
• podamos dar nuestra opinión y se respeten las ideas?
• ¿Es una práctica habitual de mi equipo o comunidad?
• equipo o mi comunidad para exponer mis ideas, defenderlas, brindar argumentos, etc.? ¿Utilizo los espacios
• adecuados para ello?
• nuestra historia como país? ¿Cómo es mi participación
• en celebraciones y ceremonias patrias?', 4)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-19-a1', 'paz-desarrollo-19', 'Respeto las decisiones tomadas democráticamente y, si no salió elegido aquello que esperaba, utilizo la experiencia como aprendizaje, regulando la frustración y colaborando positivamente.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-19-a2', 'paz-desarrollo-19', 'Me comprometo con las decisiones que tomamos, siendo consecuente con mis acciones.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-19-a3', 'paz-desarrollo-19', 'Trabajo en equipo y colaboro para tomar decisiones consensuadas.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-19-a4', 'paz-desarrollo-19', 'Defiendo mis convicciones de forma pacífica, sin imponer mi opinión ni faltar el respeto a las demás personas.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-19-a5', 'paz-desarrollo-19', 'Me comprometo con procesos democráticos para elegir las actividades y proyectos que realizaremos con nuestro equipo o comunidad caminante.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-19-a6', 'paz-desarrollo-19', 'Cuando tomamos decisiones, como en el Consejo de equipo, me aseguro de que todas las personas puedan dar su opinión y promuevo el respeto a las ideas.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-20', 'paz-desarrollo', '20. Defiendo colectivamente los Derechos de las infancias, juventudes y mujeres y promuevo acciones que contribuyan a garantizarlos.', 'Defiendo colectivamente los Derechos de las infancias, juventudes y mujeres y promuevo acciones que contribuyan a garantizarlos.

Preguntas orientadoras:
• las infancias, juventudes y las mujeres?
• juventudes y mujeres en el Grupos Scout? ¿Y en la
• Asociación o en el lugar donde vivo?
• de estos derechos? ¿Conozco los protocolos
• adecuados para esto?', 5)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-20-a1', 'paz-desarrollo-20', 'Realizo tutorías o genero actividades con mi equipo sobre los derechos de las infancias, juventudes y mujeres.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-20-a2', 'paz-desarrollo-20', 'Participo en iniciativas, proyectos y/u organizaciones que trabajan la promoción de Derechos Humanos, en particular lo de las infancias, adolescencias y mujeres.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-20-a3', 'paz-desarrollo-20', 'Realizo, junto a mi equipo, una presentación o recurso visual sobre los mecanismos de denuncia de vulneración de derechos.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-20-a4', 'paz-desarrollo-20', 'Utilizo mis redes personales o las de mi equipo, comunidad o grupo scout para participar en campañas a favor de los Derechos Humanos o denunciar su vulneración.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-21', 'paz-desarrollo', '21. Cuestiono mis prejuicios y estereotipos culturales entendiendo cómo estos influyen en las interacciones con otras personas.', 'Cuestiono mis prejuicios y estereotipos culturales entendiendo cómo estos influyen en las interacciones con otras personas.

Preguntas orientadoras:
• vivo? ¿Y en la Comunidad Caminante y el Grupo Scout?
• ¿Es importante cuestionar mis prejuicios y estereotipos?
• ¿Por qué? ¿De dónde provienen estos prejuicios y cómo
• han sido influenciados por mi entorno?
• sexual? ¿Mi posición frente a la diversidad sexual y de
• géneros es coherente con los valores del Movimiento?', 6)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-21-a1', 'paz-desarrollo-21', 'Participo en iniciativas, proyectos u organizaciones que prevengan la discriminación y promuevan la igualdad.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-21-a2', 'paz-desarrollo-21', 'Alzo la voz y denuncio la discriminación utilizando los mecanismos correspondientes.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-21-a3', 'paz-desarrollo-21', 'No me callo ante los estereotipos de género, de edad o sociales.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-21-a4', 'paz-desarrollo-21', 'Realizo cursos y capacitaciones sobre cómo reconocer, prevenir y tomar acción frente a un comportamiento inapropiado.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-21-a5', 'paz-desarrollo-21', 'No asumo la identidad, sexualidad o nacionalidad de ninguna persona.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-21-a6', 'paz-desarrollo-21', 'Comprendo la diversidad sexual y de géneros, respetándola y denunciando la discriminación.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-22', 'paz-desarrollo', '22. Trabajo activamente para facilitar y promover la participación e inclusión de todas las personas en mis actividades', 'Trabajo activamente para facilitar y promover la participación e inclusión de todas las personas en mis actividades

Preguntas orientadoras:
• sexual? ¿Mi posición frente a la diversidad sexual y de
• géneros es coherente con los valores del Movimiento?
• desigualdades? ¿Cuáles son algunas formas creativas en
• actividades para promover la inclusión y la equidad?
• organismo de nuestra asociación? ¿Puedo yo asumir esa
• responsabilidad? ¿Sé cómo hacerlo, sus responsabilidades y obligaciones?', 7)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-22-a1', 'paz-desarrollo-22', 'Evalúo, junto a mi equipo, si mi grupo scout y mi barrio son espacios inclusivos y equitativos, tanto para la diversidad como para la discapacidad.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-22-a2', 'paz-desarrollo-22', 'Realizo proyectos enmarcados en la reducción de desigualdades y promoción de la inclusión.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-22-a3', 'paz-desarrollo-22', 'Conozco las redes de apoyo que tiene mi comunidad local y Scouts de Argentina para la inclusión de personas con discapacidad.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-23', 'paz-desarrollo', '23. Me involucro de forma empática y activa, en acciones solidarias en la comunidad.', 'Me involucro de forma empática y activa, en acciones solidarias en la comunidad.

Preguntas orientadoras:
• Sostenible (ODS)? ¿Qué actividades relacionadas con los
• Comunidad Caminante?
• de esto? ¿Qué acciones solidarias realizo día a día que
• representen esta idea?
• solidaridad, pero ¿qué significa la solidaridad para mí?', 8)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-23-a1', 'paz-desarrollo-23', 'Realizo o participo en al menos un proyecto del campo de acción solidaridad con mi equipo.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-23-a2', 'paz-desarrollo-23', 'Elaboro propuestas de acción y actividades enmarcadas en los Objetivos de Desarrollo Sostenible (ODS).', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-23-a3', 'paz-desarrollo-23', 'Realizo al menos una acción solidaria en mis Raids.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-23-a4', 'paz-desarrollo-23', 'Organizo campañas de donación de sangre, alimentos, ropa, elementos de higiene y salud menstrual o aquellos que mi comunidad local necesite.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-24', 'paz-desarrollo', '24. Me preocupo por las personas que me rodean, sus necesidades y busco maneras de hacer una diferencia positiva en sus vidas', 'Me preocupo por las personas que me rodean, sus necesidades y busco maneras de hacer una diferencia positiva en sus vidas

Preguntas orientadoras:
• personas me rodean (equipo, familia, Comunidad Caminante, amigas y amigos, etc.)? ¿Cómo demuestro que
• estoy ahí para dar apoyo?
• ¿Por qué es importante la buena acción? ¿Es una idea
• que pasó de moda o sigue vigente?
• sociales de mi comunidad? ¿Sobre qué problemas
• suelo conversar con mi equipo y Comunidad Caminante?', 9)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-24-a1', 'paz-desarrollo-24', 'Promuevo el debate en mi comunidad sobre los problemas sociales e injusticias detectadas.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-24-a2', 'paz-desarrollo-24', 'Valoro los espacios de conversación de los foros, encuentros de juventudes o asambleas para trabajar estas temáticas.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-24-a3', 'paz-desarrollo-24', 'Me intereso y empatizo con las necesidades y preocupaciones de las personas cercanas a mí.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-24-a4', 'paz-desarrollo-24', 'Le doy mi apoyo a mi equipo, comunidad y familia si lo necesitan.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-24-a5', 'paz-desarrollo-24', 'Utilizo los espacios de co-evaluación del Diario de Marcha para escuchar sobre las dificultades, preocupaciones y necesidades de las personas que integran mi equipo o comunidad.', 4)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-24-a6', 'paz-desarrollo-24', 'Busco realizar una buena acción diaria en mi hogar, escuela o cualquier espacio en el que participe.', 5)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-25', 'paz-desarrollo', '25. Realizo un Rally de descubierta en los que identifico y mapeo las situaciones problemáticas de mi comunidad local e investigo sus orígenes o causas.', 'Realizo un Rally de descubierta en los que identifico y mapeo las situaciones problemáticas de mi comunidad local e investigo sus orígenes o causas.

Preguntas orientadoras:
• sociales del barrio y la ciudad?
• ¿Me permito cuestionar o dudar de aquellas afirmaciones que considero verdaderas? ¿Qué evidencia o datos
• respaldan mis opiniones?
• puedo influir en ellas? ¿Qué puedo hacer para mantenerme informado/a y actualizado/a sobre los problemas
• sociales y las iniciativas de cambio en curso?', 10)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-25-a1', 'paz-desarrollo-25', 'Identifico y analizo los factores que contribuyen a la existencia de problemas sociales, desarrollando una actitud crítica, actuando de manera coherente y responsable en mi entorno.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-25-a2', 'paz-desarrollo-25', 'Discuto con mi equipo o Comunidad Caminante sobre los factores que contribuyen a la existencia de problemas sociales.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-25-a3', 'paz-desarrollo-25', 'Realizo al menos alguno de los desafíos sobre paz y desarrollo comunitario que propone Scouts de Argentina o la Organización Mundial del Movimiento Scout.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-25-a4', 'paz-desarrollo-25', 'Utilizo las herramientas de los foros o encuentros de juventudes para declarar o manifestar aquellas preocupaciones e intereses que tenemos como jóvenes.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-26', 'paz-desarrollo', '26. Me cuestiono sobre las posturas respecto al origen, la grandeza, belleza y misterios de todo lo que soy, somos y nos rodea.', 'Me cuestiono sobre las posturas respecto al origen, la grandeza, belleza y misterios de todo lo que soy, somos y nos rodea.

Preguntas orientadoras:
• ¿Cuál es el sentido y el propósito de mi vida?
• ¿Quién soy? ¿Por qué estoy aquí?
• ¿Cuál es mi futuro?
• ¿Qué define las diferencias entre el bien y el mal?
• ¿Qué es lo correcto? ¿Por qué debo hacerlo?
• ¿Por qué hay tanta maldad en el mundo?
• ¿Cuál es mi herencia espiritual? ¿Cómo se manifiesta esa
• herencia en mi vida?', 11)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-26-a1', 'paz-desarrollo-26', 'Encuentro en los campamentos las oportunidades de reflexión y cuestionamiento, aprovechando los entornos naturales, fogones o espacios de relajación.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-26-a2', 'paz-desarrollo-26', 'Busco respuestas a mis grandes preguntas en diferentes opciones espirituales, religiosas o en las distintas creencias.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-26-a3', 'paz-desarrollo-26', 'Utilizo el Diario de Marcha para explorar lo invisible en mí, sobre quién soy, de dónde vengo y hacia dónde voy.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-27', 'paz-desarrollo', '27. Dialogo con las demás personas sobre lo que creo, promoviendo el entendimiento.', 'Dialogo con las demás personas sobre lo que creo, promoviendo el entendimiento.

Preguntas orientadoras:
• entre personas que tienen diferentes creencias?
• ¿Qué acciones o eventos promueven el diálogo interreligioso en mi grupo scout o comunidad?', 12)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-27-a1', 'paz-desarrollo-27', 'Participo en proyectos y actividades que me permiten conocer, actuar y dialogar con jóvenes de diferentes opciones espirituales.', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-27-a2', 'paz-desarrollo-27', 'Promuevo el diálogo, el entendimiento y la paz entre las personas.', 1)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-27-a3', 'paz-desarrollo-27', 'Realizo una descubierta sobre las opciones religiosas y espirituales presentes en mi comunidad.', 2)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;
INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-27-a4', 'paz-desarrollo-27', 'Realizo al menos uno de los desafíos sobre paz y diálogo que propone Scouts de Argentina o la Organización Mundial del Movimiento Scout.', 3)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

INSERT INTO topics (id, area_id, title, body, sort_order) VALUES ('paz-desarrollo-28', 'paz-desarrollo', '28. Reconozco cómo mis creencias, prioridades \YDORUHVLQƮX\HQHQPLVGHFLVLRQHVFRWLGLDQDV SDUDYLYLUGHPDQHUDDXWÄQWLFD\FRKHUHQWHFRQ lo que creo y valoro', 'Reconozco cómo mis creencias, prioridades \YDORUHVLQƮX\HQHQPLVGHFLVLRQHVFRWLGLDQDV SDUDYLYLUGHPDQHUDDXWÄQWLFD\FRKHUHQWHFRQ lo que creo y valoro', 13)
ON CONFLICT (id) DO UPDATE SET area_id = EXCLUDED.area_id, title = EXCLUDED.title, body = EXCLUDED.body, sort_order = EXCLUDED.sort_order;

INSERT INTO activities (id, topic_id, title, sort_order) VALUES ('paz-desarrollo-28-a1', 'paz-desarrollo-28', '5HFRQR]FRHOVLJQLƬFDGRGHOD/H\6FRXW\ORVSULQFLSLRVHQHVWD HWDSDGHPLYLGD )RUPXORPLFRPSURPLVRFDPLQDQWHDGKLULHQGRYROXQWDULDPHQWHDORVYDORUHVTXHHO0RYLPLHQWRQRVSURSRQH 5HƮH[LRQRVREUHORVYDORUHVGHOD3URPHVD\OD/H\6FRXWHQPL HTXLSR\PL&RPXQLGDG&DPLQDQWH ,QYHVWLJRVREUHDTXHOODVSHUVRQDVTXHFRQVLGHURTXHVRQ FRKHUHQWHVHQWUHVXVYDORUHV\VXYLGDFRWLGLDQD\FRPSDUWRHVWD LQIRUPDFLÎQFRQPLHTXLSR\FRPXQLGDG 8WLOL]RPL''LDULRGH0DUFKDSDUDDQDOL]DUPLVDFFLRQHVEXVFDQGR FRKHUHQFLDHQWUHORTXHKDJR\ORTXHFUHR', 0)
ON CONFLICT (id) DO UPDATE SET topic_id = EXCLUDED.topic_id, title = EXCLUDED.title, sort_order = EXCLUDED.sort_order;

-- Limpieza de áreas/fichas que ya no están en el catálogo
DELETE FROM likes WHERE topic_id IN (SELECT id FROM topics WHERE area_id NOT IN ('salud-bienestar', 'habilidades-vida', 'ambiente', 'paz-desarrollo'));
DELETE FROM topic_notes WHERE topic_id IN (SELECT id FROM topics WHERE area_id NOT IN ('salud-bienestar', 'habilidades-vida', 'ambiente', 'paz-desarrollo'));
DELETE FROM topic_stage_evals WHERE topic_id IN (SELECT id FROM topics WHERE area_id NOT IN ('salud-bienestar', 'habilidades-vida', 'ambiente', 'paz-desarrollo'));
DELETE FROM action_progress WHERE activity_id IN (SELECT a.id FROM activities a JOIN topics t ON t.id = a.topic_id WHERE t.area_id NOT IN ('salud-bienestar', 'habilidades-vida', 'ambiente', 'paz-desarrollo'));
DELETE FROM activities WHERE topic_id IN (SELECT id FROM topics WHERE area_id NOT IN ('salud-bienestar', 'habilidades-vida', 'ambiente', 'paz-desarrollo'));
DELETE FROM topics WHERE area_id NOT IN ('salud-bienestar', 'habilidades-vida', 'ambiente', 'paz-desarrollo');
DELETE FROM areas WHERE id NOT IN ('salud-bienestar', 'habilidades-vida', 'ambiente', 'paz-desarrollo');

INSERT INTO content_meta (key, value) VALUES ('version', '2')
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;

COMMIT;
