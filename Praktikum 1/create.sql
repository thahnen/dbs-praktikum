-- 1.4) Erstellen ...

DROP TABLE IF EXISTS import;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS abteilung;

CREATE TABLE import (
    nr varchar(255),
    ort varchar(255),
    geburt varchar(255),
    name varchar(255),
    vorname varchar(255),
    abteilungname varchar(255),
    abteilungnr varchar(255),
    gehalt varchar(255)
);

CREATE TABLE abteilung (
    nr varchar(255),
    name varchar(255),
    PRIMARY KEY (nr)
);

CREATE TABLE person (
    nr int,
    name varchar(255),
    vorname varchar(255),
    geburt date,
    abteilungnr varchar(255),
    gehalt numeric(7, 2),
    ort varchar(255),
    PRIMARY KEY (nr),
    FOREIGN KEY (abteilungnr) REFERENCES abteilung (nr)
);
