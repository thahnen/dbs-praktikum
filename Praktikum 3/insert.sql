/*
    INSERT test VALUES
*/
INSERT INTO hersteller (hnr, name) VALUES ('1', 'Pritt');
INSERT INTO hersteller (hnr, name) VALUES ('2', 'Uhu');
INSERT INTO hersteller (hnr, name) VALUES ('3', 'Pencil');
INSERT INTO hersteller (hnr, name) VALUES ('4', 'Tempo');
INSERT INTO hersteller (hnr, name) VALUES ('5', 'Extra');

INSERT INTO produkt (
    pnr, name, hnr, preis, gueltigab
) VALUES (
    '1', 'Klebestift', '1', 1.20, to_date('07.06.2019', 'DD.MM.YYYY')
);
INSERT INTO produkt (
    pnr, name, hnr, preis, gueltigab
) VALUES (
    '2', 'Sekundenkleber', '2', 2.20, to_date('08.06.2019', 'DD.MM.YYYY')
);
INSERT INTO produkt (
    pnr, name, hnr, preis, gueltigab
) VALUES (
    '3', 'Stift', '3', 3.20, to_date('09.06.2019', 'DD.MM.YYYY')
);
INSERT INTO produkt (
    pnr, name, hnr, preis, gueltigab
) VALUES (
    '4', 'Tuch', '4', 4.20, to_date('10.06.2019', 'DD.MM.YYYY')
);
INSERT INTO produkt (
    pnr, name, hnr, preis, gueltigab
) VALUES (
    '5', 'Kaugummi', '5', 5.20, to_date('11.06.2019', 'DD.MM.YYYY')
);
INSERT INTO produkt (
    pnr, name, hnr, preis, gueltigab
) VALUES (
    '6', 'Patafix', '2', 0.20, to_date('12.06.2019', 'DD.MM.YYYY')
);
