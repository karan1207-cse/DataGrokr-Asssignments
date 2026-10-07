-- Week 4 SQL Sample Data
USE week4_sql;

INSERT INTO departments VALUES
(1, 'IT', 'Bangalore'),
(2, 'HR', 'Mumbai'),
(3, 'Finance', 'Chennai'),
(4, 'Marketing', 'Delhi'),
(5, 'Operations', 'Hyderabad');

INSERT INTO employees VALUES
(101, 'Rahul Sharma', 'rahul@company.com', 1, NULL, 90000, '2022-01-10', 'Manager'),
(102, 'Amit Kumar', 'amit@company.com', 1, 101, 75000, '2023-03-15', 'Developer'),
(103, 'Priya Singh', 'priya@company.com', 1, 101, 82000, '2022-08-20', 'Developer'),
(104, 'Neha Patel', 'neha@company.com', 2, NULL, 65000, '2021-06-12', 'HR Manager'),
(105, 'Arjun Rao', 'arjun@company.com', 2, 104, NULL, '2024-02-05', 'HR Executive'),
(106, 'Sneha Iyer', 'sneha@company.com', 3, NULL, 78000, '2020-11-25', 'Accountant'),
(107, 'Vikram Das', 'vikram@company.com', 3, 106, 72000, '2023-07-19', 'Analyst'),
(108, 'Kiran Reddy', 'kiran@company.com', 4, NULL, 70000, '2022-04-01', 'Marketing Manager'),
(109, 'Ananya Gupta', 'ananya@company.com', 4, 108, 58000, '2024-01-18', 'Marketing Executive'),
(110, 'Rohan Mehta', 'rohan@company.com', NULL, NULL, 50000, '2025-01-10', 'Intern');

INSERT INTO projects VALUES
(201, 'Cloud Migration', 1, 500000, '2025-01-01', NULL),
(202, 'Mobile Application', 1, 300000, '2025-03-10', '2025-12-31'),
(203, 'Recruitment Portal', 2, 150000, '2025-02-01', NULL),
(204, 'Financial Dashboard', 3, 250000, '2024-10-01', '2025-08-31'),
(205, 'Marketing Campaign', 4, 180000, '2025-04-15', NULL);

INSERT INTO employee_projects VALUES
(101, 201, 300),
(102, 201, 420),
(103, 201, 380),
(102, 202, 250),
(103, 202, 300),
(104, 203, 200),
(105, 203, 350),
(106, 204, 400),
(107, 204, 450),
(108, 205, 320),
(109, 205, 280);

INSERT INTO customers VALUES
(1, 'Alice', 'alice@gmail.com', 'Bangalore', '2024-01-10'),
(2, 'Bob', 'bob@gmail.com', 'Mumbai', '2024-02-15'),
(3, 'Charlie', 'charlie@gmail.com', 'Chennai', '2024-03-20'),
(4, 'David', 'david@gmail.com', 'Delhi', '2024-05-01'),
(5, 'Eva', 'eva@gmail.com', 'Bangalore', '2025-01-12');

INSERT INTO orders VALUES
(1001, 1, '2025-01-05', 2500, 'Completed'),
(1002, 1, '2025-02-10', 4500, 'Completed'),
(1003, 2, '2025-02-15', 1200, 'Pending'),
(1004, 3, '2025-03-12', 7000, 'Completed'),
(1005, 3, '2025-04-18', 3200, 'Cancelled'),
(1006, 4, '2025-05-20', 5600, 'Completed'),
(1007, 5, '2025-06-10', 2800, 'Pending');
