CREATE DATABASE geochronologia;
CREATE SCHEMA wydajnosc;


-- Tabela znormalizowana
CREATE TABLE wydajnosc.GeoEon(id_eon  integer PRIMARY KEY, nazwa_eon  VARCHAR(15));
CREATE TABLE wydajnosc.GeoEra(id_era  integer PRIMARY KEY, id_eon  integer, nazwa_era  VARCHAR(15));
CREATE TABLE wydajnosc.GeoOkres(id_okres  integer PRIMARY KEY, id_era  integer, nazwa_okres  VARCHAR(15));
CREATE TABLE wydajnosc.GeoEpoka(id_epoka  integer PRIMARY KEY, id_okres  integer, nazwa_epoka VARCHAR(15));
CREATE TABLE wydajnosc.GeoPietro(id_pietro  integer PRIMARY KEY, id_epoka integer, nazwa_pietro VARCHAR(15));

ALTER TABLE wydajnosc.GeoEra ADD FOREIGN KEY (id_eon) REFERENCES wydajnosc.GeoEon(id_eon);
ALTER TABLE wydajnosc.GeoOkres ADD FOREIGN KEY (id_era) REFERENCES wydajnosc.GeoEra(id_era);
ALTER TABLE wydajnosc.GeoEpoka ADD FOREIGN KEY (id_okres) REFERENCES wydajnosc.GeoOkres(id_okres);
ALTER TABLE wydajnosc.GeoPietro ADD FOREIGN KEY (id_epoka) REFERENCES wydajnosc.GeoEpoka(id_epoka);

INSERT INTO wydajnosc.GeoEon VALUES (1, 'Fanerozoik');

INSERT INTO wydajnosc.GeoEra VALUES 
(1, 1, 'Kenozoik'),
(2, 1, 'Mezozoik'),
(3, 1, 'Paleozoik');

INSERT INTO wydajnosc.GeoOkres VALUES 
(1, 1, 'Czwartorzad'),
(2, 1, 'Neogen'),
(3, 1, 'Paleogen'),
(4, 2, 'Kreda'),
(5, 2, 'Jura'),
(6, 2, 'Trias'),
(7, 3, 'Perm'),
(8, 3, 'Karbon'),
(9, 3, 'Dewon');


INSERT INTO wydajnosc.GeoEpoka VALUES 
(1,1,'Halocen'),
(2,1,'Plejstocen'),
(3,2,'Pliocen'),
(4,2,'Miocen'),
(5,3,'Oligocen'),
(6,3,'Eocen'),
(7,3,'Paleocen'),
(8,4,'Górna'),
(9,4,'Dolna'),
(10,5,'Górna'),
(11,5,'Środkowa'),
(12,5,'Dolna'),
(13,6,'Górna'),
(14,6,'Środkowa'),
(15,6,'Dolna'),
(16,7,'Górny'),
(17,7,'Dolny'),
(18,8,'Górny'),
(19,8,'Dolny'),
(20,9,'Górny'),
(21,9,'Środkowy'),
(22,9,'Dolny');


INSERT INTO wydajnosc.GeoPietro VALUES
(1,1,'Megalaj'),
(2,1,'Northgrip'),
(3,1,'Grenland'),
(4,2,'Późny'),
(5,2,'Chiban'),
(6,2,'Kalabr'),
(7,2,'Gelas'),
(8,3,'Piacent'),
(9,3,'Zankl'),
(10,4,'Messyn'),
(11,4,'Torton'),
(12,4,'Serrawal'),
(13,4,'Lang'),
(14,4,'Burdygał'),
(15,4,'Akwitan'),
(16,5,'Szat'),
(17,5,'Rupel'),
(18,6,'Priabon'),
(19,6,'Barton'),
(20,6,'Lutet'),
(21,6,'Iprez'),
(22,7,'Tanet'),
(23,7,'Zeland'),
(24,7,'Dan'),
(25,8,'Mastrycht'),
(26,8,'Kampan'),
(27,8,'Santon'),
(28,8,'Koniak'),
(29,8,'Turon'),
(30,8,'Cenoman'),
(31,9,'Alb'),
(32,9,'Apt'),
(33,9,'Barrem'),
(34,9,'Hoteryw'),
(35,9,'Walanżyn'),
(36,9,'Berrias'),
(37,10,'Tyton'),
(38,10,'Kimeryd'),
(39,10,'Oksford'),
(40,11,'Kelowej'),
(41,11,'Baton'),
(42,11,'Bajos'),
(43,11,'Aalen'),
(44,12,'Toark'),
(45,12,'Pliensbach'),
(46,12,'Synemur'),
(47,12,'Hettang'),
(48,13,'Retyk'),
(49,13,'Noryk'),
(50,13,'Karnik'),
(51,14,'Ladyn'),
(52,14,'Anizyk'),
(53,15,'Olenek'),
(54,15,'Ind'),
(55,16,'czangsing'),
(56,16,'wucziaping'),
(57,16,'kapitan'),
(58,16,'word'),
(59,16,'road'),
(60,17,'kungur'),
(61,17,'artinsk'),
(62,17,'sakmar'),
(63,18,'assel'),
(64,18,'gżel'),
(65,18,'kasimow'),
(66,18,'moskow'),
(67,18,'baszkir'),
(68,19,'serpuchow'),
(69,19,'wizen'),
(70,19,'turnej'),
(71,20,'famen'),
(72,20,'fran'),
(73,21,'żywet'),
(74,21,'eifel'),
(75,22,'ems'),
(76,22,'prag'),
(77,22,'lochkow');


-- Tabela zdenormalizowana
CREATE TABLE wydajnosc.GeoTabela AS (SELECT * FROM wydajnosc.GeoPietro NATURAL JOIN wydajnosc.GeoEpoka
NATURAL JOIN wydajnosc.GeoOkres NATURAL JOIN wydajnosc.GeoEra NATURAL JOIN wydajnosc.GeoEon );
SELECT * FROM wydajnosc.GeoTabela;

-- Dodanie miliona rekordów
CREATE TABLE wydajnosc.Dziesiec(cyfra int, bit int);
INSERT INTO wydajnosc.Dziesiec VALUES (0,0), (1,0), (2,0), (3,0), (4,0), (5,0), (6,0), (7,0), (8,0), (9,0);

CREATE TABLE wydajnosc.Milion(liczba int,cyfra int, bit int);
INSERT INTO wydajnosc.Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 100000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM wydajnosc.Dziesiec a1, wydajnosc.Dziesiec a2, wydajnosc.Dziesiec a3, wydajnosc.Dziesiec a4, wydajnosc.Dziesiec a5, wydajnosc.Dziesiec
a6;


-- Indeksy
CREATE INDEX id_eon_idx ON wydajnosc.GeoEon(id_eon);
CREATE INDEX id_era_idx ON wydajnosc.GeoEra(id_era);
CREATE INDEX id_okres_idx ON wydajnosc.GeoOkres(id_okres);
CREATE INDEX id_epoka_idx ON wydajnosc.GeoEpoka(id_epoka);
CREATE INDEX id_pietro_idx ON wydajnosc.GeoPietro(id_pietro);
CREATE INDEX id_pietroTab_idx ON wydajnosc.GeoTabela(id_pietro);
CREATE INDEX liczba_idx ON wydajnosc.Milion(liczba);

-- Zapytania
-- Zapytanie 1 (1 ZL)
SELECT COUNT(*) FROM wydajnosc.Milion INNER JOIN wydajnosc.GeoTabela ON
(mod(wydajnosc.Milion.liczba,68)=(wydajnosc.GeoTabela.id_pietro));

-- Zapytanie 2 (2 ZL)
SELECT COUNT(*) FROM wydajnosc.Milion INNER JOIN wydajnosc.GeoPietro ON
(mod(wydajnosc.Milion.liczba,68)=wydajnosc.GeoPietro.id_pietro) NATURAL JOIN wydajnosc.GeoEpoka NATURAL JOIN
wydajnosc.GeoOkres NATURAL JOIN wydajnosc.GeoEra NATURAL JOIN wydajnosc.GeoEon;

-- Zapytanie 3 (3 ZG)
SELECT COUNT(*) FROM wydajnosc.Milion WHERE mod(wydajnosc.Milion.liczba,68)=
(SELECT wydajnosc.GeoTabela.id_pietro FROM wydajnosc.GeoTabela WHERE mod(wydajnosc.Milion.liczba,68)=(id_pietro));

-- Zapytanie 4 (4 ZG)
SELECT COUNT(*) FROM wydajnosc.Milion WHERE mod(wydajnosc.Milion.liczba,68) IN
(SELECT wydajnosc.GeoPietro.id_pietro FROM wydajnosc.GeoPietro NATURAL JOIN wydajnosc.GeoEpoka NATURAL JOIN
wydajnosc.GeoOkres NATURAL JOIN wydajnosc.GeoEra NATURAL JOIN wydajnosc.GeoEon);

-- Explain
-- Zapytanie 1 (1 ZL)
EXPLAIN SELECT COUNT(*) FROM wydajnosc.Milion INNER JOIN wydajnosc.GeoTabela ON
(mod(wydajnosc.Milion.liczba,68)=(wydajnosc.GeoTabela.id_pietro));

-- Zapytanie 2 (2 ZL)
EXPLAIN SELECT COUNT(*) FROM wydajnosc.Milion INNER JOIN wydajnosc.GeoPietro ON
(mod(wydajnosc.Milion.liczba,68)=wydajnosc.GeoPietro.id_pietro) NATURAL JOIN wydajnosc.GeoEpoka NATURAL JOIN
wydajnosc.GeoOkres NATURAL JOIN wydajnosc.GeoEra NATURAL JOIN wydajnosc.GeoEon;

-- Zapytanie 3 (3 ZG)
EXPLAIN SELECT COUNT(*) FROM wydajnosc.Milion WHERE mod(wydajnosc.Milion.liczba,68)=
(SELECT wydajnosc.GeoTabela.id_pietro FROM wydajnosc.GeoTabela WHERE mod(wydajnosc.Milion.liczba,68)=(id_pietro));

-- Zapytanie 4 (4 ZG)
EXPLAIN SELECT COUNT(*) FROM wydajnosc.Milion WHERE mod(wydajnosc.Milion.liczba,68)=
(SELECT wydajnosc.GeoPietro.id_pietro FROM wydajnosc.GeoPietro NATURAL JOIN wydajnosc.GeoEpoka NATURAL JOIN
wydajnosc.GeoOkres NATURAL JOIN wydajnosc.GeoEra NATURAL JOIN wydajnosc.GeoEon);