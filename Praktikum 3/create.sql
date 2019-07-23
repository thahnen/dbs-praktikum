/*
    Drop everything to create again!
*/
DROP FUNCTION IF EXISTS preis_at(varchar, date);
DROP VIEW IF EXISTS preishistorie;
DROP VIEW IF EXISTS letzterpreis;
DROP TABLE IF EXISTS preishist;
DROP SEQUENCE IF EXISTS preishistNr;
DROP TABLE IF EXISTS produkt;
DROP TABLE IF EXISTS hersteller;

/*
    Create tables from scratch!
*/
CREATE TABLE hersteller (
    hnr varchar (4),
    name varchar (30),
    PRIMARY KEY (hnr)
);

CREATE TABLE produkt (
    pnr varchar (4),
    name varchar (30),
    hnr varchar (4),
    preis numeric (8,2),
    gueltigab date,
    PRIMARY KEY (pnr),
    FOREIGN KEY (hnr) REFERENCES hersteller (hnr)
);

CREATE SEQUENCE preishistNr START 1 INCREMENT 1;

CREATE TABLE preishist (
    nr numeric (6) DEFAULT nextval('preishistNr'),
    preis numeric (8,2),
    gueltigab date,
    pnr varchar (4),
    PRIMARY KEY (nr),
    FOREIGN KEY (pnr) REFERENCES produkt (pnr)
);

/*
    Create view for easier access!
*/
CREATE VIEW letzterpreis AS
    SELECT p.nr, p.pnr, p.preis, p.gueltigab
    FROM preishist AS p, (
        SELECT pnr, max(gueltigab) AS gueltigab
        FROM preishist WHERE pnr IN (
            SELECT DISTINCT pnr FROM preishist
        ) GROUP BY pnr
    ) x
    WHERE p.pnr=x.pnr AND p.gueltigab=x.gueltigab;
