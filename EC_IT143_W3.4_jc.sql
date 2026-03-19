/*
================================================
EC_IT143_W3.4_jc.sql

AdventureWorksLT — Question & Answer SQL Script
================================================
*/

USE AdventureWorksLT;
GO

-- ============================================================
-- CATEGORY 1: Business User — Marginal Complexity
-- ============================================================

/*
Q1 — How many customers in our database have registered
     an email address?
*/
SELECT COUNT(*) AS CustomersWithEmail
FROM SalesLT.Customer
WHERE EmailAddress IS NOT NULL;


/*
Q2 — What are the top five products by list price?
*/
SELECT TOP 5
    ProductID,
    Name,
    ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;


-- ============================================================
-- CATEGORY 2: Business User — Moderate Complexity
-- ============================================================

/*
Q3 — Which product categories generated the highest total
     sales revenue? Rank them from highest to lowest.
     Revenue defined as SalesOrderDetail.LineTotal.
*/
SELECT
    pc.Name                    AS CategoryName,
    SUM(od.LineTotal)          AS TotalRevenue
FROM SalesLT.SalesOrderDetail      od
JOIN SalesLT.Product               p  ON od.ProductID       = p.ProductID
JOIN SalesLT.ProductCategory       pc ON p.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
ORDER BY TotalRevenue DESC;


/*
Q4 — How many unique customers have placed at least one
     order, and which city has the highest concentration
     of those customers?
*/

-- Part A: unique customers who have placed an order
SELECT COUNT(DISTINCT o.CustomerID) AS CustomersWhoOrdered
FROM SalesLT.SalesOrderHeader o;

-- Part B: city with the most of those customers
SELECT TOP 1
    a.City,
    COUNT(DISTINCT o.CustomerID) AS CustomerCount
FROM SalesLT.SalesOrderHeader  o
JOIN SalesLT.CustomerAddress   ca ON o.CustomerID  = ca.CustomerID
JOIN SalesLT.Address           a  ON ca.AddressID  = a.AddressID
GROUP BY a.City
ORDER BY CustomerCount DESC;


-- ============================================================
-- CATEGORY 3: Business User — Increased Complexity
-- ============================================================

/*
Q5 — Which of our salespersons is driving the most revenue?
     Revenue = SUM of SubTotal per salesperson.
     Show total revenue, order count, and average order value
     so we can tell whether someone wins on volume or deal size.
     Ranked top 3.
*/
SELECT TOP 3
    SalesPerson,
    COUNT(SalesOrderID)            AS OrderCount,
    SUM(SubTotal)                  AS TotalRevenue,
    ROUND(AVG(SubTotal), 2)        AS AvgOrderValue
FROM SalesLT.SalesOrderHeader
WHERE SalesPerson IS NOT NULL
GROUP BY SalesPerson
ORDER BY TotalRevenue DESC;


/*
Q6 — Which single product generated the most revenue in
     each calendar quarter (Q1–Q4) across all years combined?
     Revenue = SUM of LineTotal from order detail records.
     Show quarter, product name, and total revenue.
*/
WITH QuarterlyRevenue AS (
    SELECT
        DATEPART(QUARTER, oh.OrderDate)  AS Quarter,
        p.Name                           AS ProductName,
        SUM(od.LineTotal)                AS TotalRevenue,
        RANK() OVER (
            PARTITION BY DATEPART(QUARTER, oh.OrderDate)
            ORDER BY SUM(od.LineTotal) DESC
        )                                AS RevenueRank
    FROM SalesLT.SalesOrderDetail    od
    JOIN SalesLT.SalesOrderHeader    oh ON od.SalesOrderID = oh.SalesOrderID
    JOIN SalesLT.Product             p  ON od.ProductID    = p.ProductID
    GROUP BY
        DATEPART(QUARTER, oh.OrderDate),
        p.Name
)
SELECT
    Quarter,
    ProductName,
    ROUND(TotalRevenue, 2) AS TotalRevenue
FROM QuarterlyRevenue
WHERE RevenueRank = 1
ORDER BY Quarter;


-- ============================================================
-- CATEGORY 4: Metadata — INFORMATION_SCHEMA Views
-- ============================================================

/*
Q7 — Which tables in AdventureWorksLT contain more than
     five columns? Show the table name and exact column count,
     sorted from most columns to fewest.
     Uses: INFORMATION_SCHEMA.COLUMNS
*/
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COUNT(COLUMN_NAME) AS ColumnCount
FROM INFORMATION_SCHEMA.COLUMNS
GROUP BY TABLE_SCHEMA, TABLE_NAME
HAVING COUNT(COLUMN_NAME) > 5
ORDER BY ColumnCount DESC;


/*
Q8 — Which tables in AdventureWorksLT have more than one
     constraint defined, and what types of constraints
     are those?
     Uses: INFORMATION_SCHEMA.TABLE_CONSTRAINTS
*/
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    CONSTRAINT_TYPE,
    COUNT(*) AS ConstraintCount
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
GROUP BY TABLE_SCHEMA, TABLE_NAME, CONSTRAINT_TYPE
HAVING COUNT(*) > 1
ORDER BY TABLE_NAME, CONSTRAINT_TYPE;