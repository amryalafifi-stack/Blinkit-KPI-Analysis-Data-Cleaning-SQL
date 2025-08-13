Blinkit SQL Analytics & Data Cleaning

Project Overview:
This project analyzes Blinkit’s retail sales data using SQL. It covers importing, cleaning, processing, and generating KPIs across multiple dimensions like fat content, item type, outlet type, size, and location, providing actionable retail insights.

1. View All Data
SELECT * FROM blinkit_data;



This displays the entire raw dataset so we can inspect all fields and values before any processing.

2. Data Cleaning
UPDATE blinkit_data
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

SELECT DISTINCT Item_Fat_Content FROM blinkit_data;


This standardizes the Item_Fat_Content field to ensure consistent categories. The second query checks that the cleaning worked by showing all unique values.
3. Key Performance Indicators (KPIs)

Total Sales (in millions):

SELECT CAST(SUM(Total_Sales)/1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM blinkit_data;

<img width="203" height="97" alt="Screenshot 2025-08-13 180653" src="https://github.com/user-attachments/assets/09b2e2a9-61cf-42be-8194-8f0da2fe1a68" />


Calculates the total sales for all orders in millions for easier readability.

Average Sales:

SELECT CAST(AVG(Total_Sales) AS INT) AS Avg_Sales
FROM blinkit_data;


<img width="208" height="94" alt="Screenshot 2025-08-13 180803" src="https://github.com/user-attachments/assets/9c01d3e8-0e57-452e-921b-b704440c11c6" />


Computes the average sales per order across the dataset.

Number of Orders:

SELECT COUNT(*) AS No_of_Orders
FROM blinkit_data;


<img width="207" height="99" alt="Screenshot 2025-08-13 180809" src="https://github.com/user-attachments/assets/509e0a65-a077-4063-af6a-a3a4ed03504e" />


Counts the total number of orders in the dataset.

Average Rating:

SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating
FROM blinkit_data;

<img width="209" height="91" alt="Screenshot 2025-08-13 180819" src="https://github.com/user-attachments/assets/ec952901-2ba2-43a1-9cef-5aa96cf7a378" />


Calculates the average customer rating across all orders.

4. Sales Analysis by Category

By Fat Content:

SELECT Item_Fat_Content, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Fat_Content;

<img width="253" height="96" alt="Screenshot 2025-08-13 180831" src="https://github.com/user-attachments/assets/98db0a26-0aa0-4da1-856a-16e01eab1941" />



Shows total sales for each fat content category.

By Item Type:

SELECT Item_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC;



<img width="293" height="424" alt="Screenshot 2025-08-13 180850" src="https://github.com/user-attachments/assets/f3719c0e-39b3-4564-bf32-30f850a7a260" />




Calculates total sales for each item type and sorts them from highest to lowest.

By Outlet Location & Fat Content (Pivot):

SELECT Outlet_Location_Type, 
       ISNULL([Low Fat],0) AS Low_Fat, 
       ISNULL([Regular],0) AS Regular
FROM (
    SELECT Outlet_Location_Type, Item_Fat_Content, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT (
    SUM(Total_Sales) FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;


Transforms the data so each outlet location shows total sales for Low Fat and Regular items, replacing nulls with 0.

By Outlet Establishment Year:

SELECT Outlet_Establishment_Year, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;




<img width="309" height="253" alt="Screenshot 2025-08-13 180928" src="https://github.com/user-attachments/assets/5ae4b855-3a15-45e2-9390-57708288394a" />





Shows total sales grouped by the year the outlet was established.

Percentage of Sales by Outlet Size:

SELECT Outlet_Size, 
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(Total_Sales)*100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;




<img width="376" height="138" alt="Screenshot 2025-08-13 180939" src="https://github.com/user-attachments/assets/2371e752-8661-4d14-8539-798a7b1131fa" />






Calculates total sales and the percentage contribution of each outlet size to overall sales.

By Outlet Location:

SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;


Shows total sales for each outlet location sorted from highest to lowest.

All Metrics by Outlet Type:

SELECT Outlet_Type,
       CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
       COUNT(*) AS No_Of_Items,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
       CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;





<img width="614" height="149" alt="Screenshot 2025-08-13 180949" src="https://github.com/user-attachments/assets/6152f77f-e0d3-4b22-bf1a-af796b5e9f54" />







Aggregates total sales, average sales, number of items, average rating, and item visibility by outlet type.



