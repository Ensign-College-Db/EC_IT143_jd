/*
=============================================================================
  SCRIPT HEADER
=============================================================================
  File Name   : EC_IT143_W5.2_Simpsons_VJ.sql
  Author      : Vladimir J.
  Course      : EC IT143 – Introduction to Databases
  Assignment  : W5.2 – My Communities Data Sets Q&A Script
  Community   : The Simpsons
  Database    : Simpsons SQLite Database
  Description : This script contains four analytical questions and their
                corresponding SQL answers drawn from the Simpsons dataset.
                Tables used: actors, characters, catchphrases, quotes,
                episodes, seasons.
  Created     : 2026-04-01
=============================================================================

  TABLE SUMMARY
  -------------
  actors        – Voice actors (id, first_name, last_name, cast)
  characters    – Show characters linked to actors (id, name, actor_id)
  catchphrases  – Famous phrases linked to characters (id, phrase, character_id)
  quotes        – Episode quotes with date (id, quote, date, character_id, episode_id)
  episodes      – Episode list (id, number, title, season_id)
  seasons       – Season metadata with viewership (id, number, year_start,
                  year_end, average_viewers, most_watched_episode_id, etc.)

=============================================================================
*/


-- ===========================================================================
-- QUESTION 1
-- Author  : Vladimir J.
-- Question: Which voice actors voice more than one character, and how many
--           characters does each of them voice?
-- Purpose : Understand workload distribution across the main cast.
-- ===========================================================================

SELECT
    a.first_name || ' ' || a.last_name   AS actor_name,
    a.cast                               AS cast_type,
    COUNT(c.id)                          AS character_count
FROM       actors     AS a
INNER JOIN characters AS c
        ON c.actor_id = a.id
GROUP BY   a.id,
           a.first_name,
           a.last_name,
           a.cast
HAVING     COUNT(c.id) > 1
ORDER BY   character_count DESC,
           actor_name      ASC;

/*
EXPECTED RESULT (sample):
  actor_name            | cast_type | character_count
  ----------------------+-----------+----------------
  Dan Castellaneta      | Main      | 6
  Harry Shearer         | Main      | 6
  Hank Azaria           | Main      | 5
  ...
*/


-- ===========================================================================
-- QUESTION 2
-- Author  : Vladimir J.
-- Question: Which character has the most catchphrases in the database,
--           and what are those catchphrases?
-- Purpose : Identify the most "quotable" character in the Simpsons universe.
-- ===========================================================================

-- Step 2a: Find the character with the highest catchphrase count
WITH phrase_counts AS (
    SELECT
        c.id                   AS character_id,
        c.name                 AS character_name,
        COUNT(cp.id)           AS phrase_count
    FROM       characters   AS c
    INNER JOIN catchphrases AS cp
            ON cp.character_id = c.id
    GROUP BY   c.id,
               c.name
)
SELECT
    pc.character_name,
    pc.phrase_count,
    cp.phrase
FROM       phrase_counts  AS pc
INNER JOIN catchphrases   AS cp
        ON cp.character_id = pc.character_id
WHERE      pc.phrase_count = (
               SELECT MAX(phrase_count) FROM phrase_counts
           )
ORDER BY   cp.id ASC;

/*
EXPECTED RESULT (sample):
  character_name | phrase_count | phrase
  ---------------+--------------+----------------------------
  Homer Simpson  | 10           | D'oh!
  Homer Simpson  | 10           | Woo Hoo!
  Homer Simpson  | 10           | Why you little!
  ...
*/


-- ===========================================================================
-- QUESTION 3
-- Author  : Vladimir J.
-- Question: Which season had the highest average viewership, and what was
--           its most-watched episode title?
-- Purpose : Identify the peak popularity era of The Simpsons.
-- ===========================================================================

SELECT
    s.number                     AS season_number,
    s.year_start || '-' || s.year_end
                                 AS broadcast_years,
    s.average_viewers            AS avg_viewers,
    s.most_watched_episode_viewers
                                 AS top_episode_viewers,
    e.title                      AS most_watched_episode_title
FROM       seasons  AS s
LEFT JOIN  episodes AS e
        ON e.id = s.most_watched_episode_id
WHERE      s.average_viewers = (
               SELECT MAX(average_viewers)
               FROM   seasons
               WHERE  average_viewers IS NOT NULL
           );

/*
EXPECTED RESULT (sample):
  season_number | broadcast_years | avg_viewers | top_episode_viewers | most_watched_episode_title
  --------------+-----------------+-------------+---------------------+---------------------------
  1             | 1989-1990       | 27000000    | 33000000            | Simpsons Roasting on an...
*/


-- ===========================================================================
-- QUESTION 4
-- Author  : Vladimir J.
-- Question: What are all the quotes spoken by Homer Simpson, and in which
--           episode (title) and season did each quote appear?
-- Purpose : Explore Homer's memorable quotes linked to their episode context.
-- ===========================================================================

SELECT
    q.date                           AS quote_date,
    q.quote,
    e.title                          AS episode_title,
    s.number                         AS season_number
FROM        quotes     AS q
INNER JOIN  characters AS c
         ON c.id = q.character_id
INNER JOIN  episodes   AS e
         ON e.id = q.episode_id
INNER JOIN  seasons    AS s
         ON s.id = e.season_id
WHERE       c.name = 'Homer Simpson'
ORDER BY    q.date ASC;

/*
EXPECTED RESULT (sample):
  quote_date  | quote                                    | episode_title        | season_number
  ------------+------------------------------------------+----------------------+--------------
  1992-03-26  | It takes two to lie: one to lie and one  | Homer vs. Patty and  | 3
               | to listen.                              | Selma                |
  ...
*/


-- ===========================================================================
-- END OF SCRIPT
-- EC_IT143_W5.2_Simpsons_VJ.sql
-- ===========================================================================
