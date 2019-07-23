/*
    Drop the function and the used view
*/
DROP FUNCTION IF EXISTS preis_at(varchar, date);
DROP VIEW IF EXISTS preishistorie;

CREATE VIEW preishistorie AS (
    SELECT pnr, name, preis, gueltigab
    FROM produkt
    UNION
    SELECT ph.pnr, p.name, ph.preis, ph.gueltigab
    FROM preishist ph, produkt p
    WHERE ph.pnr=p.pnr
) ORDER BY name, gueltigab;

CREATE FUNCTION preis_at(varchar, date) RETURNS RECORD AS '
    SELECT * FROM preishistorie
    WHERE pnr=$1 AND gueltigab<=$2
    ORDER BY gueltigab DESC LIMIT 1;
' LANGUAGE SQL;
