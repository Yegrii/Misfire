🎥 Challenge 2: You have just been hired by a large movie studio to perform data analysis. 
Your manager, an executive at the company, wants to make new movies that 'recapture the magic of old Hollywood.' 
So you've decided to look at the most successful films to help generate ideas that could turn into future successful films.

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
