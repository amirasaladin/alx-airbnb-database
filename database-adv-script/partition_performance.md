# Partitioning Performance Report

## Objective
Improve query performance on the `bookings` table by partitioning it based on the `start_date` column.

---

## Approach

We implemented **table partitioning by RANGE** using the `start_date` column. The `bookings` table was restructured to be partitioned by year:

- `bookings_2023`: `2023-01-01` to `2024-01-01`
- `bookings_2024`: `2024-01-01` to `2025-01-01`
- `bookings_2025`: `2025-01-01` to `2026-01-01`

A sample query was run using `EXPLAIN ANALYZE` to test performance:

```sql
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-05-01' AND '2024-05-31';
