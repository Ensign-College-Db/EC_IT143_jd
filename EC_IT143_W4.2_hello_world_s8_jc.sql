/*******************************************************************************
** Script Name : EC_IT143_W4.2_hello_world_s8_vck.sql
** Author      : V.C.K.
** Created     : 2025-01-01
** Database    : EC_IT143_DA
** Description : W4.2 Hello World — Step 8: Execute the stored procedure
**
** The Question (from Step 1)
** --------------------------
** How many rows are in the Person.Person table?
**
** What this script does
** ---------------------
** Calls usp_load_person_row_count with a single EXEC statement,
** then queries the result table to confirm the answer.
**
** This is the entire ETL pipeline in two lines:
**   Line 1 — run the procedure (TRUNCATE + INSERT happens inside)
**   Line 2 — read the result
**
** Why this matters
** ----------------
** Any external ETL scheduler (SQL Agent, SSIS, Azure Data Factory, etc.)
** only needs to know this one procedure name to run the full pipeline.
** The implementation details are hidden inside the procedure — this script
** is as simple as the answer-focused method can produce.
**
** Full pipeline recap (Steps 3 → 8)
** -----------------------------------
**   vw_person_row_count         (Step 4) — reusable query, lives in DB
**       ↓
**   tbl_person_row_count        (Step 5) — physical result table, lives in DB
**       ↑ loaded by
**   usp_load_person_row_count   (Step 7) — stored procedure, lives in DB
**       ↑ called by
**   EXEC (this script)          (Step 8) — one line, triggers everything
**
** Revision History
** ----------------
** 2025-01-01  vck  Initial creation
*******************************************************************************/

USE EC_IT143_DA;
GO

-- Execute the stored procedure — this runs the full TRUNCATE + INSERT pipeline
EXEC dbo.usp_load_person_row_count;

-- Read the result to confirm the answer to the original question
SELECT *
FROM   dbo.tbl_person_row_count;
