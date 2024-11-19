/*Create Trigger to Update Order Total After Insert on OrderItem*/
DELIMITER $$
CREATE TRIGGER UpdateOrderTotalAfterOrderItemInsert
AFTER INSERT ON OrderItem
FOR EACH ROW
BEGIN
    DECLARE new_total DECIMAL(10,2);
    -- Calculate the new total amount for the order
    SELECT SUM(Price * Quantity) INTO new_total
    FROM OrderItem
    WHERE OrderId = NEW.OrderId;
    -- Update the total amount in the Orders table
    UPDATE Orders
    SET TotalAmount = new_total
    WHERE OrderId = NEW.OrderId;
END $$
DELIMITER ;

/*Trigger to Delete Related OrderItems When an Order is Deleted: If an order is deleted, delete all associated OrderItem records.*/

DELIMITER $$ 
CREATE TRIGGER DeleteOrderItemsWhenOrderDeleted
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    /*Delete all order items associated with the deleted order*/
    DELETE FROM OrderItem
    WHERE OrderId = OLD.OrderId;
END $$

DELIMITER ;

/*Trigger to Prevent Deletion of an Order If It Has Payment*/

DELIMITER $$ 
CREATE TRIGGER PreventOrderDeleteIfPaid
BEFORE DELETE ON Orders
FOR EACH ROW
BEGIN
    DECLARE payment_count INT;
    /*Check if the order has any associated payments*/
    SELECT COUNT(*) INTO payment_count 
    FROM Payment
    WHERE OrderId = OLD.OrderId;
    
    /*If there are payments, prevent deletion*/
    IF payment_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete order because it has associated payments';
    END IF;
END $$

DELIMITER ;

