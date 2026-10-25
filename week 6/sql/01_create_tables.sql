-- Retail analytics model: staging, dimensions, and a date-partitioned fact.
CREATE TABLE IF NOT EXISTS stg_client (
    client_key INTEGER,
    full_name TEXT,
    region TEXT,
    contact_email TEXT
);

CREATE TABLE IF NOT EXISTS stg_item (
    item_key INTEGER,
    item_label TEXT,
    department TEXT,
    list_price NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS stg_transaction (
    transaction_key INTEGER,
    transaction_day DATE,
    client_key INTEGER,
    item_key INTEGER,
    units INTEGER,
    sold_price NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS d_client (
    client_key INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    region TEXT,
    contact_email TEXT,
    refreshed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS d_item (
    item_key INTEGER PRIMARY KEY,
    item_label TEXT NOT NULL,
    department TEXT,
    list_price NUMERIC(10,2) NOT NULL CHECK (list_price >= 0)
);

CREATE TABLE IF NOT EXISTS f_transaction (
    transaction_key INTEGER NOT NULL,
    transaction_day DATE NOT NULL,
    client_key INTEGER NOT NULL REFERENCES d_client(client_key),
    item_key INTEGER NOT NULL REFERENCES d_item(item_key),
    units INTEGER NOT NULL CHECK (units > 0),
    sold_price NUMERIC(10,2) NOT NULL CHECK (sold_price >= 0),
    PRIMARY KEY (transaction_key, transaction_day)
) PARTITION BY RANGE (transaction_day);

CREATE TABLE IF NOT EXISTS f_transaction_2025
    PARTITION OF f_transaction
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE IF NOT EXISTS f_transaction_2026
    PARTITION OF f_transaction
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
