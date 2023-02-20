DECLARE @users table
(
	 [id] int NOT NULL    IDENTITY    PRIMARY KEY
	,[Name] varchar(100)
	,[WorkSection] varchar(100)
)
  
DECLARE @Deposites table
(
     [id_user] int
    ,[deposite] int
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
        ,('X', 'CCC')
  
INSERT INTO @Deposites
VALUES
		  (1, 10000)
  		 ,(2, 10020)
  		 ,(3, 100)
  		 ,(5, 100000)
         ,(6, 10002)
  		 ,(7, 10001)
         ,(8, 10002)
--1 a)   
  SELECT u.WorkSection, MAX(d.deposite) as MAXdeposite 
  FROM @users as u
  JOIN @Deposites as d 
  ON u.id = d.id_user 
  GROUP BY u.WorkSection
--1 b)
  SELECT 
  t.Name, t.WorkSection, t.deposite
  FROM (SELECT u.Name, u.WorkSection, d.deposite, 
  Max(d.deposite) OVER (PARTITION BY u.WorkSection) as MAXdeposite
  FROM @users as u
 JOIN @Deposites as d 
  ON u.id = d.id_user) as t
  WHERE t.deposite = t.MAXdeposite