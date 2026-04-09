/*
 * Script   : EC_IT143_6.3_fwf_s6_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Functions
 * Step     : 6 – Compare UDF results to ad hoc query results
 * Date     : 2026-04-09
 * Desc     : Display the ad hoc result and the UDF result side by side.
 *            Both columns should be identical for every row.
 */

SELECT
    CustomerID,
    ContactName,

    -- Ad hoc inline logic (Step 3 approach)
    CASE
        WHEN CHARINDEX(' ', ContactName) = 0 THEN ContactName
        ELSE LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
    END                                              AS FirstName_AdHoc,

    -- UDF result
    [dbo].[fn_GetFirstName](ContactName)             AS FirstName_UDF,

    -- Are they equal?  Should always be 'MATCH'
    CASE
        WHEN
            CASE
                WHEN CHARINDEX(' ', ContactName) = 0 THEN ContactName
                ELSE LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
            END
            = [dbo].[fn_GetFirstName](ContactName)
        THEN 'MATCH'
        ELSE '*** MISMATCH ***'
    END                                              AS ComparisonResult

FROM [dbo].[t_w3_schools_customers]
ORDER BY CustomerID;
