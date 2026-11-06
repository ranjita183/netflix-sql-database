-- =============================================================================
-- FILE: queries/04_aggregations_and_grouping.sql
-- DESCRIPTION: Aggregations, Grouping, and Duplicate Detection for Netflix DB
--              Demonstrates COUNT, MIN, MAX, AVG, SUM, GROUP BY, and HAVING
-- =============================================================================

USE netflix_db;

-- -----------------------------------------------------------------------------
-- 1. Aggregate Functions (COUNT, MIN, MAX, AVG, SUM)
-- -----------------------------------------------------------------------------

-- Count total videos with a rating greater than 4.0
SELECT COUNT(*) AS total_high_rated_videos
FROM videos 
WHERE rating > 4.0;

-- Calculate Minimum, Maximum, and Average rating across all movies
SELECT 
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    ROUND(AVG(rating), 2) AS avg_rating
FROM videos;

-- Calculate total revenue collected across all user subscriptions
SELECT SUM(amount_paid) AS total_subscription_revenue
FROM subscriptions;


-- -----------------------------------------------------------------------------
-- 2. GROUP BY and HAVING Clause
-- -----------------------------------------------------------------------------

-- Group videos by genre and show only genres containing 2 or more videos
-- GROUP BY: Aggregates rows with identical group key values
-- HAVING: Filters aggregated groups based on aggregate function criteria
SELECT 
    genre_id, 
    COUNT(*) AS total_movies
FROM videos
GROUP BY genre_id 
HAVING COUNT(*) >= 2;


-- -----------------------------------------------------------------------------
-- 3. Duplicate Detection Strategy
-- -----------------------------------------------------------------------------

-- Insert duplicate genre names for demonstration purposes
INSERT INTO genres (genre_name, genre_description) VALUES
('Sci-Fi', 'Duplicate Sci-Fi entry for testing'),
('Comedy', 'Duplicate Comedy entry for testing');

-- Identify genre names that appear more than once in the system
SELECT 
    genre_name, 
    COUNT(*) AS duplicate_count
FROM genres
GROUP BY genre_name 
HAVING COUNT(*) > 1;

-- Clean up inserted duplicate entries
DELETE FROM genres 
WHERE genre_description LIKE 'Duplicate%';


-- -----------------------------------------------------------------------------
-- 4. Ranking & Positional Aggregations
-- -----------------------------------------------------------------------------

-- Find the genre with the 2nd highest average rating across all categories
SELECT 
    genre_id, 
    ROUND(AVG(rating), 2) AS avg_genre_rating
FROM videos
GROUP BY genre_id
ORDER BY avg_genre_rating DESC
LIMIT 1 OFFSET 1;
