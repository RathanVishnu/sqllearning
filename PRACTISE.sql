 USE store;
/* SELECT 
	first_name,
    last_name,
    points,
    points*10+100 AS dicount
    -- arithmetic expressions.
	-- here the * and / has higher preferences that will execute first
FROM customers 
-- WHERE customer_id=1
-- ORDER BY Last_name;
*/
-- SELECT DISTINCT state AS notcommon FROM customers;

/*SELECT name,unit_price,unit_price*1.1 AS 'new price' 
FROM products; */

-- WHERE clause;
/*SELECT * FROM customers
WHERE points > 3000; -- operators >,>=,<,<=,=,!=,<>
*/
/*
SELECT * FROM customers WHERE state='VA';
SELECT * FROM customers WHERE state !='VA';
SELECT * FROM customers WHERE state <>'VA';
-- The not equal to(!=) and <> are doing the same functionalities
*/
/* SELECT *
FROM customers
WHERE NOT birth_date>'1990-01-01' OR points>=1000 AND state='VA' */
-- SELECT * FROM orders WHERE order_date>='2019-01-01'

-- SELECT * FROM order_items WHERE order_id=6 AND (unit_price*quantity>30);

-- SELECT * FROM customers WHERE state='VA' OR state='VL' OR state='FL';
-- insted of above we can write the query as below usin in operator
-- SELECT * FROM customers WHERE state IN('VA','VL','FL');-- THE both statements are true but it is simple
-- if we replce the NOT IN in tht postion of IN then it will take the values that we have not entered;
-- SELECT * FROM products WHERE quantity_in_stock IN(49,38,72)

/* BETWEEN OPERATOR

SELECT * FROM customers WHERE points BETWEEN 1000 AND 3000;
SELECT * FROM customers WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01'
*/
/* -- LIKE OPERATOR USED TO RETRIVE THE VALUE THAT MATCH A ROW WITH THE SPECIFIC STRING PATTERN
SELECT * FROM customers WHERE last_name LIKE "b%";-- IT RETRIEVES THE LETTER STARTING WITH THE LETTER B
SELECT * FROM customers WHERE last_name LIKE "B%";-- IT RETRIEVES THE LETTER ENDING WITH THE LETTER B
SELECT * FROM customers WHERE last_name LIKE "%b%";-- IT RETRIEVES THE ALL LETTER START OR END WITH THE LETTER B
-- %-used to denote any number of characters 
-- _ -used to denote single characters
SELECT * FROM customers WHERE last_name LIKE "B____Y";-- HERE THE FIRST LETTER WILL BE B AND THE FIFTH LETTER WIL BE THE Y 

SELECT *FROM customers WHERE address LIKE "%TRAIL%" 
							 OR
							 address LIKE "%AVENUE%" ;
SELECT * FROM customers WHERE phone LIKE "%9";
SELECT * FROM customers WHERE phone NOT LIKE "%9";-- IT TAKES THE VALUE EXCEPT THE VALUE 9;
*/

/* -- REGEXP
SELECT * FROM customers WHERE last_name REGEXP 'FIELD'; --  it selects the value if it has the field in it.
SELECT * FROM customers WHERE last_name REGEXP '^Brush'; -- IT SELECTS THE VALUES THAT START WITH THE LETTER Brush
SELECT * FROM customers WHERE last_name REGEXP 'seby$'; -- IT SELECTS THE VALUES THAT END WITH THE LETTER seby
SELECT * FROM customers WHERE last_name REGEXP 'FIELD|MAC|ROSE';-- it takes the the value if the value contain the letters inside the quotes
SELECT * FROM customers WHERE last_name REGEXP '[GF]E';-- IT TAKES THE VALUE LIKE IF THE VALUE HAS "GE"0R"FE"
SELECT * FROM customers WHERE last_name REGEXP '[A-G]E';
-- ^ BEGINNING 
-- $ END
-- [ABC]E
-- [A-H]
SELECT *
FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';
SELECT *
FROM customers
WHERE last_name REGEXP 'EY$|ON$';
SELECT *
FROM customers
WHERE last_name REGEXP '^MY|SE';
SELECT *
FROM customers
WHERE last_name REGEXP 'B[RU]';
*/

/* -- IS NULL OPERATOR
SELECT * FROM customers WHERE phone IS NULL;
SELECT * FROM customers WHERE phone IS NOT NULL;
SELECT * FROM orders WHERE shipped_date IS NULL;
*/

/*-- ORDER BY CLAUSE
SELECT * FROM customers ORDER BY first_name;
SELECT * FROM customers ORDER BY first_name DESC;
SELECT * FROM order_items WHERE order_id=2 ORDER BY quantity*unit_price DESC;
*/

/* -- LIMIT
SELECT * FROM customers LIMIT 3;
SELECT * FROM customers LIMIT 6,4;-- here this query says that it skips the first 6 records and
-- then chooses the remaining 4 records as given
SELECT * FROM customers ORDER BY points DESC LIMIT 3;
*/

/* -- JOINS -- inner joins

 SELECT * FROM orders JOIN customers ON orders.customer_id=customers.customer_id;
 SELECT first_name,orders.customer_id,last_name FROM orders JOIN customers ON orders.customer_id=customers.customer_id;
 SELECT 
	   order_id,
       o.product_id,
       quantity,
       o.unit_price 
 FROM order_items o 
 JOIN products p 
 ON o.product_id=p.product_id;
 
 -- WE CAN WRITE THIS IN WHERE CLASS ALSO LIKE THE BELOW MENTIONED QUERY
 SELECT 
	   order_id,
       o.product_id,
       quantity,
       o.unit_price 
 FROM order_items o,products p
WHERE o.product_id=p.product_id;
 */


/* -- joining across the databases
SELECT * FROM order_items oi 
JOIN sql_inventory.products p
ON oi.product_id=p.product_id;

USE sql_inventory;
SELECT * FROM store.order_items oi 
JOIN products p
ON oi.product_id=p.product_id;
*/

/* -- self joins is used to join the table by itself
-- here we use the sql_hr database so in that database the table employyees have managers he also be an employee of that company
-- here we are finding the who are the mangers for the employees present in the table.
USE sql_hr;
SELECT * 
FROM employees emp
JOIN employees man 
ON emp.reports_to=man.employee_id;
SELECT 
	 emp.employee_id,
     emp.first_name,
     man.first_name manager
FROM employees emp
JOIN employees man 
ON emp.reports_to=man.employee_id;
*/

/* -- joining multiple tables
SELECT o.order_id,c.customer_id,c.first_name,o.order_date,os.name status
FROM orders o
JOIN customers c
    ON o.customer_id=c.customer_id
JOIN order_statuses os
    ON o.status=os.order_status_id;
    
USE invoicing;
SELECT p.client_id,c.name,p.date,pm.name 
FROM payments p
JOIN clients c
    ON p.client_id=c.client_id
JOIN payment_methods pm
    ON p.payment_method=pm.payment_method_id;
*/

/*
-- compound join conditions
-- it is used to join the tables by multiple conditions
USE invoicing;
SELECT * 
FROM payments p
JOIN invoices i
ON p.client_id=i.client_id AND p.invoice_id=i.invoice_id;
*/

/*-- OUTER JOIN 
    -- LEFT JOIN
    -- RIGHT JOIN
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id;
SELECT c.customer_id,c.first_name,o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id=o.customer_id;

SELECT p.product_id,name,quantity
FROM products p
LEFT JOIN order_items o
ON p.product_id=o.product_id;
*/

/*-- OUTER JOIN BETWEEN MULTIPLE TABLES
USE store;
SELECT c.customer_id,o.order_id,s.shipper_id,s.name
FROM customers c
LEFT JOIN orders o
   ON c.customer_id=o.customer_id
LEFT JOIN shippers s
   ON o.shipper_id=s.shipper_id;
   
SELECT o.order_date,o.order_id,c.first_name,os.name,s.name
FROM orders o
LEFT JOIN customers c
   ON o.customer_id=c.customer_id
JOIN order_statuses os
   ON o.status=os.order_status_id
LEFT JOIN shippers s 
   ON o.shipper_id=s.shipper_id
*/

/*-- SELF OUTER JOIN
USE sql_hr;
SELECT e.employee_id,e.first_name,m.first_name
FROM employees e
LEFT JOIN employees m
  ON e.reports_to=m.employee_id;
  */
  
-/*- USING CLAUSE
SELECT o.order_date,o.order_id,c.first_name,C.customer_id
FROM orders o
JOIN customers c
   -- ON o.customer_id=c.customer_id
   USING (customer_id);-- the above and bellow statements are same by use of USING clause we can make the code simpler
USE invoicing;
SELECT p.date,c.name AS client,p.amount,pm.name
FROM payments p
JOIN clients c
   USING (client_id)
JOIN payment_methods pm
   ON p.payment_method=pm.payment_method_id
*/

/* -- NATURAL JOINS
SELECT c.customer_id,o.order_id
FROM customers c
NATURAL JOIN orders o;-- it is simple to cose but it is not recommended to use because sometimes it produces an unexpected outputs
-- here the above and the below queries produces the same output.
SELECT c.customer_id,o.order_id
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id;
*/

/*-- CROSS JOINS-> IT IS USED TO JOIN EVERY RECORD FROM THE FIRST TABLE WITH THE EVERY RECORD IN THE SECOND TABLE
-- IT IS AN EXPLICT METHOD AND IT IS BEST METHOD TO UNDERSTANDABLE
SELECT c.customer_id,p.product_id
FROM customers c
CROSS JOIN products p; 

-- IT IS AN IMPLICIT METHOD
SELECT c.customer_id,p.product_id
FROM customers c,products p; 

-- EXPLICIT METHOD   
SELECT *
FROM shippers
CROSS JOIN products;

-- IMPLICIT METHOD
SELECT *
FROM SHIPPERS, products;
*/

/*-- UNIONS BSICALLY JOINS ARE USED TO COMBINE THE COLUMNS OF MULTIPLE TABLES BUT IN SQL WE CAN JOIN THE MULTIPLE ROWS USING UNIONS
SELECT order_id,order_date,'ACTIVE' AS status 
FROM orders  WHERE order_date>='2019-01-01'
UNION
SELECT order_id,order_date,'ARCHIEVED' AS status 
FROM orders  WHERE order_date<'2019-01-01';

SELECT first_name
FROM customers
UNION
SELECT order_date 
FROM orders;

SELECT customer_id,first_name,points,'Bronze' AS Type 
FROM customers 
WHERE points<2000
UNION
SELECT customer_id,first_name,points,'Silver' AS Type 
FROM customers 
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id,first_name,points,'Gold' AS Type 
FROM customers 
WHERE points>3000
ORDER BY first_name;
*/

/*-- INSERTING A SINGLE ROW IN A TABLE
INSERT INTO customers(
     first_name,
     last_name,
     phone,
     address,
     city,
     state)
VALUES(
     'Rathan',
     'vishnu',
     9342108939,
     'address',
     'cbe',
     'IA'
     );
*/

/*-- INSERTING MULTIPLE ROWS IN A TABLE 
INSERT INTO shippers(name)
VALUES('SHIPPERS1'),
	('SHIPPERS2'),
    ('SHIPPERS');
    
    
INSERT INTO products(name,quantity_in_stock,unit_price)
VALUES('A',20,2.34),
	('B',30,3.56),
    ('C',40,4.76);
    */
    
/*-- INSERTING HIERARCHICAL ROWS ie,INSERING ROWS IN MULTIPLE TABLES
INSERT INTO orders(customer_id,order_date,status)
VALUES(10,'2023-01-19',1);
INSERT INTO order_items 
VALUES(LAST_INSERT_ID(),2,5,2.65)
*/

/*-- CREATING A COPY OF A TABLE
CREATE TABLE orders_archieved AS SELECT * FROM orders;
-- it creates a copy of the table if we need to only insert the particular values we need to truncate and
-- then we add the values the tables if we use truncate the structure of the table will not be deleted
INSERT INTO orders_archieved 
SELECT * FROM orders WHERE order_date <'2019-01-01';-- it inserts the value less than the year that was given


USE invoicing;
CREATE TABLE invoices_archieved AS 
SELECT c.name,
       i.invoice_id,
       i.number,
       i.payment_date,
       i.invoice_total,
       i.payment_total,
       i.invoice_date,
       i.due_date
FROM clients c
JOIN invoices i
    USING(client_id)
    WHERE payment_date IS NOT NULL;
*/

-- UPDATING A SINGLE ROW
  








