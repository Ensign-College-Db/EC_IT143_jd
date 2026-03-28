/*******************************************************************************
** Script Name : EC_IT143_W4.2_hello_world_s5.2_vck.sql
** Author      : V.C.K.
** Created     : 2025-01-01
** Database    : EC_IT143_DA
** Description : W4.2 Hello World — Step 5.2: Refined table definition
**
** The Question (from Step 1)
** --------------------------
** How many rows are in the Person.Person table?
**
** What this script does
** ---------------------
** Drops and re-creates tbl_person_row_count with a proper architecture:
**   - Explicit data types (INT for the count, not an inferred type)
**   - A surrogate primary key (row_count_id) using IDENTITY
**   - A NOT NULL constraint on person_row_count
**   - A snapshot_date column to record when the count was taken
**   - A default value of GETDATE() on snapshot_date
**
** Why add snapshot_date?
**   A table that stores one static number has limited value.
**   Adding a timestamp turns it into a history table — every TRUNCATE +
**   INSERT run in Step 6/7 captures the count at a point in time.
**   This makes the table useful for trend analysis later.
**
** Revision History
** ----------------
** 2025-01-01  vck  Initial creation
*******************************************************************************/

USE EC_IT143_DA;
GO

-- Drop and re-create with refined architecture
IF OBJECT_ID('dbo.tbl_person_row_count', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_person_row_count;
GO

CREATE TABLE dbo.tbl_person_row_count
(
    row_count_id      INT           NOT NULL  IDENTITY(1, 1),
    person_row_count  INT           NOT NULL,
    snapshot_date     DATETIME      NOT NULL  CONSTRAINT df_person_row_count_snapshot_date DEFAULT GETDATE(),

    CONSTRAINT pk_person_row_count PRIMARY KEY (row_count_id)
);
GO

-- Verify the empty table structure
SELECT *
FROM   dbo.tbl_person_row_count;
