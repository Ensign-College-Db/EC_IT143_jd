/*******************************************************************************
** Script Name : EC_IT143_W4.2_hello_world_s7_vck.sql
** Author      : V.C.K.
** Created     : 2025-01-01
** Database    : EC_IT143_DA
** Description : W4.2 Hello World — Step 7: Create stored procedure usp_load_person_row_count
**
** The Question (from Step 1)
** --------------------------
** How many rows are in the Person.Person table?
**
** What this stored procedure does
** --------------------------------
** Encapsulates the TRUNCATE + INSERT load logic from Step 6 into a named,
** reusable, database-resident object.
**
** Naming convention
** -----------------
** usp_  prefix → user stored procedure (distinguishes from system procs)
** load_ → indicates this procedure performs a data load operation
** person_row_count → the target table this procedure loads
**
** Why a stored procedure instead of just running the Step 6 script?
**   1. The procedure lives inside EC_IT143_DA — backed up with the database.
**   2. It can be called by a single EXEC statement from any ETL process.
**   3. It encapsulates the logic — the caller does not need to know the
**      names of the view or table, only the procedure name.
**   4. Permissions can be granted on the procedure without exposing the
**      underlying tables directly.
**
** Parameters : None
** Returns    : Row count confirmation message via PRINT
**
** Revision History
** ----------------
** 2025-01-01  vck  Initial creation
*******************************************************************************/

USE EC_IT143_DA;
GO

-- Drop the procedure if it already exists so this script is re-runnable
IF OBJECT_ID('dbo.usp_load_person_row_count', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_load_person_row_count;
GO

CREATE PROCEDURE dbo.usp_load_person_row_count
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Clear the target table
    TRUNCATE TABLE dbo.tbl_person_row_count;

    -- Step 2: Load fresh data from the view
    INSERT INTO dbo.tbl_person_row_count
    (
        person_row_count
        -- snapshot_date populated automatically by its DEFAULT constraint
    )
    SELECT person_row_count
    FROM   dbo.vw_person_row_count;

    -- Step 3: Confirm the load completed
    PRINT 'usp_load_person_row_count: load complete — '
        + CAST(@@ROWCOUNT AS VARCHAR(10))
        + ' row(s) inserted.';

END;
GO
