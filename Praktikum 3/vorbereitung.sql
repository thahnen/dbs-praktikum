select * from preishist ph, produkt p where ph.pnr = p.pnr and name = 'Klebestift' and to_date('15.07.2019','DD.MM.YYYY') >= ph.gueltigab order by ph.gueltigab desc limit 1;
