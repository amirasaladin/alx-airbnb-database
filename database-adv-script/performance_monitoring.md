# 📊 Performance Monitoring and Refinement

## 🎯 Objective
Continuously monitor and refine database performance by analyzing query execution plans and making schema or indexing adjustments.

---

## 🔍 Step 1: Monitor Query Performance

We analyzed frequently used queries using `EXPLAIN ANALYZE` to identify bottlenecks.

### Example Query Analyzed:
```sql
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.name AS user_name,
    p.name AS property_name,
    b.booking_date
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
WHERE 
    b.booking_date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY 
    b.booking_date DESC;
