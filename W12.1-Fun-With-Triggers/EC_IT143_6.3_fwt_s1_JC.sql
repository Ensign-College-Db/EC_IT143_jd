/*
 * Script   : EC_IT143_6.3_fwt_s1_vb.sql
 * Author   : Vladimir B.
 * Course   : EC IT143 – Introduction to Databases
 * Week     : 12.1 – Fun with Triggers
 * Step     : 1 – Start with a question
 * Date     : 2026-04-09
 * Desc     : Define the simplest, most focused question to solve before
 *            writing any code.
 *
 * Question : How do I automatically record WHEN a row in
 *            [dbo].[t_w3_schools_customers] was last modified?
 *
 * Notes    : A DEFAULT constraint only fires on INSERT, not on UPDATE.
 *            Therefore, we need an AFTER UPDATE trigger to reliably capture
 *            the timestamp of every modification.
 */

PRINT 'Step 1 complete – question defined:';
PRINT 'How do I automatically record WHEN a customer row was last modified?';
