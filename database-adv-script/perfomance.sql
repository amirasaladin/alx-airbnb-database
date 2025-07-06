-- 🔹 Initial Complex Query: Bookings with user, property, and payment details
SELECT 
    b.booking_id,
    b.booking_date,
    u.user_id,
    u.name AS user_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_date
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id;

-- 🔍 Analyze Performance
EXPLAIN 
SELECT 
    b.booking_id,
    b.booking_date,
    u.user_id,
    u.name AS user_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_date
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id;

-- 🔧 Refactored Query for Improved Performance
-- Assumes proper indexes exist:
--   - bookings.user_id
--   - bookings.property_id
--   - payments.booking_id
--   - users.user_id
--   - properties.property_id

-- Refactoring includes: 
--   - Selecting only necessary fields
--   - Using indexed join columns

SELECT 
    b.booking_id,
    b.booking_date,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id;
