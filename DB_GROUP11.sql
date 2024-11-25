CREATE DATABASE  IF NOT EXISTS `onlineshopping` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `onlineshopping`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: onlineshopping
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerId` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Phone` int DEFAULT NULL,
  PRIMARY KEY (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'John','Jonte','Nairobi',757483934),(2,'Peter','Peerui','Busia',754379234),(3,'Jane','jruiew','Meru',736547873),(4,'Mary','mruket','Nyeri',754768245),(5,'Grace','Gyurte','Kapsabet',754632345);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `customerorders`
--

DROP TABLE IF EXISTS `customerorders`;
/*!50001 DROP VIEW IF EXISTS `customerorders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customerorders` AS SELECT 
 1 AS `CustomerID`,
 1 AS `CustomerName`,
 1 AS `Email`,
 1 AS `Address`,
 1 AS `Phone`,
 1 AS `OrderId`,
 1 AS `OrderDate`,
 1 AS `TotalAmount`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `customerswithpendingpayments`
--

DROP TABLE IF EXISTS `customerswithpendingpayments`;
/*!50001 DROP VIEW IF EXISTS `customerswithpendingpayments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `customerswithpendingpayments` AS SELECT 
 1 AS `CustomerId`,
 1 AS `CustomerName`,
 1 AS `Email`,
 1 AS `OrderId`,
 1 AS `TotalAmount`,
 1 AS `PaidAmount`,
 1 AS `PendingAmount`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!50001 DROP VIEW IF EXISTS `orderdetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `orderdetails` AS SELECT 
 1 AS `OrderId`,
 1 AS `OrderDate`,
 1 AS `TotalAmount`,
 1 AS `OrderItemid`,
 1 AS `ShoeId`,
 1 AS `ShoeBrand`,
 1 AS `ShoeName`,
 1 AS `ShoeSize`,
 1 AS `Quantity`,
 1 AS `ItemPrice`,
 1 AS `Subtotal`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orderitem`
--

DROP TABLE IF EXISTS `orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='this is the individual item that is ordered by a customer';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitem`
--

LOCK TABLES `orderitem` WRITE;
/*!40000 ALTER TABLE `orderitem` DISABLE KEYS */;
INSERT INTO `orderitem` VALUES (1,2,3,5,4327.55,2),(2,3,4,4,23843.55,3),(3,1,2,3,367289.44,1),(4,5,4,5,43873.55,5),(5,2,1,5,54367.22,2),(6,1,5,3,3500.00,1);
/*!40000 ALTER TABLE `orderitem` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `UpdateOrderTotalAfterOrderItemInsert` AFTER INSERT ON `orderitem` FOR EACH ROW BEGIN
    DECLARE new_total DECIMAL(10,2);
    
    
    SELECT SUM(Price * Quantity) INTO new_total
    FROM OrderItem
    WHERE OrderId = NEW.OrderId;
    
    
    UPDATE Orders
    SET TotalAmount = new_total
    WHERE OrderId = NEW.OrderId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `orderitemsbycustomer`
--

DROP TABLE IF EXISTS `orderitemsbycustomer`;
/*!50001 DROP VIEW IF EXISTS `orderitemsbycustomer`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `orderitemsbycustomer` AS SELECT 
 1 AS `CustomerId`,
 1 AS `CustomerName`,
 1 AS `OrderId`,
 1 AS `OrderItemid`,
 1 AS `ShoeBrand`,
 1 AS `ShoeName`,
 1 AS `Quantity`,
 1 AS `Price`,
 1 AS `Subtotal`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderId` int NOT NULL,
  `OrderDate` date DEFAULT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  `CustomerId` int DEFAULT NULL,
  `Customer_CustomerId` int NOT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `Customer_Order` (`Customer_CustomerId`),
  CONSTRAINT `Customer_Order` FOREIGN KEY (`Customer_CustomerId`) REFERENCES `customer` (`CustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2023-11-04',1112368.32,4,4),(2,'2024-04-21',4679.99,3,3),(3,'2024-07-02',43675.99,1,1),(4,'2024-10-19',43674.99,5,5),(5,'2024-09-21',45738.99,2,2);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `PreventOrderDeleteIfPaid` BEFORE DELETE ON `orders` FOR EACH ROW BEGIN
    DECLARE payment_count INT;
    
    SELECT COUNT(*) INTO payment_count 
    FROM Payment
    WHERE OrderId = OLD.OrderId;
    
    
    IF payment_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete order because it has associated payments';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DeleteOrderItemsWhenOrderDeleted` AFTER DELETE ON `orders` FOR EACH ROW BEGIN
    
    DELETE FROM OrderItem
    WHERE OrderId = OLD.OrderId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,3,'2024-10-14 13:35:56',45375.99,'Cash',3),(2,3,'2024-07-01 14:45:24',2732.99,'Card',3),(3,1,'2024-07-02 07:29:20',1235.99,'Cash',1),(4,5,'2024-10-19 04:35:19',643.99,'Card',5),(5,2,'2024-09-21 03:25:54',3526.99,'Cash',2);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `paymentsummary`
--

DROP TABLE IF EXISTS `paymentsummary`;
/*!50001 DROP VIEW IF EXISTS `paymentsummary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `paymentsummary` AS SELECT 
 1 AS `PaymentId`,
 1 AS `OrderId`,
 1 AS `OrderTotal`,
 1 AS `PaymentDate`,
 1 AS `PaymentAmount`,
 1 AS `PaymentMethod`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `revenuebypaymentmethod`
--

DROP TABLE IF EXISTS `revenuebypaymentmethod`;
/*!50001 DROP VIEW IF EXISTS `revenuebypaymentmethod`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `revenuebypaymentmethod` AS SELECT 
 1 AS `PaymentMethod`,
 1 AS `TotalRevenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `shoe`
--

DROP TABLE IF EXISTS `shoe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='the product to be sold in the online shopping system ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shoe`
--

LOCK TABLES `shoe` WRITE;
/*!40000 ALTER TABLE `shoe` DISABLE KEYS */;
INSERT INTO `shoe` VALUES (1,'Nike','Dunks',33.2,1762.99,2,1),(2,'Nike','Blazers',27.5,326.33,3,4),(3,'Puma','Deviate',32.5,2353.99,4,3),(4,'Adidas','Samba',24.7,2356.44,5,2),(5,'Adidas','Gazelle',35.2,3764.66,2,4),(6,'Nike','Red',27.2,2345.99,3,2),(7,'Nike','Shox R4',28.0,3890.00,3,2);
/*!40000 ALTER TABLE `shoe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'onlineshopping'
--

--
-- Dumping routines for database 'onlineshopping'
--
/*!50003 DROP PROCEDURE IF EXISTS `CancelOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelOrder`(
    IN p_OrderId INT
)
BEGIN
    
    DELETE FROM OrderItem
    WHERE OrderId = p_OrderId;
    
    
    DELETE FROM Orders
    WHERE OrderId = p_OrderId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertShoe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertShoe`(
    IN p_ShoeId INT,
    IN p_Brand VARCHAR(45),
    IN p_Name VARCHAR(45),
    IN p_Size DECIMAL(3,1),
    IN p_Price DECIMAL(10,2),
    IN p_Orders_OrderId INT,
    IN p_OrderItem_OrderItemid INT
)
BEGIN
    INSERT INTO Shoe(ShoeId, Brand, Name, Size, Price, Orders_OrderId, OrderItem_OrderItemid)
    VALUES (p_ShoeId, p_Brand, p_Name, p_Size, p_Price, p_Orders_OrderId, p_OrderItem_OrderItemid);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PlaceOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PlaceOrder`(
    IN p_OrderId INT,
    IN p_CustomerId INT,
    IN p_OrderDate DATE,
    IN p_TotalAmount DECIMAL(10, 2)
)
BEGIN
    
    INSERT INTO Orders (OrderId, OrderDate, TotalAmount, CustomerId)
    VALUES (p_OrderId, p_OrderDate, p_TotalAmount, p_CustomerId);
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `customerorders`
--

/*!50001 DROP VIEW IF EXISTS `customerorders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customerorders` AS select `c`.`CustomerId` AS `CustomerID`,`c`.`Name` AS `CustomerName`,`c`.`Email` AS `Email`,`c`.`Address` AS `Address`,`c`.`Phone` AS `Phone`,`o`.`OrderId` AS `OrderId`,`o`.`OrderDate` AS `OrderDate`,`o`.`TotalAmount` AS `TotalAmount` from (`customer` `c` join `orders` `o` on((`c`.`CustomerId` = `o`.`Customer_CustomerId`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `customerswithpendingpayments`
--

/*!50001 DROP VIEW IF EXISTS `customerswithpendingpayments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customerswithpendingpayments` AS select `c`.`CustomerId` AS `CustomerId`,`c`.`Name` AS `CustomerName`,`c`.`Email` AS `Email`,`o`.`OrderId` AS `OrderId`,`o`.`TotalAmount` AS `TotalAmount`,ifnull(sum(`p`.`Amount`),0) AS `PaidAmount`,(`o`.`TotalAmount` - ifnull(sum(`p`.`Amount`),0)) AS `PendingAmount` from ((`customer` `c` join `orders` `o` on((`c`.`CustomerId` = `o`.`Customer_CustomerId`))) left join `payment` `p` on((`o`.`OrderId` = `p`.`Orders_OrderId`))) group by `o`.`OrderId` having (`PendingAmount` > 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `orderdetails`
--

/*!50001 DROP VIEW IF EXISTS `orderdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `orderdetails` AS select `o`.`OrderId` AS `OrderId`,`o`.`OrderDate` AS `OrderDate`,`o`.`TotalAmount` AS `TotalAmount`,`oi`.`OrderItemid` AS `OrderItemid`,`oi`.`ShoeId` AS `ShoeId`,`s`.`Brand` AS `ShoeBrand`,`s`.`Name` AS `ShoeName`,`s`.`Size` AS `ShoeSize`,`oi`.`Quantity` AS `Quantity`,`oi`.`Price` AS `ItemPrice`,(`oi`.`Quantity` * `oi`.`Price`) AS `Subtotal` from ((`orders` `o` join `orderitem` `oi` on((`o`.`OrderId` = `oi`.`Orders_OrderId`))) join `shoe` `s` on((`oi`.`ShoeId` = `s`.`Shoeid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `orderitemsbycustomer`
--

/*!50001 DROP VIEW IF EXISTS `orderitemsbycustomer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `orderitemsbycustomer` AS select `c`.`CustomerId` AS `CustomerId`,`c`.`Name` AS `CustomerName`,`o`.`OrderId` AS `OrderId`,`oi`.`OrderItemid` AS `OrderItemid`,`s`.`Brand` AS `ShoeBrand`,`s`.`Name` AS `ShoeName`,`oi`.`Quantity` AS `Quantity`,`oi`.`Price` AS `Price`,(`oi`.`Quantity` * `oi`.`Price`) AS `Subtotal` from (((`customer` `c` join `orders` `o` on((`c`.`CustomerId` = `o`.`Customer_CustomerId`))) join `orderitem` `oi` on((`o`.`OrderId` = `oi`.`Orders_OrderId`))) join `shoe` `s` on((`oi`.`ShoeId` = `s`.`Shoeid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `paymentsummary`
--

/*!50001 DROP VIEW IF EXISTS `paymentsummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `paymentsummary` AS select `p`.`PaymentId` AS `PaymentId`,`p`.`OrderId` AS `OrderId`,`o`.`TotalAmount` AS `OrderTotal`,`p`.`PaymentDate` AS `PaymentDate`,`p`.`Amount` AS `PaymentAmount`,`p`.`PaymentMethod` AS `PaymentMethod` from (`payment` `p` join `orders` `o` on((`p`.`Orders_OrderId` = `o`.`OrderId`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `revenuebypaymentmethod`
--

/*!50001 DROP VIEW IF EXISTS `revenuebypaymentmethod`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `revenuebypaymentmethod` AS select `p`.`PaymentMethod` AS `PaymentMethod`,sum(`p`.`Amount`) AS `TotalRevenue` from `payment` `p` group by `p`.`PaymentMethod` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-21 20:30:07
