-- WEEK 5 MINI PROJECT: Analytics
-- Covers subqueries, window functions, CTEs, recursive CTEs,
-- UNION/INTERSECT/EXCEPT, ROLLUP/CUBE/GROUPING SETS equivalents,
-- views and materialized-view concept.

USE week5_retail;

-- =========================================================
-- 1. BASIC STAR-SCHEMA SALES REPORT
-- =========================================================

SELECT
    d.year_num,
    d.month_num,
    d.month_name,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year_num, d.month_num, d.month_name
ORDER BY d.year_num, d.month_num;


-- =========================================================
-- 2. MONTH-OVER-MONTH (MoM) GROWTH
-- =========================================================

WITH monthly_sales AS (
    SELECT
        d.year_num,
        d.month_num,
        d.month_name,
        SUM(f.sales_amount) AS total_sales
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year_num, d.month_num, d.month_name
),
mom_report AS (
    SELECT
        year_num,
        month_num,
        month_name,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY year_num, month_num
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    year_num,
    month_num,
    month_name,
    total_sales,
    previous_month_sales,
    ROUND(
        (total_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0) * 100,
        2
    ) AS mom_growth_percent
FROM mom_report
ORDER BY year_num, month_num;


-- =========================================================
-- 3. WINDOW FUNCTION REPORT
-- =========================================================

SELECT
    d.month_name,
    p.category,
    SUM(f.sales_amount) AS category_sales,
    RANK() OVER (
        PARTITION BY d.month_num
        ORDER BY SUM(f.sales_amount) DESC
    ) AS category_rank,
    DENSE_RANK() OVER (
        PARTITION BY d.month_num
        ORDER BY SUM(f.sales_amount) DESC
    ) AS dense_category_rank
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY d.month_num, d.month_name, p.category
ORDER BY d.month_num, category_rank;


-- =========================================================
-- 4. PRODUCT SALES WITH LAG / LEAD
-- =========================================================

WITH product_monthly AS (
    SELECT
        p.product_name,
        d.year_num,
        d.month_num,
        SUM(f.sales_amount) AS sales
    FROM fact_sales f
    JOIN dim_product p ON f.product_key = p.product_key
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY p.product_name, d.year_num, d.month_num
)
SELECT
    product_name,
    year_num,
    month_num,
    sales,
    LAG(sales) OVER (
        PARTITION BY product_name
        ORDER BY year_num, month_num
    ) AS previous_month_sales,
    LEAD(sales) OVER (
        PARTITION BY product_name
        ORDER BY year_num, month_num
    ) AS next_month_sales
FROM product_monthly
ORDER BY product_name, year_num, month_num;


-- =========================================================
-- 5. NTILE: CUSTOMER VALUE SEGMENTS
-- =========================================================

WITH customer_sales AS (
    SELECT
        c.customer_key,
        c.customer_name,
        SUM(f.sales_amount) AS total_sales
    FROM fact_sales f
    JOIN dim_customer c ON f.customer_key = c.customer_key
    GROUP BY c.customer_key, c.customer_name
)
SELECT
    customer_name,
    total_sales,
    NTILE(4) OVER (ORDER BY total_sales DESC) AS customer_quartile
FROM customer_sales;


-- =========================================================
-- 6. RUNNING TOTAL
-- =========================================================

WITH monthly_sales AS (
    SELECT
        d.year_num,
        d.month_num,
        d.month_name,
        SUM(f.sales_amount) AS total_sales
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year_num, d.month_num, d.month_name
)
SELECT
    month_name,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY year_num, month_num
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_sales
FROM monthly_sales
ORDER BY year_num, month_num;


-- =========================================================
-- 7. SCALAR SUBQUERY
-- Products whose total sales exceed the average product sales
-- =========================================================

WITH product_sales AS (
    SELECT
        p.product_name,
        SUM(f.sales_amount) AS total_sales
    FROM fact_sales f
    JOIN dim_product p ON f.product_key = p.product_key
    GROUP BY p.product_name
)
SELECT product_name, total_sales
FROM product_sales
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM product_sales
);


-- =========================================================
-- 8. CORRELATED SUBQUERY
-- Customers whose order/sales total exceeds their segment average
-- =========================================================

SELECT
    c.customer_name,
    c.customer_segment,
    (
        SELECT SUM(f2.sales_amount)
        FROM fact_sales f2
        WHERE f2.customer_key = c.customer_key
    ) AS customer_sales
FROM dim_customer c
WHERE (
    SELECT SUM(f2.sales_amount)
    FROM fact_sales f2
    WHERE f2.customer_key = c.customer_key
) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(f3.sales_amount) AS customer_total
        FROM fact_sales f3
        GROUP BY f3.customer_key
    ) x
);


-- =========================================================
-- 9. EXISTS / NOT EXISTS
-- =========================================================

SELECT c.customer_name
FROM dim_customer c
WHERE EXISTS (
    SELECT 1
    FROM fact_sales f
    WHERE f.customer_key = c.customer_key
);

SELECT c.customer_name
FROM dim_customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM fact_sales f
    WHERE f.customer_key = c.customer_key
);


-- =========================================================
-- 10. RECURSIVE CTE
-- Demonstration: generate month numbers 1 to 12
-- =========================================================

WITH RECURSIVE months AS (
    SELECT 1 AS month_num
    UNION ALL
    SELECT month_num + 1
    FROM months
    WHERE month_num < 12
)
SELECT * FROM months;


-- =========================================================
-- 11. UNION
-- =========================================================

SELECT city FROM dim_customer
UNION
SELECT city FROM dim_store;


-- =========================================================
-- 12. INTERSECT
-- MySQL 8.0.31+ supports INTERSECT.
-- =========================================================

SELECT city FROM dim_customer
INTERSECT
SELECT city FROM dim_store;


-- =========================================================
-- 13. EXCEPT
-- MySQL 8.0.31+ supports EXCEPT.
-- =========================================================

SELECT city FROM dim_customer
EXCEPT
SELECT city FROM dim_store;


-- =========================================================
-- 14. ROLLUP
-- =========================================================

SELECT
    p.category,
    p.subcategory,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.category, p.subcategory WITH ROLLUP;


-- =========================================================
-- 15. CUBE EQUIVALENT
-- MySQL does not provide a native CUBE clause.
-- UNION ALL represents the grouping combinations.
-- =========================================================

SELECT
    p.category,
    s.region,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_store s ON f.store_key = s.store_key
GROUP BY p.category, s.region

UNION ALL

SELECT
    p.category,
    NULL,
    SUM(f.sales_amount)
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_store s ON f.store_key = s.store_key
GROUP BY p.category

UNION ALL

SELECT
    NULL,
    s.region,
    SUM(f.sales_amount)
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_store s ON f.store_key = s.store_key
GROUP BY s.region

UNION ALL

SELECT
    NULL,
    NULL,
    SUM(sales_amount)
FROM fact_sales;


-- =========================================================
-- 16. GROUPING SETS EQUIVALENT
-- =========================================================

SELECT category, region, total_sales
FROM (
    SELECT
        p.category,
        s.region,
        SUM(f.sales_amount) AS total_sales
    FROM fact_sales f
    JOIN dim_product p ON f.product_key = p.product_key
    JOIN dim_store s ON f.store_key = s.store_key
    GROUP BY p.category, s.region

    UNION ALL

    SELECT
        p.category,
        NULL,
        SUM(f.sales_amount)
    FROM fact_sales f
    JOIN dim_product p ON f.product_key = p.product_key
    GROUP BY p.category

    UNION ALL

    SELECT
        NULL,
        s.region,
        SUM(f.sales_amount)
    FROM fact_sales f
    JOIN dim_store s ON f.store_key = s.store_key
    GROUP BY s.region
) x;


-- =========================================================
-- 17. STANDARD VIEW
-- =========================================================

CREATE OR REPLACE VIEW monthly_sales_view AS
SELECT
    d.year_num,
    d.month_num,
    d.month_name,
    SUM(f.sales_amount) AS total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year_num, d.month_num, d.month_name;

SELECT * FROM monthly_sales_view;


-- =========================================================
-- 18. MATERIALIZED VIEW CONCEPT
-- MySQL has no native CREATE MATERIALIZED VIEW.
-- Create a physical snapshot table instead.
-- =========================================================

DROP TABLE IF EXISTS mv_monthly_sales;

CREATE TABLE mv_monthly_sales AS
SELECT * FROM monthly_sales_view;

SELECT * FROM mv_monthly_sales;

-- Refresh the snapshot when required:
TRUNCATE TABLE mv_monthly_sales;

INSERT INTO mv_monthly_sales
SELECT * FROM monthly_sales_view;


-- =========================================================
-- 19. NORMALIZATION EXAMPLE
-- =========================================================
-- The dimensional model avoids repeating descriptive attributes
-- inside fact_sales. Product, customer, store and date details
-- are stored separately and linked through surrogate keys.
--
-- 1NF: atomic values; no repeating groups.
-- 2NF: non-key attributes depend on the complete key.
-- 3NF: non-key attributes depend only on the key, not another
--      non-key attribute.
