-- Monthly revenue by department
SELECT date_trunc('month', f.transaction_day)::date AS sales_month,
       i.department,
       SUM(f.units * f.sold_price) AS gross_revenue
FROM f_transaction AS f
JOIN d_item AS i ON i.item_key = f.item_key
GROUP BY 1, 2
ORDER BY 1, 2;

-- Inspect the planner's strategy for a date-bounded query.
EXPLAIN ANALYZE
SELECT client_key,
       SUM(units * sold_price) AS client_revenue
FROM f_transaction
WHERE transaction_day >= DATE '2026-01-01'
  AND transaction_day < DATE '2027-01-01'
GROUP BY client_key
ORDER BY client_revenue DESC;

-- JSON output example for downstream consumers
SELECT jsonb_build_object(
    'client_id', client_key,
    'customer', full_name,
    'region', region
) AS client_record
FROM d_client
ORDER BY client_key;
