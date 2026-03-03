CREATE DATABASE GymManagement;
GO

USE GymManagement;
GO

-- =========================
-- 1. ROLES TABLE
-- =========================
CREATE TABLE Roles (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    role_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO Roles (role_name)
VALUES ('Admin'), ('Staff'), ('Member');

-- =========================
-- 2. USERS TABLE
-- =========================
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

INSERT INTO Users (username, password, role_id)
VALUES 
('admin', '123', 1),
('staff1', '123', 2),
('member1', '123', 3),
('member2', '123', 3);

-- =========================
-- 3. MEMBERS TABLE
-- =========================
CREATE TABLE Members (
    member_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT UNIQUE,
    full_name NVARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    gender NVARCHAR(10),
    date_of_birth DATE,
    bmi DECIMAL(5,2),
    member_type VARCHAR(20) DEFAULT 'New Member',
    total_spending DECIMAL(12,2) DEFAULT 0,
    renewal_count INT DEFAULT 0,
    join_date DATE DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Members (user_id, full_name, email, phone, gender, date_of_birth)
VALUES
(3, N'Nguyen Van A', 'vana@gmail.com', '0901111111', 'Male', '1995-05-15'),
(4, N'Tran Thi B', 'thib@gmail.com', '0902222222', 'Female', '1998-03-20');

-- =========================
-- 4. SUPPLIERS TABLE
-- =========================
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY IDENTITY(1,1),
    company_name NVARCHAR(200) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    supply_type VARCHAR(50),
    address NVARCHAR(300),
    status VARCHAR(20) DEFAULT 'Active'
);

INSERT INTO Suppliers (company_name, phone, email, supply_type, address)
VALUES
(N'GymTech Co.', '02812345678', 'contact@gymtech.vn', 'Equipment', N'123 Nguyen Hue, HCM'),
(N'FitFood Vietnam', '02887654321', 'sales@fitfood.vn', 'Supplement', N'456 Le Loi, HCM'),
(N'IronMax Equipment', '02811112222', 'info@ironmax.vn', 'Equipment', N'789 Tran Hung Dao, HCM');

-- =========================
-- 5. EQUIPMENT TABLE
-- =========================
CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY IDENTITY(1,1),
    equipment_name NVARCHAR(200) NOT NULL,
    quantity INT DEFAULT 1,
    status VARCHAR(30) DEFAULT 'Active',
    purchase_date DATE,
    purchase_price DECIMAL(12,2),
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

INSERT INTO Equipment (equipment_name, quantity, status, purchase_date, purchase_price, supplier_id)
VALUES
(N'Treadmill Pro X200', 5, 'Active', '2025-01-15', 25000000, 1),
(N'Dumbbell Set 5-50kg', 10, 'Active', '2025-02-01', 15000000, 1),
(N'Bench Press Station', 3, 'Active', '2025-01-20', 18000000, 3),
(N'Cable Machine Multi', 2, 'Maintenance', '2024-06-10', 35000000, 3),
(N'Spin Bike Elite', 8, 'Active', '2025-03-01', 12000000, 1);

-- =========================
-- 6. PACKAGES TABLE
-- =========================
CREATE TABLE Packages (
    package_id INT PRIMARY KEY IDENTITY(1,1),
    package_name NVARCHAR(100),
    price DECIMAL(10,2),
    duration_month INT,
    description NVARCHAR(500),
    status VARCHAR(20) DEFAULT 'Active'
);

INSERT INTO Packages (package_name, price, duration_month, description)
VALUES
(N'Basic 1 Month', 500000, 1, N'Access to gym equipment only'),
(N'Standard 3 Months', 1350000, 3, N'Gym + Group fitness classes'),
(N'Premium 6 Months', 2500000, 6, N'All services included with locker'),
(N'VIP 12 Months', 4500000, 12, N'All services + Personal Trainer support');

-- =========================
-- 7. SERVICES TABLE
-- =========================
CREATE TABLE Services (
    service_id INT PRIMARY KEY IDENTITY(1,1),
    service_name NVARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    description NVARCHAR(500),
    status VARCHAR(20) DEFAULT 'Active'
);

INSERT INTO Services (service_name, price, description)
VALUES
(N'Personal Trainer', 2000000, N'1-on-1 PT sessions per month'),
(N'Yoga Class', 500000, N'Unlimited yoga classes per month'),
(N'Zumba Class', 500000, N'Unlimited zumba classes per month'),
(N'Boxing Class', 800000, N'Boxing training with instructor');

-- =========================
-- 8. ORDERS TABLE
-- =========================
CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    member_id INT,
    order_date DATETIME DEFAULT GETDATE(),
    status VARCHAR(20) DEFAULT 'Pending',
    total_amount DECIMAL(12,2),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

INSERT INTO Orders (member_id, status, total_amount, start_date, end_date)
VALUES
(1, 'Active', 500000, '2026-01-01', '2026-02-01'),
(2, 'Active', 1350000, '2026-01-15', '2026-04-15'),
(1, 'Expired', 2500000, '2025-01-01', '2025-07-01');

-- =========================
-- 9. ORDER DETAILS TABLE
-- =========================
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    package_id INT NULL,
    service_id INT NULL,
    item_type VARCHAR(20),
    quantity INT DEFAULT 1,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (package_id) REFERENCES Packages(package_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

INSERT INTO OrderDetails (order_id, package_id, service_id, item_type, quantity, price)
VALUES
(1, 1, NULL, 'Package', 1, 500000),
(2, 2, NULL, 'Package', 1, 1350000),
(3, 3, NULL, 'Package', 1, 2500000);

-- =========================
-- 10. PAYMENTS TABLE
-- =========================
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    payment_date DATETIME DEFAULT GETDATE(),
    amount DECIMAL(12,2),
    method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Payments (order_id, amount, method)
VALUES
(1, 500000, 'Cash'),
(2, 1350000, 'Bank Transfer'),
(3, 2500000, 'Credit Card');

-- =========================
-- 11. REVENUE TABLE
-- =========================
CREATE TABLE Revenue (
    revenue_id INT PRIMARY KEY IDENTITY(1,1),
    payment_id INT,
    revenue_date DATE DEFAULT GETDATE(),
    amount DECIMAL(12,2),
    source_type VARCHAR(50),
    FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);

INSERT INTO Revenue (payment_id, revenue_date, amount, source_type)
VALUES
(1, '2026-01-01', 500000, 'Package'),
(2, '2026-01-15', 1350000, 'Package'),
(3, '2025-01-01', 2500000, 'Package');

-- =========================
-- 12. SUBSCRIPTIONS TABLE (Module 8)
-- =========================
CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY IDENTITY(1,1),
    plan_name VARCHAR(50) NOT NULL,
    max_members INT,
    price DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);

INSERT INTO Subscriptions (plan_name, max_members, price, start_date, end_date)
VALUES
('Free', 100, 0, '2026-01-01', '2027-01-01'),
('Standard', 500, 5000000, '2026-01-01', '2027-01-01'),
('Premium', -1, 15000000, '2026-01-01', '2027-01-01');

-- =========================
-- 13. CHECK-IN HISTORY TABLE
-- =========================
CREATE TABLE CheckInHistory (
    checkin_id INT PRIMARY KEY IDENTITY(1,1),
    member_id INT,
    checkin_time DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

INSERT INTO CheckInHistory (member_id, checkin_time)
VALUES
(1, '2026-02-01 08:30:00'),
(1, '2026-02-02 09:15:00'),
(2, '2026-02-01 10:00:00'),
(1, '2026-02-03 07:45:00'),
(2, '2026-02-03 14:00:00');

-- =========================
-- USEFUL QUERIES
-- =========================

-- Total Revenue
SELECT SUM(amount) AS TotalRevenue FROM Revenue;

-- Revenue by Month
SELECT 
    YEAR(revenue_date) AS [Year],
    MONTH(revenue_date) AS [Month],
    SUM(amount) AS Revenue
FROM Revenue
GROUP BY YEAR(revenue_date), MONTH(revenue_date)
ORDER BY [Year], [Month];

-- Best selling package
SELECT TOP 1 p.package_name, COUNT(*) AS sold
FROM OrderDetails od
JOIN Packages p ON od.package_id = p.package_id
WHERE od.item_type = 'Package'
GROUP BY p.package_name
ORDER BY sold DESC;

-- Equipment needing most maintenance
SELECT equipment_name, status 
FROM Equipment 
WHERE status = 'Maintenance';
