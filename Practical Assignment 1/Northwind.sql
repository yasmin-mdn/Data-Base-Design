use Northwind
/*1*/
SELECT s.ContactName,S.Phone 
FROM Suppliers S 
    where S.ContactName LIKE 'M%'

/*2*/
SELECT C.CustomerID , C.ContactName , O.OrderID
FROM Customers C INNER JOIN Orders O
     ON C.CustomerID=O.CustomerID


/*3*/
SELECT e.FirstName,e.LastName,e.BirthDate,e.HireDate,(SELECT FLOOR(DATEDIFF(DAY,e.BirthDate,e.HireDate) / 365.25)) as HireAge
FROM Employees e
/*4*/
SELECT o.CustomerID ,COUNT(o.CustomerID) as orderno
FROM Orders o
GROUP BY(o.CustomerID)
/*5*/
SELECT o.EmployeeID ,COUNT(o.EmployeeID) as orderno
FROM Orders o
GROUP BY(o.EmployeeID)
HAVING  count(o.EmployeeID) >=3
/*6*/
SELECT EmployeeID,FirstName,LastName
FROM Employees
where NOT Title='Sales Representative'
/*7*/
SELECT c.ContactName,c.Address
FROM [Order Details] od,Orders o,Customers c
where c.CustomerID=o.CustomerID and od.OrderID=o.OrderID and (od.Quantity*od.ProductID)+o.Freight >6000
/*8  SUM(round(od.UnitPrice * od.Quantity * (1 - od.Discount), 2)+o.Freight) as total ,c.ContactName,c.Country*/
SELECT  c.CustomerID,c.ContactName,c.Country,od.UnitPrice,od.Quantity,od.Discount,o.Freight
FROM ((Orders o
INNER JOIN [Order Details] od ON o.OrderID=od.OrderID)
INNER JOIN Customers c ON c.CustomerID=o.CustomerID )





