create database Retail;

use Retail;

create table customer (
customer_id int(2) NOT NULL,
customer_name varchar(20),
address varchar(50),
phone_number varchar(15),
Primary Key (customer_id)
);

INSERT INTO customer(customer_id, customer_name, address, phone_number)
Values
	(1, 'Henry F', '84 Beck st, Syosset NH, USA', '603-761-1053'),
    (2, 'J Stone', '44 Rule st, Keene NH, USA', '603-227-4987'),
    (3, 'Brad B', '11 James st, Oyster Bay NY', '516-771-1245'),
    (4, 'Kyle D', '1055 Jobr rd, East Norwich NY', '516-288-3456'),
    (5, 'Doug C', '32 Hayes rd, Hicksville NY', '516-234-1234'),
    (6, 'Jake M', '45 Long dr, Longwood NY', '516-908-8743'),
    (7, 'Ted M', '47 Longdrive rd, Syosset NY', '516-456-9987'),
    (8, 'Aidan K', '32 Rule st, Keene NH', '603-209-4475'),
    (9, 'Zach J', '42 Park dr, Westy NH', '603-355-4009'),
    (10, 'Connor M', '82 Kelleher st, Keene NH', '603-762-4793');

create table orders (
order_id int(2) NOT NULL,
order_date Date,
customer_id int(2) NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
Primary Key (order_id)
);

INSERT INTO orders (order_id, order_date, customer_id)
VALUES
  (11, '2022-01-01', 1),
  (12, '2022-01-02', 2),
  (13, '2022-01-03', 3),
  (14, '2022-01-04', 4),
  (15, '2022-01-05', 5),
  (16, '2022-01-06', 6),
  (17, '2022-01-07', 7),
  (18, '2022-01-08', 8),
  (19, '2022-01-09', 9),
  (20, '2022-01-10', 10);

create table items (
item_id int(2) NOT NULL,
order_id int(2) NOT NULL,
quantity int,
price DECIMAL (10, 2),
product_detail_id int(2) NOT NULL,
FOREIGN KEY (product_detail_id) REFERENCES product_detail(product_detail_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
Primary Key (item_id)
);

INSERT INTO items (item_id, order_id, quantity, price, product_detail_id)
VALUES 
	(31, 11, 2, 39.98, 21),
    (32, 12, 1, 29.99, 22),
	(33, 13, 3, 119.97, 23),
    (34, 14, 2, 99.98, 24),
    (35, 15, 1, 59.99, 25),
    (36, 16, 4, 279.96, 26),
    (37, 17, 2, 159.98, 27),
    (38, 18, 3, 269.97, 28),
    (39, 19, 1, 99.99, 29),
    (40, 20, 2, 219.98, 30);



create table product_detail (
product_detail_id INT Primary Key,
product_name varchar(30),
product_price DECIMAL (10, 2),
product_description TEXT
);

INSERT INTO product_detail (product_detail_id, product_name, product_price, product_description)
VALUES
  (21, 'Product A', 19.99, 'This is a description of Product A.'),
  (22, 'Product B', 29.99, 'This is a description of Product B.'),
  (23, 'Product C', 39.99, 'This is a description of Product C.'),
  (24, 'Product D', 49.99, 'This is a description of Product D.'),
  (25, 'Product E', 59.99, 'This is a description of Product E.'),
  (26, 'Product F', 69.99, 'This is a description of Product F.'),
  (27, 'Product G', 79.99, 'This is a description of Product G.'),
  (28, 'Product H', 89.99, 'This is a description of Product H.'),
  (29, 'Product I', 99.99, 'This is a description of Product I.'),
  (30, 'Product J', 109.99, 'This is a description of Product J.');
  
#Creating Procedure
#Out of this database, I created a procedure that will call all the names of the customers.
DELIMITER $$
CREATE PROCEDURE show_name_of_customers ()
BEGIN
  SELECT customer_name
  FROM Retail.customer;
END $$
DELIMITER ;

CALL show_name_of_customers;

#Creating view
#I set product_view as a variable that when called, you get the product name, price, and Id from the product detail column
CREATE VIEW product_view AS
SELECT product_detail_id, product_name, product_price
FROM product_detail;

SELECT * FROM product_view;

#Product Index
#I indexed the customer_name table to make it more accesiable for the user
CREATE INDEX idx_customer_name ON customer(customer_name);

#Product Function
#I created a function that when called upon you can view the total price of all items order based upon customer ID.
DELIMITER //
CREATE FUNCTION get_customer_orders(customer_id INT) RETURNS INT 
DETERMINISTIC
READS SQL DATA
BEGIN  
  DECLARE order_count INT;  
  SELECT COUNT(*) INTO order_count FROM orders WHERE customer_id = customer_id;  
  RETURN order_count; 
END //
DELIMITER ;

SELECT get_customer_orders(13);





