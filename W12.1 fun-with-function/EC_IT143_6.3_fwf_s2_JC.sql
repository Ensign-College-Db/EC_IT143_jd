/*
 * Script   : EC_IT143_6.3_fwf_s2_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Functions
 * Step     : 2 – Begin creating an answer
 * Date     : 2026-04-09
 * Desc     : Document current knowledge and the next logical step toward
 *            answering the question posed in Step 1.
 *
 * Where I am now:
 *   - I know that ContactName contains "FirstName LastName".
 *   - I know T-SQL has string functions (LEFT, CHARINDEX, SUBSTRING).
 *   - I know CHARINDEX returns the position of a character inside a string.
 *   - I know LEFT(string, n) returns the first n characters of a string.
 *
 * Next logical step:
 *   - Find the position of the space character with CHARINDEX(' ', ContactName).
 *   - Use LEFT() to grab everything BEFORE that position.
 *   - Formula: LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
 *
 * Simplified question (revised):
 *   What is the character position of the space in ContactName,
 *   and how do I use that position to isolate the first name?
 */

-- Preview the raw ContactName values to confirm the "FirstName LastName" pattern.
SELECT TOP 10
    CustomerID,
    ContactName
FROM [dbo].[t_w3_schools_customers]
ORDER BY CustomerID;
