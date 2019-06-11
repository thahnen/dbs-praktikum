/*
    Create trigger to add to "preishist"
    Triggered on update on "produkt"
*/
DROP FUNCTION IF EXISTS log_preis();
CREATE FUNCTION log_preis() RETURNS TRIGGER AS '
    DECLARE
        lastChange record;
    BEGIN
        -- i do not know if this is necessary?
        IF (TG_OP = ''UPDATE'') THEN
            RAISE NOTICE ''TRIGGER1'';

            -- gets the last price for the given product number
            SELECT * INTO lastChange
            FROM letzterpreis
            WHERE pnr=OLD.pnr;

            -- handle the case that the new date is older than the old one
            IF (FOUND AND lastChange.gueltigab >= NEW.gueltigab) THEN
                RAISE EXCEPTION ''gueltigab must be > %'', lastChange.gueltigab;
            END IF;

            -- add the new price if it changed and there is a new date
            IF (NOT FOUND OR (lastChange.preis != NEW.preis AND lastChange.gueltigab < NEW.gueltigab)) THEN
                RAISE NOTICE ''TRIGGER2'';

                INSERT INTO preishist (
                    preis, gueltigab, pnr
                ) VALUES (
                    OLD.preis, OLD.gueltigab, OLD.pnr
                );
            END IF;
        END IF;
        RETURN NEW;
    END;
' LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS log_preis ON produkt;
CREATE TRIGGER log_preis
    BEFORE UPDATE ON produkt
    FOR EACH ROW EXECUTE PROCEDURE log_preis();
