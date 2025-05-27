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
	COUNT(*) > 1; --NO results returned = NO duplicates 
