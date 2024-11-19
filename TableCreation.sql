CREATE TABLE `shoe` (
  `Shoeid` int NOT NULL,
  `Brand` varchar(45) DEFAULT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `Size` decimal(3,1) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Orders_OrderId` int DEFAULT NULL,
  `OrderItem_OrderItemid` int NOT NULL,
  PRIMARY KEY (`Shoeid`),
  KEY `OrderItem_Shoe` (`OrderItem_OrderItemid`),
  CONSTRAINT `OrderItem_Shoe` FOREIGN KEY (`OrderItem_OrderItemid`) REFERENCES `orderitem` (`OrderItemid`)

CREATE TABLE `customer` (
  `CustomerId` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Phone` int DEFAULT NULL,
  PRIMARY KEY (`CustomerId`)

CREATE TABLE `orderitem` (
  `OrderItemid` int NOT NULL,
  `OrderId` int DEFAULT NULL,
  `ShoeId` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Orders_OrderId` int DEFAULT NULL,
  PRIMARY KEY (`OrderItemid`),
  KEY `Order_OrderItem` (`Orders_OrderId`),
  CONSTRAINT `Order_OrderItem` FOREIGN KEY (`Orders_OrderId`) REFERENCES `orders` (`OrderId`)


CREATE TABLE `orders` (
  `OrderId` int NOT NULL,
  `OrderDate` date DEFAULT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  `CustomerId` int DEFAULT NULL,
  `Customer_CustomerId` int NOT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `Customer_Order` (`Customer_CustomerId`),
  CONSTRAINT `Customer_Order` FOREIGN KEY (`Customer_CustomerId`) REFERENCES `customer` (`CustomerId`)

CREATE TABLE `payment` (
  `PaymentId` int NOT NULL,
  `OrderId` int DEFAULT NULL,
  `PaymentDate` datetime NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL,
  `Orders_OrderId` int DEFAULT NULL,
  PRIMARY KEY (`PaymentId`),
  KEY `Order_Payment` (`Orders_OrderId`),
  CONSTRAINT `Order_Payment` FOREIGN KEY (`Orders_OrderId`) REFERENCES `orders` (`OrderId`)
