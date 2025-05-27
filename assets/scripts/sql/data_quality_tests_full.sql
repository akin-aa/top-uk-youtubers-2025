/*

#Data Quality Tests

1. The data needs to be 100 records of YouTube channels (row count test) ---[PASSED!]
2. The data needs 4 fields (column count test) ---[PASSED!]
3. The channel name column must be string format, and the other columns must be numerical data types (data type check) ---[PASSED!]
4. Each record must be unique in the dataset(duplicate count check) ---[PASSED!]
*/

/*
	1. row count test
		Count the total number of rows (or records) in the SQL view. 
		Expected row count: 100
*/

SELECT 
	COUNT(*) AS no_of_rows
FROM 
	view_uk_youtubers_2025 


/*
	2. Column count test
		Count the total number of columns (or fields) in the SQL view. 
		Expected column count: 4
*/

SELECT 
	COUNT(*) AS column_count
FROM 
	INFORMATION_SCHEMA.COLUMNS --want information about the columns
WHERE 
	TABLE_NAME='view_uk_youtubers_2025'

/*
	3. Data Type test
		Check the data types of each column from the SQL view by checking the INFORMATION SCHEMA view. 
		Expected Data types:
			channel_name= VARCHAR
			total_subscribers= INT OR BIGINT
			total_views= INT OR BIGINT
			total_videos= INT OR BIGINT
*/

SELECT 
	COLUMN_NAME,
	DATA_TYPE
FROM 
	INFORMATION_SCHEMA.COLUMNS 
WHERE 
	TABLE_NAME='view_uk_youtubers_2025'

/*
	4. Duplicate Records/Count Check
		-- (4.1) Check for duplicate rows in the view.
		-- (4.2) Group by the channel names.
		-- (4.3) Filter for groups with more than one row.
		Expected result: ZERO Duplicates
*/

SELECT
	channel_name,
	COUNT(*) AS duplicate_count
FROM
	view_uk_youtubers_2025
GROUP BY
	channel_name
HAVING 
	COUNT(*) > 1 --NO results returned = NO duplicates 
