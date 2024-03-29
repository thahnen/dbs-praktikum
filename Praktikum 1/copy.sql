-- 1.4) Schreiben Sie ...

-- Kodierung setzen und aus CSV importieren
\encoding utf8
\copy import from 'dbsnam-utf8.csv' delimiter ';'

-- In Tabellen einfügen
INSERT INTO abteilung (
    nr, name
) SELECT DISTINCT
    abteilungnr,
    abteilungname
FROM import;

INSERT INTO person (
    nr,
    name,
    vorname,
    geburt,
    abteilungnr,
    gehalt,
    ort
) SELECT
    CAST (nr AS int),
    name,
    vorname,
    to_date(geburt, 'DD.MM.YYYY'),
    abteilungnr,
    to_number(gehalt, '00000D00'),
    ort
FROM import;
