-- Question 5.1
SELECT 
    c.Cust_Name AS Customer_Name,
    c.Cust_Email AS Customer_Email,
    o.Order_Number,
    o.Order_Date,
    p.Prod_Name AS Product_Name,
    p.Prod_Price,
    od.Quantity,
    o.Order_GrandTotal
FROM 
    Customer c
JOIN 
    Customer_Order o ON c.Cust_Email = o.Cust_Email
JOIN 
    Order_Details od ON o.Order_Number = od.Order_Number
JOIN 
    Product p ON od.Prod_Number = p.Prod_Number
ORDER BY 
    c.Cust_Email, o.Order_Date;

-- Question 5.2
SELECT 
    c.Cust_Email AS Customer_Email,
    c.Cust_Name AS Customer_Name,
    c.Cust_Birthdate AS Customer_Birthday,
    gc.Current_Balance AS Gift_Card_Balance,
    p.Prod_Name AS Product_Name,
    bdt.Quantity AS Product_Quantity
FROM 
    Customer c
JOIN 
    Basket b ON c.Cust_Email = b.Cust_Email
JOIN 
    "Basket Details" bdt ON b.Basket_Number = bdt.Basket_Number
JOIN 
    Product p ON bdt.Prod_Number = p.Prod_Number
LEFT JOIN 
    Payment_Method pm ON c.Cust_Email = pm.Cust_Email
LEFT JOIN 
    Gift_Card gc ON pm.Payment_ID = gc.Payment_ID
WHERE 
    bdt.Quantity > 0
ORDER BY 
    c.Cust_Email;

-- Question 5.2: Revised to include a list of products in the basket.
SELECT 
    c.Cust_Email AS Customer_Email,
    c.Cust_Name AS Customer_Name,
    c.Cust_Birthdate AS Customer_Birthday,
    gc.Current_Balance AS Gift_Card_Balance,
    GROUP_CONCAT(p.Prod_Name) AS Products_In_Basket
FROM 
    Customer c
JOIN 
    Basket b ON c.Cust_Email = b.Cust_Email
JOIN 
    "Basket Details" bd ON b.Basket_Number = bd.Basket_Number
JOIN 
    Product p ON bd.Prod_Number = p.Prod_Number
LEFT JOIN 
    Gift_Card gc ON gc.Payment_ID IN (
        SELECT Payment_ID
        FROM Payment_Method
        WHERE Cust_Email = c.Cust_Email
    )
GROUP BY 
    c.Cust_Email, c.Cust_Name, c.Cust_Birthdate, gc.Current_Balance
ORDER BY 
    c.Cust_Email;

-- Question 5.3
WITH CategorySales AS (
    SELECT 
        p.Category_ID,
        cat.Category_Name,
        p.Prod_Number,
        p.Prod_Name,
        SUM(od.Quantity * od.Price_At_Purchase) AS Total_Sales
    FROM 
        Product p
    JOIN 
        Order_Details od ON p.Prod_Number = od.Prod_Number
    JOIN 
        Category cat ON p.Category_ID = cat.Category_ID
    GROUP BY 
        p.Category_ID, p.Prod_Number, p.Prod_Name, cat.Category_Name
),
RankedSales AS (
    SELECT 
        Category_ID,
        Category_Name,
        Prod_Number,
        Prod_Name,
        Total_Sales,
        RANK() OVER (PARTITION BY Category_ID ORDER BY Total_Sales DESC) AS Rank
    FROM 
        CategorySales
)
SELECT 
    Category_ID,
    Category_Name,
    Prod_Number,
    Prod_Name,
    Total_Sales
FROM 
    RankedSales
WHERE 
    Rank <= 2
ORDER BY 
    Category_ID, Rank;

-- Question 5.4
WITH MonthlySales AS (
    SELECT 
        strftime('%Y', o.Order_Date) AS Year,
        strftime('%m', o.Order_Date) AS Month,
        SUM(o.Order_GrandTotal) - IFNULL(SUM(r.Return_Amount), 0) AS Net_Sales
    FROM 
        Customer_Order o
    LEFT JOIN 
        Return r ON o.Order_Number = r.Order_Number AND r.Return_Status = 'completed'
    GROUP BY 
        strftime('%Y', o.Order_Date), strftime('%m', o.Order_Date)
    ORDER BY 
        Year, Month
),
SalesGrowth AS (
    SELECT 
        Year,
        Month,
        Net_Sales,
        LAG(Net_Sales) OVER (ORDER BY Year, Month) AS Previous_Month_Sales,
        CASE 
            WHEN LAG(Net_Sales) OVER (ORDER BY Year, Month) IS NOT NULL 
            THEN ROUND((Net_Sales - LAG(Net_Sales) OVER (ORDER BY Year, Month)) / LAG(Net_Sales) OVER (ORDER BY Year, Month) * 100, 2)
            ELSE NULL
        END AS Sales_Growth_Percentage
    FROM 
        MonthlySales
)
SELECT 
    Year,
    Month,
    Net_Sales,
    Sales_Growth_Percentage
FROM 
    SalesGrowth
ORDER BY 
    Year, Month;






	