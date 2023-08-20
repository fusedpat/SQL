-- Alias
SELECT CustomerID AS ID, CustomerName AS Customer
FROM Customers;

SELECT CustomerName AS Customer, ContactName AS [Contact Person]
FROM Customers;

SELECT CustomerName, Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address
FROM Customers;


SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o
WHERE c.CustomerName='Around the Horn' AND c.CustomerID=o.CustomerID;

---- Group By -------------------------------

SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;



SELECT productName, MIN(Price) AS SmallestPrice
FROM Products
GROUP BY productName;


SELECT SupplierID, MAX(Price) AS LargestPrice
FROM Products
GROUP BY SupplierID;


SELECT SupplierID, productName, MAX(Price) AS LargestPrice
FROM Products
GROUP BY SupplierID;


SELECT SupplierID, AVG(Price) AS AveragePrice
FROM Products
GROUP BY SupplierID;

SELECT productName, SUM(Price) AS TotalQuantitySold
FROM Products
GROUP BY ProductID;



------------ Group by having -------------------

-- Finding the Smallest Price for Each Category with a Minimum Price Constraint

SELECT productName, MIN(Price) AS SmallestPrice
FROM Products
GROUP BY productName
HAVING SmallestPrice < 50

-- Finding the Largest Price for Each Supplier 
SELECT SupplierID, MAX(Price) AS LargestPrice
FROM Products
GROUP BY SupplierID
HAVING SUM(price) > 10;

-- Total quantity sold by each ProductID

SELECT ProductID, SUM(Quantity) AS TotalQuantitySold
FROM OrderDetails
GROUP BY ProductID
HAVING TotalQuantitySold > 100;


---------Inner join-----------------------------

SELECT Orders.OrderID, Customers.CustomerName
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;


-- Inner join Customers and Orders tables with their matching fields customer_id
SELECT *
FROM Customers
INNER JOIN Orders 
ON Customers.customerid = Orders.customerid
where Customers.customerid > 3;


-- multi table joins ------------
SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM ((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);


-- Left outer join ----------------------

SELECT *
FROM customers
LEFT JOIN orders ON customers.customerid = orders.customerid;


-------- Right outer joins -----------------------------

SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY Orders.OrderID;


SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID
where orderId is null
ORDER BY Orders.OrderID;


----------------- Self join -----------------------------------

SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;


-------------------  Group By -------------------------------------

SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;


--------------------Union(distinct value) --------------------------------------------

SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;

-----------Exists--------------
--The EXISTS clause is used to check for the existence of a subquery result,EXISTS returns true or false.
--IN returns true for rows where the value matches any value in the list.


SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);


SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.supplierID AND Price > 2000);


------------- Any ----------------
SELECT ProductName 
FROM Products
WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);


----------All ----------------

SELECT ProductName
FROM Products
WHERE ProductID = ALL
  (SELECT ProductID
  FROM OrderDetails
  WHERE Quantity = 10);