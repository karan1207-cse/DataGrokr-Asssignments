# Week 5 — Retail Sales Analytics Mini Project

## Mini Project

**Dimensional Model + Window Function Report + CTE Month-over-Month Growth**

This project is designed for the Week 5 Intermediate + Advanced SQL syllabus.

### Business Problem

A retail company wants to analyze sales across products, customers, stores and time.

The project answers questions such as:

- How much did the company sell each month?
- Which products and categories perform best?
- How much did sales grow compared with the previous month?
- Which customers are the highest value?
- How do products rank within a category?
- What is the running total of sales?
- How can customers be divided into sales quartiles?

---

## Project Structure

```text
week_5/
│
├── README.md
│
└── sql/
    ├── 01_schema.sql
    ├── 02_seed_data.sql
    ├── 03_analytics.sql
    └── 04_exercises.sql
```

### 01_schema.sql

Creates the dimensional model.

**Dimension tables**
- `dim_date`
- `dim_product`
- `dim_customer`
- `dim_store`

**Fact table**
- `fact_sales`

The model follows a **star schema**.

```text
                 dim_date
                    |
                    |
dim_product --- fact_sales --- dim_customer
                    |
                    |
                dim_store
```

---

## 02_seed_data.sql

Loads sample retail data for:

- Dates
- Products
- Customers
- Stores
- Sales transactions

---

## 03_analytics.sql

Contains solved examples for the Week 5 syllabus.

### Subqueries
- Scalar subqueries
- Correlated subqueries
- EXISTS
- NOT EXISTS

### Normalization
- 1NF
- 2NF
- 3NF

### Window Functions
- RANK
- DENSE_RANK
- LAG
- LEAD
- NTILE
- Running totals
- Window calculations

### CTE
- Normal CTE
- Recursive CTE

### Set Operations
- UNION
- INTERSECT
- EXCEPT

### Advanced Aggregation
- ROLLUP
- CUBE equivalent
- GROUPING SETS equivalent

### Views
- Standard view
- Materialized-view concept using a snapshot table

### Main Project Report
The most important query is the **Month-over-Month Growth Report**, which uses:

```text
CTE
  ↓
Monthly sales
  ↓
LAG()
  ↓
Previous month sales
  ↓
MoM growth %
```

Formula:

```text
MoM Growth % =
(Current Month Sales - Previous Month Sales)
/
Previous Month Sales × 100
```

---

## 04_exercises.sql

Contains 25 practice questions divided into:

- Beginner
- Intermediate
- Advanced
- Mini-project report tasks

Try these before checking the solved analytics file.

---

## How to Run

Use MySQL 8+.

Run in this order:

```sql
SOURCE 01_schema.sql;
SOURCE 02_seed_data.sql;
SOURCE 03_analytics.sql;
```

Then solve:

```sql
SOURCE 04_exercises.sql;
```

Or execute the files through MySQL Workbench.

---

## Technologies

- MySQL 8+
- SQL
- CTE
- Window Functions
- Dimensional Modeling
- Star Schema

## Week 5 Learning Outcome

After completing this project, you should be able to:

1. Design a basic dimensional/star schema.
2. Write scalar and correlated subqueries.
3. Use EXISTS and NOT EXISTS.
4. Apply RANK, DENSE_RANK, LAG, LEAD and NTILE.
5. Build recursive CTEs.
6. Calculate Month-over-Month growth.
7. Build running totals.
8. Use ROLLUP and understand CUBE/GROUPING SETS.
9. Create standard views.
10. Understand the materialized-view concept.
11. Build an analytical SQL report from a fact table and dimensions.
