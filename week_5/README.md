# Week 5 — Retail Sales Analytics

This project focuses on SQL analytics using a retail sales star schema.

## Objective

Analyze sales performance across time, products, customers, and stores using:

- CTEs
- Subqueries
- Window functions
- Aggregations
- Month-over-month growth reporting

## Project Structure

```text
week_5/
├── README.md
└── sql/
    ├── 01_schema.sql
    ├── 02_seed_data.sql
    ├── 03_analytics.sql
    └── 04_exercises.sql
```

## Files

- `01_schema.sql` — creates the star schema tables
- `02_seed_data.sql` — inserts sample retail data
- `03_analytics.sql` — solved SQL analytics queries
- `04_exercises.sql` — practice questions

## Main Concepts

- Dimensional modeling
- Fact and dimension tables
- Window functions: `RANK`, `DENSE_RANK`, `LAG`, `LEAD`, `NTILE`
- Running totals
- CTEs and recursive CTEs
- Set operations: `UNION`, `INTERSECT`, `EXCEPT`
- Rollup and grouping logic
- Month-over-month sales growth report

## Run Order

```sql
SOURCE 01_schema.sql;
SOURCE 02_seed_data.sql;
SOURCE 03_analytics.sql;
SOURCE 04_exercises.sql;
```

Use MySQL 8+ to run the scripts.
