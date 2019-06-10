SELECT * FROM preishist ph, produkt p
WHERE ph.pnr=p.pnr AND name='Klebestift' AND to_date('15.07.2019', 'DD.MM.YYYY')>=ph.gueltigab
ORDER BY ph.gueltigab DESC LIMIT 1;
