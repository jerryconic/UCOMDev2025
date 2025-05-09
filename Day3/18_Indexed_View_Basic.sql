USE AdventureWorks2019
SELECT  CUST.CustomerID ,
        PER.FirstName ,
        PER.LastName ,
        SOH.SalesOrderID ,
        SOH.OrderDate ,
        SOH.[Status] ,
        SOD.ProductID ,
        PROD.Name ,
        SOD.OrderQty
FROM    Sales.SalesOrderHeader SOH
        INNER JOIN Sales.SalesOrderDetail SOD 
               ON SOH.SalesOrderID = SOD.SalesOrderID
        INNER JOIN Production.Product PROD
               ON PROD.ProductID = SOD.ProductID
        INNER JOIN Sales.Customer CUST
               ON SOH.CustomerID = CUST.CustomerID
        INNER JOIN Person.Person PER
               ON PER.BusinessEntityID = CUST.PersonID;

SELECT  CUST.CustomerID ,
        SOH.SalesOrderID ,
        SOH.OrderDate ,
        SOD.ProductID ,
        PROD.Name ,
        SUM(SOD.OrderQty) AS TotalSpent
FROM    Sales.SalesOrderHeader SOH
        INNER JOIN Sales.SalesOrderDetail SOD
               ON SOH.SalesOrderID = SOD.SalesOrderID
        INNER JOIN Production.Product PROD
               ON PROD.ProductID = SOD.ProductID
        INNER JOIN Sales.Customer CUST
               ON SOH.CustomerID = CUST.CustomerID
        INNER JOIN Person.Person PER
               ON PER.BusinessEntityID = CUST.PersonID
GROUP BY CUST.CustomerID ,
        SOH.SalesOrderID ,
        SOH.OrderDate ,
        SOD.ProductID ,
        PROD.Name; 