DECLARE @Deposites table
(
  [id] int NOT NULL    IDENTITY    PRIMARY KEY
 ,[id_user]  int
 ,[Month_id] int
 ,[deposite] int
)
DECLARE @Month table  
(		
     [id] int NOT NULL    IDENTITY    PRIMARY KEY
    ,[name] varchar(100)
)
DECLARE @users table
(
	 [id] int NOT NULL    IDENTITY    PRIMARY KEY
	,[Name] varchar(100)
	,[WorkSection] varchar(100)
)
  INSERT INTO @users
VALUES
		 ('A', 'AAA')
		,('B', 'AAA')
		,('C', 'AAA')
		,('D', 'BBB')
		,('E', 'BBB')
		,('F', 'CCC')
		,('G', 'CCC')
  		,('Y', 'CCC')
  
INSERT INTO @Month
VALUES
 ('January')
,('February')
,('March')
,('April')
,('May')
,('June')
,('July')
,('August')
,('September')
,('October')
,('November')
,('December')
  
DECLARE @max int = 10
DECLARE @min int = 1

DECLARE @i INT = 1;
WHILE @i <= (Select Count(*) FROM @users)
BEGIN  
 DECLARE @j INT = 1;
 WHILE @j <= 12
 BEGIN
     INSERT INTO @Deposites VALUES (@i, @j, ABS(CHECKSUM(NEWID()) %(@max - @min + 1)) + @min)
     SET @j = @j + 1;
 END;
 SET @i = @i + 1;
END;

--2 a)
SELECT u.Name, u.WorkSection, m.name as Month, d.deposite AS Salary
FROM @Deposites as d
JOIN @Month as m ON d.month_id = m.id
JOIN @users as u
ON u.id = d.id_user

--2 b)  
SELECT u.Name, SUM(d.deposite) as SumDeposites 
  FROM @users as u, @Deposites as d 
  WHERE u.id = d.id_user 
  group by u.Name
--2 c)  
SELECT u.WorkSection, SUM(d.deposite) as SumDeposites 
  FROM @users as u
  JOIN @Deposites as d 
  ON u.id = d.id_user 
  group by u.WorkSection