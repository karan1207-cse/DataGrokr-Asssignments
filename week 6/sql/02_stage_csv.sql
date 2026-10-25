-- Load source files into staging. Execute with psql from the project root.
TRUNCATE stg_client, stg_item, stg_transaction;

\copy stg_client(client_key, full_name, region, contact_email) FROM 'data/clients_initial.csv' WITH (FORMAT csv, HEADER true)
\copy stg_item(item_key, item_label, department, list_price) FROM 'data/items.csv' WITH (FORMAT csv, HEADER true)
\copy stg_transaction(transaction_key, transaction_day, client_key, item_key, units, sold_price) FROM 'data/transactions.csv' WITH (FORMAT csv, HEADER true)

-- Simple ingestion audit
SELECT 'clients' AS source_name, COUNT(*) AS loaded_rows FROM stg_client
UNION ALL
SELECT 'items', COUNT(*) FROM stg_item
UNION ALL
SELECT 'transactions', COUNT(*) FROM stg_transaction;
