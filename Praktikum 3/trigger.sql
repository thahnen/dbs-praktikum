/*
    Create trigger to add to "preishist"
    Triggered on update on "produkt"
*/
DROP FUNCTION IF EXISTS log_preis();
CREATE FUNCTION log_preis() returns trigger AS '
    declare
        lastChange record;
    begin
        if (TG_OP = ''UPDATE'') then
            raise notice ''TRIGGER1'';

            SELECT * INTO lastChange
            FROM letzterpreis
            WHERE pnr=old.pnr;

            if (found and lastChange.gueltigab >= new.gueltigab) then
                raise exception ''gueltigab must be > %'', lastChange.gueltigab;
            end if;

            if (not found or (lastChange.preis != new.preis and lastChange.gueltigab < new.gueltigab)) then
                --if (not found or (old.preis != new.preis and old.gueltigab < new.gueltigab)) then
                -- ???
                raise notice ''TRIGGER2'';

                INSERT INTO preishist (
                    preis, gueltigab, pnr
                ) VALUES (
                    old.preis, old.gueltigab, old.pnr
                );
            end if;
        end if;
        return new;
    end;
' language 'plpgsql';

DROP TRIGGER IF EXISTS log_preis ON produkt;
CREATE TRIGGER log_preis
    before UPDATE ON produkt
    for each row execute procedure log_preis();
