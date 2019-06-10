\i create.sql
\i insert.sql
\i trigger.sql

UPDATE produkt
SET preis=10, gueltigab=to_date('01.07.2019', 'DD.MM.YYYY')
WHERE pnr='1';

UPDATE produkt
SET preis=20, gueltigab=to_date('02.07.2019', 'DD.MM.YYYY')
WHERE pnr='1';

UPDATE produkt
SET preis=30, gueltigab=to_date('02.07.2019', 'DD.MM.YYYY')
WHERE pnr='2';
