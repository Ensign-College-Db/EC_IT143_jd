/*
 * Script   : EC_IT143_6.3_fwf_s5_vb.sql   (Triggers section – Step 5)
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Triggers
 * Step     : 5 – Test results to see if they are as expected
 * Date     : 2026-04-09
 * Desc     : Fire a controlled UPDATE and verify that both [ModifiedDate]
 *            and [ModifiedBy] are populated correctly by the triggers.
 */

-- ── 1. Capture the BEFORE state ──────────────────────────────────────────────
SELECT
    CustomerID,
    ContactName,
    ModifiedDate   AS ModifiedDate_Before,
    ModifiedBy     AS ModifiedBy_Before
FROM [dbo].[t_w3_schools_customers]
WHERE CustomerID = 1;

-- ── 2. Perform a test UPDATE (change nothing meaningful – just touch the row) ─
UPDATE [dbo].[t_w3_schools_customers]
SET    ContactName = ContactName   -- no real change; triggers still fire
WHERE  CustomerID = 1;

-- ── 3. Capture the AFTER state ───────────────────────────────────────────────
SELECT
    CustomerID,
    ContactName,
    ModifiedDate   AS ModifiedDate_After,   -- should now be populated
    ModifiedBy     AS ModifiedBy_After      -- should now be populated
FROM [dbo].[t_w3_schools_customers]
WHERE CustomerID = 1;

/*
 * Expected outcome:
 *   ModifiedDate_After  → current datetime (not NULL)
 *   ModifiedBy_After    → your SQL Server login name (not NULL)
 *
 * If both columns are populated the triggers are working as designed.
 */
PRINT 'Test complete. ModifiedDate and ModifiedBy should both be populated above.';
