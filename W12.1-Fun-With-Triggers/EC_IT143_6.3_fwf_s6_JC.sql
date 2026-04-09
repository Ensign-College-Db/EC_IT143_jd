/*
 * Script   : EC_IT143_6.3_fwf_s6_vb.sql   (Triggers section – Step 6)
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Triggers
 * Step     : 6 – Ask the next question
 * Date     : 2026-04-09
 * Desc     : Reflect on what was learned and identify the next interesting
 *            question to explore.
 *
 * ── What I learned ───────────────────────────────────────────────────────────
 *   - A DEFAULT constraint only populates a column at INSERT time.
 *   - An AFTER UPDATE trigger is required to capture changes at UPDATE time.
 *   - GETDATE() captures the server timestamp; SYSTEM_USER captures the login.
 *   - The INSERTED pseudo-table inside a trigger holds the post-update rows.
 *
 * ── Next question ────────────────────────────────────────────────────────────
 * Question : How do I set [ModifiedBy] to the APPLICATION user
 *            (not the SQL Server login) when an app connects via a service
 *            account?
 *
 * Approach : Use SESSION_CONTEXT or APP_NAME() to pass the application-layer
 *            user into the trigger context.
 *
 * Example  : CAST(SESSION_CONTEXT(N'AppUser') AS NVARCHAR(128))
 *
 * Resources:
 *   https://docs.microsoft.com/en-us/sql/t-sql/functions/session-context-transact-sql
 *   https://docs.microsoft.com/en-us/sql/t-sql/functions/system-user-transact-sql
 */

-- Quick demonstration of what SYSTEM_USER and SESSION_CONTEXT return today.
SELECT
    SYSTEM_USER                                              AS SQLLogin,
    CURRENT_USER                                             AS DatabaseUser,
    APP_NAME()                                               AS ApplicationName,
    CAST(SESSION_CONTEXT(N'AppUser') AS NVARCHAR(128))       AS AppUser_Context;

PRINT 'Step 6 complete – next question documented. Ready for the next iteration.';
