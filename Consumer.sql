
CREATE DATABASE ConsumerBuyingPattern;
USE ConsumerBuyingPattern;

-- Consumer Table
CREATE TABLE Consumer (
 Consumer_ID INT PRIMARY KEY,
 Name VARCHAR(50) NOT NULL,
 Age INT,
 Gender VARCHAR(10),
 Location VARCHAR(50)
);

-- Category Table
CREATE TABLE Category (
 Category_ID INT PRIMARY KEY,
 Category_Name VARCHAR(50) NOT NULL
);

-- Product Table
CREATE TABLE Product (
 Product_ID INT PRIMARY KEY,
 Product_Name VARCHAR(50) NOT NULL,
 Category_ID INT,
 Price DECIMAL(10,2),
 FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);

-- Purchase Table
CREATE TABLE Purchase (
 Purchase_ID INT PRIMARY KEY,
 Consumer_ID INT,
 Product_ID INT,
 Quantity INT,
 Purchase_Date DATE,
 Total_Amount DECIMAL(10,2),
 FOREIGN KEY (Consumer_ID) REFERENCES Consumer(Consumer_ID),
 FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Categories Data
INSERT INTO Category VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Groceries'),
(4, 'Books'),
(5, 'Furniture');

-- Consumers 
INSERT INTO Consumer VALUES
(101, 'Rahul Sharma', 25, 'Male', 'Mumbai'),
(102, 'Priya Mehta', 30, 'Female', 'Pune'),
(103, 'Amit Verma', 28, 'Male', 'Delhi'),
(104, 'Sneha Reddy', 22, 'Female', 'Bangalore'),
(105, 'Karan Singh', 35, 'Male', 'Chennai');

-- Products 
INSERT INTO Product VALUES
(201, 'Mobile Phone', 1, 15000),
(202, 'T-Shirt', 2, 800),
(203, 'Rice 5kg', 3, 400),
(204, 'Novel - Fiction', 4, 300),
(205, 'Office Chair', 5, 5000);

-- Purchases 
INSERT INTO Purchase VALUES
(301, 101, 201, 1, '2026-02-01', 15000),
(302, 102, 202, 2, '2026-02-05', 1600),
(303, 103, 203, 5, '2026-02-08', 2000),
(304, 104, 204, 2, '2026-02-10', 600),
(305, 105, 205, 1, '2026-02-12', 5000);


-- Total Spending by Each Consumer
SELECT Name, Product_Name, Quantity, Total_Amount, Purchase_Date
FROM Consumer
JOIN Purchase ON Consumer.Consumer_ID = Purchase.Consumer_ID
JOIN Product ON Purchase.Product_ID = Product.Product_ID;


-- GROUP BY
SELECT Consumer_ID, COUNT(Purchase_ID) AS Total_Purchases
FROM Purchase
GROUP BY Consumer_ID;

-- HAVING
SELECT Consumer_ID, SUM(Total_Amount) AS Total_Spending
FROM Purchase
GROUP BY Consumer_ID
HAVING SUM(Total_Amount) > 5000;

-- Subquery
SELECT Name
FROM Consumer
WHERE Consumer_ID IN (
 SELECT Consumer_ID
 FROM Purchase
 WHERE Total_Amount > 5000
);

-- View Creation
CREATE VIEW Consumer_Purchase_View AS
SELECT Name, Product_Name, Quantity, Total_Amount, Purchase_Date
FROM Consumer
JOIN Purchase ON Consumer.Consumer_ID = Purchase.Consumer_ID
JOIN Product ON Purchase.Product_ID = Product.Product_ID;

-- Most Purchased Product
SELECT pr.product_name, SUM(p.quantity) AS total_quantity
FROM Product pr
JOIN Purchase p ON pr.product_id = p.product_id
GROUP BY pr.product_name
ORDER BY total_quantity DESC
LIMIT 1;

-- Category-wise Sales
SELECT cat.category_name, SUM(p.total_amount) AS total_sales
FROM Category cat
JOIN Product pr ON cat.category_id = pr.category_id
JOIN Purchase p ON pr.product_id = p.product_id
GROUP BY cat.category_name;

-- Monthly Sales Report
SELECT MONTH(purchase_date) AS month,
SUM(total_amount) AS monthly_sales
FROM Purchase
GROUP BY MONTH(purchase_date);

-- High-Value Customers (Spending > 5000)
SELECT c.name, SUM(p.total_amount) AS total_spent
FROM Consumer c
JOIN Purchase p ON c.consumer_id = p.consumer_id
GROUP BY c.name
HAVING SUM(p.total_amount) > 5000;