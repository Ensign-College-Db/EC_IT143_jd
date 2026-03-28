/*******************************************************************************
** Script Name : EC_IT143_W4.2_hello_world_s5.1_vck.sql
** Author      : V.C.K.
** Created     : 2025-01-01
** Database    : EC_IT143_DA
** Description : W4.2 Hello World — Step 5.1: Create table from view (SELECT INTO)
**
** The Question (from Step 1)
** --------------------------
** How many rows are in the Person.Person table?
**
** What this script does
** ---------------------
** Uses SELECT ... INTO to create a physical table from the view created
** in Step 4.  This is the fastest first pass — SQL Server infers column
** names and data types directly from the view.
**
** Naming convention
** -----------------
** Source view : vw_person_row_count   (vw_ prefix)
** Target table: tbl_person_row_count  (tbl_ prefix, same root name)
** The symmetry makes the data lineage obvious at a glance.
**
** Note
** ----
** SELECT INTO creates the table AND loads it in one statement.
** Step 5.2 will refine the table definition (PK, constraints, data types).
** Step 6 will handle all future loads with TRUNCATE + INSERT.
**
** Revision History
** ----------------
** 2025-01-01  vck  Initial creation
*******************************************************************************/

USE EC_IT143_DA;
GO

-- Drop the table if it exists so this script is re-runnable
IF OBJECT_ID('dbo.tbl_person_row_count', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_person_row_count;
GO

-- Create and load the table from the view in one step
SELECT *
INTO   dbo.tbl_person_row_count
FROM   dbo.vw_person_row_count;
GO

-- Verify the result
SELECT *
FROM   dbo.tbl_person_row_count;
