/*
	1. row count test
		Count the total number of rows (or records) in the SQL view. 
		Expected row count: 100
*/

SELECT 
	COUNT(*) AS no_of_rows
FROM 
	view_uk_youtubers_2025
