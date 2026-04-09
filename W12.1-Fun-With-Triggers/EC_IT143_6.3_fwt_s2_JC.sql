/*
 * Script   : EC_IT143_6.3_fwt_s2_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Triggers
 * Step     : 2 – Begin creating an answer
 * Date     : 2026-04-09
 * Desc     : Document current knowledge and the next logical step toward
 *            answering the question posed in Step 1.
 *
 * Where I am now:
 *   - I know that a DEFAULT constraint populates a column only on INSERT.
 *   - I know T-SQL supports AFTER triggers that fire after DML operations.
 *   - An AFTER UPDATE trigger can execute code immediately after any UPDATE.
 *   - GETDATE() returns the current server date and time.
 *
 * Next logical step:
 *   1. Add a [ModifiedDate] column (DATETIME, nullable) to the customers table.
 *   2. Create an AFTER UPDATE trigger that sets [ModifiedDate] = GETDATE()
 *      for every row that was just updated.
 *
 * Revised question:
 *   How do I write an AFTER UPDATE trigger that sets a datetime column
 *   to the current timestamp for every row touched by an UPDATE statement?
 */

-- Preview the current table structure before we add any columns.
SELECT TOP 5 * FROM [dbo].[t_w3_schools_customers];
EXEC sp_help '[dbo].[t_w3_schools_customers]';
