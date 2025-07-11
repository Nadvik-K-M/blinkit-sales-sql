-- 1. Create and use database
CREATE DATABASE IF NOT EXISTS blinkit;
USE blinkit;

SELECT COUNT(*) FROM blinkitdata;

UPDATE blinkitdata 
SET Item_Fat_Content = 
CASE
WHEN Item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END;

SET SQL_SAFE_UPDATES=0;

SELECT DISTINCT(Item_Fat_Content) FROM blinkitdata;

SELECT CONCAT(CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2))) ,'million' AS Total_Sales_Millions
FROM blinkitdata;

SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS AVG_SALES FROM blinkitdata;

SELECT COUNT(*) AS NO_OF_ITEM FROM blinkitdata;

SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2))  AS Total_Sales_LowFat
FROM blinkitdata 
WHERE Item_Fat_Content = 'Low Fat';
SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,0))  AS AVG_Sales_LowFat
FROM blinkitdata 
WHERE Item_Fat_Content = 'Low Fat';

SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL (10,2)) AS Total_Sales_2022
FROM blinkitdata
WHERE Outlet_Establishment_Year = 2022;
SELECT COUNT(Total_Sales) AS Count_Sales_2022
FROM blinkitdata
WHERE Outlet_Establishment_Year = 2022;
SELECT CAST(MAX(Total_Sales)AS DECIMAL(10,0)) AS MAX_Sales_2022
FROM blinkitdata
WHERE Outlet_Establishment_Year = 2022;

SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating FROM blinkitdata;

--  Overall totals and averages by Fat Content
SELECT Item_Fat_Content, 
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
        CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS AVG_Sales,
        CAST(MAX(Total_Sales) AS DECIMAL(10,0)) AS Max_Sales,
        CAST(MIN(Total_Sales) AS DECIMAL(10,0)) AS Min_Sales,
        COUNT(Total_Sales) AS No_Of_Sales
FROM blinkitdata
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;

--  Overall totals and averages by 2022
SELECT Outlet_Establishment_Year, 
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
        CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS AVG_Sales,
        CAST(MAX(Total_Sales) AS DECIMAL(10,0)) AS Max_Sales,
        CAST(MIN(Total_Sales) AS DECIMAL(10,0)) AS Min_Sales,
        COUNT(Total_Sales) AS No_Of_Sales
FROM blinkitdata
WHERE Outlet_Establishment_Year= 2022
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;

-- Overall totals and averages by Item_Type(Top 5)
SELECT  Item_Type,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
        CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS AVG_Sales,
        CAST(MAX(Total_Sales) AS DECIMAL(10,0)) AS Max_Sales,
        CAST(MIN(Total_Sales) AS DECIMAL(10,0)) AS Min_Sales,
        COUNT(Total_Sales) AS No_Of_Sales
FROM blinkitdata
GROUP BY Item_Type 
ORDER BY Total_Sales ASC 
LIMIT 5 ;

-- Outlet location and fat-content breakdown
SELECT Outlet_Location_Type,Item_Fat_Content,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
        CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS AVG_Sales,
        CAST(MAX(Total_Sales) AS DECIMAL(10,0)) AS Max_Sales,
        CAST(MIN(Total_Sales) AS DECIMAL(10,0)) AS Min_Sales,
        COUNT(*) AS No_Of_Sales
FROM blinkitdata
GROUP BY Outlet_Location_Type,Item_Fat_Content
ORDER BY Total_Sales ASC;

--  Outlet year vs fat-content breakdown
SELECT Outlet_Establishment_Year,Item_Fat_Content,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
        CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS AVG_Sales,
        CAST(MAX(Total_Sales) AS DECIMAL(10,0)) AS Max_Sales,
        CAST(MIN(Total_Sales) AS DECIMAL(10,0)) AS Min_Sales,
        COUNT(*) AS No_Of_Sales
FROM blinkitdata
GROUP BY Outlet_Establishment_Year,Item_Fat_Content
ORDER BY Outlet_Establishment_Year ASC;

-- Outlet_Size metrics for 2020
SELECT
  Outlet_Size,
  CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
  CAST(
    SUM(Total_Sales) * 100.0
    / SUM(SUM(Total_Sales)) OVER ()
    AS DECIMAL(10,2)
  ) AS Sales_Percentage
FROM blinkitdata
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-- Outlet_Location_Type 2020
SELECT Outlet_Location_Type,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
        CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS AVG_Sales,
        CAST(MAX(Total_Sales) AS DECIMAL(10,0)) AS Max_Sales,
        CAST(MIN(Total_Sales) AS DECIMAL(10,0)) AS Min_Sales,
        COUNT(*) AS No_Of_Sales
FROM blinkitdata
WHERE Outlet_Establishment_Year = 2020
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales ASC;

 -- Outlet type and sales % overal
SELECT Outlet_Type,
		CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
        CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS AVG_Sales,
        CAST(SUM(Total_Sales) * 100.0/ SUM(SUM(Total_Sales)) OVER ()AS DECIMAL(10,2)) AS Sales_Percentage,
        CAST(MAX(Total_Sales) AS DECIMAL(10,0)) AS Max_Sales,
        CAST(MIN(Total_Sales) AS DECIMAL(10,0)) AS Min_Sales,
        COUNT(*) AS No_Of_Sales
FROM blinkitdata
GROUP BY Outlet_Type
ORDER BY Total_Sales ASC;

SELECT * FROM blinkitdata;

