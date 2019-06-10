-- 1.4) Aus welchem ...
SELECT ort, count(nr) FROM person GROUP BY ort;

-- 1.4) Wie heisst ...
SELECT person.vorname, person.name, abteilung.name
FROM person, abteilung
WHERE person.abteilungnr=abteilung.nr AND person.vorname='Norbert' AND person.name='Herrling';

-- 1.4) Was ist ...
SELECT cast(avg(person.gehalt) AS numeric (7, 2)), abteilung.name
FROM person, abteilung
WHERE person.abteilungnr=abteilung.nr GROUP BY abteilung.nr;
