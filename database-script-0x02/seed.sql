-- seed.sql

-- =========================
-- USERS
-- =========================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
  ('11111111-1111-1111-1111-111111111111', 'Alice', 'Smith', 'alice@example.com', 'hashedpassword1', '1234567890', 'guest'),
  ('22222222-2222-2222-2222-222222222222', 'Bob', 'Johnson', 'bob@example.com', 'hashedpassword2', '0987654321', 'host'),
  ('33333333-3333-3333-3333-333333333333', 'Charlie', 'Admin', 'admin@example.com', 'hashedpassword3', NULL, 'admin');

-- =========================
-- PROPERTIES
-- =========================
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES 
  ('aaa11111-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 'Cozy Cabin', 'A peaceful cabin in the woods', 'Lake Tahoe', 150.00),
  ('bbb22222-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', 'Downtown Apartment', 'Modern apartment in city center', 'San Francisco', 200.00);

-- =========================
-- BOOKINGS
-- =========================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  ('book1234-aaaa-bbbb-cccc-111122223333', 'aaa11111-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', '2025-07-01', '2025-07-05', 600.00, 'confirmed'),
  ('book5678-dddd-eeee-ffff-444455556666', 'bbb22222-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111', '2025-08-15', '2025-08-20', 1000.00, 'pending');

-- =========================
-- PAYMENTS
-- =========================
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
  ('pay11111-aaaa-bbbb-cccc-ddddeeeeeeee', 'book1234-aaaa-bbbb-cccc-111122223333', 600.00, 'stripe'),
  ('pay22222-ffff-gggg-hhhh-iiiiijjjjjj', 'book5678-dddd-eeee-ffff-444455556666', 1000.00, 'paypal');

-- =========================
-- REVIEWS
-- =========================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
  ('rev11111-aaaa-bbbb-cccc-1111aaaa1111', 'aaa11111-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 5, 'Amazing place! Super clean and quiet.'),
  ('rev22222-eeee-ffff-gggg-2222bbbb2222', 'bbb22222-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111', 4, 'Great location, but a bit noisy.');

-- =========================
-- MESSAGES
-- =========================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
  ('msg11111-aaaa-bbbb-cccc-ddddaaaa1111', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Hi! Is the cabin available next month?'),
  ('msg22222-eeee-ffff-gggg-hhhhbbbb2222', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Yes, it’s open for the first week of July!');
