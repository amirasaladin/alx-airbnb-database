-- schema.sql

-- =========================
-- USER TABLE
-- =========================
CREATE TABLE users (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster lookup by email
CREATE INDEX idx_users_email ON users(email);

-- =========================
-- PROPERTY TABLE
-- =========================
CREATE TABLE properties (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (host_id) REFERENCES users(user_id)
);

-- Index for faster filtering by host or property
CREATE INDEX idx_properties_host_id ON properties(host_id);

-- =========================
-- BOOKING TABLE
-- =========================
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Indexes for faster lookups
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- =========================
-- PAYMENT TABLE
-- =========================
CREATE TABLE payments (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Index for faster lookup
CREATE INDEX idx_payments_booking_id ON payments(booking_id);

-- =========================
-- REVIEW TABLE
-- =========================
CREATE TABLE reviews (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Indexes for faster filtering
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);

-- =========================
-- MESSAGE TABLE
-- =========================
CREATE TABLE messages (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);

-- Indexes for message queries
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_recipient ON messages(recipient_id);
