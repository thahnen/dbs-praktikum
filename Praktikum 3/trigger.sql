drop function log_preis();
create function log_preis()
returns trigger as '
  declare
    lastChange record;
  begin
    if (TG_OP = ''UPDATE'') then
      raise notice ''TRIGGER1'';
      select * into lastChange from letzterpreis where pnr = old.pnr;
      if (found and lastChange.gueltigab >= new.gueltigab) then
        raise exception ''gueltigab must be > %'', lastChange.gueltigab;
      end if;
      if (not found or (lastChange.preis != new.preis and lastChange.gueltigab < new.gueltigab)) then
      --if (not found or (old.preis != new.preis and old.gueltigab < new.gueltigab)) then
        -- ???
        raise notice ''TRIGGER2'';
        insert into preishist(preis, gueltigab, pnr) values(old.preis, old.gueltigab, old.pnr);
      end if;
    end if;
    return new;
  end;
' language 'plpgsql';

--drop trigger log_preis on produkt;
create trigger log_preis
  before update on produkt
  for each row execute procedure log_preis();
