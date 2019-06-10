\i drop.sql
\i create.sql
\i trigger.sql

update produkt set preis = 10, gueltigab = to_date('01.07.2019','DD.MM.YYYY') where pnr = '1';
update produkt set preis = 20, gueltigab = to_date('02.07.2019','DD.MM.YYYY') where pnr = '1';
update produkt set preis = 30, gueltigab = to_date('02.07.2019','DD.MM.YYYY') where pnr = '2';

