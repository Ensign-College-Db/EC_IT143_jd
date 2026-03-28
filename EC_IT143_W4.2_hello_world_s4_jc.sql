/*******************************************************************************
** Script Name : EC_IT143_W4.2_hello_world_s4_vck.sql
** Author      : V.C.K.
** Created     : 2025-01-01
** Database    : EC_IT143_DA
** Description : W4.2 Hello World — Step 4: Create view vw_person_row_count
**
** The Question (from Step 1)
** --------------------------
** How many rows are in the Person.Person table?
**
** What this view does
** -------------------
** Wraps the ad hoc COUNT query from Step 3 into a named, reusable database
** object.  Unlike a .sql file, this view lives inside EC_IT143_DA and is
** backed up with the database.
**
** Naming convention
** -----------------
** vw_  prefix  → identifies this as a view
** person_row_count → describes exactly what the view returns
**
** Source table  : Person.Person   (AdventureWorks schema)
** Output column : person_row_count  INT — total row count
**
** Usage
** -----
**   SELECT * FROM vw_person_row_count;
**
** Downstream
** ----------
** Step 5 will use this view as the source for table tbl_person_row_count.
**
** Revision History
** ----------------
** 2025-01-01  vck  Initial creation
*******************************************************************************/

USE EC_IT143_DA;
GO

-- Drop the view if it already exists so this script is re-runnable
IF OBJECT_ID('dbo.vw_person_row_count', 'V') IS NOT NULL
    DROP VIEW dbo.vw_person_row_count;
GO

CREATE VIEW dbo.vw_person_row_count
AS
/*
    Returns a single row with the total number of persons
    in the Person.Person table.
*/
SELECT COUNT(*) AS person_row_count
FROM   Person.Person;
GO

-- Verify the view works immediately after creation
SELECT *
FROM   dbo.vw_person_row_count;
