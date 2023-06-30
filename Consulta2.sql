DROP TABLE encuesta_pregunta;
DROP TABLE pregunta;

ALTER TABLE encuesta
ADD COLUMN pregunta1 INT(2) NOT NULL,
ADD COLUMN pregunta2 INT(2) NOT NULL,
ADD COLUMN pregunta3 INT(2) NOT NULL,
ADD COLUMN pregunta4 INT(2) NOT NULL,
ADD COLUMN pregunta5 INT(2) NOT NULL,
ADD COLUMN pregunta6 INT(2) NOT NULL,
ADD COLUMN pregunta7 INT(2) NOT NULL;


ALTER TABLE usuario DROP COLUMN usuario_contrasena;
ALTER TABLE usuario ADD correo VARCHAR(100);
