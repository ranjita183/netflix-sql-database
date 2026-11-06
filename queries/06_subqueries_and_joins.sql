-- =============================================================================
-- FILE: queries/06_subqueries_and_joins.sql
-- DESCRIPTION: Subqueries, Nested Queries, and Multi-Table Joins for Netflix DB
-- =============================================================================

USE netflix_db;

-- -----------------------------------------------------------------------------
-- 1. Subqueries & Derived Tables
-- -----------------------------------------------------------------------------

-- Find genres that currently have no associated movies in catalog (NOT IN)
SELECT genre_name 
FROM genres
WHERE id NOT IN (
    SELECT DISTINCT genre_id
    FROM videos
    WHERE genre_id IS NOT NULL
);

-- Find movies with rating strictly greater than the overall average rating
SELECT movie_title, rating
FROM videos
WHERE rating > (
    SELECT AVG(rating)
    FROM videos
);

-- Derived Table Subquery: Filter genres whose average rating is between 4.0 and 4.3
SELECT genre_id, avg_rating
FROM (
    SELECT genre_id, ROUND(AVG(rating), 2) AS avg_rating
    FROM videos
    GROUP BY genre_id
) AS genre_ratings_summary
WHERE avg_rating >= 4.0 AND avg_rating <= 4.3;

-- Find subscription plan tier generating highest revenue
SELECT subscription_type, total_revenue
FROM (
    SELECT subscription_type, SUM(amount_paid) AS total_revenue
    FROM subscriptions
    GROUP BY subscription_type
) AS revenue_summary
ORDER BY total_revenue DESC 
LIMIT 1;


-- -----------------------------------------------------------------------------
-- 2. Basic Joins (INNER JOIN & LEFT JOIN)
-- -----------------------------------------------------------------------------

-- INNER JOIN: Display movie titles alongside their respective genre names
SELECT 
    v.id AS video_id,
    v.movie_title, 
    g.genre_name
FROM videos v
INNER JOIN genres g ON v.genre_id = g.id;

-- LEFT JOIN: Display all genres including count of catalog movies (including 0 count)
SELECT 
    g.genre_name, 
    COUNT(v.id) AS total_movies_in_catalog
FROM genres g
LEFT JOIN videos v ON g.id = v.genre_id
GROUP BY g.id, g.genre_name;


-- -----------------------------------------------------------------------------
-- 3. Multi-Table Joins (Joining 4 Interconnected Tables)
-- -----------------------------------------------------------------------------

-- Join users, watch_history, videos, and genres tables
SELECT 
    u.username, 
    v.movie_title, 
    g.genre_name,
    wh.watch_min
FROM users u
INNER JOIN watch_history wh ON u.id = wh.user_id
INNER JOIN videos v ON wh.video_id = v.id
INNER JOIN genres g ON v.genre_id = g.id;


-- -----------------------------------------------------------------------------
-- 4. Advanced Analytics Subquery with Multi-Table Joins
-- -----------------------------------------------------------------------------

-- Find users who have completed watching at least one movie fully 
-- (where total_duration_min - watch_min = 0)
SELECT DISTINCT username 
FROM (
    SELECT 
        u.username, 
        v.movie_title, 
        v.total_duration_min, 
        wh.watch_min, 
        (v.total_duration_min - wh.watch_min) AS remaining_duration_min
    FROM users u
    INNER JOIN watch_history wh ON u.id = wh.user_id
    INNER JOIN videos v ON wh.video_id = v.id
) AS viewing_completion_analysis
WHERE remaining_duration_min = 0;
