-- =============================================================================
-- FILE: scripts/setup_all.sql
-- DESCRIPTION: End-to-End Master Execution Script for Netflix Database Setup
--              Builds Schema, Seeds Data, and Executes Sample Demonstration Queries
-- =============================================================================

DROP DATABASE IF EXISTS netflix_db;
CREATE DATABASE netflix_db;
USE netflix_db;

-- -----------------------------------------------------------------------------
-- 1. DATABASE SCHEMA CREATION (DDL)
-- -----------------------------------------------------------------------------

CREATE TABLE genres (
    id INT AUTO_INCREMENT, 
    genre_name VARCHAR(255) NOT NULL,
    genre_description TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE videos (
    id INT AUTO_INCREMENT,
    genre_id INT NOT NULL,
    movie_title VARCHAR(255) NOT NULL,
    movie_description TEXT,
    PRIMARY KEY (id),
    CONSTRAINT fk_videos_genres FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

-- Schema Alteration Demonstrations
ALTER TABLE genres ADD created_date DATE;
ALTER TABLE genres MODIFY genre_name VARCHAR(50) NOT NULL;
ALTER TABLE genres DROP COLUMN created_date;

ALTER TABLE videos ADD released_date DATE;
ALTER TABLE videos ADD rating DECIMAL(2,1);
ALTER TABLE videos ADD total_duration_min INT;

CREATE TABLE users (
    id INT AUTO_INCREMENT, 
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    mobile VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE subscriptions (
    id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    subscription_type VARCHAR(20) NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_subscriptions_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE watch_history (
    id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    video_id INT NOT NULL,
    watch_min INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_watch_history_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_watch_history_videos FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------
-- 2. DATA SEEDING (DML)
-- -----------------------------------------------------------------------------

-- Genres
INSERT INTO genres (genre_name, genre_description) VALUES
('Sci-Fi', 'Science fiction and futuristic adventure movies'),
('Comedy', 'Comedy series and feel-good movies'),
('Horror', 'Supernatural, ghost stories, and suspense thrillers'),
('Action', 'Marvel, DC, and high-octane action thrillers'),
('Racing', 'High-speed motorsport and car racing blockbusters');

UPDATE genres SET genre_name = 'Horror & Conspiracy' WHERE genre_name = 'Horror';

-- Videos
INSERT INTO videos (genre_id, movie_title, movie_description) VALUES
(1, 'Interstellar', 'Sci-Fi masterpiece directed by Christopher Nolan'),
(1, 'Jurassic Park', 'Classic Sci-Fi adventure involving prehistoric predators'),
(2, '3 Idiots', 'Comedy drama highlighting engineering student life'),
(2, 'Kirataka', 'Popular Kannada comedy-drama film'),
(2, 'Golmaal', 'Classic Hindi comedy film starring Ajay Devgn'),
(3, 'Annabelle', 'Supernatural horror movie inspired by true events'),
(3, 'Obsession', 'Psychological thriller film'),
(4, 'Avengers: Age of Ultron', 'Marvel Cinematic Universe superhero action movie'),
(4, 'Temporary Test Movie', 'Temporary record inserted to demonstrate deletion');

DELETE FROM videos WHERE id = 9;

INSERT INTO videos (genre_id, movie_title, movie_description) VALUES
(4, 'Fast & Furious 6', 'Action-packed street racing blockbuster');

-- Update Metadata
UPDATE videos SET released_date = '2014-11-07', rating = 4.7, total_duration_min = 169 WHERE id = 1;
UPDATE videos SET released_date = '1993-06-11', rating = 4.2, total_duration_min = 127 WHERE id = 2;
UPDATE videos SET released_date = '2009-12-25', rating = 4.5, total_duration_min = 170 WHERE id = 3;
UPDATE videos SET released_date = '2011-06-24', rating = 3.9, total_duration_min = 140 WHERE id = 4;
UPDATE videos SET released_date = '2006-07-14', rating = 4.1, total_duration_min = 150 WHERE id = 5;
UPDATE videos SET released_date = '2014-10-03', rating = 3.8, total_duration_min = 99  WHERE id = 6;
UPDATE videos SET released_date = '2019-04-12', rating = 3.5, total_duration_min = 90  WHERE id = 7;
UPDATE videos SET released_date = '2015-05-01', rating = 4.3, total_duration_min = 141 WHERE id = 8;
UPDATE videos SET released_date = '2013-05-24', rating = 4.0, total_duration_min = 130 WHERE id = 10;

-- Users
INSERT INTO users (username, email, mobile) VALUES
('shivu_0304', 'shivu@example.com', '8618910204'),
('alex_morgan', 'alex.morgan@example.com', '9812345678'),
('sarah_connor', 'sarah.c@example.com', '9711223344'),
('rahul_sharma', 'rahul.sharma@example.com', '9654321098'),
('emily_watson', 'emily.w@example.com', '9543210987');

-- Subscriptions
INSERT INTO subscriptions (user_id, subscription_type, amount_paid) VALUES
(1, 'Monthly', 199.00),
(2, 'Yearly', 1029.00),
(3, 'Yearly', 1029.00),
(4, 'Yearly', 1029.00);

-- Watch History
INSERT INTO watch_history (user_id, video_id, watch_min) VALUES
(1, 1, 169),
(1, 2, 40),
(2, 3, 170),
(2, 4, 50),
(2, 5, 40),
(3, 1, 70);


-- -----------------------------------------------------------------------------
-- 3. DEMONSTRATION QUERIES (DQL, Aggregations, Case, Regex, Joins)
-- -----------------------------------------------------------------------------

-- Filter and Pagination
SELECT * FROM videos WHERE id >= 2 AND id <= 5;
SELECT * FROM videos LIMIT 4 OFFSET 2;

-- Sorting
SELECT * FROM videos ORDER BY released_date ASC;

-- Aggregations
SELECT MIN(rating) AS min_rating, MAX(rating) AS max_rating, ROUND(AVG(rating), 2) AS avg_rating FROM videos;

-- Group By & Having
SELECT genre_id, COUNT(*) AS total_movies FROM videos GROUP BY genre_id HAVING COUNT(*) >= 2;

-- Pattern Matching & Regex
SELECT * FROM videos WHERE movie_title LIKE 'A%';
SELECT * FROM users WHERE mobile REGEXP '^[0-9]{10}$';

-- CASE Control Flow
SELECT 
    movie_title, 
    rating,
    CASE 
        WHEN rating < 4.0 THEN 'Average'
        WHEN rating >= 4.0 AND rating < 4.5 THEN 'Good'
        WHEN rating >= 4.5 THEN 'Masterpiece'
    END AS rating_category
FROM videos;

-- Subqueries
SELECT movie_title, rating FROM videos WHERE rating > (SELECT AVG(rating) FROM videos);

-- Joins across 4 tables
SELECT 
    u.username, 
    v.movie_title, 
    g.genre_name,
    wh.watch_min
FROM users u
INNER JOIN watch_history wh ON u.id = wh.user_id
INNER JOIN videos v ON wh.video_id = v.id
INNER JOIN genres g ON v.genre_id = g.id;

-- Completed Watch Query
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
) AS completion_summary
WHERE remaining_duration_min = 0;
