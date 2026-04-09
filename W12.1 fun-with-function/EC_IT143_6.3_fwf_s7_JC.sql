/*
 * Script   : EC_IT143_6.3_fwf_s7_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Functions
 * Step     : 7 – Perform a "0 results expected" test
 * Date     : 2026-04-09
 * Desc     : Use a Common Table Expression (CTE) to compare the UDF output
 *            against the ad hoc logic.  If the function is working correctly
 *            this query should return ZERO rows.  Any row returned indicates
 *            a discrepancy that needs investigation.
 *
 * Reference: https://docs.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql
 */

WITH cte_Comparison AS
(
    SELECT
        CustomerID,
        ContactName,

        -- Ad hoc first-name logic
        CASE
            WHEN CHARINDEX(' ', ContactName) = 0 THEN ContactName
            ELSE LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
        END                                     AS FirstName_AdHoc,

        -- UDF first-name result
        [dbo].[fn_GetFirstName](ContactName)    AS FirstName_UDF

    FROM [dbo].[t_w3_schools_customers]
)
SELECT
    CustomerID,
    ContactName,
    FirstName_AdHoc,
    FirstName_UDF
FROM cte_Comparison
WHERE FirstName_AdHoc <> FirstName_UDF   -- Only show rows where they DIFFER
   OR (FirstName_AdHoc IS NULL AND FirstName_UDF IS NOT NULL)
   OR (FirstName_AdHoc IS NOT NULL AND FirstName_UDF IS NULL);

-- ── Expected outcome: 0 rows returned ───────────────────────────────────────
PRINT '0 rows expected. Any rows above indicate a bug in fn_GetFirstName.';
