-- WEEK 5 MINI PROJECT: Exercises
-- Try these WITHOUT looking at 03_analytics.sql first.

USE week5_retail;

-- =========================================================
-- BEGINNER
-- =========================================================

-- Q1. Find total sales for each product.
-- Expected columns: product_name, total_sales


-- Q2. Find total sales for each store region.


-- Q3. Find the customer with the highest total sales.


-- Q4. Find the average sales amount per transaction.


-- =========================================================
-- INTERMEDIATE
-- =========================================================

-- Q5. Use RANK() to rank products by total sales within
-- each product category.


-- Q6. Use LAG() to calculate the previous month's total sales.


-- Q7. Calculate month-over-month sales growth percentage.


-- Q8. Use NTILE(4) to divide customers into four sales groups.


-- Q9. Find products whose sales are greater than the
-- average product sales using a scalar subquery.


-- Q10. Find customers who have at least one sale using EXISTS.


-- Q11. Find customers with no sales using NOT EXISTS.


-- Q12. Create a CTE that calculates monthly sales and then
-- returns only months where sales are greater than 100000.


-- =========================================================
-- ADVANCED
-- =========================================================

-- Q13. Create a recursive CTE that generates numbers from 1 to 12.


-- Q14. Find the top-selling product for every month using
-- ROW_NUMBER() or RANK().


-- Q15. Calculate a running total of sales month by month.


-- Q16. Calculate each product's percentage contribution
-- to total company sales.


-- Q17. Compare every month's sales with the previous month
-- using LAG() and classify the result as:
-- 'GROWTH', 'DECLINE', or 'NO CHANGE'.


-- Q18. Use ROLLUP to calculate:
-- product category + subcategory totals + grand total.


-- Q19. Reproduce a CUBE-style report using UNION ALL for:
-- category/region, category total, region total, grand total.


-- Q20. Create a view containing monthly sales.


-- Q21. Create a materialized-view-style snapshot table
-- from the monthly sales view.


-- =========================================================
-- MINI PROJECT REPORT
-- =========================================================

-- Q22. Build a final report containing:
-- month
-- total sales
-- previous month sales
-- MoM growth %
-- running total
-- monthly rank
--
-- Use at least:
-- 1 CTE
-- 1 window function
-- 1 LAG()
-- 1 aggregate function


-- Q23. Build a product performance report containing:
-- product
-- category
-- total quantity
-- total sales
-- sales rank
-- percentage of total sales
--
-- Use RANK() and a window SUM().


-- Q24. Build a customer segmentation report using NTILE(4).


-- Q25. Explain in comments why the database is a star schema
-- and identify the fact table and dimension tables.
