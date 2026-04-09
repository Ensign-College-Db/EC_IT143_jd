/*
 * Script   : EC_IT143_6.3_fwf_s3_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Functions
 * Step     : 3 – Create an ad hoc SQL query
 * Date     : 2026-04-09
 * Desc     : Write a quick, inline query (no function yet) that extracts
 *            the first name from ContactName using CHARINDEX and LEFT.
 *            This proves the logic works before we wrap it in a UDF.
 */

-- Ad hoc query: extract first name inline
SELECT
    CustomerID,
    ContactName,
    -- Position of the first space
    CHARINDEX(' ', ContactName)                                   AS SpacePosition,
    -- Everything to the LEFT of that space = first name
    LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)           AS FirstName
FROM [dbo].[t_w3_schools_customers]
ORDER BY CustomerID;
