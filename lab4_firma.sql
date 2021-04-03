-- Zadanie Lab4

--1.Utwórzenie bazy danych o nazwie firma
CREATE DATABASE firma;

--2. Dodanie schematu "rozliczenia"
CREATE SCHEMA rozliczenia;

--3. Dodanie 4 tabel (z ustalonymi typami danych, okreslonymi wymaganymi danymi i kluczami głównymi) do schematu 
CREATE TABLE rozliczenia.pracownicy(id_pracownika integer PRIMARY KEY, imie VARCHAR(20) NOT NULL, nazwisko VARCHAR(30) NOT NULL, adres VARCHAR(50), telefon CHAR(9));
CREATE TABLE rozliczenia.godziny(id_godziny integer PRIMARY KEY, data DATE NOT NULL, liczba_godzin integer NOT NULL, id_pracownika integer NOT NULL);
CREATE TABLE rozliczenia.pensje(id_pensji integer PRIMARY KEY, stanowisko VARCHAR(30) NOT NULL, kwota integer, id_premii integer NOT NULL);
CREATE TABLE rozliczenia.premie(id_premii integer PRIMARY KEY, rodzaj VARCHAR(30) NOT NULL, kwota integer NOT NULL);


--3d. Utworzenie związków między tabelami przez dodanie kluczów obcych
ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);
ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

--4. Dodanie do każdej tabeli po 10 rekordów
-- pracownicy
INSERT INTO rozliczenia.pracownicy VALUES (1, 'Adam', 'Kowalski', 'ul. Nowa 2/12 Kraków', 987654321);
INSERT INTO rozliczenia.pracownicy VALUES (2, 'Maria', 'Nowak', 'ul. Leśna 54/1 Kraków', 346123856);
INSERT INTO rozliczenia.pracownicy VALUES (3, 'Jan', 'Gajewski', 'ul. Słoneczna 3 Wieliczka', 634856234);
INSERT INTO rozliczenia.pracownicy VALUES (4, 'Anna', 'Mikołajczak', 'ul. Długa 5/5 Kraków', 645234098);
INSERT INTO rozliczenia.pracownicy VALUES (5, 'Mikołaj', 'Kowalczyk', 'ul. Krótka 1 Wieliczka', 504044233);
INSERT INTO rozliczenia.pracownicy VALUES (6, 'Danuta', 'Ptak', 'ul. Rajska 33/3 Kraków', 500334526);
INSERT INTO rozliczenia.pracownicy VALUES (7, 'Jakub', 'Wiśniewski', 'ul. Stara 234 Balice', 444555666);
INSERT INTO rozliczenia.pracownicy VALUES (8, 'Marta', 'Lis', 'ul. Polna 1 Myślenice', 900645333);
INSERT INTO rozliczenia.pracownicy VALUES (9, 'Krzysztof', 'Wróbel', 'ul. Bałtycka 34/56 Kraków', 234877888);
INSERT INTO rozliczenia.pracownicy VALUES (10, 'Agata', 'Nowak', 'ul. Warszawska 23/4 Kraków', 656777234);
SELECT * FROM rozliczenia.pracownicy;			

--godziny
INSERT INTO rozliczenia.godziny VALUES (1, '2020-01-06', 4, 3);
INSERT INTO rozliczenia.godziny VALUES (2, '2020-01-09', 4, 6);
INSERT INTO rozliczenia.godziny VALUES (3, '2020-01-11', 9, 4);
INSERT INTO rozliczenia.godziny VALUES (4, '2020-01-14', 12, 9); 
INSERT INTO rozliczenia.godziny VALUES (5, '2020-01-14', 12, 5);
INSERT INTO rozliczenia.godziny VALUES (6, '2020-01-25', 10, 1);
INSERT INTO rozliczenia.godziny VALUES (7, '2020-02-06', 5, 7);
INSERT INTO rozliczenia.godziny VALUES (8, '2020-02-14', 4, 2);
INSERT INTO rozliczenia.godziny VALUES (9, '2020-02-17', 10, 10);
INSERT INTO rozliczenia.godziny VALUES (10, '2020-02-28', 4, 8);
SELECT * FROM rozliczenia.godziny;	

--premie 
INSERT INTO rozliczenia.premie VALUES (1, 'regulaminowa', 500);
INSERT INTO rozliczenia.premie VALUES (2, 'uznaniowa', 1000);
INSERT INTO rozliczenia.premie VALUES (3, 'regulaminowa', 600);
INSERT INTO rozliczenia.premie VALUES (4, 'regulaminowa', 800);
INSERT INTO rozliczenia.premie VALUES (5, 'uznaniowa', 500);
INSERT INTO rozliczenia.premie VALUES (6, 'regulaminowa', 700);
INSERT INTO rozliczenia.premie VALUES (7, 'uznaniowa', 600);
INSERT INTO rozliczenia.premie VALUES (8, 'uznaniowa', 900);
INSERT INTO rozliczenia.premie VALUES (9, 'regulaminowa', 500);
INSERT INTO rozliczenia.premie VALUES (10, 'regulaminowa', 700);
SELECT * FROM rozliczenia.premie;

--pensje
INSERT INTO rozliczenia.pensje VALUES (1, 'manager', 10000, 4);
INSERT INTO rozliczenia.pensje VALUES (2, 'praktykant', 1000, 8);
INSERT INTO rozliczenia.pensje VALUES (3, 'junior', 4000, 2);
INSERT INTO rozliczenia.pensje VALUES (4, 'kierownik', 10000, 10);
INSERT INTO rozliczenia.pensje VALUES (5, 'zastępca kierownika', 8000, 7);
INSERT INTO rozliczenia.pensje VALUES (6, 'senior', 8000, 1);
INSERT INTO rozliczenia.pensje VALUES (7, 'junior', 5000, 6);
INSERT INTO rozliczenia.pensje VALUES (8, 'senior', 9000, 3);
INSERT INTO rozliczenia.pensje VALUES (9, 'senior', 7000, 5);
INSERT INTO rozliczenia.pensje VALUES (10, 'senior', 7000, 9);
SELECT * FROM rozliczenia.pensje;


--5. Zapytanie wyświetlające nazwiska i adresy pracowników
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

--6. Zapytanie konwertujące datę w tabeli godziny tak, aby wyświetlana była informacja jaki to dzień tygodnia i jaki miesiąc
SELECT *, DATE_PART('dow',data) AS dzien_tygodnia, DATE_PART('month',data) AS miesiac FROM rozliczenia.godziny;
      

--7. Zmiana atrybutów w tabeli pensje: kwota->kwota brutto, dodanie kwota_netto i dodanie jej wartości
ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;
ALTER TABLE rozliczenia.pensje ADD kwota_netto integer;
UPDATE rozliczenia.pensje SET kwota_netto=kwota_brutto*0.8;
SELECT kwota_brutto, kwota_netto FROM rozliczenia.pensje;