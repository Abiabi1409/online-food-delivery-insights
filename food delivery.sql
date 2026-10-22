CREATE DATABASE food_delivery;
USE food_delivery;

# Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

# Insert customer values
INSERT INTO customers (customer_id, customer_name, city)
VALUES
(1, 'Arun', 'Chennai'),
(2, 'Priya', 'Madurai'),
(3, 'Rahul', 'Coimbatore'),
(4, 'Divya', 'Chennai'),
(5, 'Karthik', 'Madurai'),
(6, 'Sneha', 'Trichy'),
(7, 'Vijay', 'Chennai'),
(8, 'Anitha', 'Coimbatore');

SELECT * FROM customers;

# Create restaurants table
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(50),
    cuisine VARCHAR(50)
);

#Insert restaurant values
INSERT INTO restaurants (restaurant_id, name, cuisine)
VALUES
(101, 'Anjappar', 'South Indian'),
(102, 'Dominos', 'Pizza'),
(103, 'A2B', 'Indian'),
(104, 'Burger King', 'Fast Food'),
(105, 'Behrouz Biryani', 'Biryani'),
(106, 'Saravana Bhavan', 'South Indian');

SELECT * FROM restaurants;

# Create orders table

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date DATETIME,
    amount DECIMAL(10,2)
);

# Insert order values

INSERT INTO orders (order_id, customer_id, restaurant_id, order_date, amount)
VALUES
(1001, 1, 101, '2026-09-01 12:30:00', 450.00),
(1002, 2, 102, '2026-09-01 19:45:00', 650.00),
(1003, 3, 103, '2026-09-02 13:15:00', 300.00),
(1004, 1, 105, '2026-09-02 20:30:00', 750.00),
(1005, 4, 104, '2026-09-03 18:45:00', 500.00),
(1006, 5, 101, '2026-09-03 12:15:00', 400.00),
(1007, 2, 105, '2026-09-04 21:00:00', 850.00),
(1008, 6, 106, '2026-09-04 13:30:00', 350.00),
(1009, 1, 102, '2026-09-05 19:30:00', 600.00),
(1010, 7, 104, '2026-09-05 20:15:00', 550.00),
(1011, 3, 101, '2026-09-06 12:45:00', 450.00),
(1012, 5, 105, '2026-09-06 21:30:00', 900.00),
(1013, 4, 103, '2026-09-07 13:00:00', 350.00),
(1014, 2, 102, '2026-09-07 19:00:00', 700.00),
(1015, 1, 106, '2026-09-08 20:45:00', 500.00);

SELECT * FROM orders;

# RATINGS TABLE

CREATE TABLE ratings (
    rating_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    score DECIMAL(2,1)
);

# Insert rating values

INSERT INTO ratings (rating_id, customer_id, restaurant_id, score)
VALUES
(1, 1, 101, 4.5),
(2, 2, 102, 4.0),
(3, 3, 103, 4.2),
(4, 1, 105, 4.8),
(5, 4, 104, 3.9),
(6, 5, 101, 4.3),
(7, 2, 105, 4.7),
(8, 6, 106, 4.1),
(9, 1, 102, 4.4),
(10, 7, 104, 3.8),
(11, 3, 101, 4.6),
(12, 5, 105, 4.9);

SELECT * FROM ratings;

SHOW TABLES;


# Check all records

SELECT * FROM customers;
SELECT * FROM restaurants;
SELECT * FROM orders;
SELECT * FROM ratings;

# Check table structure

DESC customers;
DESC restaurants;
DESC orders;
DESC ratings;


#Count Customers
SELECT COUNT(*) AS TotalCustomers
FROM customers;

# Count Restaurants
SELECT COUNT(*) AS TotalRestaurants
FROM restaurants;

# Count Orders
SELECT COUNT(*) AS TotalOrders
FROM orders;

# Count Ratings
SELECT COUNT(*) AS TotalRatings
FROM ratings;

# Check unique customers

SELECT DISTINCT city
FROM customers;

# Check different cuisines

SELECT DISTINCT cuisine
FROM restaurants;

#CHECK FOR MISSING DATA

# Check missing customer names

SELECT * FROM customers
WHERE customer_name IS NULL;

# Check missing cities

SELECT * FROM customers
WHERE city IS NULL;

#Check missing restaurant names

SELECT * FROM restaurants
WHERE name IS NULL;

#Check missing cuisine

SELECT * FROM restaurants
WHERE cuisine IS NULL;

# Check missing order customer IDs

SELECT * FROM orders
WHERE customer_id IS NULL;

# Check missing restaurant IDs in orders

SELECT * FROM orders
WHERE restaurant_id IS NULL;

# Check missing order dates

SELECT * FROM orders
WHERE order_date IS NULL;

# Check missing amounts

SELECT * FROM orders
WHERE amount IS NULL;

# Check missing rating scores

SELECT * FROM ratings
WHERE score IS NULL;

#CHECK FOR DUPLICATE DATA

# Check duplicate customer IDs

SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

# Check duplicate restaurant IDs

SELECT restaurant_id, COUNT(*)
FROM restaurants
GROUP BY restaurant_id
HAVING COUNT(*) > 1;

# Check duplicate order IDs

SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

# Check duplicate rating IDs

SELECT rating_id, COUNT(*)
FROM ratings
GROUP BY rating_id
HAVING COUNT(*) > 1;

# CHECK FOR INCONSISTENT DATA

# Check negative or zero order amounts

SELECT * FROM orders
WHERE amount <= 0;

# Check invalid ratings

SELECT * FROM ratings
WHERE score < 1 OR score > 5;

# CHECK CUSTOMER IDs IN ORDERS

SELECT orders.order_id, orders.customer_id
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
WHERE customers.customer_id IS NULL;

#CHECK RESTAURANT IDs IN ORDERS

SELECT orders.order_id, orders.restaurant_id
FROM orders
LEFT JOIN restaurants
ON orders.restaurant_id = restaurants.restaurant_id
WHERE restaurants.restaurant_id IS NULL;

# CHECK RESTAURANT IDs IN RATINGS

SELECT ratings.rating_id, ratings.restaurant_id
FROM ratings
LEFT JOIN restaurants
ON ratings.restaurant_id = restaurants.restaurant_id
WHERE restaurants.restaurant_id IS NULL;

# CHECK CUSTOMER IDs IN RATINGS

SELECT ratings.rating_id, ratings.customer_id
FROM ratings
LEFT JOIN customers
ON ratings.customer_id = customers.customer_id
WHERE customers.customer_id IS NULL;

# RESTAURANT PERFORMANCE

#View restaurant and order data together

SELECT
restaurants.name,
orders.order_id,
orders.amount
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id;

# Total orders for each restaurant

SELECT
restaurants.name,
COUNT(orders.order_id) AS TotalOrders
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id
GROUP BY restaurants.name;

# Total revenue for each restaurant

SELECT
restaurants.name,
SUM(orders.amount) AS TotalRevenue
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id
GROUP BY restaurants.name;

# Restaurants by total orders

SELECT
restaurants.name,
COUNT(orders.order_id) AS TotalOrders
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id
GROUP BY restaurants.name
ORDER BY TotalOrders DESC;

# Top 3 restaurants by total orders

SELECT
restaurants.name,
COUNT(orders.order_id) AS TotalOrders
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id
GROUP BY restaurants.name
ORDER BY TotalOrders DESC
LIMIT 3;


# Restaurants by total revenue

SELECT
restaurants.name,
SUM(orders.amount) AS TotalRevenue
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id
GROUP BY restaurants.name
ORDER BY TotalRevenue DESC;

# Top 3 restaurants by revenue

SELECT
restaurants.name,
SUM(orders.amount) AS TotalRevenue
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id
GROUP BY restaurants.name
ORDER BY TotalRevenue DESC
LIMIT 3;

# Average rating for each restaurant

SELECT
restaurants.name,
AVG(ratings.score) AS AverageRating
FROM restaurants
JOIN ratings
ON restaurants.restaurant_id = ratings.restaurant_id
GROUP BY restaurants.name;

# Sort restaurants by average rating

SELECT
restaurants.name,
AVG(ratings.score) AS AverageRating
FROM restaurants
JOIN ratings
ON restaurants.restaurant_id = ratings.restaurant_id
GROUP BY restaurants.name
ORDER BY AverageRating DESC;

# Top 3 restaurants by average rating

SELECT
restaurants.name,
AVG(ratings.score) AS AverageRating
FROM restaurants
JOIN ratings
ON restaurants.restaurant_id = ratings.restaurant_id
GROUP BY restaurants.name
ORDER BY AverageRating DESC
LIMIT 3;

# Restaurant Performance — Combined View

SELECT
restaurants.name,
COUNT(orders.order_id) AS TotalOrders,
SUM(orders.amount) AS TotalRevenue
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id
GROUP BY restaurants.name
ORDER BY TotalRevenue DESC;

# Restaurant Performance with Average Rating

# Total Orders
SELECT
restaurants.name,
COUNT(orders.order_id) AS TotalOrders
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id
GROUP BY restaurants.name
ORDER BY TotalOrders DESC;

# Total Revenue
SELECT
restaurants.name,
SUM(orders.amount) AS TotalRevenue
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id
GROUP BY restaurants.name
ORDER BY TotalRevenue DESC;

# Average Rating
SELECT
restaurants.name,
AVG(ratings.score) AS AverageRating
FROM restaurants
JOIN ratings
ON restaurants.restaurant_id = ratings.restaurant_id
GROUP BY restaurants.name
ORDER BY AverageRating DESC;


# CUSTOMER LOYALTY

# Count orders for each customer

SELECT
customer_id,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY customer_id;

# Find repeat customers

SELECT
customer_id,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

# Show repeat customers with their names

SELECT
customers.customer_id,
customers.customer_name,
COUNT(orders.order_id) AS TotalOrders
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.customer_name
HAVING COUNT(orders.order_id) > 1;

# Sort customers by number of orders

SELECT
customers.customer_id,
customers.customer_name,
COUNT(orders.order_id) AS TotalOrders
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.customer_name
ORDER BY TotalOrders DESC;

# RANK() — Customer Loyalty

SELECT
customer_id,
COUNT(order_id) AS TotalOrders,
RANK() OVER (ORDER BY COUNT(order_id) DESC) AS CustomerRank
FROM orders
GROUP BY customer_id;

# RANK() with customer names

SELECT
customers.customer_id,
customers.customer_name,
COUNT(orders.order_id) AS TotalOrders,
RANK() OVER (ORDER BY COUNT(orders.order_id) DESC) AS CustomerRank
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.customer_name;

# DENSE_RANK() — Customer Loyalty

SELECT
customer_id,
COUNT(order_id) AS TotalOrders,
DENSE_RANK() OVER (ORDER BY COUNT(order_id) DESC) AS CustomerRank
FROM orders
GROUP BY customer_id;

# DENSE_RANK() with customer names

SELECT
customers.customer_id,
customers.customer_name,
COUNT(orders.order_id) AS TotalOrders,
DENSE_RANK() OVER (ORDER BY COUNT(orders.order_id) DESC) AS CustomerRank
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id, customers.customer_name;

# Customer Loyalty with Total Spending

SELECT
customer_id,
COUNT(order_id) AS TotalOrders,
SUM(amount) AS TotalAmount
FROM orders
GROUP BY customer_id;

# Rank customers by total spending

SELECT
customer_id,
SUM(amount) AS TotalAmount,
RANK() OVER (ORDER BY SUM(amount) DESC) AS CustomerRank
FROM orders
GROUP BY customer_id;

# Rank customers by total orders

SELECT
customer_id,
COUNT(order_id) AS TotalOrders,
RANK() OVER (ORDER BY COUNT(order_id) DESC) AS CustomerRank
FROM orders
GROUP BY customer_id;

# View order dates and times

SELECT
order_id,
order_date,
amount
FROM orders;

# Count orders by date

SELECT
DATE(order_date) AS OrderDate,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY DATE(order_date);


# Sort dates by number of orders

SELECT
DATE(order_date) AS OrderDate,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY DATE(order_date)
ORDER BY TotalOrders DESC;


# Find the day with the most orders

SELECT
DATE(order_date) AS OrderDate,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY DATE(order_date)
ORDER BY TotalOrders DESC
LIMIT 1;

# Find orders by hour

SELECT
HOUR(order_date) AS OrderHour,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY HOUR(order_date)
ORDER BY OrderHour;


# Find peak ordering hour

SELECT
HOUR(order_date) AS OrderHour,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY HOUR(order_date)
ORDER BY TotalOrders DESC
LIMIT 1;

# Find orders by day of week

SELECT
DAYNAME(order_date) AS OrderDay,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY DAYNAME(order_date)
ORDER BY TotalOrders DESC;

# Find the day with the most orders

SELECT
DAYNAME(order_date) AS OrderDay,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY DAYNAME(order_date)
ORDER BY TotalOrders DESC
LIMIT 1;

# Orders by hour and sort

SELECT
HOUR(order_date) AS OrderHour,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY HOUR(order_date)
ORDER BY TotalOrders DESC;

# Orders by restaurant and date

SELECT
restaurant_id,
DATE(order_date) AS OrderDate,
COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY restaurant_id, DATE(order_date)
ORDER BY OrderDate;

# Restaurant order trends with restaurant name

SELECT
restaurants.name,
DATE(orders.order_date) AS OrderDate,
COUNT(orders.order_id) AS TotalOrders
FROM restaurants
JOIN orders
ON restaurants.restaurant_id = orders.restaurant_id
GROUP BY restaurants.name, DATE(orders.order_date)
ORDER BY OrderDate;

# Orders by day and total revenue

SELECT
DATE(order_date) AS OrderDate,
COUNT(order_id) AS TotalOrders,
SUM(amount) AS TotalRevenue
FROM orders
GROUP BY DATE(order_date)
ORDER BY OrderDate;

# Peak day by revenue

SELECT
DATE(order_date) AS OrderDate,
SUM(amount) AS TotalRevenue
FROM orders
GROUP BY DATE(order_date)
ORDER BY TotalRevenue DESC
LIMIT 1;

# Peak hour by revenue

SELECT
HOUR(order_date) AS OrderHour,
SUM(amount) AS TotalRevenue
FROM orders
GROUP BY HOUR(order_date)
ORDER BY TotalRevenue DESC
LIMIT 1;

