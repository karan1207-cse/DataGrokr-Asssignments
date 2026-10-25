-- Load fact rows only when both dimension keys are present.
INSERT INTO f_transaction
    (transaction_key, transaction_day, client_key, item_key, units, sold_price)
SELECT s.transaction_key, s.transaction_day, s.client_key, s.item_key, s.units, s.sold_price
FROM stg_transaction AS s
JOIN d_client AS c ON c.client_key = s.client_key
JOIN d_item AS i ON i.item_key = s.item_key
WHERE s.transaction_day IS NOT NULL
  AND s.units > 0
  AND s.sold_price >= 0
ON CONFLICT (transaction_key, transaction_day) DO NOTHING;

-- Basic load reconciliation
SELECT
    (SELECT COUNT(*) FROM stg_transaction) AS staged_rows,
    (SELECT COUNT(*) FROM f_transaction) AS fact_rows;
