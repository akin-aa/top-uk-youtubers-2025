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
	TABLE_NAME='view_uk_youtubers_2025';
