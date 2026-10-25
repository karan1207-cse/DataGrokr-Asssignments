-- Simulate a later source delivery containing changed and newly added clients.
TRUNCATE stg_client;
\copy stg_client(client_key, full_name, region, contact_email) FROM 'data/clients_delta.csv' WITH (FORMAT csv, HEADER true)

INSERT INTO d_client (client_key, full_name, region, contact_email, refreshed_at)
SELECT client_key, full_name, region, contact_email, now()
FROM stg_client
WHERE client_key IS NOT NULL AND full_name IS NOT NULL
ON CONFLICT (client_key) DO UPDATE
SET full_name = EXCLUDED.full_name,
    region = EXCLUDED.region,
    contact_email = EXCLUDED.contact_email,
    refreshed_at = now();

SELECT client_key, full_name, region, refreshed_at
FROM d_client
ORDER BY client_key;
