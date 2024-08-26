

USE classicmodels;


select @@hostname;
SELECT * FROM customers;
SELECT * FROM employees;

SELECT * FROM orderdetails;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM payments;

SELECT * FROM offices;
SELECT * FROM ProductLines;

-- QUESTION 1: What countries are the customers of classicmodels located in?
SELECT DISTINCT country FROM Customers;


-- QUESTION 2: What country has the highest number of orders between 2003 and 2005?
SELECT country, COUNT(country) AS count
FROM orders O
JOIN customers C
ON O.customerNumber = C.customerNumber
GROUP BY C.country
ORDER BY count DESC;

-- QUESTION 3: What is the hierarchy of the company’s employees?
SELECT e.employeeNumber, -- e.firstName AS Employee_Name, em.firstName AS Supervisor_Name
 CONCAT(e.firstName, " " , e.lastName) AS Employee_Name,
 CONCAT(em.firstName, " " , em.lastName) AS Supervisor_Name
FROM employees e
JOIN employees em
ON e.reportsTo = em.employeeNumber;

-- QUESTION 4: What countries are the company branches situated in and which employee(s) work there?
SELECT e.employeeNumber,
e.firstName,
e.lastName,
e.jobTitle,
o.city,
o.addressline1 AS address,
o.state,
o.country
FROM employees e
JOIN offices o
ON e.officeCode = o.officeCode
ORDER BY EmployeeNumber;

-- QUESTION 5: What is the list of orders that have been shipped successfully from 2003–2005?
select orderNumber, CustomerNumber, shippedDate, status 
from orders
where status = "Shipped"

-- QUESTION 7 : Taking the orders of customers into context, what product(s) did they actually request for

SELECT od.productCode,
od.orderNumber,
o.orderDate,
od.quantityOrdered,
od.PriceEach,
p.productName,
p.productLine
FROM orderdetails od JOIN products p
USING (productCode)
JOIN orders o
USING (orderNumber)
ORDER BY orderNumber;


-- QUESTION 8: What is the list of total sales, the total amount of sales and the total number of sales for the year 2003? 
SELECT customerNumber,
paymentDate,
amount
FROM payments
WHERE paymentDate <= "2003–31–12";


-- QUESTION 9: What is the productline with the highest orders?
SELECT p.productLine,
COUNT(od.productCode) AS num_of_sales
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
GROUP BY p.productLine
ORDER BY num_of_sales DESC;


-- QUESTION 10: What products are currently in stock, purchase price, sale price and estimated profit?

SELECT p.productCode,
p.productName,
pl.productLine,
p.quantityInStock,
p.buyPrice,
p.MSRP,
(p.MSRP - p.buyPrice) AS estimated_profit
FROM products p
JOIN productlines pl
USING (productLine)
ORDER BY productCode;
