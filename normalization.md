# 🧮 Database Normalization (3NF)

## 🎯 Objective

To ensure data integrity, reduce redundancy, and improve scalability, the Airbnb clone database schema must be normalized up to **Third Normal Form (3NF)**.

---

## 🔍 Overview of Normal Forms

### First Normal Form (1NF)

* **Rule**: Each column must contain atomic (indivisible) values. Each record must be unique.
* ✅ **Achieved**: All fields in the current schema are atomic (e.g., no multiple values in a single field), and all tables have a primary key.

### Second Normal Form (2NF)

* **Rule**: Must be in 1NF and all non-key attributes must be fully functionally dependent on the **entire** primary key.
* ✅ **Achieved**: No partial dependencies exist; all non-key attributes depend on the full primary key (note: no composite keys are used).

### Third Normal Form (3NF)

* **Rule**: Must be in 2NF and have **no transitive dependencies** (i.e., non-key attributes should not depend on other non-key attributes).
* ✅ **Achieved**: No transitive dependencies are present. All non-key fields depend only on the primary key of their respective tables.

---

## 🛠️ Normalization Steps Applied

### 1. **User Table**

* ✅ Atomic and unique fields.
* ✅ `email` is unique.
* ✅ `role` is ENUM — avoids unnecessary join tables for user types.

### 2. **Property Table**

* ✅ `host_id` is a foreign key to the `User` table — avoids host data duplication.
* ✅ Each property is fully described without redundant data.

### 3. **Booking Table**

* ✅ Links `property_id` and `user_id` through foreign keys.
* ✅ `total_price` is derived from date range × nightly rate, but is stored for performance (acceptable denormalization).

### 4. **Payment Table**

* ✅ Linked directly to `Booking`.
* ✅ No redundant user or property info — all context comes via `booking_id`.

### 5. **Review Table**

* ✅ Every review is linked to a property and user.
* ✅ No transitive dependencies.

### 6. **Message Table**

* ✅ Each message stores sender and recipient IDs only.
* ✅ No unnecessary duplication of user data.

---

## ⚖️ Trade-Offs and Design Choices

* Storing `total_price` in `Booking` is a **controlled denormalization** for performance. It can be recalculated if needed, but storing it avoids repeated computation.
* ENUMs (for `role`, `status`, `payment_method`) are used instead of separate lookup tables to simplify the schema while maintaining validation.

---

## ✅ Final Verdict

**The database schema is fully normalized up to 3NF.**
All tables:

* Have atomic and relevant fields.
* Avoid data redundancy.
* Maintain integrity via foreign keys.
* Support scalability and efficient querying.
