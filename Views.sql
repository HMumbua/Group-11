/*Customer order View*/
CREATE VIEW CustomerOrders AS
SELECT c.CustomerId,c.Name AS CustomerName,c.Email,c.Address,c.Phone,o.OrderId, o.OrderDate, o.TotalAmount FROM customer c JOIN orders o ON c.CustomerId = o.Customer_CustomerId;

/*displaying the order details view*/
CREATE VIEW OrderDetails AS 
SELECT o.OrderId, o.OrderDate, o.TotalAmount, oi.OrderItemid, oi.ShoeId, s.Brand AS ShoeBrand, s.Name AS ShoeName, s.Size AS ShoeSize, oi.Quantity, oi.Price AS ItemPrice, (oi.Quantity * oi.Price) AS Subtotal FROM orders o JOIN orderitem oi ON o.OrderId = oi.Orders_OrderId JOIN shoe s ON oi.ShoeId = s.Shoeid;

/*payment summary view*/

CREATE VIEW PaymentSummary AS
SELECT p.PaymentId, p.OrderId,o.TotalAmount AS OrderTotal, p.PaymentDate, p.Amount AS PaymentAmount,p.PaymentMethod FROM payment p JOIN orders o ON p.Orders_OrderId = o.OrderId;

/*customers with pending payment view*/

CREATE VIEW CustomersWithPendingPayments AS
SELECT c.CustomerId, c.Name AS CustomerName,c.Email,o.OrderId,o.TotalAmount, IFNULL(SUM(p.Amount), 0) AS PaidAmount,(o.TotalAmount - IFNULL(SUM(p.Amount), 0)) AS PendingAmount
FROM customer c
JOIN orders o ON c.CustomerId = o.Customer_CustomerId
LEFT JOIN payment p ON o.OrderId = p.Orders_OrderId
GROUP BY o.OrderId
HAVING PendingAmount > 0;

/*items ordered by each customer*/
CREATE VIEW OrderItemsByCustomer AS
SELECT c.CustomerId,c.Name AS CustomerName,o.OrderId,oi.OrderItemid,s.Brand AS ShoeBrand,s.Name AS ShoeName,oi.Quantity,oi.Price,(oi.Quantity * oi.Price) AS Subtotal
FROM customer c
JOIN orders o ON c.CustomerId = o.Customer_CustomerId
JOIN orderitem oi ON o.OrderId = oi.Orders_OrderId
JOIN shoe s ON oi.ShoeId = s.Shoeid;

/*Summary of the total revenue made by each payment method*/
CREATE VIEW RevenueByPaymentMethod AS
SELECT p.PaymentMethod, SUM(p.Amount) AS TotalRevenue FROM payment p GROUP BY p.PaymentMethod;

