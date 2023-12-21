use classicmodels;
SELECT 
  customerNumber, 
  customerName, 
  state, 
  creditLimit
FROM 
  customers
WHERE 
  state IS NOT NULL
  AND creditLimit BETWEEN 50000 AND 100000
ORDER BY 
  creditLimit DESC;
  
  SELECT DISTINCT productLine
FROM products
WHERE productLine LIKE '%cars';

SELECT 
  orderNumber, 
  status, 
  COALESCE(comments, '-') AS comments
FROM 
  orders
WHERE 
  status = 'Shipped';
  
  SELECT
  employeeNumber,
  firstName,
  jobTitle,
  CASE
    WHEN jobTitle = 'President' THEN 'P'
    WHEN jobTitle IN ('Sales Manager', 'Sale Manager') THEN 'SM'
    WHEN jobTitle = 'Sales Rep' THEN 'SR'
    WHEN jobTitle LIKE '%VP%' THEN 'VP'
  END AS jobTitle_Abbr
FROM
  employees ;
  
  SELECT
  employeeNumber,
  firstName,
  jobTitle,
  CASE
    WHEN jobTitle = 'President' THEN 'P'
    WHEN jobTitle IN ('Sales Manager (APAC)','Sales manager(NA)', 'Sale Manager(EMEA)') THEN 'SM'
    WHEN jobTitle = 'Sales Rep' THEN 'SR'
    WHEN jobTitle LIKE '%VP%' THEN 'VP'
  END AS jobTitleAbbreviation
FROM
  employees;
  
  SELECT
  employeeNumber,
  firstName,
  jobTitle,
  COALESCE(
    CASE
      WHEN jobTitle = 'President' THEN 'P'
      WHEN jobTitle IN ('Sales Manager', 'Sale Manager') THEN 'SM'
      WHEN jobTitle = 'Sales Rep' THEN 'SR'
      WHEN jobTitle LIKE '%VP%' THEN 'VP'
    END, 'SM'
  ) AS jobTitleAbbreviation
FROM
  employees;
  

SELECT
  YEAR(paymentDate) AS paymentYear,
  MIN(amount) AS minPaymentAmount
FROM
  payments
GROUP BY
  YEAR(paymentDate)
  order by paymentyear;
  
  select * from orders;
 
SELECT
  YEAR(orderDate) AS orderYear,
  CONCAT('Q', QUARTER(orderDate)) AS orderQuarter,
  COUNT(DISTINCT customerNumber) AS uniqueCustomers,
  COUNT(orderNumber) AS totalOrders
FROM
  orders
GROUP BY
  orderYear, orderQuarter
ORDER BY
  orderYear, orderQuarter;
  
  
  SELECT
  MONTHNAME(paymentDate) AS paymentMonth,
  CONCAT(FORMAT(SUM(amount) / 1000, 0), 'K') AS formattedAmount
FROM
  payments
GROUP BY
  paymentMonth
HAVING
  SUM(amount) BETWEEN 500000 AND 1000000
ORDER BY
  SUM(amount) DESC;
  
  
  CREATE TABLE journey (
  Bus_ID INT PRIMARY KEY NOT NULL,
  Bus_Name VARCHAR(255) NOT NULL,
  Source_Station VARCHAR(255) NOT NULL,
  Destination VARCHAR(255) NOT NULL,
  Email VARCHAR(255) UNIQUE NOT NULL
);

select * from journey;

CREATE TABLE vendor (
  Vendor_ID INT PRIMARY KEY UNIQUE NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Email VARCHAR(255) UNIQUE NOT NULL,
  Country VARCHAR(255) DEFAULT 'N/A'
);

select * from vendor;


CREATE TABLE movie (
  Movie_ID INT PRIMARY KEY UNIQUE NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Release_Year VARCHAR(4) DEFAULT '-' NULL,
  Cast VARCHAR(255) NOT NULL,
  Gender ENUM('Male', 'Female') NOT NULL,
  No_of_shows INT CHECK (No_of_shows >= 0) NOT NULL
);

select * from movie;

CREATE TABLE Suppliers (
  supplier_id INT PRIMARY KEY AUTO_INCREMENT,
  supplier_name VARCHAR(255),
  location VARCHAR(255)
);
select * from suppliers;

CREATE TABLE Product (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  supplier_id INT,
  FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);
select * from product;

CREATE TABLE Stock (
  id INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT,
  balance_stock INT,
  FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
select * from stock;

use classicmodels;

SELECT
  e.employeeNumber AS employeeNumber,
  CONCAT(e.firstName, ' ', e.lastName) AS SalesPerson,
  COUNT(DISTINCT c.customerNumber) AS UniqueCustomers
FROM
  Employees e
JOIN
  Customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY
  e.employeeNumber, SalesPerson
ORDER BY
  UniqueCustomers DESC;
  
  
  SELECT
  c.customerNumber,
  p.productCode,
  p.productName,
  SUM(od.quantityOrdered) AS TotalQuantities,
  p.quantityInStock AS TotalQuantitiesInStock,
  p.quantityInStock - SUM(od.quantityOrdered) AS LeftOverQuantities
FROM
  Customers c
JOIN
  Orders o ON c.customerNumber = o.customerNumber
JOIN
  Orderdetails od ON o.orderNumber = od.orderNumber
JOIN
  Products p ON od.productCode = p.productCode
GROUP BY
  c.customerNumber, p.productCode, p.productName, TotalQuantitiesInStock
ORDER BY
  c.customerNumber;
  

CREATE TABLE Laptop (
  Laptop_Name VARCHAR(255)
);


INSERT INTO Laptop (Laptop_Name) VALUES
('DELL'),
('HP');

-- Create Colours table
CREATE TABLE Colours (
  Colour_Name VARCHAR(255)
);


INSERT INTO Colours (Colour_Name) VALUES
('White'),
('Silver'),
('Black');


SELECT
  Laptop.Laptop_Name,
  Colours.Colour_Name
FROM
  Laptop
CROSS JOIN
  Colours;
  
  drop table laptop;
  drop table colours;



CREATE TABLE Project (
  EmployeeID INT,
  FullName VARCHAR(255),
  Gender VARCHAR(10),
  ManagerID INT
);

INSERT INTO Project VALUES(1, 'Pranaya', 'Male', 3);
INSERT INTO Project VALUES(2, 'Priyanka', 'Female', 1);
INSERT INTO Project VALUES(3, 'Preety', 'Female', NULL);
INSERT INTO Project VALUES(4, 'Anurag', 'Male', 1);
INSERT INTO Project VALUES(5, 'Sambit', 'Male', 1);
INSERT INTO Project VALUES(6, 'Rajesh', 'Male', 3);
INSERT INTO Project VALUES(7, 'Hina', 'Female', 3);

SELECT
  M.FullName AS Manager,
  E.FullName AS Employee
FROM
  Project E
JOIN
  Project M ON E.ManagerID = M.EmployeeID
WHERE
  E.FullName IS NOT NULL AND M.FullName IS NOT NULL;

drop table project;


CREATE TABLE Facility (
  Facility_ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  City VARCHAR(255) NOT NULL,
  State VARCHAR(255),
  Country VARCHAR(255)
);


DESC Facility;



DESC Facility;

drop table university;


CREATE TABLE University (
  ID INT PRIMARY KEY,
  Name VARCHAR(255)
);

INSERT INTO University (ID, Name) VALUES
(1, "Pune University"),
(2, "Mumbai University"),
(3, "Delhi University"),
(4, "Madras University"),
(5, "Nagpur University");

UPDATE University
SET Name = REPLACE(Name, ' ', '');

SELECT * FROM University;


use classicmodels;
drop view products_status;

-- Create the view products_status
CREATE VIEW products_status AS
SELECT
  YEAR(o.orderDate) AS orderYear,
  CONCAT(
    LPAD(FORMAT(ROUND(SUM(od.priceEach * od.quantityOrdered), 0), 4), 4, '0'),
    ' (',
    ROUND((SUM(od.priceEach * od.quantityOrdered) / (SELECT SUM(priceEach * quantityOrdered) FROM orderdetails)) * 100, 0),
    '%)'
  ) AS ValueAndPercentage
FROM
  orders o
JOIN
  orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY
  orderYear
ORDER BY
  orderYear;
  
SELECT * FROM products_status;



drop procedure Getcustomerlevel;
use classicmodels;
DELIMITER //

CREATE PROCEDURE GetCustomerLevel(IN customerNumber INT, OUT customerLevel VARCHAR(50))
BEGIN
  DECLARE creditLimit INT;


  SELECT creditLimit INTO creditLimit FROM Customers WHERE customerNumber = customerNumber LIMIT 1;

  
  IF creditLimit > 100000 THEN
    SET customerLevel = 'Platinum';
  ELSEIF creditLimit BETWEEN 25000 AND 100000 THEN
    SET customerLevel = 'Gold';
  ELSE
    SET customerLevel = 'Silver';
  END IF;
END //


DELIMITER ;

CALL GetCustomerLevel(245999, @customerLevel);

SELECT @customerLevel;

drop procedure get_country_payments;
DELIMITER //

CREATE PROCEDURE Get_country_payments(IN inputYear INT, IN inputCountry VARCHAR(50), OUT resultYear INT, OUT resultCountry VARCHAR(50), OUT totalAmountFormatted VARCHAR(50))
BEGIN
  SELECT 
    YEAR(paymentDate) AS year,
    (SELECT country FROM Customers WHERE customerNumber = Payments.customerNumber) AS country,
    CONCAT(FORMAT(SUM(amount) / 1000, 0), 'K') AS totalAmount
  INTO 
    resultYear,
    resultCountry,
    totalAmountFormatted
  FROM Payments
  WHERE YEAR(paymentDate) = inputYear AND (SELECT country FROM Customers WHERE customerNumber = Payments.customerNumber) = inputCountry
  GROUP BY year, country;
END //

DELIMITER ;


CALL Get_country_payments(2003, 'FRANCE', @resultYear, @resultCountry, @totalAmountFormatted);
SELECT @resultYear AS 'Year', @resultCountry AS 'Country', @totalAmountFormatted AS 'TotalAmount';




SELECT 
    YEAR(orderdate) AS order_year,
    MONTHNAME(orderdate) AS month_name,
    COUNT(*) AS totalorder,
    CONCAT(FORMAT((COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY YEAR(orderdate), MONTH(orderdate))) / LAG(COUNT(*)) OVER (ORDER BY YEAR(orderdate), MONTH(orderdate)) * 100, 0), '%') AS yoy_change
FROM 
    Orders
GROUP BY 
    order_year, MONTH(orderdate), month_name
ORDER BY 
    order_year, MONTH(orderdate);





    
    
    SELECT CustomerNumber, CustomerName
FROM Customers
WHERE CustomerNumber NOT IN (
    SELECT CustomerNumber
    FROM Orders
);

 SELECT 
    COALESCE(c.CustomerNumber, o.CustomerNumber) AS CustomerNumber,
    COALESCE(c.CustomerName, 'Unknown') AS CustomerName,
    COUNT(o.OrderNumber) AS OrderCount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerNumber = o.CustomerNumber
GROUP BY COALESCE(c.CustomerNumber, o.CustomerNumber), COALESCE(c.CustomerName, 'Unknown');


select * from customers;
select * from orders;


SELECT 
    OrderNumber,
    MAX(Quantityordered) AS SecondHighestQuantity
FROM Orderdetails od1
WHERE Quantityordered < (
    SELECT MAX(Quantityordered)
    FROM Orderdetails od2
    WHERE od1.OrderNumber = od2.OrderNumber
)
GROUP BY OrderNumber;

select * from orderdetails;
use classicmodels;



SELECT 
    MAX(Total) AS MaxTotal,
    MIN(Total) AS MinTotal
FROM (
    SELECT COUNT(Productcode) AS Total
    FROM Orderdetails
    GROUP BY OrderNumber
) AS ProductCounts;




SELECT 
    ProductLine,
    COUNT(*) AS ProductLineCount
FROM Products
WHERE BuyPrice > (SELECT AVG(BuyPrice) FROM Products)
GROUP BY ProductLine;



-- Create the table Emp_EH
CREATE TABLE Emp_EH (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(255),
    EmailAddress VARCHAR(255)
);




-- Create the stored procedure
DELIMITER //

CREATE PROCEDURE InsertEmp_EH(
    IN p_EmpID INT,
    IN p_EmpName VARCHAR(255),
    IN p_EmailAddress VARCHAR(255)
)
BEGIN
    DECLARE error_occurred BOOLEAN DEFAULT FALSE;
    
    -- Exception handling
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET error_occurred = TRUE;
    END;
    
    -- Insert data into Emp_EH
    INSERT INTO Emp_EH (EmpID, EmpName, EmailAddress) VALUES (p_EmpID, p_EmpName, p_EmailAddress);
    
    -- Check for errors
    IF error_occurred THEN
        SELECT 'Error occurred' AS ErrorMessage;
    ELSE
        SELECT 'Data inserted successfully' AS SuccessMessage;
    END IF;
    
END //

DELIMITER ;
-- Call the stored procedure
CALL InsertEmp_EH(2, 'komal jain', 'komal77@gmail.com');
CALL InsertEmp_EH(3, 'kashish jain', 'kashish77@gmail.com');





-- Create the table Emp_BIT
CREATE TABLE Emp_BIT (
    Name VARCHAR(255),
    Occupation VARCHAR(255),
    Working_date DATE,
    Working_hours INT
);

-- Insert data into Emp_BIT
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),
('Warner', 'Engineer', '2020-10-04', 10),
('Peter', 'Actor', '2020-10-04', 13),
('Marco', 'Doctor', '2020-10-04', 14),
('Brayden', 'Teacher', '2020-10-04', 12),
('Antonio', 'Business', '2020-10-04', 11);

-- Create BEFORE INSERT trigger
DELIMITER //

CREATE TRIGGER BeforeInsert_Emp_BIT
BEFORE INSERT ON Emp_BIT
FOR EACH ROW
BEGIN
    -- Make sure Working_hours is inserted as positive
    IF NEW.Working_hours < 0 THEN
        SET NEW.Working_hours = ABS(NEW.Working_hours);
    END IF;
END //

DELIMITER ;


-- Try inserting a row with a negative Working_hours value
INSERT INTO Emp_BIT VALUES ('komal', 'Analyst', '2020-10-05', 8);


-- Check the contents of Emp_BIT table
SELECT * FROM Emp_BIT;

