-- Useful for client/date filtering and item-based reporting.
CREATE INDEX IF NOT EXISTS ix_f_transaction_client_day
    ON f_transaction (client_key, transaction_day);

CREATE INDEX IF NOT EXISTS ix_f_transaction_item
    ON f_transaction (item_key);

ANALYZE d_client;
ANALYZE d_item;
ANALYZE f_transaction;
