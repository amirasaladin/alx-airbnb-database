# Performance Optimization Report

## 🎯 Objective
Refactor a complex SQL query that retrieves booking, user, property, and payment details to improve performance.

---

## 🔍 Initial Query Analysis

The initial query joins four tables:

- `bookings`
- `users`
- `properties`
- `payments`

### Issues Identified via EXPLAIN:
- Full table scans on `users`, `properties`, and `payments` due to missing indexes.
- Retrieves unused columns (e.g., `user_id`, `payment_date`) increasing I/O.
- No filtering or pagination, so all rows are processed.

---

## ✅ Optimization Strategies Applied

1. **Indexes Added**:
   - `bookings.user_id`
   - `bookings.property_id`
   - `payments.booking_id`
   - `users.user_id`
   - `properties.property_id`

2. **Reduced Column Load**:
   - Selected only necessary fields for output

3. **Join Conditions Aligned with Indexed Columns**

---

## ⚡ Refactored Query Benefits

- Significantly reduced execution time in large datasets
- Improved I/O and memory usage
- Query plan shows use of indexes instead of full scans

---

## 📌 Recommendation

Always pair complex joins with selective fields and proper indexing. Consider pagination (`LIMIT/OFFSET`) or filtering for large production queries.
