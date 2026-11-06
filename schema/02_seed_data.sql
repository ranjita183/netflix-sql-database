-- =============================================================================
-- FILE: schema/02_seed_data.sql
-- DESCRIPTION: Data Manipulation Language (DML) Scripts for Netflix DB
--              Demonstrates INSERT, UPDATE, DELETE, and AUTO_INCREMENT mechanics
-- =============================================================================

USE netflix_db;

-- -----------------------------------------------------------------------------
-- 1. Populate Genres Table ('genres')
-- -----------------------------------------------------------------------------
INSERT INTO genres (genre_name, genre_description) VALUES
('Sci-Fi', 'Science fiction and futuristic adventure movies'),
('Comedy', 'Comedy series and feel-good movies'),
('Horror', 'Supernatural, ghost stories, and suspense thrillers'),
('Action', 'Marvel, DC, and high-octane action thrillers'),
('Racing', 'High-speed motorsport and car racing blockbusters');


-- -----------------------------------------------------------------------------
-- 2. Update Genre Record
-- Example: Update Genre Name from 'Horror' to 'Horror & Conspiracy'
-- -----------------------------------------------------------------------------
UPDATE genres
SET genre_name = 'Horror & Conspiracy'
WHERE genre_name = 'Horror';


-- -----------------------------------------------------------------------------
-- 3. Populate Video Catalog Table ('videos')
-- -----------------------------------------------------------------------------
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


-- -----------------------------------------------------------------------------
-- 4. Record Deletion & Auto-Increment Behavior Demonstration
-- -----------------------------------------------------------------------------
-- Delete temporary record (id = 9)
DELETE FROM videos
WHERE id = 9;

-- Note: MySQL AUTO_INCREMENT will NOT reuse deleted ID 9; it advances to ID 10
INSERT INTO videos (genre_id, movie_title, movie_description) VALUES
(4, 'Fast & Furious 6', 'Action-packed street racing blockbuster');


-- -----------------------------------------------------------------------------
-- 5. Update Metadata Columns (released_date, rating, total_duration_min)
-- -----------------------------------------------------------------------------
UPDATE videos SET released_date = '2014-11-07', rating = 4.7, total_duration_min = 169 WHERE id = 1;
UPDATE videos SET released_date = '1993-06-11', rating = 4.2, total_duration_min = 127 WHERE id = 2;
UPDATE videos SET released_date = '2009-12-25', rating = 4.5, total_duration_min = 170 WHERE id = 3;
UPDATE videos SET released_date = '2011-06-24', rating = 3.9, total_duration_min = 140 WHERE id = 4;
UPDATE videos SET released_date = '2006-07-14', rating = 4.1, total_duration_min = 150 WHERE id = 5;
UPDATE videos SET released_date = '2014-10-03', rating = 3.8, total_duration_min = 99  WHERE id = 6;
UPDATE videos SET released_date = '2019-04-12', rating = 3.5, total_duration_min = 90  WHERE id = 7;
UPDATE videos SET released_date = '2015-05-01', rating = 4.3, total_duration_min = 141 WHERE id = 8;
UPDATE videos SET released_date = '2013-05-24', rating = 4.0, total_duration_min = 130 WHERE id = 10;


-- -----------------------------------------------------------------------------
-- 6. Populate User Profiles Table ('users')
-- -----------------------------------------------------------------------------
INSERT INTO users (username, email, mobile) VALUES
('shivu_0304', 'shivu@example.com', '8618910204'),
('alex_morgan', 'alex.morgan@example.com', '9812345678'),
('sarah_connor', 'sarah.c@example.com', '9711223344'),
('rahul_sharma', 'rahul.sharma@example.com', '9654321098'),
('emily_watson', 'emily.w@example.com', '9543210987');


-- -----------------------------------------------------------------------------
-- 7. Populate Subscription Plans Table ('subscriptions')
-- -----------------------------------------------------------------------------
INSERT INTO subscriptions (user_id, subscription_type, amount_paid) VALUES
(1, 'Monthly', 199.00),
(2, 'Yearly', 1029.00),
(3, 'Yearly', 1029.00),
(4, 'Yearly', 1029.00);


-- -----------------------------------------------------------------------------
-- 8. Populate Viewing Logs Table ('watch_history')
-- -----------------------------------------------------------------------------
INSERT INTO watch_history (user_id, video_id, watch_min) VALUES
(1, 1, 169), -- User completed entire movie duration
(1, 2, 40),
(2, 3, 170), -- User completed entire movie duration
(2, 4, 50),
(2, 5, 40),
(3, 1, 70);
