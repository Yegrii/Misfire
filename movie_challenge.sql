-- Preview LIMIT data from films table
SELECT 
	*
FROM 
	films f 
LIMIT 10;

-- COUNT 'null' values in release_year column
SELECT 
	COUNT(*) 
FROM 
	films f 
WHERE 
	release_year = 'null';

-- Updating data in release_year column
UPDATE films 
SET release_year = NULL 
WHERE release_year = 'null';

-- Changing data type in release_year column
ALTER TABLE films 
MODIFY COLUMN release_year INT;

-- COUNT 'null' values in duration column
SELECT 
	COUNT(*)
FROM
	films f 
WHERE 
	duration = 'null';

-- Updating data in duration column
UPDATE films 
SET duration = NULL 
WHERE duration = 'null';

-- Changing data type in duration column
ALTER TABLE films 
MODIFY COLUMN duration INT;

-- COUNT 'null' values in gross column
SELECT 
	COUNT(*)
FROM
	films f 
WHERE 
	gross = 'null';

-- Updating data in gross column
UPDATE films 
SET gross = NULL 
WHERE gross = 'null';

-- Changing data type in gross column
ALTER TABLE films 
MODIFY COLUMN gross INT;

-- COUNT 'null' values in budget column
SELECT 
	COUNT(*)
FROM
	films f 
WHERE 
	budget = 'null';

-- Updating data in budget column
UPDATE films 
SET budget = NULL 
WHERE budget = 'null';

-- Changing data type in budget column
ALTER TABLE films 
MODIFY COLUMN budget BIGINT;

-- Check the data types in all columns:
DESC films ;

-- 1. How many movies are present in the database?

SELECT 
	COUNT( title)
FROM 
	films f ;

SELECT 
	COUNT(DISTINCT title)
FROM 
	films f ;

SELECT 
	title ,
	COUNT(*) AS dupli 
FROM 
	films f 
GROUP BY 
	title  
HAVING 
	COUNT(*) > 1
ORDER BY 
	dupli DESC ;

SELECT 
	title ,
	COUNT(*) AS dupli 
FROM 
	films f 
GROUP BY 
	title  
HAVING 
	COUNT(*) = 2
ORDER BY 
	dupli DESC ;

SELECT 
	title ,
	COUNT(*) AS dupli 
FROM 
	films f 
GROUP BY 
	title  
HAVING 
	COUNT(*) > 2
ORDER BY 
	dupli DESC ;
	
-- 2. There seems to be a lot of missing data in the gross and budget columns. 
-- How many rows have missing data? What would you recommend your manager to do with these rows?

SELECT
	COUNT(*)
FROM 
	films f 
WHERE 
	gross IS NULL ;

SELECT
	COUNT(*)
FROM 
	films f 
WHERE 
	budget IS NULL ;

-- 3. How many different certifications or ratings are present in the database?
	
SELECT 
	certification ,
	COUNT(*) AS cert_count
FROM 
	films f 
GROUP BY
	certification 
ORDER BY 
	cert_count DESC;
	
SELECT 
	COUNT(DISTINCT certification)
FROM
	films f ;

-- I suggest replacing the empty certification with 'Not Rated'. 

UPDATE films 
SET certification = 'Not Rated'
WHERE certification = '';

-- 4. What are the top five countries in terms of number of movies produced?

SELECT 
	country ,
	COUNT(*) AS country_num
FROM 
	films f 
GROUP BY
	country 
ORDER BY 
	country_num DESC 
LIMIT 5;

-- 5. What is the average duration of English versus French movies?

SELECT 
	`language` ,
	ROUND(AVG(duration), 2) AS avg_duration
FROM 
	films f 
WHERE 
	`language` IN ('English', 'French')
GROUP BY 
	`language`;

-- 6. Any other insights you found during your analysis?

-- How the length of a movie affects gross box office.

SELECT
	CASE 
		WHEN duration <= 99 THEN '< 100 min'
		WHEN duration BETWEEN 100 AND 125 THEN '<= 125 min'
		ELSE '> 125 min'
	END AS gradation,
	ROUND(AVG(gross), 2) AS avg_gross
FROM 
	films f 
WHERE 
	gross IS NOT NULL 
GROUP BY 
	1
ORDER BY 
	2 DESC;

-- Top 10 movie producing countries	
SELECT 
	country ,
	SUM(gross) AS total
FROM 
	films f 
GROUP BY
	country 
ORDER BY 
	total DESC 
LIMIT 10;

-- Top 5 
SELECT 
	`language` ,
	SUM(gross) AS total 
FROM 
	films f 
GROUP BY
	`language` 
ORDER BY 
	total DESC 
LIMIT 5;
