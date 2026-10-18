create database p1ecomm;
use p1ecomm;
-- Customers
CREATE TABLE customers (
 customer_id INT PRIMARY KEY,
 name VARCHAR(100),
 email VARCHAR(100),
 city VARCHAR(50),
 signup_date DATE
);

select * from customers;


-- Products
CREATE TABLE products (
 product_id INT PRIMARY KEY,
 product_name VARCHAR(255),
 category VARCHAR(50),
 price DECIMAL(10,2),
 stock_quantity INT
);

select * from products;

-- Orders
CREATE TABLE orders (
 order_id INT PRIMARY KEY,
 customer_id INT,
 order_date DATE,
 status VARCHAR(20),
 FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

select * from orders ;

-- Order Items
CREATE TABLE order_items (
 order_item_id INT PRIMARY KEY,
 order_id INT,
 product_id INT,
 quantity INT,
 price DECIMAL(10,2),
 FOREIGN KEY (order_id) REFERENCES orders(order_id),
 FOREIGN KEY (product_id) REFERENCES products(product_id)
);

select * from order_items;

-- Payments
CREATE TABLE payments (
 payment_id INT PRIMARY KEY,
 order_id INT,
 payment_method VARCHAR(50),
 payment_status VARCHAR(20),
 amount DECIMAL(10,2),
 FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
select * from payments;


-- Shipping
CREATE TABLE shipping (
 shipping_id INT PRIMARY KEY,
 order_id INT,
 shipping_status VARCHAR(50),
 delivery_date DATE,
 FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

SELECT o.order_id, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT o.order_id, p.product_name
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id;





