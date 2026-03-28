/*******************************************************************************
** Script Name : EC_IT143_W4.2_hello_world_s3_vck.sql
** Author      : V.C.K.
** Created     : 2025-01-01
** Database    : EC_IT143_DA
** Description : W4.2 Hello World — Step 3: Ad hoc SQL query
**
** The Question (from Step 1)
** --------------------------
** How many rows are in the Person.Person table?
**
** Sub-answer 1 (this script)
** --------------------------
** Write an ad hoc SELECT COUNT(*) to confirm the table is accessible
** and to see the raw result before formalizing it into a view.
**
** This is a one-off exploratory script.
** It is NOT saved inside the database — it lives only in this .sql file.
**
** Notes on the data
** -----------------
** Person.Person is part of the AdventureWorks schema loaded into EC_IT143_DA.
** Each row represents one person (employee, customer, or contact).
** BusinessEntityID is the primary key.
**
** Revision History
** ----------------
** 2025-01-01  vck  Initial creation
*******************************************************************************/

USE EC_IT143_DA;
GO

-- Ad hoc query: count all rows in Person.Person
SELECT COUNT(*) AS person_row_count
FROM   Person.Person;
