-- 🔹 Create indexes on high-usage columns

-- Users table
CREATE INDEX idx_users_user_id ON users(user_id);

-- Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_booking_date ON bookings(booking_date);

-- Properties table
CREATE INDEX idx_properties_property_id ON properties(property_id);

-- Payments table (if applicable)
CREATE INDEX idx_payments_booking_id ON payments(booking_id);

-- Reviews table (for JOINs and aggregations)
CREATE INDEX idx_reviews_property_id ON reviews(property_id);


-- 🔹 Measure query performance using EXPLAIN ANALYZE

-- Example query: Fetch recent bookings with user and property info
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    u.name AS user_name,
    p.name AS property_name
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
WHERE 
    b.booking_date >= '2024-01-01';
