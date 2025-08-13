SELECT * FROM blinkit_data

SELECT CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022


SELECT CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022 


SELECT COUNT(*) Number_Of_Items FROM blinkit_data 
WHERE Outlet_Establishment_Year = 2022

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) Avg_Rating FROM blinkit_data



SELECT Outlet_Establishment_Year,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS Number_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year, Item_Fat_Content
ORDER BY Total_Sales DESC

SELECT 
    Outlet_Size,
    CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales)*100.0/SUM(SUM(Total_Sales)) OVER()) AS DECIMAL (10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;


SELECT Outlet_Type,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales)*100/SUM(SUM(Total_Sales)) OVER ()) AS DECIMAL (10,2)) AS Sales_Percentage,
    CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS Number_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC






