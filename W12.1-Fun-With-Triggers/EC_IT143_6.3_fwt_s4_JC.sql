/*
 * Script   : EC_IT143_6.3_fwt_s4_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Triggers
 * Step     : 4 – Create AFTER UPDATE triggers
 * Date     : 2026-04-09
 * Desc     : Two triggers on [dbo].[t_w3_schools_customers]:
 *
 *              1. [trg_Customers_SetModifiedDate]
 *                 Sets [ModifiedDate] = GETDATE() for every updated row.
 *
 *              2. [trg_Customers_SetModifiedBy]
 *                 Sets [ModifiedBy] = SYSTEM_USER for every updated row.
 *
 *            Both triggers use the virtual INSERTED table (which holds the
 *            post-update version of the affected rows) to join back to the
 *            base table and apply the correct values.
 *
 *            Note: A DEFAULT constraint only fires on INSERT.  A trigger is
 *            required to capture the timestamp/user on every UPDATE.
 */

-- ════════════════════════════════════════════════════════════════════════════
-- Trigger 1: Record the date/time of the last modification
-- ════════════════════════════════════════════════════════════════════════════
IF OBJECT_ID('[dbo].[trg_Customers_SetModifiedDate]', 'TR') IS NOT NULL
    DROP TRIGGER [dbo].[trg_Customers_SetModifiedDate];
GO

CREATE TRIGGER [dbo].[trg_Customers_SetModifiedDate]
ON [dbo].[t_w3_schools_customers]
AFTER UPDATE                          -- fires once per UPDATE statement
AS
BEGIN
    SET NOCOUNT ON;   -- suppress "n rows affected" messages

    /*
     * Join the base table back to the INSERTED pseudo-table (which contains
     * the new versions of the updated rows) and stamp ModifiedDate with
     * the current server timestamp.
     */
    UPDATE c
    SET    c.[ModifiedDate] = GETDATE()
    FROM   [dbo].[t_w3_schools_customers] AS c
    INNER JOIN INSERTED AS i ON c.[CustomerID] = i.[CustomerID];
END;
GO

PRINT 'Trigger [trg_Customers_SetModifiedDate] created successfully.';


-- ════════════════════════════════════════════════════════════════════════════
-- Trigger 2: Record WHO last modified the row
-- ════════════════════════════════════════════════════════════════════════════
IF OBJECT_ID('[dbo].[trg_Customers_SetModifiedBy]', 'TR') IS NOT NULL
    DROP TRIGGER [dbo].[trg_Customers_SetModifiedBy];
GO

CREATE TRIGGER [dbo].[trg_Customers_SetModifiedBy]
ON [dbo].[t_w3_schools_customers]
AFTER UPDATE                          -- fires once per UPDATE statement
AS
BEGIN
    SET NOCOUNT ON;

    /*
     * SYSTEM_USER returns the SQL Server login name of the session that
     * issued the UPDATE statement – exactly who we want to track.
     */
    UPDATE c
    SET    c.[ModifiedBy] = SYSTEM_USER
    FROM   [dbo].[t_w3_schools_customers] AS c
    INNER JOIN INSERTED AS i ON c.[CustomerID] = i.[CustomerID];
END;
GO

PRINT 'Trigger [trg_Customers_SetModifiedBy] created successfully.';
