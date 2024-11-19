POPULATING THE ONLINE SHOPPING SYSTEM DATABASE WITH SAMPLE DATA

INSERT INTO
Customer(CustomerId,Name,Email,Address,Phone)VALUES(001,'John','Jonte','Nairobi',0757483934),(002,'Peter','Peerui','Busia',0754379234),(003,'Jane','jruiew','Meru',0736547873),(004,'Mary','mruket','Nyeri',0754768245),(005,'Grace', 'Gyurte','Kapsabet',0754632345);

INSERT INTO Orders(OrderId,OrderDate,TotalAmount,CustomerId,Customer_CustomerId)VALUES(001,'2023-11-04',5000.99,004,004),(002,'2024-04-21',4679.99,003,003),(003,'2024-07-02',43675.99,001,001),(004,'2024-10-19',43674.99,005,005),(005,'2024-09-21',45738.99,002,002);

INSERT INTO Payment(PaymentID,OrderId,PaymentDate,Amount,PaymentMethod,Orders_OrderId)VALUES(001,003,'2024-10-14 13:35:56',45375.99,'Cash',003),(002,003,'2024-07-01 14:45:24',2732.99,'Card',003),(003,001,'2024-07-02 07:29:20',1235.99,'Cash',001),(004,005,'2024-10-19 04:35:19',643.99,'Card',005),(005,002,'2024-09-21 03:25;54',3526.99,'Cash',002);

INSERT INTO Shoe(ShoeId,Brand,Name,Size,Price,Orders_OrderId,OrderItem_OrderItemId)VALUES(001,'Nike','Dunks',33.2,1762.99,002,001),(002,'Nike','Blazers',27.5,326.33,003,004),(003,'Puma','Deviate',32.5,2353.99,004,003),(004,'Adidas','Samba',24.7,2356.44,005,002),(005,'Adidas','Gazelle',35.2,3764.66,002,004);

INSERT INTO OrderItem(OrderItemid,OrderId,ShoeId,Quantity,Price,Orders_OrderId)VALUES(001,002,003,5,4327.55,002),(002,003,004,4,23843.55,003),(003,001,002,3,367289.44,001),(004,005,004,5,43873.55,005),(005,002,001,5,54367.22,002);

CRUD OPERATIONS
CREATE

INSERT INTO Shoe(ShoeId,Brand,Name,Size,Price,Orders_OrderId,OrderItem_OrderItemId)VALUES(006,'Nike','Red',27.2,2345.99,003,002);

INSERT INTO OrderItem(OrderItemid,OrderId,ShoeId,Quantity,Price,Orders_OrderId)VALUES(006,004,003,3,5485.99,004);

INSERT INTO Payment(PaymentID,OrderId,PaymentDate,Amount,PaymentMethod,Orders_OrderId)VALUES(006,002,'2024-12-03 11:45:56',4387.99,'Cash',002);

INSERT INTO Orders(OrderId,OrderDate,TotalAmount,CustomerId,Customer_CustomerId)VALUES(006,'2022-09-06',5000.99,003,003);

INSERT INTO Customer(CustomerId,Name,Email,Address,Phone)VALUES(006,'James','yeh','Eldoret',075758435);

READ

SELECT * FROM shoe;

SELECT * FROM Orders;

SELECT * FROM Payment;

SELECT * FROM OrderItem;

SELECT * FROM Customer;

UPDATE

UPDATE payment SET Amount=6473.88 WHERE PaymentId=003;

UPDATE Customer SET Name='Ken' WHERE CustomerId=005;

UPDATE Shoe SET Brand='Jordans' WHERE ShoeId=002;

UPDATE Orders SET TotalAmount='5347.99' WHERE OrderId=001;

UPDATE OrderItem SET Quantity=5 WHERE OrderItemId=005;

DELETE

DELETE FROM Orders Where Orderid=006;

DELETE FROM Customer Where Customerid=006;

DELETE FROM Payment Where Paymentid=006;

DELETE FROM Shoe Where Shoeid=006;

DELETE FROM OrderItem Where OrderItemid=006;

