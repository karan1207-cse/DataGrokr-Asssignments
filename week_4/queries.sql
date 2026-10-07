-- WEEK 4 SQL PRACTICE
-- Run schema.sql first, then data.sql.
USE week4_sql;

-- =========================================================
-- 1. NULL HANDLING
-- =========================================================

-- Employees whose salary is NULL
SELECT * FROM employees WHERE salary IS NULL;

-- Replace NULL salary with 0
SELECT emp_name, COALESCE(salary, 0) AS salary
FROM employees;

-- NULLIF: returns NULL when two values are equal
SELECT emp_name, NULLIF(salary, 0) AS salary
FROM employees;

-- Department employees including those without a department
SELECT e.emp_name, COALESCE(d.department_name, 'Not Assigned') AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;


-- =========================================================
-- 2. AGGREGATE FUNCTIONS, GROUP BY, HAVING
-- =========================================================

SELECT COUNT(*) AS total_employees FROM employees;

SELECT COUNT(salary) AS employees_with_salary FROM employees;

SELECT SUM(salary) AS total_salary FROM employees;

SELECT AVG(salary) AS average_salary FROM employees;

SELECT MIN(salary) AS minimum_salary, MAX(salary) AS maximum_salary
FROM employees;

SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;

SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 70000;


-- =========================================================
-- 3. JOINS
-- =========================================================

-- INNER JOIN
SELECT e.emp_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

-- LEFT JOIN
SELECT e.emp_name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

-- RIGHT JOIN
SELECT e.emp_name, d.department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;

-- FULL OUTER JOIN equivalent in MySQL
SELECT e.emp_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
UNION
SELECT e.emp_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

-- Three-table JOIN
SELECT e.emp_name, p.project_name, ep.hours_worked
FROM employees e
JOIN employee_projects ep ON e.emp_id = ep.emp_id
JOIN projects p ON ep.project_id = p.project_id;


-- =========================================================
-- 4. CASE WHEN
-- =========================================================

SELECT emp_name, salary,
CASE
    WHEN salary >= 80000 THEN 'High'
    WHEN salary >= 60000 THEN 'Medium'
    WHEN salary IS NULL THEN 'Not Available'
    ELSE 'Low'
END AS salary_category
FROM employees;


-- =========================================================
-- 5. STRING FUNCTIONS
-- =========================================================

SELECT emp_name, UPPER(emp_name) AS upper_name
FROM employees;

SELECT emp_name, LOWER(emp_name) AS lower_name
FROM employees;

SELECT emp_name, LENGTH(emp_name) AS name_length
FROM employees;

SELECT CONCAT(emp_name, ' - ', job_role) AS employee_details
FROM employees;

SELECT TRIM('   SQL Practice   ') AS trimmed_text;

SELECT SUBSTRING(emp_name, 1, 5) AS short_name
FROM employees;


-- =========================================================
-- 6. DATE / TIME FUNCTIONS
-- =========================================================

SELECT emp_name, YEAR(joining_date) AS joining_year
FROM employees;

SELECT emp_name, MONTH(joining_date) AS joining_month
FROM employees;

SELECT emp_name, DATEDIFF(CURDATE(), joining_date) AS days_worked
FROM employees;

SELECT emp_name, joining_date
FROM employees
WHERE joining_date >= '2024-01-01';


-- =========================================================
-- 7. DDL AND CONSTRAINTS
-- =========================================================

CREATE TABLE demo_table (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18)
);

ALTER TABLE demo_table ADD COLUMN city VARCHAR(50);

ALTER TABLE demo_table MODIFY COLUMN name VARCHAR(100) NOT NULL;

DROP TABLE IF EXISTS demo_table;


-- =========================================================
-- 8. SCALAR SUBQUERY
-- =========================================================

-- Employees earning more than average salary
SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


-- =========================================================
-- 9. CORRELATED SUBQUERY
-- =========================================================

-- Employees earning more than their department average
SELECT e.emp_name, e.department_id, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);


-- =========================================================
-- 10. EXISTS / NOT EXISTS
-- =========================================================

SELECT d.department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);

SELECT d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);


-- =========================================================
-- 11. WINDOW FUNCTIONS
-- =========================================================

SELECT emp_name, department_id, salary,
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;

SELECT emp_name, department_id, salary,
DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dense_rank
FROM employees;

SELECT emp_name, salary,
LAG(salary) OVER (ORDER BY salary) AS previous_salary
FROM employees;

SELECT emp_name, salary,
LEAD(salary) OVER (ORDER BY salary) AS next_salary
FROM employees;

SELECT emp_name, salary,
NTILE(4) OVER (ORDER BY salary DESC) AS salary_quartile
FROM employees;

SELECT emp_name, salary,
SUM(salary) OVER (
    ORDER BY joining_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_salary
FROM employees;


-- =========================================================
-- 12. CTE
-- =========================================================

WITH high_salary AS (
    SELECT emp_name, salary
    FROM employees
    WHERE salary > 70000
)
SELECT * FROM high_salary;


-- Department average salary using CTE
WITH dept_avg AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT d.department_name, da.avg_salary
FROM dept_avg da
JOIN departments d ON da.department_id = d.department_id;


-- =========================================================
-- 13. RECURSIVE CTE
-- =========================================================

WITH RECURSIVE employee_hierarchy AS (
    SELECT emp_id, emp_name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.emp_id, e.emp_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh
    ON e.manager_id = eh.emp_id
)
SELECT * FROM employee_hierarchy
ORDER BY level, emp_id;


-- =========================================================
-- 14. UNION / INTERSECT / EXCEPT
-- =========================================================

SELECT city FROM customers
UNION
SELECT location FROM departments;

SELECT city FROM customers
INTERSECT
SELECT location FROM departments;

SELECT city FROM customers
EXCEPT
SELECT location FROM departments;


-- =========================================================
-- 15. ROLLUP
-- =========================================================

SELECT department_id, job_role, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id, job_role WITH ROLLUP;


-- =========================================================
-- 16. CUBE
-- =========================================================
-- MySQL does not support CUBE directly.
-- Equivalent grouping combinations can be produced with UNION ALL.

SELECT department_id, job_role, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id, job_role

UNION ALL

SELECT department_id, NULL, COUNT(*)
FROM employees
GROUP BY department_id

UNION ALL

SELECT NULL, job_role, COUNT(*)
FROM employees
GROUP BY job_role

UNION ALL

SELECT NULL, NULL, COUNT(*)
FROM employees;


-- =========================================================
-- 17. GROUPING SETS
-- =========================================================
-- MySQL does not support GROUPING SETS directly.
-- Use UNION ALL for equivalent results.

SELECT department_id, job_role, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id, job_role

UNION ALL

SELECT department_id, NULL, COUNT(*)
FROM employees
GROUP BY department_id

UNION ALL

SELECT NULL, job_role, COUNT(*)
FROM employees
GROUP BY job_role;


-- =========================================================
-- 18. VIEWS
-- =========================================================

CREATE OR REPLACE VIEW employee_department_view AS
SELECT e.emp_id, e.emp_name, d.department_name, e.salary
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

SELECT * FROM employee_department_view;


-- =========================================================
-- 19. MATERIALIZED VIEW
-- =========================================================
-- MySQL has no native CREATE MATERIALIZED VIEW statement.
-- A table can be used as a materialized snapshot.

DROP TABLE IF EXISTS department_salary_summary;

CREATE TABLE department_salary_summary AS
SELECT department_id, AVG(salary) AS avg_salary, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id;

SELECT * FROM department_salary_summary;


-- =========================================================
-- 20. ASSESSMENT-STYLE QUESTIONS
-- =========================================================

-- Q1. Find the second-highest salary.
SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

-- Q2. Find the highest-paid employee in every department.
SELECT *
FROM (
    SELECT e.*,
           RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS rnk
    FROM employees e
) x
WHERE rnk = 1;

-- Q3. Find departments having more than 2 employees.
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Q4. Find customers whose total order amount is above 5000.
SELECT c.customer_name, SUM(o.amount) AS total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 5000;

-- Q5. Find the top 3 salaries.
SELECT emp_name, salary
FROM employees
WHERE salary IS NOT NULL
ORDER BY salary DESC
LIMIT 3;

-- Q6. Find employees who are not assigned to any department.
SELECT emp_name
FROM employees
WHERE department_id IS NULL;

-- Q7. Find employees who work on at least one project.
SELECT DISTINCT e.emp_name
FROM employees e
JOIN employee_projects ep ON e.emp_id = ep.emp_id;

-- Q8. Find each employee's salary and difference from department average.
SELECT emp_name, department_id, salary,
       salary - AVG(salary) OVER (PARTITION BY department_id) AS difference_from_avg
FROM employees;

-- Q9. Find the latest employee in each department.
SELECT *
FROM (
    SELECT e.*,
           ROW_NUMBER() OVER (
               PARTITION BY department_id
               ORDER BY joining_date DESC
           ) AS rn
    FROM employees e
) x
WHERE rn = 1;

-- Q10. Count completed, pending and cancelled orders.
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status;
