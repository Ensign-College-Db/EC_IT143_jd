-- ============================================================
-- Script Name : W6.4_performance_analysis.sql
-- Author      : Christopher JEROME 
-- Course      : EC IT143 – Introduction to Databases
-- Purpose     : Deliverable W6.4 – Execution Plans, Missing Index
--               Recommendations, and Index Creation
-- Database    : AdventureWorksLT (or AdventureWorks2019)
-- Instructions: Run each section one at a time.
--               Enable "Include Actual Execution Plan" (Ctrl+M)
--               before executing each query to see execution plans
--               and missing index recommendations.
-- ============================================================


-- ============================================================
-- QUERY 1 – SalesOrderHeader filtered on an unindexed char field
-- Table   : SalesLT.SalesOrderHeader
-- Filter  : ShipMethod (varchar, not indexed by default)
-- ============================================================

-- STEP 1 & 2: Run the query WITH the Actual Execution Plan enabled.
-- Note the Estimated Subtree Cost and any missing index recommendation
-- shown as a green bar at the top of the execution plan.

SELECT
    SalesOrderID,
    OrderDate,
    DueDate,
    ShipDate,
    Status,
    ShipMethod,
    SubTotal,
    TaxAmt,
    Freight,
    TotalDue
FROM SalesLT.SalesOrderHeader
WHERE ShipMethod = 'CARGO TRANSPORT 5';

-- STEP 5 – Record the Estimated Subtree Cost BEFORE adding the index.
-- (Hover over the SELECT node in the execution plan to read it.)

-- STEP 6 & 7 – Use the missing index recommendation (right-click the
-- green bar → Missing Index Details) or create the index manually below.
-- Give the index a clear, descriptive name before executing.

CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_ShipMethod
ON SalesLT.SalesOrderHeader (ShipMethod)
INCLUDE (SalesOrderID, OrderDate, DueDate, ShipDate,
         Status, SubTotal, TaxAmt, Freight, TotalDue);

-- STEP 8 – Re-run the original query to observe the new Estimated
-- Subtree Cost and confirm the index is now being used (Index Seek
-- instead of Table Scan / Clustered Index Scan).

SELECT
    SalesOrderID,
    OrderDate,
    DueDate,
    ShipDate,
    Status,
    ShipMethod,
    SubTotal,
    TaxAmt,
    Freight,
    TotalDue
FROM SalesLT.SalesOrderHeader
WHERE ShipMethod = 'CARGO TRANSPORT 5';

-- Expected result: lower Estimated Subtree Cost and an Index Seek
-- operator visible in the execution plan.


-- ============================================================
-- QUERY 2 – Customer filtered on an unindexed char field
-- Table   : SalesLT.Customer
-- Filter  : CompanyName (nvarchar, not indexed by default)
-- ============================================================

-- STEP 1 & 2: Run the query WITH the Actual Execution Plan enabled.

SELECT
    CustomerID,
    FirstName,
    LastName,
    CompanyName,
    EmailAddress,
    Phone,
    ModifiedDate
FROM SalesLT.Customer
WHERE CompanyName = 'Riding Cycles';

-- STEP 5 – Record the Estimated Subtree Cost BEFORE adding the index.

-- STEP 6 & 7 – Create the recommended index.

CREATE NONCLUSTERED INDEX IX_Customer_CompanyName
ON SalesLT.Customer (CompanyName)
INCLUDE (CustomerID, FirstName, LastName,
         EmailAddress, Phone, ModifiedDate);

-- STEP 8 – Re-run the query to confirm performance improvement.

SELECT
    CustomerID,
    FirstName,
    LastName,
    CompanyName,
    EmailAddress,
    Phone,
    ModifiedDate
FROM SalesLT.Customer
WHERE CompanyName = 'Riding Cycles';

-- Expected result: lower Estimated Subtree Cost and Index Seek
-- replacing the previous Clustered Index Scan.


-- ============================================================
-- CLEANUP (optional – run only if you want to reset the demo)
-- ============================================================

-- DROP INDEX IF EXISTS IX_SalesOrderHeader_ShipMethod
--     ON SalesLT.SalesOrderHeader;

-- DROP INDEX IF EXISTS IX_Customer_CompanyName
--     ON SalesLT.Customer;

-- ============================================================
-- END OF SCRIPT
-- ============================================================
