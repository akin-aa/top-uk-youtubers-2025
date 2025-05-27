/*

1. Define the variables
2. Create a CTE that rounds the average views per video
3. Select the columns that are required for the analysis
4. Filter the results by the YouTube channels with the highest subscriber bases
5. Order by the net_profit (from the highest to the lowest)

*/

--1.
DECLARE @conversionRate FLOAT = 0.02;		--The conversion rate @ 2%
DECLARE @productCost MONEY = 5.0;			--The product cost @ $5
DECLARE @campaignCost MONEY = 50000.0;	--The campaign cost @ $50,000


--2.
WITH ChannelData AS (
	SELECT
	channel_name,
	total_views,
	total_videos,
	ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
	FROM view_uk_youtubers_2025
)

--3. 

SELECT 
	channel_name,
	rounded_avg_views_per_video,
	(rounded_avg_views_per_video * @conversionRate) AS potential_product_sales_per_video,
	(rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
	((rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost) AS net_profit
FROM ChannelData

--4.
WHERE channel_name IN ('NoCopyrightSounds', 'DanTDM', 'Dan Rhodes')

--5.
ORDER BY 
	net_profit DESC
