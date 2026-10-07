# Week 4 - SQL

This folder contains the SQL practice and assessment material for Week 4.

## Topics Covered

- NULL handling: `IS NULL`, `COALESCE`, `NULLIF`
- Aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `GROUP BY` and `HAVING`
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, FULL OUTER JOIN equivalent
- `CASE WHEN`
- String functions
- Date and time functions
- DDL and constraints
- Scalar subqueries
- Correlated subqueries
- `EXISTS` and `NOT EXISTS`
- Normalization concepts: 1NF, 2NF, 3NF
- Window functions: `RANK`, `DENSE_RANK`, `LAG`, `LEAD`, `NTILE`
- Window frames and running totals
- CTEs
- Recursive CTEs
- `UNION`, `INTERSECT`, `EXCEPT`
- `ROLLUP`
- `CUBE` equivalent in MySQL
- `GROUPING SETS` equivalent in MySQL
- Views
- Materialized-view concept using a snapshot table
- Assessment-style SQL problems

## Files

### schema.sql
Creates the database and tables with primary keys, foreign keys, UNIQUE, NOT NULL and CHECK constraints.

### data.sql
Contains sample data for employees, departments, projects, customers and orders.

### queries.sql
Contains examples and assessment-style SQL queries covering the Week 4 syllabus.

## How to Run

Using MySQL:

```sql
SOURCE schema.sql;
SOURCE data.sql;
SOURCE queries.sql;
```

Or open the three SQL files in MySQL Workbench and execute them in this order:

1. `schema.sql`
2. `data.sql`
3. `queries.sql`

## Database Design

The main tables are:

- `departments`
- `employees`
- `projects`
- `employee_projects`
- `customers`
- `orders`

The database demonstrates primary keys, foreign keys and many-to-many relationships.

## Note

This project is designed for SQL practice and assessment preparation. Some advanced SQL features such as `CUBE`, `GROUPING SETS`, and native materialized views are database-specific. MySQL does not provide native `CREATE MATERIALIZED VIEW`, `CUBE`, or `GROUPING SETS`, so equivalent approaches are demonstrated in `queries.sql`.
