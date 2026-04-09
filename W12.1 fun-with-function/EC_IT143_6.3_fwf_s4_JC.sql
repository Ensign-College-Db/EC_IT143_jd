/*
 * Script   : EC_IT143_6.3_fwf_s4_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Functions
 * Step     : 4 – Research and test a solution
 * Date     : 2026-04-09
 * Desc     : Research confirmed the approach.  Test with edge cases
 *            (names with no space, NULL values) before building the UDF.
 *
 * Resources used:
 *   1. https://www.w3schools.com/sql/func_sqlserver_charindex.asp
 *   2. https://stackoverflow.com/questions/1565988/getting-first-and-last-name-from-a-full-name-in-sql
 */

-- ── Test 1: Standard case – confirm first name extraction ────────────────────
SELECT
    CustomerID,
    ContactName,
    LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)  AS FirstName
FROM [dbo].[t_w3_schools_customers]
ORDER BY CustomerID;

-- ── Test 2: Edge case – what happens when there is NO space? ─────────────────
--   CHARINDEX returns 0 → LEFT(..., -1) throws an error.
--   Guard with NULLIF to return NULL instead of crashing.
SELECT
    CustomerID,
    ContactName,
    CASE
        WHEN CHARINDEX(' ', ContactName) = 0 THEN ContactName   -- no space: treat whole value as first name
        ELSE LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
    END AS FirstName_Safe
FROM [dbo].[t_w3_schools_customers]
ORDER BY CustomerID;

-- ── Test 3: Spot-check a literal value ───────────────────────────────────────
SELECT
    LEFT('Maria Anders', CHARINDEX(' ', 'Maria Anders') - 1)  AS Expected_Maria;
