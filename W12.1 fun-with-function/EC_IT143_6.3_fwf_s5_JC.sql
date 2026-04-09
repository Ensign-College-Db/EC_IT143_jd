/*
 * Script   : EC_IT143_6.3_fwf_s5_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Functions
 * Step     : 5 – Create a user-defined scalar function
 * Date     : 2026-04-09
 * Desc     : Wraps the tested first-name extraction logic into a reusable
 *            scalar UDF.  The function accepts a full name string and
 *            returns only the first name (text before the first space).
 *            If no space is found the entire input is returned as-is.
 *
 * Function : [dbo].[fn_GetFirstName]
 * Input    : @FullName NVARCHAR(100)
 * Returns  : NVARCHAR(50) – the first name portion of the full name
 */

-- Drop the function if it already exists so the script is re-runnable.
IF OBJECT_ID('[dbo].[fn_GetFirstName]', 'FN') IS NOT NULL
    DROP FUNCTION [dbo].[fn_GetFirstName];
GO

CREATE FUNCTION [dbo].[fn_GetFirstName]
(
    -- Input: full name stored as "FirstName LastName"
    @FullName NVARCHAR(100)
)
RETURNS NVARCHAR(50)
AS
BEGIN
    /*
     * Local variable to hold the position of the first space character.
     * CHARINDEX returns 0 when the character is not found.
     */
    DECLARE @SpacePos INT;
    SET @SpacePos = CHARINDEX(' ', @FullName);

    /*
     * If there is no space (SpacePos = 0) we treat the entire value as
     * the first name.  Otherwise we take everything to the LEFT of the space.
     */
    RETURN
        CASE
            WHEN @SpacePos = 0 THEN @FullName
            ELSE LEFT(@FullName, @SpacePos - 1)
        END;
END;
GO

PRINT 'Function [dbo].[fn_GetFirstName] created successfully.';
