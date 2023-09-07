CREATE DATABASE mydb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mydb;


-- Create the Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

-- Create the Products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    category VARCHAR(50)
);

-- Create the Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    count_of_product INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into Customers table
INSERT INTO customers (first_name, last_name, email, phone_number)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '+1-555-123-4567'),
    ('Jane', 'Smith', 'jane.smith@example.com', '+1-555-987-6543'),
    ('Alice', 'Johnson', 'alice.johnson@example.com', '+1-555-789-0123');

-- Insert sample data into Products table
INSERT INTO products (product_name, description, price, category)
VALUES
    ('Laptop', 'High-performance laptop with SSD', 899.99, 'Electronics'),
    ('Smartphone', 'Latest smartphone with great camera', 699.99, 'Electronics'),
    ('Desk Chair', 'Comfortable office chair', 149.99, 'Furniture');

-- Insert sample data into orders table (including product_id)
INSERT INTO orders (customer_id, product_id, order_date, count_of_product, total_amount)
VALUES
    (1, 1, '2023-01-15', 2, 1799.98),  -- Two laptops
    (1, 2, '2023-01-15', 1, 699.99),   -- One smartphones
    (2, 2, '2023-02-10', 3, 2099.97),  -- Three smartphones
    (3, 3, '2023-03-20', 1, 149.99);    -- One desk chair
