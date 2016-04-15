# --- !Ups
CREATE TABLE News (
    id bigint(20) NOT NULL AUTO_INCREMENT,
    title varchar(255) NOT NULL,
    content text NOT NULL,
    date bigint(12) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Event (
    id bigint(20) NOT NULL AUTO_INCREMENT,
    title varchar(255) NOT NULL,
    location varchar(255) NOT NULL,
    date bigint(12) NOT NULL,
    description text NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Sig (
    id varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    description text NOT NULL,
    PRIMARY KEY (id)
);


INSERT INTO News(title, content, date) values ('Noticia 1', 'Contenido de la primera noticia', 1460689973);
INSERT INTO News(title, content, date) values ('Noticia 2', 'Contenido de la segunda noticia', 1460689973);
INSERT INTO News(title, content, date) values ('Noticia 3', 'Contenido de la tercera noticia', 1460689973);
INSERT INTO News(title, content, date) values ('Noticia 4', 'Contenido de la cuarta noticia', 1460689973);
INSERT INTO News(title, content, date) values ('Noticia 5', 'Contenido de la quinta noticia', 1460689973);

INSERT INTO Event(title, location, description, date) values ('Evento 1', 'Lugar imaginario a la hora que quieras.', 'Curso genérico de un lenguaje de programación que nadie usa y en el que no vas a aprender nada.', 1460689973);
INSERT INTO Event(title, location, description, date) values ('Evento 2', 'Lugar imaginario a la hora que quieras.', 'Curso genérico de un lenguaje de programación que nadie usa y en el que no vas a aprender nada.', 1428192000);
INSERT INTO Event(title, location, description, date) values ('Evento 3', 'Lugar imaginario a la hora que quieras.', 'Curso genérico de un lenguaje de programación que nadie usa y en el que no vas a aprender nada.', 1428192000);
INSERT INTO Event(title, location, description, date) values ('Evento 4', 'Lugar imaginario a la hora que quieras.', 'Curso genérico de un lenguaje de programación que nadie usa y en el que no vas a aprender nada.', 1395532800);

INSERT INTO Sig(id, name, description) values ('gamedev', 'GameDev', 'Sig de videojuegos y poco más.');
INSERT INTO Sig(id, name, description) values ('seguridad', 'Seguridad', 'Sig de seguridad y poco más.');
INSERT INTO Sig(id, name, description) values ('generic', 'Genérico', 'Sig genérico y poco más.');

# --- !Downs
DROP TABLE News;
DROP TABLE Event;
DROP TABLE Sig;
