-- 🔹 Step 1: Drop existing table if needed (optional, use with caution)
-- DROP TABLE IF EXISTS bookings CASCADE;

-- 🔹 Step 2: Create a partitioned bookings table based on start_date
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT,
    property_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
) PARTITION BY RANGE (start_date);

-- 🔹 Step 3: Create individual partitions (example: yearly)
CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- 🔹 Step 4: Performance test query
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-05-01' AND '2024-05-31';
