SELECT TOP 10 * FROM KMS_order

SELECT TOP 1 *
FROM KMS_order;

ALTER TABLE KMS_order
ALTER COLUMN Product_Base_Margin DECIMAL(5,2)

--- 1) Which Product category had the highest sales?
---This shows total sales per category, sorted with the highest first.
SELECT [Product_Category], SUM(Sales) AS Total_Sales
FROM KMS_order
GROUP BY [Product_Category]
ORDER BY Total_Sales DESC;

---2) What are the Top 3 and Bottom 3 regions in terms of sales?
---Top 3
SELECT TOP 3 Region, SUM(Sales) AS Total_Sales
FROM KMS_order
GROUP BY Region
ORDER BY Total_Sales DESC;

----Bottom 3:
SELECT TOP 3 Region, SUM(Sales) AS Total_Sales
FROM KMS_order
GROUP BY Region
ORDER BY Total_Sales ASC;

----3) What were the total sales of appliances in Ontario?
SELECT SUM(Sales) AS Total_Sales
FROM KMS_order
WHERE [Product_Sub_Category] = 'Appliances'
  AND Province = 'Ontario';

---- 4) Advise KMS on how to increase revenue from the bottom 10 customers
SELECT TOP 10 [Customer_Name], SUM(Sales) AS Total_Sales
FROM KMS_order
GROUP BY [Customer_Name]
ORDER BY Total_Sales ASC;

-----5) KMS incurred the most shipping cost using which shipping method?
SELECT [Ship_Mode], SUM([Shipping_Cost]) AS Total_Shipping_Cost
FROM KMS_order
GROUP BY [Ship_Mode]
ORDER BY Total_Shipping_Cost DESC;


----6) Who are the most valuable customers, and what do they buy?
SELECT [Customer_Name], [Product_Category], SUM(Sales) AS Total_Sales
FROM KMS_order
GROUP BY [Customer_Name], [Product_Category]
ORDER BY Total_Sales DESC;


---- 7) Which small business customer had the highest sales?
SELECT TOP 1 [Customer_Name], SUM(Sales) AS Total_Sales
FROM KMS_order
WHERE [Customer_Segment] = 'Small Business'
GROUP BY [Customer_Name]
ORDER BY Total_Sales DESC;


-----8) Which corporate customer placed the most orders?
SELECT [Customer_Name], COUNT([Order_ID]) AS Order_Count
FROM KMS_order
WHERE [Customer_Segment] = 'Corporate'
GROUP BY [Customer_Name]
ORDER BY Order_Count DESC;


----9) Which consumer customer was the most profitable?
SELECT TOP 1 [Customer_Name], SUM(Profit) AS Total_Profit
FROM KMS_order
WHERE [Customer_Segment] = 'Consumer'
GROUP BY [Customer_Name]
ORDER BY Total_Profit DESC;

select * from Order_Status
----10) Which customer returned items, and what segment do they belong to?
SELECT 
    K.Customer_Name,
    K.Customer_Segment
FROM 
    KMS_order K
JOIN 
    Order_status S
    ON K.Order_ID = S.Order_ID
WHERE 
    S.Status = 'Returned';

-----11) Was shipping cost used appropriately by priority?
SELECT [Order_Priority], [Ship_Mode], AVG([Shipping_Cost]) AS Avg_Shipping_Cost
FROM KMS_order
GROUP BY [Order_Priority], [Ship_Mode]
ORDER BY [Order_Priority], Avg_Shipping_Cost DESC;


ROUND(SUM(Sales - Profit),2) AS EstimatedShippingCost,
AVG(DATEDIFF(day, [Order_Date], [Ship_Date])) AS AvgShipDays