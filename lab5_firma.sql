-- Zadanie Lab5

--1.Utwórzenie bazy danych o nazwie firma
CREATE DATABASE firma;

--2. Dodanie schematu "ksiegowosc"
CREATE SCHEMA ksiegowosc;

--3. Dodanie 4 tabel (z ustalonymi typami danych, okreslonymi wymaganymi danymi i kluczami głównymi) do schematu 
CREATE TABLE ksiegowosc.pracownicy(id_pracownika integer PRIMARY KEY, imie VARCHAR(20) NOT NULL, nazwisko VARCHAR(30) NOT NULL, adres VARCHAR(50), telefon CHAR(9));
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

--5. 
-- a) Wyświetl tylko id pracownika oraz jego nazwisko.
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

-- b) Wyświetl id pracowników, których płaca jest większa niż 1000.
SELECT pracownicy.id_pracownika, pensje.kwota FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji WHERE pensje.kwota>1000;

-- c) Wyświetl id pracowników nieposiadających premii, których płaca jest większa niż 2000.
SELECT pracownicy.id_pracownika, pensje.kwota FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji JOIN ksiegowosc.premie ON wynagrodzenie.id_premii=premie.id_premii WHERE pensje.kwota>2000 AND premie.kwota=0;

-- d) Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’.
SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE 'J%';

-- e) Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’.
SELECT * FROM ksiegowosc.pracownicy WHERE nazwisko LIKE 'N%' AND imie LIKE '%a';

-- f)  Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, iż standardowy czas pracy to 160 h miesięcznie.
SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin AS liczba_nadgodzin FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.godziny ON godziny.id_godziny=wynagrodzenie.id_godziny --WHERE liczba_godzin>160;

-- g) Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000 PLN.
SELECT pracownicy.imie, pracownicy.nazwisko, pensje.kwota FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji WHERE pensje.kwota>1500 AND pensje.kwota<3000;

-- h)  Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii.
SELECT pracownicy.id_pracownika FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika LEFT JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny=godziny.id_godziny LEFT JOIN ksiegowosc.premie ON premie.id_premii=wynagrodzenie.id_premii WHERE liczba_godzin>160 AND premie.kwota=0;

-- i) Uszereguj pracowników według pensji.
SELECT pracownicy.id_pracownika, pensje.kwota FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji ORDER BY kwota;

-- j) Uszereguj pracowników według pensji i premii malejąco.
SELECT pracownicy.id_pracownika, pensje.kwota, premie.kwota FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji LEFT JOIN ksiegowosc.premie ON premie.id_premii=wynagrodzenie.id_premii ORDER BY pensje.kwota DESC, premie.kwota DESC;

--  k) Zlicz i pogrupuj pracowników według pola ‘stanowisko’.
SELECT pensje.stanowisko, COUNT(pracownicy.id_pracownika) AS ilosc_pracownikow FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji GROUP BY pensje.stanowisko;

-- l) Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie masz, to przyjmij dowolne inne).
SELECT AVG(kwota), MIN(kwota), MAX(kwota) FROM ksiegowosc.pensje WHERE stanowisko='senior'

-- m) Policz sumę wszystkich wynagrodzeń.
SELECT SUM(pensje.kwota) AS suma_wynagrodzen FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji;

-- f) Policz sumę wynagrodzeń w ramach danego stanowiska.
SELECT SUM(pensje.kwota) AS suma_wynagrodzen, pensje.stanowisko FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji GROUP BY pensje.stanowisko;

-- g) Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska.
SELECT COUNT(premie.id_premii) AS liczba_premii, pensje.stanowisko FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji LEFT JOIN ksiegowosc.premie ON premie.id_premii=wynagrodzenie.id_premii GROUP BY pensje.stanowisko;

-- h) Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł.
DELETE FROM ksiegowosc.pracownicy WHERE pracownicy.id_pracownika IN (
 SELECT pracownicy.id_pracownika FROM ksiegowosc.pracownicy LEFT JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika=wynagrodzenie.id_pracownika LEFT JOIN ksiegowosc.pensje ON pensje.id_pensji=wynagrodzenie.id_pensji WHERE pensje.kwota<1200);
