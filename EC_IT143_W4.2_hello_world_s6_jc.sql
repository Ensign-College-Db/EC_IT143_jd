/*******************************************************************************
** Script Name : EC_IT143_W4.2_hello_world_s6_vck.sql
** Author      : V.C.K.
** Created     : 2025-01-01
** Database    : EC_IT143_DA
** Description : W4.2 Hello World — Step 6: Ad hoc load script
**
** The Question (from Step 1)
** --------------------------
** How many rows are in the Person.Person table?
**
** What this script does
** ---------------------
** Loads tbl_person_row_count from vw_person_row_count using the
** TRUNCATE + INSERT pattern.
**
** Why TRUNCATE + INSERT (not just INSERT)?
**   TRUNCATE removes all existing rows before the new INSERT.
**   This guarantees the table always reflects a fresh, clean load.
**   It is faster than DELETE and resets the IDENTITY seed.
**
** Why not SELECT INTO here?
**   SELECT INTO creates the table.  Step 5 already did that.
**   This script only loads data into the existing table.
**
** Name symmetry
** -------------
**   Source view : vw_person_row_count
**   Target table: tbl_person_row_count
**   Same root name — the lineage is immediately obvious.
**
** Revision History
** ----------------
** 2025-01-01  vck  Initial creation
*******************************************************************************/

USE EC_IT143_DA;
GO

-- Step 1 of the load: clear the table
TRUNCATE TABLE dbo.tbl_person_row_count;

-- Step 2 of the load: insert fresh data from the view
INSERT INTO dbo.tbl_person_row_count
(
    person_row_count
    -- snapshot_date is populated automatically by its DEFAULT constraint
)
SELECT person_row_count
FROM   dbo.vw_person_row_count;

-- Verify the load
SELECT *
FROM   dbo.tbl_person_row_count;
