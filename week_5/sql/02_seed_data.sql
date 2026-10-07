-- WEEK 5 MINI PROJECT: Seed Data
USE week5_retail;

-- =========================
-- DATE DIMENSION
-- =========================

INSERT INTO dim_date VALUES
(20250101, '2025-01-05', 2025, 1, 1, 'January'),
(20250115, '2025-01-15', 2025, 1, 1, 'January'),
(20250205, '2025-02-05', 2025, 1, 2, 'February'),
(20250218, '2025-02-18', 2025, 1, 2, 'February'),
(20250307, '2025-03-07', 2025, 1, 3, 'March'),
(20250321, '2025-03-21', 2025, 1, 3, 'March'),
(20250410, '2025-04-10', 2025, 2, 4, 'April'),
(20250425, '2025-04-25', 2025, 2, 4, 'April'),
(20250508, '2025-05-08', 2025, 2, 5, 'May'),
(20250522, '2025-05-22', 2025, 2, 5, 'May'),
(20250606, '2025-06-06', 2025, 2, 6, 'June'),
(20250620, '2025-06-20', 2025, 2, 6, 'June');

-- =========================
-- PRODUCT DIMENSION
-- =========================

INSERT INTO dim_product
(product_name, category, subcategory, unit_price)
VALUES
('Laptop Pro 14', 'Electronics', 'Laptop', 85000),
('Smartphone X', 'Electronics', 'Mobile', 45000),
('Wireless Headphones', 'Electronics', 'Audio', 6000),
('Office Chair', 'Furniture', 'Chair', 12000),
('Standing Desk', 'Furniture', 'Desk', 25000),
('Backpack', 'Accessories', 'Bag', 2500);

-- =========================
-- CUSTOMER DIMENSION
-- =========================

INSERT INTO dim_customer
(customer_name, city, state, customer_segment)
VALUES
('Aarav Sharma', 'Bangalore', 'Karnataka', 'Premium'),
('Priya Nair', 'Chennai', 'Tamil Nadu', 'Regular'),
('Rahul Verma', 'Mumbai', 'Maharashtra', 'Premium'),
('Ananya Rao', 'Hyderabad', 'Telangana', 'Regular'),
('Vikram Singh', 'Delhi', 'Delhi', 'Corporate'),
('Sneha Iyer', 'Bangalore', 'Karnataka', 'Corporate');

-- =========================
-- STORE DIMENSION
-- =========================

INSERT INTO dim_store
(store_name, city, region)
VALUES
('Bangalore Central', 'Bangalore', 'South'),
('Chennai Central', 'Chennai', 'South'),
('Mumbai Central', 'Mumbai', 'West'),
('Delhi Central', 'Delhi', 'North');

-- =========================
-- FACT SALES
-- =========================

INSERT INTO fact_sales
(date_key, product_key, customer_key, store_key, quantity, unit_price, discount, sales_amount)
VALUES
(20250101, 1, 1, 1, 1, 85000, 2000, 83000),
(20250115, 2, 2, 2, 2, 45000, 3000, 87000),
(20250115, 3, 3, 3, 3, 6000, 500, 17500),

(20250205, 1, 4, 2, 1, 85000, 5000, 80000),
(20250218, 4, 5, 4, 2, 12000, 1000, 23000),
(20250218, 6, 2, 2, 5, 2500, 500, 12000),

(20250307, 2, 1, 1, 1, 45000, 2000, 43000),
(20250321, 5, 6, 1, 2, 25000, 2000, 48000),
(20250321, 3, 3, 3, 4, 6000, 1000, 23000),

(20250410, 1, 5, 4, 1, 85000, 3000, 82000),
(20250425, 4, 2, 2, 3, 12000, 1500, 34500),
(20250425, 6, 4, 2, 6, 2500, 500, 14500),

(20250508, 2, 3, 3, 2, 45000, 4000, 86000),
(20250522, 5, 6, 1, 1, 25000, 1000, 24000),
(20250522, 3, 1, 1, 5, 6000, 1500, 28500),

(20250606, 1, 1, 1, 1, 85000, 5000, 80000),
(20250620, 2, 5, 4, 2, 45000, 3000, 87000),
(20250620, 4, 2, 2, 2, 12000, 500, 23500);
