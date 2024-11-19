advanced queries:
/*1. Customers with Highest Number of Products Ordered*/

SELECT c.CustomerId, c.Name AS CustomerName, SUM(oi.Quantity) AS TotalQuantityOrdered FROM Customer c JOIN Orders o ON c.CustomerId = o.Customer_CustomerId JOIN OrderItem oi ON o.OrderId = oi.OrderId GROUP BY c.CustomerId ORDER BY TotalQuantityOrdered DESC LIMIT 10;

/*2. monthly revenue per shoe brand and its trend, including a running total for each shoe.*/

WITH ShoeRevenue AS ( SELECT s.ShoeId, s.Brand, DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month, SUM(oi.Quantity * oi.Price) AS Revenue FROM Shoe s JOIN OrderItem oi ON s.ShoeId = oi.ShoeId JOIN Orders o ON oi.OrderId = o.OrderId GROUP BY s.ShoeId, s.Brand, Month ) SELECT ShoeId,Brand,Month, Revenue, SUM(Revenue) OVER (PARTITION BY ShoeId ORDER BY Month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal FROM ShoeRevenue ORDER BY ShoeId, Month DESC;

/*3. most profitable shoes by brand, categorized by customer type (e.g., first-time customers, returning customers*/

WITH ShoeProfitability AS ( SELECT s.Brand, s.ShoeId, SUM(oi.Quantity * oi.Price) AS Revenue, c.CustomerId, CASE WHEN COUNT(o.OrderId) = 1 THEN 'First-Time Customer' ELSE 'Returning Customer' END AS CustomerType FROM Shoe s JOIN OrderItem oi ON s.ShoeId = oi.ShoeId JOIN Orders o ON oi.OrderId = o.OrderId JOIN Customer c ON o.Customer_CustomerId = c.CustomerId GROUP BY s.Brand, s.ShoeId, c.CustomerId ) SELECT Brand, ShoeId, CustomerType, SUM(Revenue) AS TotalRevenue FROM ShoeProfitability GROUP BY Brand, ShoeId, CustomerType ORDER BY TotalRevenue DESC;

/*4.  Orders Without Payments*/

SELECT o.OrderId, o.TotalAmount FROM Orders o LEFT JOIN Payment p ON o.OrderId = p.Orders_OrderId WHERE p.PaymentId IS NULL;

/*5. Calculates how much each customer has spent in total.*/

SELECT c.CustomerId, c.Name AS CustomerName,SUM(o.TotalAmount) AS TotalSpent FROM Customer c JOIN Orders o ON c.CustomerId = o.Customer_CustomerId GROUP BY c.CustomerId, c.Name ORDER BY TotalSpent DESC;

/*6.Lists the shoes that have generated more than 1000/- in revenue. */
SELECT s.ShoeId, s.Name AS ShoeName, SUM(oi.Quantity * oi.Price) AS TotalRevenue FROM Shoe s JOIN OrderItem oi ON s.ShoeId = oi.ShoeId GROUP BY s.ShoeId, s.Name HAVING TotalRevenue > 1000 ORDER BY TotalRevenue DESC;

/*7. Calculating the average order value for all customers.*/
SELECT AVG(o.TotalAmount) AS AverageOrderValue FROM Orders o;


