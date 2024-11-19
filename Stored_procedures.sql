/*Stored procedures example to insert Shoe:*/

DELIMITER $$
CREATE PROCEDURE InsertShoe(
    IN p_ShoeId INT,
    IN p_Brand VARCHAR(100),
    IN p_Name VARCHAR(100),
    IN p_Size DECIMAL(3,1),
    IN p_Price DECIMAL(10,2)
)
BEGIN
    INSERT INTO Shoe (ShoeId, Brand, Name, Size, Price) 
    VALUES (p_ShoeId, p_Brand, p_Name, p_Size, p_Price);
END$$
DELIMITER ;

/*Stored Procedure to Place an Order:*/ 

DELIMITER $$
CREATE PROCEDURE PlaceOrder(
    IN p_OrderId INT,
    IN p_CustomerId INT,
    IN p_OrderDate DATE,
    IN p_TotalAmount DECIMAL(10, 2)
)
BEGIN
    /*Insert new order into Orders table*/
    INSERT INTO Orders (OrderId, OrderDate, TotalAmount, CustomerId)
    VALUES (p_OrderId, p_OrderDate, p_TotalAmount, p_CustomerId);
    
    END$$
DELIMITER ;

/*Stored Procedure to Cancel an Order:*/

DELIMITER $$

CREATE PROCEDURE CancelOrder(
    IN p_OrderId INT
)
BEGIN
    /* Deleting all order items for the order */
    DELETE FROM OrderItem
    WHERE OrderId = p_OrderId;
    
    /* Deleting the order itself */
    DELETE FROM Orders
    WHERE OrderId = p_OrderId;
END$$

DELIMITER ;




 