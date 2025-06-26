Here's a well-formatted `requirements.md` section for your GitHub project, describing the **Database Design** and **Entity Relationships** based on your Airbnb clone schema. You can copy and paste this directly into a `requirements.md` file:

---

# 📦 Database Requirements

## 🎯 Objective

Design a normalized, scalable, and relational database schema to support the core backend functionalities of an Airbnb-like platform. The database should support users (guests/hosts/admins), property listings, bookings, reviews, messaging, and payments.

---

## 🗄️ Database Entities and Relationships

### 1. **User**

Stores all registered users, including guests, hosts, and admins.

| Field           | Type      | Constraints                          |
| --------------- | --------- | ------------------------------------ |
| `user_id`       | UUID      | Primary Key, Indexed                 |
| `first_name`    | VARCHAR   | Not Null                             |
| `last_name`     | VARCHAR   | Not Null                             |
| `email`         | VARCHAR   | Unique, Not Null                     |
| `password_hash` | VARCHAR   | Not Null                             |
| `phone_number`  | VARCHAR   | Nullable                             |
| `role`          | ENUM      | Values: guest, host, admin; Not Null |
| `created_at`    | TIMESTAMP | Default: `CURRENT_TIMESTAMP`         |

---

### 2. **Property**

Represents listings created by hosts.

| Field           | Type      | Constraints                   |
| --------------- | --------- | ----------------------------- |
| `property_id`   | UUID      | Primary Key, Indexed          |
| `host_id`       | UUID      | Foreign Key → `User(user_id)` |
| `name`          | VARCHAR   | Not Null                      |
| `description`   | TEXT      | Not Null                      |
| `location`      | VARCHAR   | Not Null                      |
| `pricepernight` | DECIMAL   | Not Null                      |
| `created_at`    | TIMESTAMP | Default: `CURRENT_TIMESTAMP`  |
| `updated_at`    | TIMESTAMP | Updated on modification       |

---

### 3. **Booking**

Captures reservations made by guests on properties.

| Field         | Type      | Constraints                           |
| ------------- | --------- | ------------------------------------- |
| `booking_id`  | UUID      | Primary Key, Indexed                  |
| `property_id` | UUID      | Foreign Key → `Property(property_id)` |
| `user_id`     | UUID      | Foreign Key → `User(user_id)`         |
| `start_date`  | DATE      | Not Null                              |
| `end_date`    | DATE      | Not Null                              |
| `total_price` | DECIMAL   | Not Null                              |
| `status`      | ENUM      | Values: pending, confirmed, canceled  |
| `created_at`  | TIMESTAMP | Default: `CURRENT_TIMESTAMP`          |

---

### 4. **Payment**

Handles transaction records related to bookings.

| Field            | Type      | Constraints                          |
| ---------------- | --------- | ------------------------------------ |
| `payment_id`     | UUID      | Primary Key, Indexed                 |
| `booking_id`     | UUID      | Foreign Key → `Booking(booking_id)`  |
| `amount`         | DECIMAL   | Not Null                             |
| `payment_date`   | TIMESTAMP | Default: `CURRENT_TIMESTAMP`         |
| `payment_method` | ENUM      | Values: credit\_card, paypal, stripe |

---

### 5. **Review**

Allows users to leave feedback on properties.

| Field         | Type      | Constraints                           |
| ------------- | --------- | ------------------------------------- |
| `review_id`   | UUID      | Primary Key, Indexed                  |
| `property_id` | UUID      | Foreign Key → `Property(property_id)` |
| `user_id`     | UUID      | Foreign Key → `User(user_id)`         |
| `rating`      | INTEGER   | Range: 1–5, Not Null                  |
| `comment`     | TEXT      | Not Null                              |
| `created_at`  | TIMESTAMP | Default: `CURRENT_TIMESTAMP`          |

---

### 6. **Message**

Enables private messaging between users.

| Field          | Type      | Constraints                   |
| -------------- | --------- | ----------------------------- |
| `message_id`   | UUID      | Primary Key, Indexed          |
| `sender_id`    | UUID      | Foreign Key → `User(user_id)` |
| `recipient_id` | UUID      | Foreign Key → `User(user_id)` |
| `message_body` | TEXT      | Not Null                      |
| `sent_at`      | TIMESTAMP | Default: `CURRENT_TIMESTAMP`  |

---

## 🔗 Entity Relationships

* A **User** can:

  * Create many **Properties** (if Host)
  * Make many **Bookings**
  * Write many **Reviews**
  * Send and receive **Messages**
* A **Property**:

  * Belongs to one **Host**
  * Has many **Bookings**
  * Has many **Reviews**
* A **Booking**:

  * Belongs to one **User** and one **Property**
  * Triggers one **Payment**
* A **Review**:

  * Linked to one **Property** and one **User**
* A **Message**:

  * Has a sender and a recipient (both Users)

---

## 🧩 Indexes and Constraints

* **Primary Keys**: Auto-indexed
* **Foreign Keys**: Enforced for relational integrity
* **Unique**: `email` field in `User`
* **Validation Rules**:

  * `rating`: Must be between 1 and 5
  * `status`: Booking status must be a valid ENUM
* **Performance Indexes**:

  * `email` (User)
  * `property_id` (Property, Booking)
  * `booking_id` (Booking, Payment)

---

Let me know if you'd like a **visual ER diagram** version of this section for use in presentations or documentation too!
