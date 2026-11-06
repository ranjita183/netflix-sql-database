-- =============================================================================
-- FILE: queries/05_pattern_matching_and_conditionals.sql
-- DESCRIPTION: Pattern Matching (LIKE, REGEXP) & Conditional Logic (CASE WHEN)
-- =============================================================================

USE netflix_db;

-- -----------------------------------------------------------------------------
-- 1. Wildcard Pattern Matching (LIKE Operator)
-- -----------------------------------------------------------------------------

-- Find movies with titles starting with 'A'
-- '%' matches zero or more characters
SELECT * 
FROM videos
WHERE movie_title LIKE 'A%';

-- Find movies with titles ending with 'n'
SELECT * 
FROM videos
WHERE movie_title LIKE '%n';

-- Find movies containing the string 'Park' anywhere in the title
SELECT * 
FROM videos
WHERE movie_title LIKE '%Park%';

-- Find movie titles starting with 'A' followed by exactly 6 characters (7 chars total)
-- '_' matches exactly one single character
SELECT * 
FROM videos
WHERE movie_title LIKE 'A______';


-- -----------------------------------------------------------------------------
-- 2. Regular Expressions (REGEXP Operator)
-- -----------------------------------------------------------------------------

-- Validate users with exactly 10-digit mobile phone numbers
-- '^[0-9]{10}$' asserts 10 numeric digits from start to end of string
SELECT * 
FROM users
WHERE mobile REGEXP '^[0-9]{10}$';

-- Filter users registered with specific email domain extensions (example.com or gmail.com)
SELECT * 
FROM users
WHERE email REGEXP '@(example\.com|gmail\.com)$';


-- -----------------------------------------------------------------------------
-- 3. Arithmetic Operations & Computed Columns
-- -----------------------------------------------------------------------------

-- Calculate 18% Tax (GST) and final price for each user subscription plan
SELECT 
    user_id, 
    subscription_type,
    amount_paid, 
    ROUND(amount_paid * 0.18, 2) AS tax_amount_18_percent, 
    ROUND(amount_paid * 1.18, 2) AS final_price_with_tax
FROM subscriptions;


-- -----------------------------------------------------------------------------
-- 4. Conditional Control Flow (CASE Expressions)
-- -----------------------------------------------------------------------------

-- Example A: Categorize movie ratings into performance tiers
SELECT 
    movie_title, 
    rating,
    CASE 
        WHEN rating < 4.0 THEN 'Average'
        WHEN rating >= 4.0 AND rating < 4.5 THEN 'Good'
        WHEN rating >= 4.5 THEN 'Masterpiece'
        ELSE 'Unrated'
    END AS rating_category
FROM videos;

-- Example B: Calculate discounted plan prices based on subscription tier
-- Monthly -> 5% Discount
-- Yearly  -> 10% Discount
SELECT 
    user_id, 
    subscription_type, 
    amount_paid, 
    CASE 
        WHEN subscription_type = 'Monthly' THEN ROUND(amount_paid * 0.95, 2)
        WHEN subscription_type = 'Yearly'  THEN ROUND(amount_paid * 0.90, 2)
        ELSE amount_paid
    END AS discounted_amount
FROM subscriptions;
