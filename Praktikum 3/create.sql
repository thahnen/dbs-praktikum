create table hersteller (
  hnr   varchar(4),
  name  varchar(30),
  primary key (hnr)
);


create table produkt (
  pnr         varchar(4),
  name        varchar(30),
  hnr         varchar(4),
  preis       numeric(8,2),
  gueltigab   date,
  primary key (pnr),
  foreign key (hnr) references hersteller (hnr)
);

create sequence preishistNr start 1 increment 1;

create table preishist (
  nr          numeric(6) default nextval('preishistNr'),
  preis       numeric(8,2),
  gueltigab   date,
  pnr         varchar(4),
  primary key (nr),
  foreign key (pnr) references produkt (pnr)
);

create view letzterpreis as 
  select p.nr, p.pnr, p.preis, p.gueltigab 
  from preishist as p, 
    (select pnr, max(gueltigab) as gueltigab 
    from preishist where pnr in 
      (select distinct pnr from preishist)
    group by pnr) x 
  where p.pnr = x.pnr and p.gueltigab = x.gueltigab;

insert into hersteller (hnr, name) values ('1','Pritt');
insert into hersteller (hnr, name) values ('2','Uhu');
insert into hersteller (hnr, name) values ('3','Pencil');
insert into hersteller (hnr, name) values ('4','Tempo');
insert into hersteller (hnr, name) values ('5','Extra');

insert into produkt (pnr, name, hnr, preis, gueltigab) 
values ('1','Klebestift','1',1.20,to_date('07.06.2019','DD.MM.YYYY'));
insert into produkt (pnr, name, hnr, preis, gueltigab) 
values ('2','Sekundenkleber','2',2.20,to_date('08.06.2019','DD.MM.YYYY'));
insert into produkt (pnr, name, hnr, preis, gueltigab) 
values ('3','Stift','3',3.20,to_date('09.06.2019','DD.MM.YYYY'));
insert into produkt (pnr, name, hnr, preis, gueltigab) 
values ('4','Tuch','4',4.20,to_date('10.06.2019','DD.MM.YYYY'));
insert into produkt (pnr, name, hnr, preis, gueltigab) 
values ('5','Kaugummi','5',5.20,to_date('11.06.2019','DD.MM.YYYY'));
insert into produkt (pnr, name, hnr, preis, gueltigab) 
values ('6','Patafix','2',0.20,to_date('12.06.2019','DD.MM.YYYY'));
