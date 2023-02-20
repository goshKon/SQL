DECLARE @SOTR TABLE
(
	ID INT IDENTITY PRIMARY KEY,
	Name VARCHAR(10),
	Address VARCHAR(50),
	Mesto VARCHAR(10),
	Sex VARCHAR(1),
	BirthDate DATE
	);

INSERT INTO @SOTR
	VALUES
	('Петр','г. Москва, ул. Петрова, д.4','Москва','M','1985-04-23'),
	('Иван','г. Киев, ул. Иванова, д.3','Киев','M','1979-12-12'),
	('Маша','г. Москва, ул. Машина, д.1','Москва','W','1980-09-11'),
	('Федор','г. Москва, ул. Федорова, д.10','Фрунзе','M','1976-07-03');
--1 задача
SELECT * FROM @SOTR
WHERE BirthDate BETWEEN '1977-01-01' AND '1983-12-31';
--2 задача
SELECT * FROM @SOTR
WHERE Sex IN ('W');

DECLARE @ZARP TABLE 
(
	ID INT  IDENTITY PRIMARY KEY,
	Name VARCHAR(10),
	Zarp INT
	);

INSERT INTO @ZARP
	VALUES
	('Петр',100),
	('Федор',200),
	('Маша',300);

--3 задача
SELECT z.id as ID, z.Name, s.Address,z.Zarp
FROM @SOTR as s
JOIN @ZARP as z
ON s.name = z.name
WHERE z.Name IN ('Федор');


--4 задача
SELECT s.id as ID, z.Name, s.Address, z.Zarp		
FROM @ZARP as z
JOIN @SOTR as s
ON z.Name = s.Name
union 
Select s.id as ID, s.name, s.Address, 0
from @SOTR s
where s.name not in (select z.name from @ZARP z)


DECLARE @PAYMENTS TABLE
(
	ID INT IDENTITY PRIMARY KEY,
	Name VARCHAR(10),
	Date_dep DATE,
	Amount FLOAT
	);

INSERT INTO @PAYMENTS
	VALUES
	('Петр', '2007-03-30', 70),
	('Федор', '2007-03-30', 200),
	('Петр', '2007-04-30', 100),
	('Маша', '2007-04-30', 250),
	('Федор', '2007-04-30', 200),
	('Федор', '2007-05-31', 200),
	('Маша', '2007-05-31', 300),
	('Петр', '2007-05-31', 100);

--5 задача
select s.Name, SUM(p.amount) as FullAmount
from @SOTR s 
JOIN @PAYMENTS p
ON s.name = p.name
group by s.name
union    
Select s.name, 0 as FullAmount
from @SOTR s
where  s.name not in (select p.name from @PAYMENTS p)


