Generating reports- SQL QUERIES
/* 1. Sales Revenue report- Showing total revenue for a specific period.*/
SELECT DATE(OrderDate) AS SaleDate, SUM(TotalAmount) AS TotalRevenue FROM Orders GROUP BY SaleDate ORDER BY SaleDate DESC;

/*2. Customer order report with total number of orders the customers have and the total spend*/
SELECT 
    c.CustomerId,c.Name AS CustomerName,COUNT(o.OrderId) AS TotalOrders, SUM(o.TotalAmount) AS TotalSpent FROM Customer c JOIN Orders o ON c.CustomerId = o.Customer_CustomerId GROUP BY c.CustomerId, c.Name ORDER BY TotalSpent DESC;

/*3. displaying report for the most ordered shoes with their quantity and the revenue*/

SELECT s.ShoeId,s.Brand,s.Name AS ShoeName,SUM(oi.Quantity) AS TotalSold,SUM(oi.Quantity * oi.Price) AS TotalRevenue FROM Shoe s JOIN OrderItem oi ON s.ShoeId = oi.ShoeId GROUP BY s.ShoeId, s.Brand, s.Name ORDER BY TotalSold DESC LIMIT 10;

/*4. Pending payment report to show the customers who have pending payments for their orders*/
SELECT c.CustomerId, c.Name AS CustomerName,o.OrderId, o.TotalAmount, IFNULL(SUM(p.Amount), 0) AS PaidAmount,(o.TotalAmount - IFNULL(SUM(p.Amount), 0)) AS PendingAmount FROM Customer c JOIN Orders o ON c.CustomerId = o.Customer_CustomerId LEFT JOIN Payment p ON o.OrderId = p.Orders_OrderId GROUP BY o.OrderId HAVING PendingAmount > 0 ORDER BY PendingAmount DESC;

/*5. Payment method report- shows a report of the total revenue collected by each payment method and the transactions made by each payment method*/
SELECT p.PaymentMethod,COUNT(p.PaymentId) AS TransactionsCount, SUM(p.Amount) AS TotalRevenue FROM Payment p GROUP BY p.PaymentMethod ORDER BY TotalRevenue DESC;

/*6. report to show the total revenue generated for each month*/
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS Month, SUM(TotalAmount) AS MonthlyRevenue FROM Orders GROUP BY Month ORDER BY Month DESC;

/*7. Revenue collected by every shoe brand*/

SELECT s.Brand,SUM(oi.Quantity * oi.Price) AS TotalRevenue FROM Shoe s JOIN OrderItem oi ON s.ShoeId = oi.ShoeId GROUP BY s.Brand ORDER BY TotalRevenue DESC;
