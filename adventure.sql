--1.Przygotuj blok anonimowy, który:
SELECT * FROM AdventureWorks2017.HumanResources.Employee;
SELECT * FROM AdventureWorks2017.HumanResources.EmployeePayHistory;
-- znajdzie średnią stawkę wynagrodzenia pracowników,
-- wyświetli szczegóły pracowników, których stawka wynagrodzenia jest niższa niż średnia.
BEGIN
SELECT ROUND(AVG(Rate), 2) AS 'Średnia stawka' FROM humanresources.employeepayhistory;

DECLARE @srednia float;
SET @srednia = (SELECT ROUND(AVG(Rate), 2) FROM humanresources.employeepayhistory);

SELECT HumanResources.Employee.BusinessEntityID, HumanResources.Employee.JobTitle, HumanResources.Employee.HireDate, HumanResources.EmployeePayHistory.Rate 
FROM HumanResources.Employee JOIN HumanResources.EmployeePayHistory ON HumanResources.EmployeePayHistory.BusinessEntityID = HumanResources.Employee.BusinessEntityID
WHERE HumanResources.EmployeePayHistory.Rate< @srednia;
END;

--2. Utwórz funkcję, która zwróci datę wysyłki określonego zamówienia.
SELECT * FROM [Sales].[SalesOrderHeader];

CREATE OR ALTER FUNCTION dbo.dataWysylki(@zamowienie INT)
RETURNS datetime
AS
BEGIN
	DECLARE @data datetime;
	SELECT @data = AdventureWorks2017.Sales.SalesOrderHeader.ShipDate
	FROM AdventureWorks2017.Sales.SalesOrderHeader
	WHERE AdventureWorks2017.Sales.SalesOrderHeader.SalesOrderID=@zamowienie;
	RETURN @data;
END;
	
SELECT dbo.dataWysylki(43659);


--3. Utwórz procedurę składowaną, która jako parametr przyjmuję nazwę produktu, a jakorezultat wyświetla jego identyfikator, numer i dostępność.
SELECT * FROM production.product;
SELECT * FROM production.productinventory; 

USE AdventureWorks2017;
GO
CREATE OR ALTER PROCEDURE produktInfo
@name nvarchar(50)
AS
SELECT AdventureWorks2017.production.product.ProductID, AdventureWorks2017.production.product.ProductNumber, SUM(AdventureWorks2017.production.productinventory.Quantity) AS Quantity
FROM AdventureWorks2017.production.product JOIN AdventureWorks2017.production.productinventory ON AdventureWorks2017.production.productinventory.ProductID = AdventureWorks2017.production.product.ProductID
GROUP BY AdventureWorks2017.production.product.ProductID, AdventureWorks2017.production.product.ProductNumber, AdventureWorks2017.production.product.Name 
HAVING AdventureWorks2017.production.product.Name = @name;
GO

EXECUTE produktInfo @name=N'Bearing Ball';
GO

-- 4. Utwórz funkcję, która zwraca numer karty kredytowej dla konkretnego zamówienia.
SELECT * FROM [Sales].[SalesOrderHeader];
SELECT * FROM [Sales].[CreditCard];

CREATE OR ALTER FUNCTION dbo.numerKarty(@zamowienie INT)
RETURNS bigint
AS
BEGIN
	DECLARE @nrKarty bigint;
	SELECT @nrKarty = AdventureWorks2017.Sales.CreditCard.CardNumber
	FROM AdventureWorks2017.Sales.CreditCard JOIN AdventureWorks2017.Sales.SalesOrderHeader ON AdventureWorks2017.Sales.CreditCard.CreditCardID = AdventureWorks2017.Sales.SalesOrderHeader.CreditCardID
	WHERE AdventureWorks2017.Sales.SalesOrderHeader.SalesOrderID=@zamowienie;
	RETURN @nrKarty;
END;
	
SELECT dbo.numerKarty(43659) AS "Numer karty kredytowej";

-- 5. Utwórz procedurę składowaną, która jako parametry wejściowe przyjmuje dwie liczby, num1i num2, a zwraca wynik ich dzielenia. 
--Ponadto wartość num1 powinna zawsze być większa niżwartość num2. 
-- Jeżeli wartość num1 jest mniejsza niż num2, wygeneruj komunikat o błędzie„Niewłaściwie zdefiniowałeś dane wejściowe”.

GO
CREATE OR ALTER PROCEDURE dzielenie
@num1 float,
@num2 float
AS
DECLARE @wynik float;
SET @wynik = @num1/@num2;	
IF (@num1 > @num2)	
	SELECT @wynik AS 'output';
ELSE
	PRINT 'Niewłaściwie zdefiniowałeś dane wejściowe';
RETURN @wynik;
GO

EXECUTE dzielenie @num1=1, @num2=3;
GO

-- 6. Napisz procedurę, która jako parametr przyjmie NationalIDNumber danej osoby, a zwróci stanowisko oraz liczbę dni urlopowych i chorobowych.
SELECT * FROM humanresources.employee;

USE AdventureWorks2017;
GO
CREATE OR ALTER PROCEDURE pracownikInfo
@id int
AS
SELECT AdventureWorks2017.HumanResources.Employee.JobTitle, AdventureWorks2017.HumanResources.Employee.VacationHours/8 AS VacationDays, AdventureWorks2017.HumanResources.Employee.SickLeaveHours/8 AS SickDays
FROM AdventureWorks2017.HumanResources.Employee
WHERE AdventureWorks2017.HumanResources.Employee.NationalIDNumber = @id;
GO

EXECUTE pracownikInfo @id=295847284;
GO


-- 7. Napisz procedurę będącą kalkulatorem walutowym. Wykorzystaj dwie tabele: Sales.Currencyoraz Sales.CurrencyRate. 
-- Parametrami wejściowymi mają być: kwota, waluty oraz data(CurrencyRateDate). Przyjmij, iż zawsze jedną ze stron jest dolar amerykański (USD).
-- Zaimplementuj kalkulację obustronną, tj:1400 USD → PLN lub PLN → USD

SELECT * FROM Sales.Currency;
SELECT * FROM Sales.CurrencyRate;

USE AdventureWorks2017;
GO
CREATE OR ALTER PROCEDURE waluty
@kwota float,
@waluta	nvarchar(50),
@data datetime

AS
DECLARE @wynik float;
DECLARE @wynikUSD float;
DECLARE @przelicznik float;
SELECT @przelicznik=AdventureWorks2017.Sales.CurrencyRate.AverageRate
FROM AdventureWorks2017.Sales.CurrencyRate JOIN AdventureWorks2017.Sales.Currency ON AdventureWorks2017.Sales.CurrencyRate.ToCurrencyCode = AdventureWorks2017.Sales.Currency.CurrencyCode
WHERE AdventureWorks2017.Sales.Currency.Name= @waluta AND AdventureWorks2017.Sales.CurrencyRate.CurrencyRateDate = @data;
SET @wynik=@kwota*@przelicznik;
SET @wynikUSD=@kwota/@przelicznik;
SELECT @wynik AS "USD -> waluta", @wynikUSD AS "waluta -> USD";
GO

EXECUTE waluty @kwota=100, @waluta=N'Euro', @data='2011-05-31 00:00:00.000';
GO


