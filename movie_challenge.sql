SELECT *
FROM 
	films f 
;

	
UPDATE films 
SET release_year = NULL 
WHERE release_year = 'null';

ALTER TABLE films 
MODIFY COLUMN release_year INT;

DESC films ;

SELECT *
FROM 
	films f 
WHERE 
	duration = 'null';
	
UPDATE films 
SET duration = NULL 
WHERE duration = 'null';

ALTER TABLE films 
MODIFY COLUMN duration INT;

SELECT *
FROM 
	films f 
WHERE 
	gross  = 'null';

UPDATE films 
SET gross = NULL 
WHERE gross = 'null';

ALTER TABLE films 
MODIFY COLUMN gross INT;


SELECT *
FROM films f 
WHERE budget IS NOT NULL ;

UPDATE films 
SET budget = NULL 
WHERE budget = 'null';

ALTER TABLE films 
MODIFY COLUMN budget BIGINT;


SELECT *
FROM films f 
WHERE country = ''

UPDATE films 
SET country = 'Unknown'
WHERE country = '';


SELECT *
FROM films f 
WHERE `language` = ''

UPDATE films 
SET `language` = 'Unknown'
WHERE `language` = '';