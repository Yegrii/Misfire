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

-- Top 5 movie language
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


SELECT 
	*
FROM 
	films f;
	
SELECT
    CASE 
        WHEN release_year BETWEEN 1910 AND 1919 THEN '1910s'
        WHEN release_year BETWEEN 1920 AND 1929 THEN '1920s'
        WHEN release_year BETWEEN 1930 AND 1939 THEN '1930s'
        WHEN release_year BETWEEN 1940 AND 1949 THEN '1940s'
        WHEN release_year BETWEEN 1950 AND 1959 THEN '1950s'
        WHEN release_year BETWEEN 1960 AND 1969 THEN '1960s'
        WHEN release_year BETWEEN 1970 AND 1979 THEN '1970s'
        WHEN release_year BETWEEN 1980 AND 1989 THEN '1980s'
        WHEN release_year BETWEEN 1990 AND 1999 THEN '1990s'
        WHEN release_year BETWEEN 2000 AND 2009 THEN '2000s'
        WHEN release_year BETWEEN 2010 AND 2019 THEN '2010s'
    END AS decades,
    SUM(gross) AS decade_gross
FROM 
    films f 
WHERE 
	gross IS NOT NULL
	AND release_year IS NOT NULL
GROUP BY
    decades
ORDER BY 
    decades;
   
   
SELECT 
 	country,
 	COUNT(title) AS movie_count,
 	SUM(budget) AS total_budget,
 	SUM(gross) AS total_gross
FROM 
 	films f
WHERE
	gross IS NOT NULL
	AND budget IS NOT NULL
GROUP BY
 	country
ORDER BY 
	total_budget DESC, total_gross DESC;

