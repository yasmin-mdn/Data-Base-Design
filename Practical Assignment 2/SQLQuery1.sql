use Northwind
/*1*/
;WITH CTE_Sum
AS(
SELECT C.CustomerID, (SUM((OD.UnitPrice*OD.Quantity)*(1-Discount))/SUM(OD.Quantity)) AS [AVG]
FROM Customers C INNER JOIN Orders O
ON C.CustomerID=O.CustomerID INNER JOIN [Order Details] OD
ON OD.OrderID=O.OrderID
GROUP BY C.CustomerID
)
SELECT C.CustomerID,CS.AVG,
((CS.AVG)-(SELECT AVG((OD.UnitPrice*OD.Quantity)*(1-Discount))  / (SELECT AVG((OD.UnitPrice*OD.Quantity)*(1-Discount)))
FROM [Order Details] OD)) as diff
FROM CTE_Sum CS  INNER JOIN Customers C
ON C.CustomerID=CS.CustomerID
/*2*/
SELECT p.ProductName
FROM Products p
WHERE p.ProductID in (
SELECT TOP 10  od.ProductID 
FROM [Order Details] od INNER JOIN Orders o ON  od.OrderID=o.OrderID 
GROUP BY
 od.ProductID 
ORDER BY
  SUM(od.Quantity) DESC
)
/*3*/
;WITH CTE_CountryNumber
AS(
SELECT C.Country AS Country, COUNT(C.Country) AS [COUNT]
FROM Customers C INNER JOIN Orders O
ON C.CustomerID=O.CustomerID INNER JOIN [Order Details] OD
ON OD.OrderID=O.OrderID
GROUP BY C.Country
)
SELECT Country,CCN.COUNT
FROM CTE_CountryNumber CCN
WHERE CCN.COUNT =(SELECT MAX(CCN.COUNT) FROM CTE_CountryNumber CCN ) OR 
CCN.COUNT =(SELECT MIN(CCN.COUNT) FROM CTE_CountryNumber CCN )

/*4*/ 
WITH  temporaryTable (EmployeeID,ShipVia,number) as
(SELECT Top 1 o.EmployeeID,o.ShipVia ,COUNT(*) as times
FROM Orders o 
GROUP BY o.EmployeeID,o.ShipVia
ORDER BY COUNT(*) DESC)
SELECT E.FirstName,E.LastName,sh.CompanyName
FROM Shippers sh, Employees E,temporaryTable 
WHERE sh.ShipperID=temporaryTable.ShipVia and E.EmployeeID=temporaryTable.EmployeeID
/*5*/
WITH ALL_countries(ShipCountry,price) as (
SELECT  o.ShipCountry,(OD.UnitPrice*OD.Quantity)*(1-Discount)
FROM Orders o INNER JOIN [Order Details] OD ON o.OrderID=OD.OrderID
GROUP by o.ShipCountry,(OD.UnitPrice*OD.Quantity)*(1-Discount))

SELECT ac.ShipCountry , SUM(ac.price) as total
FROM ALL_countries ac
GROUP BY ac.ShipCountry
order by SUM(ac.price)  DESC
/*6*/
SELECT TOP 1 t.RegionID,COUNT(t.RegionID) as number
FROM EmployeeTerritories et INNER JOIN  Orders o ON o.EmployeeID=et.EmployeeID
INNER JOIN  Territories t ON t.TerritoryID=et.TerritoryID
GROUP BY t.RegionID
ORDER BY COUNT(t.RegionID) DESC
/*7*/
;WITH CTE_Sum
AS(
SELECT C.CustomerID, SUM((OD.UnitPrice*OD.Quantity)*(1-Discount)) AS [SUM]
FROM Customers C INNER JOIN Orders O
ON C.CustomerID=O.CustomerID INNER JOIN [Order Details] OD
ON OD.OrderID=O.OrderID
GROUP BY C.CustomerID
)
SELECT C.CustomerID,CS.SUM,
((CS.SUM)-(SELECT AVG((OD.UnitPrice*OD.Quantity)*(1-Discount)) AS [AVG] 
FROM [Order Details] OD)) AS DIFF
FROM CTE_Sum CS  INNER JOIN Customers C
ON C.CustomerID=CS.CustomerID
/*8*/
with discount_tb(CustomerID,times_use_code)as
(SELECT c.CustomerID,COUNT(c.CustomerID) as times_use_code
FROM Orders o INNER JOIN Customers c ON C.CustomerID=o.CustomerID
INNER JOIN [Order Details] od ON (od.OrderID=o.OrderID and od.Discount!=0)
GROUP BY c.CustomerID)
select c.ContactName,c.CustomerID,t.times_use_code
from Customers c , discount_tb t WHERE t.CustomerID=c.CustomerID
order by t.times_use_code DESC
/*9*/
with varedat_tbl(ShipCountry,nomber_of_products) as
(
SELECT o.ShipCountry , COUNT(*) as nomber_of_products
FROM Orders o INNER JOIN [Order Details] od on o.OrderID=od.OrderID
GROUP BY o.ShipCountry,od.ProductID
)
SELECT t.ShipCountry,SUM(t.nomber_of_products) as TOTAL_of_diffrent_kind_of_products
FROM varedat_tbl t
GROUP by t.ShipCountry
ORDER BY SUM(t.nomber_of_products) DESC
/**************************************view*************************/
CREATE VIEW [RES]
AS 
SELECT E.EmployeeID, LOWER(E.FirstName + E.LastName) AS full_name,
		CAST(E.BirthDate AS DATE) AS  BirthDate,
		(E.Region ) AS Region ,
		O.OrderID,
		c.Phone as customer_phone,
       ((UnitPrice*Quantity) * (1-Discount)) AS TotalPrice,
	   CAST(O.OrderDate AS DATE) AS OrderDate,
	   CAST(O.ShippedDate AS DATE) AS ShippedDate,
	   CASE
	   WHEN  5<DATEDIFF(DAY,O.ShippedDate,O.RequiredDate) AND DATEDIFF(DAY,O.ShippedDate,O.RequiredDate)<10
	         THEN 0.1*((UnitPrice*Quantity) * (1-Discount))
	   WHEN  10<DATEDIFF(DAY,O.ShippedDate,O.RequiredDate) AND  DATEDIFF(DAY,O.ShippedDate,O.RequiredDate)<15
	         THEN 0.2*((UnitPrice*Quantity) * (1-Discount))
	   WHEN DATEDIFF(DAY,O.ShippedDate,O.RequiredDate)>15 
	         THEN 0.3*((UnitPrice*Quantity) * (1-Discount))
	   ELSE 0
	   END AS PaymentPenalty
FROM Employees E 
INNER JOIN Orders O ON O.EmployeeID=E.EmployeeID 
INNER JOIN [Order Details] OD ON OD.OrderID=O.OrderID
INNER JOIN Customers c ON c.CustomerID=O.CustomerID

SELECT * FROM [RES]

/*******************************function*****************************************/
CREATE FUNCTION Customer_shops(
@ID as nvarchar(5))
RETURNS TABLE
RETURN
	SELECT p.CategoryID as category,p.ProductName as name,p.QuantityPerUnit as quantityperUnit,s.CompanyName as company
     FROM [Order Details] od , Orders o ,Customers c,Products p	,Suppliers s	  
	WHERE c.CustomerID=@ID and  o.OrderID=od.OrderID and o.CustomerID=c.CustomerID and p.ProductID=od.ProductID and p.SupplierID=s.SupplierID

select * FROM Customer_shops('NORTS')