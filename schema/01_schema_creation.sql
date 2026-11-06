-- =============================================================================
-- FILE: schema/01_schema_creation.sql
-- DESCRIPTION: Data Definition Language (DDL) Scripts for Netflix DB
--              Creates Database, Tables, Primary/Foreign Keys, and Schema Alterations
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. Database Initialization
-- -----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS netflix_db;
USE netflix_db;

-- -----------------------------------------------------------------------------
-- 2. Create Table: genres (Genre Master Table)
-- -----------------------------------------------------------------------------
-- Stores categories/genres for movies and video content.
CREATE TABLE IF NOT EXISTS genres (
    id INT AUTO_INCREMENT, 
    genre_name VARCHAR(255) NOT NULL,
    genre_description TEXT,
    PRIMARY KEY (id)
);

-- Inspect Table Structure
DESCRIBE genres;


-- -----------------------------------------------------------------------------
-- 3. Create Table: videos (Movies / Video Catalog Table)
-- -----------------------------------------------------------------------------
-- Stores video catalog details with Foreign Key reference to genres table.
CREATE TABLE IF NOT EXISTS videos (
    id INT AUTO_INCREMENT,
    genre_id INT NOT NULL,
    movie_title VARCHAR(255) NOT NULL,
    movie_description TEXT,
    PRIMARY KEY (id),
    CONSTRAINT fk_videos_genres FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);

-- Inspect Table Structure
DESCRIBE videos;


-- -----------------------------------------------------------------------------
-- 4. Schema Alteration Examples (ALTER TABLE Operations)
-- -----------------------------------------------------------------------------

-- Example A: Add temporary column 'created_date' to 'genres' table
ALTER TABLE genres
ADD created_date DATE;

-- Example B: Modify data type/length of 'genre_name' column
ALTER TABLE genres
MODIFY genre_name VARCHAR(50) NOT NULL;

-- Example C: Remove column 'created_date' from 'genres' table
ALTER TABLE genres
DROP COLUMN created_date;

-- Example D: Add additional metadata columns to 'videos' table
ALTER TABLE videos 
ADD released_date DATE;

-- rating: DECIMAL(2,1) allows ratings up to 9.9 (e.g., 4.5)
ALTER TABLE videos 
ADD rating DECIMAL(2,1);

ALTER TABLE videos    
ADD total_duration_min INT;


-- -----------------------------------------------------------------------------
-- 5. Create Table: users (Registered User Profiles)
-- -----------------------------------------------------------------------------
-- Stores registered subscriber accounts.
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT, 
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    mobile VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);

-- Inspect Table Structure
DESCRIBE users;


-- -----------------------------------------------------------------------------
-- 6. Create Table: subscriptions (Billing & Plan Details)
-- -----------------------------------------------------------------------------
-- Tracks billing plans and payments for users.
CREATE TABLE IF NOT EXISTS subscriptions (
    id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    subscription_type VARCHAR(20) NOT NULL,
    amount_paid DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_subscriptions_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Inspect Table Structure
DESCRIBE subscriptions;


-- -----------------------------------------------------------------------------
-- 7. Create Table: watch_history (User Viewing Activity Log)
-- -----------------------------------------------------------------------------
-- Maps users to watched videos and tracks total minutes watched.
CREATE TABLE IF NOT EXISTS watch_history (
    id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    video_id INT NOT NULL,
    watch_min INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_watch_history_users FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_watch_history_videos FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE
);

-- Inspect Table Structure
DESCRIBE watch_history;
