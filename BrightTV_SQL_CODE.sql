-------------------------------------------------------------------------------------------------------
--viewing my data from two tables
-------------------------------------------------------------------------------------------------------
SELECT * FROM bright.viewer.tv LIMIT 10;
SELECT * FROM bright.viewer.user LIMIT 10;
-------------------------------------------------------------------------------------------------------
--Convert UTC to South African Time (SA timezone = Africa/Johannesburg (UTC+2))
-------------------------------------------------------------------------------------------------------
SELECT 
    UserID,
    channel2,
    CONVERT_TIMEZONE('UTC', 'Africa/Johannesburg', 
        TO_TIMESTAMP(recorddate2, 'YYYY/MM/DD HH24:MI')
    ) AS RecordDate_SA
FROM bright.viewer.tv;
-------------------------------------------------------------------------------------------------------
--Clean Duration Column (HH:MM:SS → Seconds/Minutes)
-------------------------------------------------------------------------------------------------------
SELECT 
    *,
    DATEDIFF(second, TIME '00:00:00', TO_TIME(TRIM(duration2))) AS duration_seconds,
    DATEDIFF(second, TIME '00:00:00', TO_TIME(TRIM(duration2))) / 60 AS duration_minutes
FROM bright.viewer.tv;

-------------------------------------------------------------------------------------------------------
--Creating a Cleaned View Combining Everything
-------------------------------------------------------------------------------------------------------
USE DATABASE bright;
USE SCHEMA viewer;
-------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TABLE bright.viewer.cleaned_viewer_table AS
SELECT 
    v.UserID,
    v.Channel2,
    CONVERT_TIMEZONE('UTC','Africa/Johannesburg',
        TO_TIMESTAMP(v.recorddate2, 'YYYY/MM/DD HH24:MI')
    ) AS RecordDateSA,
    DATEDIFF(second, TIME '00:00:00', TO_TIME(TRIM(duration2))) AS duration_seconds,
    DATEDIFF(second, TIME '00:00:00', TO_TIME(TRIM(duration2))) / 60 AS duration_minutes,
    p.Name,
    p.Surname,
    p.Gender,
    p.Race,
    p.Age,
    p.Province
FROM bright.viewer.tv v
LEFT JOIN bright.viewer.user p
    ON v.UserID = p.UserID;

-------------------------------------------------------------------------------------------------------
--Analysis Queries
--Sessions Per Day
-------------------------------------------------------------------------------------------------------
SELECT 
    TO_DATE(RecordDateSA) AS view_date,
    COUNT(*) AS sessions
FROM cleaned_viewer_table
GROUP BY 1
ORDER BY 1;
-------------------------------------------------------------------------------------------------------
--Peak Viewing Hours
-------------------------------------------------------------------------------------------------------
SELECT 
    EXTRACT(HOUR FROM RecordDateSA) AS hour_of_day,
    COUNT(*) AS sessions
FROM cleaned_viewer_table
GROUP BY 1
ORDER BY 1;
-------------------------------------------------------------------------------------------------------
--Top 10 Channels
-------------------------------------------------------------------------------------------------------
SELECT 
    Channel2,
    COUNT(*) AS sessions
FROM cleaned_viewer_table
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
-------------------------------------------------------------------------------------------------------
--Usage by Age Group
-------------------------------------------------------------------------------------------------------
SELECT 
    CASE 
        WHEN Age < 18 THEN 'Teenage'
        WHEN Age BETWEEN 18 AND 24 THEN 'youth'
        WHEN Age BETWEEN 25 AND 34 THEN 'young_adult'
        WHEN Age BETWEEN 35 AND 44 THEN 'adult'
        WHEN Age BETWEEN 45 AND 54 THEN 'older_adult'
        WHEN Age BETWEEN 55 AND 64 THEN 'Senior_adult'
        ELSE 'elderly'
    END AS age_group,
    COUNT(*) AS sessions
FROM cleaned_viewer_table
GROUP BY 1
ORDER BY 1;
-------------------------------------------------------------------------------------------------------
--Usage by Province
-------------------------------------------------------------------------------------------------------
SELECT 
    Province,
    COUNT(*) AS sessions
FROM cleaned_viewer_table
GROUP BY 1
ORDER BY 2 DESC;

-------------------------------------------------------------------------------------------------------
--Weekday vs Weekend Consumption
--------------------------------------------------------------------------------------------------------
SELECT 
    DAYNAME(RecordDateSA) AS day_name,
    COUNT(*) AS sessions
FROM cleaned_viewer_table
GROUP BY 1
ORDER BY 2 DESC;

-------------------------------------------------------------------------------------------------------
--Factors Influencing Consumption
--correlation by age, gender, province & channel preference.
--Most-watched content by demographic:
-------------------------------------------------------------------------------------------------------
SELECT 
    Gender,
    Channel2,
    COUNT(*) AS views
FROM cleaned_viewer_table
GROUP BY 1,2
ORDER BY 3 DESC;

-------------------------------------------------------------------------------------------------------
--Average session duration by channel:
-------------------------------------------------------------------------------------------------------
SELECT 
    Channel2,
    AVG(duration_minutes) AS avg_minutes
FROM cleaned_viewer_table
GROUP BY 1
ORDER BY 2 DESC;

-------------------------------------------------------------------------------------------------------
--Final Query for new table
-------------------------------------------------------------------------------------------------------
USE DATABASE bright;
USE SCHEMA viewer;

CREATE OR REPLACE TABLE bright.viewer.cleaned_viewer_table AS
SELECT
    v.UserID,
    v.channel2,
    CONVERT_TIMEZONE('UTC', 'Africa/Johannesburg', 
        TO_TIMESTAMP(recorddate2, 'YYYY/MM/DD HH24:MI')
    ) AS RecordDate_SA,

    -- Excel-friendly date fields
    TO_DATE(
        CONVERT_TIMEZONE('UTC','Africa/Johannesburg',
        TO_TIMESTAMP(v.recorddate2, 'YYYY/MM/DD HH24:MI'))
    ) AS SA_Date,

    EXTRACT(HOUR FROM 
        CONVERT_TIMEZONE('UTC','Africa/Johannesburg',
        TO_TIMESTAMP(v.recorddate2, 'YYYY/MM/DD HH24:MI'))
    ) AS SA_Hour,

    DAYNAME(
        CONVERT_TIMEZONE('UTC','Africa/Johannesburg',
        TO_TIMESTAMP(v.recorddate2, 'YYYY/MM/DD HH24:MI'))
    ) AS SA_Weekday,

    -- Duration using DATEDIFF
    DATEDIFF(second, TIME '00:00:00', TO_TIME(TRIM(duration2))) AS duration_seconds,
    DATEDIFF(second, TIME '00:00:00', TO_TIME(TRIM(duration2))) / 60 AS duration_minutes,

    -- User profile fields
    p.Name,
    p.Surname,
    p.Gender,
    p.Race,
    p.Age,
    p.Province,

    -- Age Group
    CASE
         WHEN p.Age < 18 THEN 'Teenage'
        WHEN p.Age BETWEEN 18 AND 24 THEN 'youth'
        WHEN p.Age BETWEEN 25 AND 34 THEN 'young_adult'
        WHEN p.Age BETWEEN 35 AND 44 THEN 'adult'
        WHEN p.Age BETWEEN 45 AND 54 THEN 'older_adult'
        WHEN p.Age BETWEEN 55 AND 64 THEN 'Senior_adult'
        ELSE 'elderly'
    END AS age_group,

FROM bright.viewer.tv v
LEFT JOIN bright.viewer.user p
    ON v.UserID = p.UserID;


-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
