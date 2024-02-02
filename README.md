🎥 Challenge 2: You have just been hired by a large movie studio to perform data analysis. 
Your manager, an executive at the company, wants to make new movies that 'recapture the magic of old Hollywood.' 
So you've decided to look at the most successful films to help generate ideas that could turn into future successful films.

💪 Challenge II
Help your team leader understand the data that's available in the _cinema.films_ dataset. Include:

1. How many movies are present in the database?
2. There seems to be a lot of missing data in the gross and budget columns. How many rows have missing data? What would you recommend your manager to do with these rows?
3. How many different certifications or ratings are present in the database?
4. What are the top five countries in terms of number of movies produced?
5. What is the average duration of English versus French movies? (Don't forget, you can use the AI assistant!)
6. Any other insights you found during your analysis


When loading the dataset into the database, there were errors because several columns should contain INT numeric values, but there are text "null" along with the numeric data. 
Therefore, when loading data into the database, I declared all data except ID as VARCHAR.

<img width="442" alt="Screenshot 2024-02-02 at 13 52 03" src="https://github.com/Yegrii/Misfire/assets/30467268/2a8c958e-5fb3-46de-9c8b-7b925738d36a">

After that, I will change the data type in the columns release_year, duration, gross, budget to INT and replace all text "null" with NULL;

The release_year column contains 42 rows with release_year = 'null';
``` SQL
SELECT 
	COUNT(*) 
FROM 
	films f 
WHERE 
	release_year = 'null';
	
UPDATE films 
SET release_year = NULL 
WHERE release_year = 'null';

ALTER TABLE films 
MODIFY COLUMN release_year INT;
```
The duration column contains 13 rows with duration = 'null';
```SQL
SELECT 
	COUNT(*)
FROM
	films f 
WHERE 
	duration = 'null';
	
UPDATE films 
SET duration = NULL 
WHERE duration = 'null';

ALTER TABLE films 
MODIFY COLUMN duration INT;
```
The gross column contains 810 rows with gross = 'null';
```SQL
SELECT 
	COUNT(*)
FROM
	films f 
WHERE 
	gross = 'null';
	
UPDATE films 
SET gross = NULL 
WHERE gross = 'null';

ALTER TABLE films 
MODIFY COLUMN gross INT;
```
The budget column contains 430 rows with budget = 'null';
```SQL
SELECT 
	COUNT(*)
FROM
	films f 
WHERE 
	budget = 'null';
	
UPDATE films 
SET budget = NULL 
WHERE budget = 'null';

ALTER TABLE films 
MODIFY COLUMN budget BIGINT;
```
Check the data types in all columns:
```SQL
DESC films;
```
<img width="513" alt="Screenshot 2024-02-02 at 14 31 17" src="https://github.com/Yegrii/Misfire/assets/30467268/6fbe555a-b176-45a1-a5f3-7b673502cd42">

The data is now ready for further processing.

1. How many movies are present in the database?

There are 4,968 movies in the database
```SQL
SELECT 
	COUNT(title)
FROM 
	films f ;
```
but there are only 4,844 unique movie titles
```SQL
SELECT 
	COUNT(DISTINCT title)
FROM 
	films f ;
```
110 movies that meet 2 times
```SQL
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
```
and seven movies that meet 3 times.
```SQL
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
```

2. There seems to be a lot of missing data in the gross and budget columns. How many rows have missing data? What would you recommend your manager to do with these rows?

The gross column contains 810 missing rows.
```SQL
SELECT
	COUNT(*)
FROM 
	films f 
WHERE 
	gross IS NULL ;
```
The budget column contains 430 missing rows.
```SQL
SELECT
	COUNT(*)
FROM 
	films f 
WHERE 
	budget IS NULL ;
```

3. How many different certifications or ratings are present in the database?

The certification column contains 13 different types, including 1 empty certificate.
```SQL
SELECT 
	COUNT(DISTINCT certification)
FROM
	films f ;
```
Let's count how many movies apply to each certification.
```SQL
SELECT 
	certification ,
	COUNT(*) AS cert_count
FROM 
	films f 
GROUP BY
	certification 
ORDER BY 
	cert_count DESC
```
<img width="307" alt="Screenshot 2024-02-02 at 17 33 57" src="https://github.com/Yegrii/Misfire/assets/30467268/cff40e3e-88a1-45f7-9324-0bad8f9bc81e">

I suggest replacing the empty certification with 'Not Rated'. 
```SQL
UPDATE films 
SET certification = 'Not Rated'
WHERE certification = '';
```
<img width="310" alt="Screenshot 2024-02-02 at 17 36 54" src="https://github.com/Yegrii/Misfire/assets/30467268/c6bc165b-bf88-4a10-ba26-01f31b4209a3">

4. What are the top five countries in terms of number of movies produced?

Top 5 countries:

```SQL
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
```
<img width="297" alt="Screenshot 2024-02-02 at 17 42 02" src="https://github.com/Yegrii/Misfire/assets/30467268/d1a5aea8-1d3f-46b0-abf4-6915cefbcd0a">

5. What is the average duration of English versus French movies?

The average English-language movie runs ~3 minutes longer than French-language movies.
```SQL
SELECT 
	`language` ,
	ROUND(AVG(duration), 2) AS avg_duration
FROM 
	films f 
WHERE 
	`language` IN ('English', 'French')
GROUP BY 
	`language`;
```
<img width="307" alt="Screenshot 2024-02-02 at 17 48 00" src="https://github.com/Yegrii/Misfire/assets/30467268/6d36ee5e-ef12-4422-8c90-ba51898c67df">

6. Any other insights you found during your analysis?
