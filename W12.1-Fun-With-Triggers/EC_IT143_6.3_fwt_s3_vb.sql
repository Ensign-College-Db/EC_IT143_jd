/*
 * Script   : EC_IT143_6.3_fwt_s3_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Triggers
 * Step     : 3 – Research and test a solution
 * Date     : 2026-04-09
 * Desc     : Research confirmed the approach.  Add the audit columns to the
 *            table, then verify the structure before writing the trigger.
 *
 * Resources used:
 *   1. https://www.w3schools.com/sql/sql_ref_after_update.asp
 *   2. https://docs.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql
 *   3. https://stackoverflow.com/questions/9556474/how-do-i-automatically-update-a-datetime-field-in-sql-server-on-insert-and-upda
 */

-- ── Add audit columns if they do not already exist ───────────────────────────

IF COL_LENGTH('[dbo].[t_w3_schools_customers]', 'ModifiedDate') IS NULL
BEGIN
    ALTER TABLE [dbo].[t_w3_schools_customers]
        ADD [ModifiedDate] DATETIME NULL;
    PRINT 'Column [ModifiedDate] added.';
END
ELSE
    PRINT 'Column [ModifiedDate] already exists – skipping ALTER.';

IF COL_LENGTH('[dbo].[t_w3_schools_customers]', 'ModifiedBy') IS NULL
BEGIN
    ALTER TABLE [dbo].[t_w3_schools_customers]
        ADD [ModifiedBy] NVARCHAR(128) NULL;
    PRINT 'Column [ModifiedBy] added.';
END
ELSE
    PRINT 'Column [ModifiedBy] already exists – skipping ALTER.';

-- ── Verify the new structure ─────────────────────────────────────────────────
SELECT TOP 5
    CustomerID,
    ContactName,
    ModifiedDate,
    ModifiedBy
FROM [dbo].[t_w3_schools_customers];
