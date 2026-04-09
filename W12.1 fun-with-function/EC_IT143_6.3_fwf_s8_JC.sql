/*
 * Script   : EC_IT143_6.3_fwf_s8_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Functions
 * Step     : 8 – Ask the next question (restart the process for LAST NAME)
 * Date     : 2026-04-09
 * Desc     : Now that we can extract the first name, the natural next
 *            question is: How do I extract the LAST NAME?
 *            This script restarts the 8-step process for the last name.
 *
 * ── STEP 1  (new question) ───────────────────────────────────────────────────
 * Question : How do I extract the LAST NAME from the ContactName column?
 *
 * ── STEP 2  (begin answer) ───────────────────────────────────────────────────
 * Where I am: I know the space separates first and last name.
 * Next step : Use CHARINDEX to find the space, then use SUBSTRING to grab
 *             everything AFTER the space to the end of the string.
 * Formula   : SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))
 *
 * ── STEP 3  (ad hoc query) ───────────────────────────────────────────────────
 */
SELECT
    CustomerID,
    ContactName,
    SUBSTRING(
        ContactName,
        CHARINDEX(' ', ContactName) + 1,    -- start one char after the space
        LEN(ContactName)                    -- take everything to the end
    )                                       AS LastName_AdHoc
FROM [dbo].[t_w3_schools_customers]
ORDER BY CustomerID;

/*
 * ── STEP 4  (research) ───────────────────────────────────────────────────────
 * Resources:
 *   https://www.w3schools.com/sql/func_sqlserver_substring.asp
 *   https://stackoverflow.com/questions/1565988/getting-first-and-last-name-from-a-full-name-in-sql
 *
 * ── STEP 5  (create UDF) ─────────────────────────────────────────────────────
 */
IF OBJECT_ID('[dbo].[fn_GetLastName]', 'FN') IS NOT NULL
    DROP FUNCTION [dbo].[fn_GetLastName];
GO

CREATE FUNCTION [dbo].[fn_GetLastName]
(
    -- Input: full name stored as "FirstName LastName"
    @FullName NVARCHAR(100)
)
RETURNS NVARCHAR(50)
AS
BEGIN
    /*
     * Find the position of the first space.
     * Everything AFTER that position is the last name.
     * If no space exists, return NULL (no last name can be determined).
     */
    DECLARE @SpacePos INT;
    SET @SpacePos = CHARINDEX(' ', @FullName);

    RETURN
        CASE
            WHEN @SpacePos = 0 THEN NULL   -- Cannot determine last name
            ELSE SUBSTRING(@FullName, @SpacePos + 1, LEN(@FullName))
        END;
END;
GO

PRINT 'Function [dbo].[fn_GetLastName] created successfully.';

/*
 * ── STEP 6  (compare UDF vs ad hoc) ─────────────────────────────────────────
 */
SELECT
    CustomerID,
    ContactName,
    SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))  AS LastName_AdHoc,
    [dbo].[fn_GetLastName](ContactName)                                         AS LastName_UDF
FROM [dbo].[t_w3_schools_customers]
ORDER BY CustomerID;

/*
 * ── STEP 7  (0 results expected test) ───────────────────────────────────────
 */
WITH cte_LastName AS
(
    SELECT
        CustomerID,
        SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName))  AS LastName_AdHoc,
        [dbo].[fn_GetLastName](ContactName)                                         AS LastName_UDF
    FROM [dbo].[t_w3_schools_customers]
)
SELECT *
FROM cte_LastName
WHERE LastName_AdHoc <> LastName_UDF
   OR (LastName_AdHoc IS NULL AND LastName_UDF IS NOT NULL)
   OR (LastName_AdHoc IS NOT NULL AND LastName_UDF IS NULL);

PRINT '0 rows expected for last-name test. Any rows above indicate a bug.';

/*
 * ── STEP 8  (next question) ──────────────────────────────────────────────────
 * Question: Could I combine both UDFs to display a formatted "Last, First"
 *           name from a single ContactName column?
 * → That exploration leads naturally into the Triggers section.
 */
