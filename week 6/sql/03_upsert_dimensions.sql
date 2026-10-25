-- Type 1 update: keep the latest customer attributes in one current row.
INSERT INTO d_client (client_key, full_name, region, contact_email, refreshed_at)
SELECT client_key, full_name, region, contact_email, now()
FROM stg_client
WHERE client_key IS NOT NULL AND full_name IS NOT NULL
ON CONFLICT (client_key) DO UPDATE
SET full_name = EXCLUDED.full_name,
    region = EXCLUDED.region,
    contact_email = EXCLUDED.contact_email,
    refreshed_at = now();

INSERT INTO d_item (item_key, item_label, department, list_price)
SELECT item_key, item_label, department, list_price
FROM stg_item
WHERE item_key IS NOT NULL AND item_label IS NOT NULL
ON CONFLICT (item_key) DO UPDATE
SET item_label = EXCLUDED.item_label,
    department = EXCLUDED.department,
    list_price = EXCLUDED.list_price;
