# Data Portfolio: Excel to Power BI
## Top UK YouTubers 2025


![excel-to-powerbi-animated-diagram](assets/images/kaggle_to_powerbi.gif)




# Table of contents 

- [Objective](#objective)
- [Data Source](#data-source)
- [Stages](#stages)
- [Design](#design)
  - [Mockup](#mockup)
  - [Tools](#tools)
- [Development](#development)
  - [Pseudocode](#pseudocode)
  - [Data Exploration](#data-exploration)
  - [Data Cleaning](#data-cleaning)
  - [Transform the Data](#transform-the-data)
  - [Create the SQL View](#create-the-sql-view)
- [Testing](#testing)
  - [Data Quality Tests](#data-quality-tests)
- [Visualization](#visualization)
  - [Results](#results)
  - [DAX Measures](#dax-measures)
- [Analysis](#analysis)
  - [Findings](#findings)
  - [Validation](#validation)
  - [Discovery](#discovery)
- [Recommendations](#recommendations)
  - [Potential ROI](#potential-roi)
  - [Potential Courses of Actions](#potential-courses-of-actions)
- [Conclusion](#conclusion)
- [About Me](#about-me)




# Objective 

- What is the key pain point? 

The Head of Marketing wants to find out who the top YouTubers are in 2025 to decide on which YouTubers would be best to run marketing campaigns throughout the rest of the year.


- What is the ideal solution? 

To create a dashboard that provides insights into the top UK YouTubers in 2025 that includes their: 
- subscriber count
- total views
- total videos, and
- engagement metrics

This will help the marketing team make informed decisions about which YouTubers to collaborate with for their marketing campaigns.

## User story 

As the Head of Marketing, I want to use a dashboard that analyses YouTube channel data in the UK. 

This dashboard should allow me to identify the top-performing channels based on metrics like subscriber base and average views. 

With this information, I can make more informed decisions about which Youtubers are right to collaborate with, and therefore maximise how effective each marketing campaign is.


# Data source 

- What data is needed to achieve our objective?

We need data on the top UK YouTubers in 2025 that includes their:
- channel names
- total subscribers
- total views
- total videos uploaded



- Where is the data coming from? 
The data is sourced from Kaggle (an Excel extract), [see here to find it.](https://www.kaggle.com/datasets/bhavyadhingra00020/top-100-social-media-influencers-2024-countrywise?resource=download)


# Stages

- Design
- Development
- Testing
- Analysis
 


# Design 

## Dashboard components required 
- What should the dashboard contain based on the requirements provided?

To understand what it should contain, we need to figure out what questions we need the dashboard to answer:

1. Who are the top 10 YouTubers with the most subscribers?
2. Which 3 channels have uploaded the most videos?
3. Which 3 channels have the most views?
4. Which 3 channels have the highest average views per video?
5. Which 3 channels have the highest views per subscriber ratio?
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

For now, these are some of the questions we need to answer, this may change as we progress down our analysis. 


## Dashboard mockup

- What should it look like? 

Some of the data visuals that may be appropriate in answering our questions include:

1. Table
2. Treemap
3. Scorecards
4. Horizontal bar chart 




![Dashboard-Mockup](assets/images/dashboard_mockup.png)


## Tools 


| Tool       | Purpose                                               |
| ---        | ---                                                   |  
| Excel      | Exploring the data                                    |
| SQL Server | Cleaning, testing, and analysing the data             |
| Power BI   | Visualising the data via interactive dashboards       |
| GitHub     | Hosting the project documentation and version control |
| Mokkup AI  | Designing the mockup of the dashboard                 | 


# Development

## Pseudocode

- What's the general approach in creating this solution from start to finish?

1. Get the data
2. Explore the data in Excel
3. Load the data into SQL Server
4. Clean the data with SQL
5. Test the data with SQL
6. Visualise the data in Power BI
7. Generate the findings based on the insights
8. Write the documentation + commentary
9. Publish the data to GitHub Pages

## Data exploration notes

This is the stage where you have a scan of what's in the data, errors, inconsistencies, bugs, weird and corrupted characters, etc  


- What are your initial observations with this dataset? What's caught your attention so far? 

1. There are at least 4 columns that contain the data we need for this analysis, which signals we have everything we need from the file without needing to contact the client for any more data. 
2. The first column contains the channel ID with what appears to be channel IDS, which are separated by a @ symbol - we need to extract the channel names from this.
3. Some of the cells and header names are in a different language - we need to confirm if these columns are needed, and if so, we need to address them.
4. We have more data than we need, so some of these columns would need to be removed





## Data cleaning 
- What do we expect the clean data to look like? (What should it contain? What constraints should we apply to it?)

The aim is to refine our dataset to ensure it is structured and ready for analysis. 

The cleaned data should meet the following criteria and constraints:

- Only relevant columns should be retained.
- All data types should be appropriate for the contents of each column.
- No column should contain null values, indicating complete data for all records.

Below is a table outlining the constraints on our cleaned dataset:

| Property          | Description |
| ---               | ---         |
| Number of Rows    | 100         |
| Number of Columns | 4           |

And here is a tabular representation of the expected schema for the clean data:

| Column Name       | Data Type | Nullable |
| ---               | ---       | ---      |
| channel_name      | VARCHAR   | NO       |
| total_subscribers | INTEGER   | NO       |
| total_views       | INTEGER   | NO       |
| total_videos      | INTEGER   | NO       |



- What steps are needed to clean and shape the data into the desired format?

1. Remove unnecessary columns by only selecting the ones you need.
2. Extract YouTube channel names from the first column.
3. Rename columns using aliases.







### Transform the data 



```sql
/*
# 1. Select the required columns
# 2. Extract the channel name from the 'NOMBRE' column
*/

-- 1.
SELECT
    SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE) -1) AS channel_name,  -- 2.
    total_subscribers,
    total_views,
    total_videos

FROM
    top_uk_youtubers_2025
```


### Create the SQL view 

```sql
/*
# 1. Create a view to store the transformed data
# 2. Cast the extracted channel name as VARCHAR(100)
# 3. Select the required columns from the top_uk_youtubers_2024 SQL table 
*/

-- 1.
CREATE VIEW view_uk_youtubers_2025 AS

-- 2.
SELECT CAST(SUBSTRING(NOMBRE,1,CHARINDEX('@', NOMBRE)-2) AS varchar(100)) AS channel_name, --CONVERTED TO STRING RESTRICTING WITH 100 CHARACTERS
	total_subscribers,
	total_views,
	total_videos

-- 3.
FROM top_uk_youtubers_2025

```


# Testing 

- What data quality and validation checks are you going to create?

Here are the data quality tests conducted:

## Row count check

```sql
/*
    Count the total number of rows (or records) in the SQL view. 
		Expected row count: 100
*/

SELECT 
	COUNT(*) AS no_of_rows
FROM 
	view_uk_youtubers_2025;

```

![Row count check](assets/images/1_row_count_check.png)



## Column count check
### SQL query 
```sql
/*
		Count the total number of columns (or fields) in the SQL view. 
		Expected column count: 4
*/

SELECT 
	COUNT(*) AS column_count
FROM 
	INFORMATION_SCHEMA.COLUMNS --want information about the columns
WHERE 
	TABLE_NAME='view_uk_youtubers_2025';
```
### Output 
![Column count check](assets/images/2_column_count_check.png)



## Data type check
### SQL query 
```sql
/*
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
```
### Output
![Data type check](assets/images/3_data_type_check.png)


## Duplicate count check
### SQL query 
```sql
/*
		-- (1) Check for duplicate rows in the view.
		-- (2) Group by the channel names.
		-- (3) Filter for groups with more than one row.
		Expected result: ZERO Duplicates
*/

--1.
SELECT
	channel_name,
	COUNT(*) AS duplicate_count
FROM
	view_uk_youtubers_2025

--2.
GROUP BY
	channel_name

--3.
HAVING 
	COUNT(*) > 1; --NO results returned = NO duplicates
```
### Output
![Duplicate count check](assets/images/4_duplicate_records_check.png)

# Visualization 


## Results

- What does the dashboard look like?

![GIF of Power BI Dashboard](assets/images/Top_uk_youtubers_2025.gif)

This shows the Top UK YouTubers in 2025 so far. 

## DAX Measures

### 1. Total Subscribers (M)
```sql
Total Subscriber (M) = 
VAR million = 1000000
VAR sumOfSubscribers = SUM(view_uk_youtubers_2025[total_subscribers])
VAR totalSubscribers = DIVIDE(sumOfSubscribers,million)

RETURN totalSubscribers

```

### 2. Total Views (B)
```sql
Total Views (B) = 
VAR billion = 1000000000
VAR sumOfTotalViews = SUM(view_uk_youtubers_2025[total_views])
VAR totalViews = DIVIDE(sumOfTotalViews, billion)

RETURN totalViews

```

### 3. Total Videos
```sql
Total Videos = 
VAR totalVideos = SUM(view_uk_youtubers_2025[total_videos])

RETURN totalVideos

```

### 4. Average Views Per Video (M)
```sql
Avg Views per video(M) = 
VAR sumOfTotalViews = SUM(view_uk_youtubers_2025[total_views])
VAR sumOfTotalVideos = SUM(view_uk_youtubers_2025[total_videos])
VAR avgOfViewsPerVideo = DIVIDE(sumOfTotalViews,sumOfTotalVideos,BLANK())
VAR finalAvgViewsPerVideo = DIVIDE(avgOfViewsPerVideo, 1000000, BLANK())

RETURN finalAvgViewsPerVideo

```


### 5. Subscriber Engagement Rate
```sql
Subscriber Engagement Rate = 
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers_2025[total_subscribers])
VAR sumOfTotalVideos = SUM(view_uk_youtubers_2025[total_videos])
VAR subscriberEngRate = DIVIDE(sumOfTotalSubscribers,sumOfTotalVideos)

RETURN subscriberEngRate

```


### 6. Views per subscriber
```sql
Views Per Subscriber = 
VAR sumOfTotalViews = SUM(view_uk_youtubers_2025[total_views])
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers_2025[total_subscribers])
VAR viewsPerSubscriber = DIVIDE(sumOfTotalViews,sumOfTotalSubscribers, BLANK())

RETURN viewsPerSubscriber

```




# Analysis 

## Findings

- What did we find?

For this analysis, we're going to focus on the questions below to get the information we need for our marketing client - 

Here are the key questions we need to answer for our marketing client: 
1. Who are the top 10 YouTubers with the most subscribers?
2. Which 3 channels have uploaded the most videos?
3. Which 3 channels have the most views?
4. Which 3 channels have the highest average views per video?
5. Which 3 channels have the highest views per subscriber ratio?
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?


### 1. Who are the top 10 YouTubers with the most subscribers?

| Rank | Channel Name         | Subscribers (M) |
|------|----------------------|-----------------|
| 1    | NoCopyrightSounds    | 34.00           |
| 2    | DanTDM               | 29.20           |
| 3    | Dan Rhodes           | 26.80           |
| 4    | Miss Katy            | 25.40           |
| 5    | KSI                  | 25.00           |
| 6    | Mister Max           | 25.00           |
| 7    | Dua Lipa             | 24.20           |
| 8    | Jelly                | 23.50           |
| 9    | Mrwhosetheboss       | 20.90           |
| 10   | Ali-A                | 19.60           |


### 2. Which 3 channels have uploaded the most videos?

| Rank | Channel Name    | Videos Uploaded |
|------|-----------------|-----------------|
| 1    | GRM Daily       | 15,343          |
| 2    | Manchester City | 9,438           |
| 3    | Yogscast        | 7,128           |



### 3. Which 3 channels have the most views?


| Rank | Channel Name | Total Views (B) |
|------|--------------|-----------------|
| 1    | DanTDM       | 20.17           |
| 2    | Dan Rhodes   | 19.19           |
| 3    | Mister Max   | 16.49           |


### 4. Which 3 channels have the highest average views per video?

| Channel Name | Average Views per Video (M) |
|--------------|-----------------            |
| Mark Ronson  | 350.37                      |
| Dua Lipa     | 46.60                       |
| Jessie J     | 41.03                       |


### 5. Which 3 channels have the highest views per subscriber ratio?

| Rank | Channel Name       | Views per Subscriber        |
|------|-----------------   |---------------------------- |
| 1    | Disney Junior UK   | 1633.76                     |
| 2    | GRM Daily          | 1213.34                     |
| 3    | Nickelodeon UK     | 1065.82                     |




### 6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

| Rank | Channel Name    | Subscriber Engagement Rate  |
|------|-----------------|---------------------------- |
| 1    | Mark Ronson     | 354,500.00                  |
| 2    | Dua Lipa        | 77,564.10                   |
| 3    | Jessie J        | 72,000.00                   |




### Notes

For this analysis, we'll prioritise analysing the metrics that are important in generating the expected ROI for our marketing client, which are the YouTube channels with the most 

- subscribers
- total views
- videos uploaded



## Validation 

### 1. Youtubers with the most subscribers 

#### Calculation breakdown

Campaign idea = product placement 

1. NoCopyrightSounds 
- Average views per video = 6.01 million
- Product cost = $5
- Potential units sold per video = 6.01 million x 2% conversion rate =  120,200 units sold
- Potential revenue per video =  120,200 x $5 = $601,000 
- Campaign cost (one-time fee) = $50,000
- **Net profit = $601,000 - $50,000 = $ 551,000**

b. DanTDM

- Average views per video = 5.37 million  
- Product cost = $5
- Potential units sold per video = 5.37 million x 2% conversion rate = 107,400 units sold
- Potential revenue per video = 107,400 x $5 = $537,000 
- Campaign cost (one-time fee) = $50,000
- **Net profit = $537,000 - $50,000 = $487,000**

c. Dan Rhodes

- Average views per video = 11.34 million
- Product cost = $5
- Potential units sold per video = 11.34 million x 2% conversion rate = 226,800 units sold  
- Potential revenue per video = 226,800 x $5 = $1,134,000
- Campaign cost (one-time fee) = $50,000
- **Net profit = $1,134,000 - $50,000 = $1,084,000**


Best option from category: Dan Rhodes


#### SQL query 

```sql
/*

1. Define the variables
2. Create a CTE that rounds the average views per video
3. Select the columns that are required for the analysis
4. Filter the results by the YouTube channels with the highest subscribers
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

```

#### Output

![Most subsc](assets/images/youtubers_with_the_most_subs.png)


### 2. Youtubers with the most videos uploaded

### Calculation breakdown 

Campaign idea = sponsored video series  

1. GRM Daily
- Average views per video = 520,000
- Product cost = $5
- Potential units sold per video = 520,000 x 2% conversion rate = 10,400 units sold
- Potential revenue per video = 10,400 x $5= $52,000
- Campaign cost (11-videos @ $5,000 each) = $55,000
- **Net profit = $52,000 - $55,000 = -$3,000 (potential loss)**

b. **Manchester City**

- Average views per video = 260,000
- Product cost = $5
- Potential units sold per video = 260,000 x 2% conversion rate = 5,200 units sold
- Potential revenue per video = 5,200 x $5= $26,000
- Campaign cost (11-videos @ $5,000 each) = $55,000
- **Net profit = $26,000 - $55,000 = -$29,000 (potential loss)**

b. **Yogscast**

- Average views per video = 650,000
- Product cost = $5
- Potential units sold per video = 650,000 x 2% conversion rate = 13,000 units sold
- Potential revenue per video = 13,000 x $5= $65,000
- Campaign cost (11-videos @ $5,000 each) = $55,000
- **Net profit = $65,000 - $55,000 = $10,000 (profit)**


Best option from category: Yogscast

#### SQL query 
```sql
/* 
# 1. Define variables
# 2. Create a CTE that rounds the average views per video
# 3. Select the columns you need and create calculated columns from existing ones
# 4. Filter results by YouTube channels
# 5. Sort results by net profits (from highest to lowest)
*/


-- 1.
DECLARE @conversionRate FLOAT = 0.02;           -- The conversion rate @ 2%
DECLARE @productCost FLOAT = 5.0;               -- The product cost @ $5
DECLARE @campaignCostPerVideo FLOAT = 5000.0;   -- The campaign cost per video @ $5,000
DECLARE @numberOfVideos INT = 11;               -- The number of videos (11)


-- 2.
WITH ChannelData AS (
    SELECT
        channel_name,
        total_views,
        total_videos,
        ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
    FROM
        view_uk_youtubers_2025
)


-- 3.
SELECT
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    ((rounded_avg_views_per_video * @conversionRate * @productCost) - (@campaignCostPerVideo * @numberOfVideos)) AS net_profit
FROM
    ChannelData


-- 4.
WHERE
    channel_name IN ('GRM Daily', 'Man City', 'YOGSCAST Lewis & Simon ')


-- 5.
ORDER BY
    net_profit DESC;
```

#### Output

![Most videos](assets/images/youtubers_with_the_most_videos.png)


### 3.  Youtubers with the most views 

#### Calculation breakdown

Campaign idea = Influencer marketing 

a. DanTDM

- Average views per video = 5.37 million
- Product cost = $5
- Potential units sold per video = 5.37 million x 2% conversion rate = 107,400 units sold
- Potential revenue per video = 107,400 x $5 = $537,000
- Campaign cost (3-month contract) = $130,000
- **Net profit = $537,000 - $130,000 = $407,000**

b. Dan Rhodes

- Average views per video = 11.34 million
- Product cost = $5
- Potential units sold per video = 11.34 million x 2% conversion rate = 226,800 units sold
- Potential revenue per video = 226,800 x $5 = $1,134,000
- Campaign cost (3-month contract) = $130,000
- **Net profit = $1,134,000 - $130,000 = $1,004,000**

c. Mister Max

- Average views per video = 13.76 million
- Product cost = $5
- Potential units sold per video = 13.76 million x 2% conversion rate = 275,200 units sold
- Potential revenue per video = 275,200 x $5 = $1,376,000
- Campaign cost (3-month contract) = $130,000
- **Net profit = $1,376,000 - $130,000 = $1,246,000**

Best option from category: Mister Max



#### SQL query 
```sql
/*
# 1. Define variables
# 2. Create a CTE that rounds the average views per video
# 3. Select the columns you need and create calculated columns from existing ones
# 4. Filter results by YouTube channels
# 5. Sort results by net profits (from highest to lowest)
*/



-- 1.
DECLARE @conversionRate FLOAT = 0.02;        -- The conversion rate @ 2%
DECLARE @productCost MONEY = 5.0;            -- The product cost @ $5
DECLARE @campaignCost MONEY = 130000.0;      -- The campaign cost @ $130,000



-- 2.
WITH ChannelData AS (
    SELECT
        channel_name,
        total_views,
        total_videos,
        ROUND(CAST(total_views AS FLOAT) / total_videos, -4) AS avg_views_per_video
    FROM
		view_uk_youtubers_2025
)


-- 3.
SELECT
    channel_name,
    avg_views_per_video,
    (avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    (avg_views_per_video * @conversionRate * @productCost) - @campaignCost AS net_profit
FROM
    ChannelData


-- 4.
WHERE
    channel_name IN ('Mister Max', 'DanTDM', 'Dan Rhodes')


-- 5.
ORDER BY
    net_profit DESC;
```

#### Output

![Most views](assets/images/youtubers_with_the_most_views.png)


## Discovery

- What did we learn?

We discovered that 


1. NoCopyrightSounds, DanTDM and Dan Rhodes are the channels with the most subscribers in the UK
2. GRM Daily, Man City and Yogscast are the channels with the most videos uploaded
3. DanTDM, Dan Rhodes and Mister Max are the channels with the most views
4. Entertainment channels are useful for broader reach, as the channels focused on entertainment and music are the ones posting consistently on their platforms and generating the most engagement.




## Recommendations 

- What do you recommend based on the insights gathered? 
  
1. Dan Rhodes is the best YouTube channel to collaborate with if we want to maximise visibility because this channel has the most YouTube subscribers in the country.
2. Although GRM Daily, Man City and Yogcasts regularly upload on YouTube, it may be worth considering whether collaborating with them with the current budget caps is worth the effort, as the potential return on investment is significantly lower compared to the other channels. A suggestion may be to negotiate with the board to raise the budget for the 11-video series campaign to establish a good, long-term relationship with the channels. This is because their consistent upload rate would inevitably increase their potential reach over time.
3. Mister Max is the best YouTuber to collaborate with if we're interested in maximising reach, but collaborating with DanTDM and Dan Rhodes may be better long-term options, considering that they both have large subscriber bases and average significantly high views.
4. The top 3 channels to form collaborations with are NoCopyrightSounds, DanTDM and Dan Rhodes based on this analysis, because they attract the most engagement on their channels consistently.


### Potential ROI 
- What ROI do we expect if we take this course of action?

1. Setting up a collaboration deal with Dan Rhodes would make the client a net profit of $1,084,000 per video
2. An influencer marketing contract with Mister Max can help the client generate a net profit of $1,246,000
3. If we go with a product placement campaign with DanTDM, this could  generate the client approximately $487,000 per video. However, if we advance with an influencer marketing campaign deal instead, this would make the client a one-off net profit of $407,000.
4. NoCopyrightSounds could profit the client $551,000 per video, too (which is worth considering) 




### Action plan
- What course of action should we take and why?

Based on our analysis, we believe the best channel to advance a long-term partnership deal to promote the client's products is the Dan Rhodes channel. 

We'll have conversations with the marketing client to forecast what they also expect from this collaboration. Once we observe that we are hitting the expected milestones, we'll advance with potential partnerships with DanTDM, Mister Max and NoCopyrightSounds channels in the future.   

- What steps do we take to implement the recommended decisions effectively?


1. Reach out to the teams behind each of these channels, starting with Dan Rhodes.
2. Negotiate contracts within the budgets allocated to each marketing campaign.
3. Kick off the campaigns and track each of their performances against the KPIs.
4. Review how the campaigns have gone, gather insights and optimise based on feedback from converted customers and each channel's audiences.


# About Me

Hi, I’m a recent Industrial Engineering graduate from the University of Pretoria with a passion for solving real-world problems using data. My interest in data analytics grew during my studies, and I’ve since committed to a hands-on, project-based learning approach to build practical, job-ready skills.

I believe the best way to learn is by doing, not just watching tutorials or memorising concepts, but actively applying them to real challenges. That’s why I’ve created this GitHub to showcase a growing collection of projects that reflect my learning journey, from data cleaning and SQL analytics to building insightful dashboards and exploring business questions.

Each project is an opportunity to sharpen my skills, understand industry tools and standards, and build a portfolio that demonstrates not just what I’ve learned, but how I think and solve problems.













