-- 🔹 CREATE INDEXES to Improve Query Performance

-- Index on users.user_id (used in JOINs and WHERE)
CREATE INDEX idx_users_user_id ON users(user_id);

-- Index on bookings.user_id (used in JOINs and WHERE)
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Index on bookings.property_id (used in JOINs and filtering)
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Index on bookings.booking_date if used in ORDER BY or filtering
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date);

-- Index on properties.property_id (used in JOINs)
CREATE INDEX idx_properties_property_id ON properties(property_id);

-- Index on reviews.property_id (for JOIN and aggregation by property)
CREATE INDEX idx_reviews_property_id ON reviews(property_id);


-- 🔹 SAMPLE QUERY PERFORMANCE TEST: BEFORE AND AFTER INDEXES

-- Use EXPLAIN to check query plan (in MySQL) or EXPLAIN ANALYZE (in PostgreSQL)

-- Example: Find all bookings with user info for recent bookings
EXPLAIN
SELECT 
    b.booking_id,
    b.booking_date,
    u.name AS user_name,
    u.email
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
WHERE 
    b.booking_date >= '2024-01-01';

-- Optional: To get execution time in PostgreSQL
-- EXPLAIN ANALYZE SELECT ... (same query)

-- Repeat EXPLAIN after indexes are created to compare performance
