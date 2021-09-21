-- Inner Join 2a / (Wer dient wem?)
-- "X ist der Diener von Y" / Dienstverhältnis
SELECT
	CONCAT(servant_name, " ist der Diener von " ,cat_name, ".") AS Dienstverhältnis
FROM mydb.cats INNER JOIN mydb.servants
ON mydb.cats.id = mydb.servants.cats_id
#WHERE cat_name = "Grizabella"
#WHERE servant_name = "Holger"   
;

-- Inner Join 3 / Dienstzeit
SELECT
	servant_name AS Diener,
    yrs_served AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON mydb.cats.id = mydb.servants.cats_id
;

-- Inner Join 4 / Dienstzeit
-- "X - der Diener von Y - ist der Diener mit der längsten Dienszeit" // MAX()
-- 1. LIMIT (QUICK & DIRTY / Nur bei einem MAX-Wert vollständige Lösung)
SELECT
	CONCAT(servant_name, " - der Diener von " ,cat_name, " - ist der Diener mit der längsten Dienstzeit.") AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON mydb.cats.id = mydb.servants.cats_id
ORDER BY yrs_served DESC
LIMIT 1;
;

-- 2. Subquery
SELECT
	CONCAT(servant_name, " - der Diener von " ,cat_name, " - ist der Diener mit der längsten Dienstzeit.") AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON mydb.cats.id = mydb.servants.cats_id
WHERE yrs_served = (SELECT MAX(yrs_served) FROM mydb.servants)
;

-- 3. VIEW
USE mydb;
DROP VIEW IF EXISTS max_time;
CREATE VIEW max_time AS 
	SELECT 
		MAX(yrs_served) 
	FROM mydb.servants;
SELECT * FROM max_time;

SELECT
	CONCAT(servant_name, " - der Diener von " ,cat_name, " - ist der Diener mit der längsten Dienstzeit.") AS Dienstzeit
FROM mydb.cats INNER JOIN mydb.servants
ON mydb.cats.id = mydb.servants.cats_id
WHERE yrs_served = (SELECT * FROM max_time)
;


