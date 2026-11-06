-- =============================================================================
-- FILE: queries/03_filtering_and_sorting.sql
-- DESCRIPTION: Data Query Language (DQL) Scripts for Netflix DB
--              Demonstrates SELECT, WHERE Filtering, Pagination (LIMIT/OFFSET), & ORDER BY
-- =============================================================================

USE netflix_db;

-- -----------------------------------------------------------------------------
-- 1. Basic Data Selection
-- -----------------------------------------------------------------------------

-- Select all columns from genres table
SELECT * FROM genres;

-- Select specific columns (id, genre_name) from genres table
SELECT id, genre_name FROM genres;


-- -----------------------------------------------------------------------------
-- 2. Conditional Filtering (WHERE Clause)
-- -----------------------------------------------------------------------------

-- Filter videos with ID between 2 and 5 (inclusive)
SELECT * 
FROM videos
WHERE id >= 2 AND id <= 5;

-- Exclude video with ID = 2 using inequality operator (!=)
SELECT * 
FROM videos
WHERE id != 2;

-- Exclude video with ID = 2 using NOT operator
SELECT * 
FROM videos
WHERE NOT (id = 2);


-- -----------------------------------------------------------------------------
-- 3. Pagination using LIMIT & OFFSET
-- -----------------------------------------------------------------------------

-- Retrieve the first 3 video records
SELECT * 
FROM videos 
LIMIT 3;

-- Skip the first 2 records and retrieve the next 4 records (Pagination: Page 2)
SELECT * 
FROM videos 
LIMIT 4 OFFSET 2;


-- -----------------------------------------------------------------------------
-- 4. Date Range & Complex Filters
-- -----------------------------------------------------------------------------

-- Retrieve movies NOT released between years 2005 and 2008
SELECT movie_title, released_date 
FROM videos
WHERE NOT (released_date >= '2005-01-01' AND released_date <= '2008-12-31');

-- Retrieve movies released in or after year 2000 that are NOT in Action genre (genre_id != 4)
SELECT movie_title, released_date, genre_id 
FROM videos
WHERE released_date >= '2000-01-01' AND genre_id != 4;


-- -----------------------------------------------------------------------------
-- 5. Sorting Output (ORDER BY)
-- -----------------------------------------------------------------------------

-- Sort videos in descending order of ID
SELECT * 
FROM videos
ORDER BY id DESC;

-- Sort videos in ascending order of ID
SELECT * 
FROM videos
ORDER BY id ASC;

-- Sort videos alphabetically by movie title
SELECT * 
FROM videos
ORDER BY movie_title ASC;

-- Sort videos chronologically by released date
SELECT * 
FROM videos
ORDER BY released_date ASC;


-- -----------------------------------------------------------------------------
-- 6. Positional Querying (Last / N-th Inserted Records)
-- -----------------------------------------------------------------------------

-- Retrieve the most recently inserted video record
SELECT id, movie_title 
FROM videos
ORDER BY id DESC
LIMIT 1;

-- Retrieve the second-most recently inserted video record
SELECT id, movie_title 
FROM videos
ORDER BY id DESC
LIMIT 1 OFFSET 1;
