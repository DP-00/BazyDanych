-- Zadanie Lab5

--1.Utwórzenie bazy danych o nazwie firma
CREATE DATABASE firma;

--2. Dodanie schematu "ksiegowosc"
CREATE SCHEMA ksiegowosc;

--3. Dodanie 4 tabel (z ustalonymi typami danych, okreslonymi wymaganymi danymi i kluczami głównymi) do schematu 
CREATE TABLE ksiegowosc.pracownicy (id_pracownika integer PRIMARY KEY, imie VARCHAR(20) NOT NULL, nazwisko VARCHAR(30) NOT NULL, adres VARCHAR(50), telefon CHAR(9));
CREATE TABLE ksiegowosc.godziny(id_godziny integer PRIMARY KEY, data DATE NOT NULL, liczba_godzin integer NOT NULL, id_pracownika integer NOT NULL);
CREATE TABLE ksiegowosc.pensje(id_pensji integer PRIMARY KEY, stanowisko VARCHAR(30) NOT NULL, kwota integer, id_premii integer NOT NULL);
CREATE TABLE ksiegowosc.premie(id_premii integer PRIMARY KEY, rodzaj VARCHAR(30) NOT NULL, kwota integer NOT NULL);
CREATE TABLE ksiegowosc.wynagrodzenie( id_wynagrodzenia integer PRIMARY KEY, data DATE NOT NULL, id_pracownika integer NOT NULL, id_godziny integer NOT NULL, id_pensji integer NOT NULL, id_premii integer NOT NULL); 

-- Utworzenie związków między tabelami przez dodanie kluczów obcych
ALTER TABLE ksiegowosc.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika) ON DELETE CASCADE;
ALTER TABLE ksiegowosc.pensje ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie(id_premii) ON DELETE CASCADE;
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika) ON DELETE CASCADE;
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.godziny(id_godziny) ON DELETE CASCADE;
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensje(id_pensji) ON DELETE CASCADE;
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie(id_premii) ON DELETE CASCADE;

-- dodanie komentarza dla każdej tabeli (COMMENT)
COMMENT ON TABLE ksiegowosc.pracownicy IS 'Dane personalne dotyczace pracownikow';
COMMENT ON TABLE ksiegowosc.godziny IS 'Ilosc wypracowanych godzin w miesiacu wraz z data wpisania';
COMMENT ON TABLE ksiegowosc.pensje IS 'Rodzaj stanowiska i wysokosc pensji';
COMMENT ON TABLE ksiegowosc.premie IS 'Rodzaj i wysokosc premii';
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Calkowite wynagrodzenie wraz z data wpisania';

--4. Dodanie do każdej tabeli po 10 rekordów
-- pracownicy
INSERT INTO ksiegowosc.pracownicy VALUES (1, 'Adam', 'Kowalski', 'ul. Nowa 2/12 Kraków', 987654321);
INSERT INTO ksiegowosc.pracownicy VALUES (2, 'Maria', 'Nowak', 'ul. Leśna 54/1 Kraków', 346123856);
INSERT INTO ksiegowosc.pracownicy VALUES (3, 'Jan', 'Gajewski', 'ul. Słoneczna 3 Wieliczka', 634856234);
INSERT INTO ksiegowosc.pracownicy VALUES (4, 'Anna', 'Mikołajczak', 'ul. Długa 5/5 Kraków', 645234098);
INSERT INTO ksiegowosc.pracownicy VALUES (5, 'Mikołaj', 'Kowalczyk', 'ul. Krótka 1 Wieliczka', 504044233);
INSERT INTO ksiegowosc.pracownicy VALUES (6, 'Danuta', 'Ptak', 'ul. Rajska 33/3 Kraków', 500334526);
INSERT INTO ksiegowosc.pracownicy VALUES (7, 'Jakub', 'Wiśniewski', 'ul. Stara 234 Balice', 444555666);
INSERT INTO ksiegowosc.pracownicy VALUES (8, 'Marta', 'Lis', 'ul. Polna 1 Myślenice', 900645333);
INSERT INTO ksiegowosc.pracownicy VALUES (9, 'Krzysztof', 'Wróbel', 'ul. Bałtycka 34/56 Kraków', 234877888);
INSERT INTO ksiegowosc.pracownicy VALUES (10, 'Agata', 'Nowak', 'ul. Warszawska 23/4 Kraków', 656777234);
SELECT * FROM ksiegowosc.pracownicy;			

--godziny
INSERT INTO ksiegowosc.godziny VALUES (1, '2020-01-06', 80, 3);
INSERT INTO ksiegowosc.godziny VALUES (2, '2020-01-09', 80, 6);
INSERT INTO ksiegowosc.godziny VALUES (3, '2020-01-11', 160, 4);
INSERT INTO ksiegowosc.godziny VALUES (4, '2020-01-14', 200, 9); 
INSERT INTO ksiegowosc.godziny VALUES (5, '2020-01-14', 200, 5);
INSERT INTO ksiegowosc.godziny VALUES (6, '2020-01-25', 180, 1);
INSERT INTO ksiegowosc.godziny VALUES (7, '2020-02-06', 120, 7);
INSERT INTO ksiegowosc.godziny VALUES (8, '2020-02-14', 80, 2);
INSERT INTO ksiegowosc.godziny VALUES (9, '2020-02-17', 180, 10);
INSERT INTO ksiegowosc.godziny VALUES (10, '2020-02-28', 80, 8);
SELECT * FROM ksiegowosc.godziny;	

--premie 
INSERT INTO ksiegowosc.premie VALUES (1, 'regulaminowa', 500);
INSERT INTO ksiegowosc.premie VALUES (2, 'uznaniowa', 1000);
INSERT INTO ksiegowosc.premie VALUES (3, 'regulaminowa', 600);
INSERT INTO ksiegowosc.premie VALUES (4, 'regulaminowa', 800);
INSERT INTO ksiegowosc.premie VALUES (5, 'uznaniowa', 500);
INSERT INTO ksiegowosc.premie VALUES (6, 'regulaminowa', 700);
INSERT INTO ksiegowosc.premie VALUES (7, 'uznaniowa', 600);
INSERT INTO ksiegowosc.premie VALUES (8, 'uznaniowa', 900);
INSERT INTO ksiegowosc.premie VALUES (9, 'regulaminowa', 500);
INSERT INTO ksiegowosc.premie VALUES (10, 'regulaminowa', 700);
SELECT * FROM ksiegowosc.premie;

--pensje
INSERT INTO ksiegowosc.pensje VALUES (1, 'manager', 10000, 4);
INSERT INTO ksiegowosc.pensje VALUES (2, 'praktykant', 1000, 8);
INSERT INTO ksiegowosc.pensje VALUES (3, 'junior', 4000, 2);
INSERT INTO ksiegowosc.pensje VALUES (4, 'kierownik', 10000, 10);
INSERT INTO ksiegowosc.pensje VALUES (5, 'zastępca kierownika', 8000, 7);
INSERT INTO ksiegowosc.pensje VALUES (6, 'senior', 8000, 1);
INSERT INTO ksiegowosc.pensje VALUES (7, 'junior', 5000, 6);
INSERT INTO ksiegowosc.pensje VALUES (8, 'senior', 9000, 3);
INSERT INTO ksiegowosc.pensje VALUES (9, 'senior', 7000, 5);
INSERT INTO ksiegowosc.pensje VALUES (10, 'senior', 7000, 9);
SELECT * FROM ksiegowosc.pensje;

--wynagrodzenie
INSERT INTO ksiegowosc.wynagrodzenie VALUES (1, '2020-01-25', 1, 6, 1, 4);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (2, '2020-02-14', 2, 8, 7, 6);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (3, '2020-01-11', 3, 1, 2, 8);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (4, '2020-01-14', 4, 3, 5, 7);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (5, '2020-01-14', 5, 5, 4, 10);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (6, '2020-01-25', 6, 2, 3, 2);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (7, '2020-02-06', 7, 7, 8, 3);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (8, '2020-02-28', 8, 10, 6, 1);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (9, '2020-01-14', 9, 4, 10, 9);
INSERT INTO ksiegowosc.wynagrodzenie VALUES (10, '2020-02-17',  10, 9, 9, 5);
SELECT * FROM ksiegowosc.wynagrodzenie;


ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon TYPE VARCHAR(15); 
-- a) dodanie +48 do początku numeru telefon
UPDATE ksiegowosc.pracownicy SET telefon=CONCAT('+48', pracownicy.telefon); 

-- b) rozdzielenie numeru telefonu co 3 cyfry myślnikime (999-999-999)
UPDATE ksiegowosc.pracownicy SET telefon= CONCAT_WS('-', SUBSTRING(pracownicy.telefon, 1, 3), SUBSTRING(pracownicy.telefon, 4, 3), SUBSTRING(pracownicy.telefon, 6, 3), SUBSTRING(pracownicy.telefon, 9, 3)); 

-- c) wyświetlenie danych pracownika, którego nazwisko jest najdłuższe, uzywając dużych liter
SELECT  * FROM ksiegowosc.pracownicy WHERE LENGTH(pracownicy.nazwisko) = (SELECT MAX(LENGTH(pracownicy.nazwisko)) FROM ksiegowosc.pracownicy); 

-- d) wyświetlenie dane pracownikow i ich pensje zakodowane przy pomocy algorytmu md5
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, MD5( CAST(pensje.kwota AS VARCHAR(100))) FROM ksiegowosc.pracownicy JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji ;

-- f) wyświetlenie dane pracownikow i ich pensje i premie, wykorzystujac złączenie lewostronne
SELECT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pensje.kwota AS pensja, premie.kwota AS premia FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji JOIN ksiegowosc.premie ON wynagrodzenie.id_premii=premie.id_premii;

-- g) wygenreuj raport (zapytanie), które zwróci w wyniku treść wg. szablonu

SELECT CONCAT('Pracownik ',pracownicy.imie, ' ', pracownicy.nazwisko ,' w dniu ', wynagrodzenie.data , ' otrzymał(a) pensję całkowitą na kwotę ', pensje.kwota+premie.kwota, ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ', pensje.kwota , ' zł, premia: ', premie.kwota, ' zł, nadgodziny: ', CASE WHEN (godziny.liczba_godzin)>160 THEN ((godziny.liczba_godzin)-160)*10 ELSE 0 END, ' zł.') AS Raport
FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika 
JOIN ksiegowosc.godziny ON godziny.id_godziny=wynagrodzenie.id_godziny 
JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji
JOIN ksiegowosc.premie ON premie.id_premii=wynagrodzenie.id_premii;