CREATE DATABASE  IF NOT EXISTS `db_icase_seminario` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_icase_seminario`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: db_icase_seminario
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.24.04.1

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
-- Table structure for table `tb_ajuste_inventario`
--

DROP TABLE IF EXISTS `tb_ajuste_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_ajuste_inventario` (
  `id_ajuste` varchar(36) NOT NULL DEFAULT (uuid()),
  `razon_ajuste` varchar(200) NOT NULL,
  `cantidad_ajuste` int NOT NULL,
  `stock_anterior` int NOT NULL,
  `stock_nuevo` int NOT NULL,
  `id_producto` varchar(36) DEFAULT NULL,
  `nota` text,
  `fecha_ajuste` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` tinyint(1) DEFAULT '1',
  `tipo_ajuste` enum('INCREMENTO','DISMINUCION') NOT NULL,
  PRIMARY KEY (`id_ajuste`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `tb_ajuste_inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `tb_productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_ajuste_inventario`
--

LOCK TABLES `tb_ajuste_inventario` WRITE;
/*!40000 ALTER TABLE `tb_ajuste_inventario` DISABLE KEYS */;
INSERT INTO `tb_ajuste_inventario` VALUES ('b0b42579-c236-11ef-82a9-c03fd5ad989d',' Equivocacion al crear  el cosos',1,24,25,'6dcd625f-a953-11ef-a9f6-00e04cf010f7','Probando primer ajuste','2024-12-25 01:36:02',1,'INCREMENTO'),('dea2f22b-c236-11ef-82a9-c03fd5ad989d','probando disminucion ',1,25,24,'6dcd625f-a953-11ef-a9f6-00e04cf010f7','Probando disminucion','2024-12-25 01:37:19',1,'DISMINUCION');
/*!40000 ALTER TABLE `tb_ajuste_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_categorias`
--

DROP TABLE IF EXISTS `tb_categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_categorias` (
  `id_categoria` varchar(36) NOT NULL DEFAULT (uuid()),
  `nombre_cat` varchar(100) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nombre_cat_UNIQUE` (`nombre_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_categorias`
--

LOCK TABLES `tb_categorias` WRITE;
/*!40000 ALTER TABLE `tb_categorias` DISABLE KEYS */;
INSERT INTO `tb_categorias` VALUES ('0f5fac59-83cd-11ef-8655-00e04cf010f7','Cargadores',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fd5ba-83cd-11ef-8655-00e04cf010f7','Auriculares',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fd763-83cd-11ef-8655-00e04cf010f7','Fundas',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fd849-83cd-11ef-8655-00e04cf010f7','Protectores de pantalla',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fd92a-83cd-11ef-8655-00e04cf010f7','Teclados',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fd9f9-83cd-11ef-8655-00e04cf010f7','Ratones',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fdac4-83cd-11ef-8655-00e04cf010f7','Monitores',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fdb8f-83cd-11ef-8655-00e04cf010f7','Accesorios de gaming',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fdc63-83cd-11ef-8655-00e04cf010f7','Baterías externas',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fdd27-83cd-11ef-8655-00e04cf010f7','Webcams',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fdded-83cd-11ef-8655-00e04cf010f7','Discos duros externos',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fdeb2-83cd-11ef-8655-00e04cf010f7','Adaptadores',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fdf78-83cd-11ef-8655-00e04cf010f7','Soportes para móviles',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('0f5fe03f-83cd-11ef-8655-00e04cf010f7','Estuches para PC',1,'2024-10-06 10:23:42','2024-10-06 10:23:42'),('a096a329-8b59-11ef-893b-00e04cf010f7','Categoria Prueba',1,'2024-10-16 05:57:32','2024-10-16 05:57:33'),('afcf750e-94eb-11ef-a166-00e04cf010f7','Senati Prueba',0,'2024-10-28 10:15:44','2024-10-28 10:15:46');
/*!40000 ALTER TABLE `tb_categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cliente`
--

DROP TABLE IF EXISTS `tb_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_cliente` (
  `id_cliente` varchar(36) NOT NULL DEFAULT (uuid()),
  `id_persona` varchar(36) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `tipo_cliente` enum('RECURRENTE','CASUAL','VIP','CORPORATIVO') DEFAULT 'CASUAL',
  `clasificacion` enum('A','B','C') DEFAULT 'C',
  `ultima_compra` date DEFAULT NULL,
  `total_compras` decimal(10,2) DEFAULT '0.00',
  `observaciones` text,
  `codigo_cliente` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `codigo_cliente` (`codigo_cliente`),
  KEY `id_persona` (`id_persona`),
  CONSTRAINT `tb_cliente_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `tb_personas` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente`
--

LOCK TABLES `tb_cliente` WRITE;
/*!40000 ALTER TABLE `tb_cliente` DISABLE KEYS */;
INSERT INTO `tb_cliente` VALUES ('18176837-c3e7-11ef-9148-c03fd5ad989d','0a6cda84-c3e7-11ef-9148-c03fd5ad989d',1,'2024-12-27 00:11:18','CASUAL','C',NULL,0.00,'Cliente creado \n','CLI00003'),('5bf2dc52-b2d1-11ef-833c-00e04cf010f7','00808406-93f0-11ef-ab9a-00e04cf010f7',1,'2024-12-05 06:22:53','CASUAL','C','2024-12-14',2301.00,'Cliente uwunt 2','CLI00002'),('7de31aee-ab95-11ef-95f5-00e04cf010f7','e51c6fa5-83d0-11ef-8655-00e04cf010f7',1,'2024-11-25 20:26:42','CASUAL','C','2024-12-14',1710.75,NULL,'CLI00001');
/*!40000 ALTER TABLE `tb_cliente` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_cliente` BEFORE INSERT ON `tb_cliente` FOR EACH ROW BEGIN
    DECLARE siguiente_numero INT;
    
    -- Obtener el último número del código de cliente
    SELECT COALESCE(MAX(CAST(SUBSTRING(codigo_cliente, 8) AS SIGNED)), 0) + 1
    INTO siguiente_numero
    FROM tb_cliente;
    
    -- Generar el nuevo código (CLI00001)
    SET NEW.codigo_cliente = CONCAT('CLI', LPAD(siguiente_numero, 5, '0'));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_compra`
--

DROP TABLE IF EXISTS `tb_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_compra` (
  `id_compra` varchar(36) NOT NULL DEFAULT (uuid()),
  `id_metodo_pago` varchar(36) DEFAULT NULL,
  `proveedor_id` varchar(36) DEFAULT NULL,
  `proveedor_ruc` varchar(15) DEFAULT NULL,
  `proveedor_correo` varchar(100) DEFAULT NULL,
  `numero_documento` varchar(20) DEFAULT NULL,
  `compra_subtotal` decimal(10,2) DEFAULT NULL,
  `compra_igv` decimal(10,2) DEFAULT NULL,
  `compra_total` decimal(10,2) DEFAULT NULL,
  `compra_comentario` text,
  `fecha_compra` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_compra`),
  KEY `id_metodo_pago` (`id_metodo_pago`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `tb_compra_ibfk_1` FOREIGN KEY (`id_metodo_pago`) REFERENCES `tb_metodo_pago` (`id_metodo_pago`),
  CONSTRAINT `tb_compra_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `tb_proveedores` (`id_proveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_compra`
--

LOCK TABLES `tb_compra` WRITE;
/*!40000 ALTER TABLE `tb_compra` DISABLE KEYS */;
INSERT INTO `tb_compra` VALUES ('054225ed-b0e2-11ef-ad0f-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7','d7530666-ab98-11ef-95f5-00e04cf010f7','76543221','1433044@senati.pe','COM-1733167026850',79.99,14.40,94.39,'PROVANDO LA FEHCA ULTIMA','2024-12-03 00:17:07'),('0f91efe3-abb6-11ef-95f5-00e04cf010f7','7ec5eedd-a5ed-11ef-84ff-00e04cf010f7','d7530666-ab98-11ef-95f5-00e04cf010f7','76543221','1433044@senati.pe','COM-1732598390465',79.99,0.00,79.99,'prvando provedore venta reporte','2024-11-26 10:19:51'),('192bb365-ba2d-11ef-a8f5-c03fd5ad989d','7ec5850f-a5ed-11ef-84ff-00e04cf010f7','bc511764-b101-11ef-ad0f-00e04cf010f7','1020304948','jose.martin@example.com','COM-1734188833013',449.91,80.98,530.89,'PRonvado coso','2024-12-14 20:07:13'),('7e3043af-ba29-11ef-a8f5-c03fd5ad989d','7ec5850f-a5ed-11ef-84ff-00e04cf010f7','9def0c01-a954-11ef-a9f6-00e04cf010f7','20136353315','eps.gmail.com','COM-1734187284505',20.00,3.60,23.60,'Compras incremnete','2024-12-14 19:41:25'),('9434b72b-b0e3-11ef-ad0f-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7','d7530666-ab98-11ef-95f5-00e04cf010f7','76543221','1433044@senati.pe','COM-1733167696211',79.99,14.40,94.39,'PROBANDO TRIGGER\n','2024-12-03 00:28:16'),('95efe6da-b0e5-11ef-ad0f-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7','d7530666-ab98-11ef-95f5-00e04cf010f7','76543221','1433044@senati.pe','COM-1733168558098',29.99,5.40,35.39,'PROBADO 2 TRIGGER FEHCA','2024-12-03 00:42:38'),('a51e67c0-aba1-11ef-95f5-00e04cf010f7','7ec5a6ae-a5ed-11ef-84ff-00e04cf010f7','d7530666-ab98-11ef-95f5-00e04cf010f7','76543221','1433044@senati.pe','COM-1732589621729',29.99,0.00,29.99,'CHecgha','2024-11-26 07:53:42'),('b002166f-b9b8-11ef-bedc-c03fd5ad989d','7ec5850f-a5ed-11ef-84ff-00e04cf010f7','9def0c01-a954-11ef-a9f6-00e04cf010f7','20136353315','eps.gmail.com','COM-1734138834960',39.99,7.20,47.19,'Probando compra dia 14','2024-12-14 06:13:55'),('b3c653ac-ba28-11ef-a8f5-c03fd5ad989d','7ec5850f-a5ed-11ef-84ff-00e04cf010f7','9def0c01-a954-11ef-a9f6-00e04cf010f7','20136353315','eps.gmail.com','COM-1734186944911',39.99,7.20,47.19,'Probando reoporta 10 compras','2024-12-14 19:35:45'),('e5192ffa-b25d-11ef-a732-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7','9def0c01-a954-11ef-a9f6-00e04cf010f7','20136353315','eps.gmail.com','COM-1733330181666',14.99,2.70,17.69,'PRONADO A EPS.SEDACURSO.SAA','2024-12-04 21:36:22');
/*!40000 ALTER TABLE `tb_compra` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_metricas_proveedor` AFTER INSERT ON `tb_compra` FOR EACH ROW BEGIN
    -- Variables para manejar cálculos
    DECLARE total_compras_proveedor DECIMAL(10,2);
    DECLARE ultima_compra_proveedor DATE;

    -- Calcular total de compras al proveedor
    SELECT 
        COALESCE(SUM(compra_total), 0),
        MAX(fecha_compra)
    INTO 
        total_compras_proveedor,
        ultima_compra_proveedor
    FROM 
        tb_compra
    WHERE 
        proveedor_id = NEW.proveedor_id;

    -- Actualizar métricas del proveedor
    UPDATE tb_proveedores 
    SET 
        total_compras = total_compras_proveedor,
        ultima_compra = ultima_compra_proveedor,
        updated_at = CURRENT_TIMESTAMP
    WHERE 
        id_proveedor = NEW.proveedor_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_fecha_compra` AFTER INSERT ON `tb_compra` FOR EACH ROW BEGIN
    -- Actualizar la última compra con la fecha y hora actual de la nueva compra
    UPDATE tb_proveedores 
    SET 
        ultima_compra = NOW(),  -- Registra la fecha y hora actuales
        updated_at = NOW()      -- Actualiza el timestamp de actualización
    WHERE 
        id_proveedor = NEW.proveedor_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_detalle_compra`
--

DROP TABLE IF EXISTS `tb_detalle_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_detalle_compra` (
  `id_detalle_compra` varchar(36) NOT NULL DEFAULT (uuid()),
  `id_compra` varchar(36) DEFAULT NULL,
  `id_producto` varchar(36) DEFAULT NULL,
  `id_categoria` varchar(36) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `fecha_compra` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_detalle_compra`),
  KEY `id_compra` (`id_compra`),
  KEY `id_producto` (`id_producto`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `tb_detalle_compra_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `tb_compra` (`id_compra`),
  CONSTRAINT `tb_detalle_compra_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `tb_productos` (`id_producto`),
  CONSTRAINT `tb_detalle_compra_ibfk_3` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categorias` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_detalle_compra`
--

LOCK TABLES `tb_detalle_compra` WRITE;
/*!40000 ALTER TABLE `tb_detalle_compra` DISABLE KEYS */;
INSERT INTO `tb_detalle_compra` VALUES ('054957cf-b0e2-11ef-ad0f-00e04cf010f7','054225ed-b0e2-11ef-ad0f-00e04cf010f7','6dcd625f-a953-11ef-a9f6-00e04cf010f7','0f5fdc63-83cd-11ef-8655-00e04cf010f7',1,79.99,79.99,'2024-12-02 19:17:07','2024-12-03 00:17:07'),('0f9fce5d-abb6-11ef-95f5-00e04cf010f7','0f91efe3-abb6-11ef-95f5-00e04cf010f7','6dcd625f-a953-11ef-a9f6-00e04cf010f7','0f5fdb8f-83cd-11ef-8655-00e04cf010f7',1,79.99,79.99,'2024-11-26 05:19:51','2024-11-26 10:19:51'),('192ccbab-ba2d-11ef-a8f5-c03fd5ad989d','192bb365-ba2d-11ef-a8f5-c03fd5ad989d','6dcc786d-a953-11ef-a9f6-00e04cf010f7','0f5fdd27-83cd-11ef-8655-00e04cf010f7',9,49.99,449.91,'2024-12-14 15:07:13','2024-12-14 20:07:13'),('7e30c80b-ba29-11ef-a8f5-c03fd5ad989d','7e3043af-ba29-11ef-a8f5-c03fd5ad989d','1645df7b-b06e-11ef-a589-00e04cf010f7','0f5fac59-83cd-11ef-8655-00e04cf010f7',1,20.00,20.00,'2024-12-14 14:41:25','2024-12-14 19:41:25'),('94366e6b-b0e3-11ef-ad0f-00e04cf010f7','9434b72b-b0e3-11ef-ad0f-00e04cf010f7','6dcd931f-a953-11ef-a9f6-00e04cf010f7','0f5fd5ba-83cd-11ef-8655-00e04cf010f7',1,79.99,79.99,'2024-12-02 19:28:16','2024-12-03 00:28:16'),('95f1fd86-b0e5-11ef-ad0f-00e04cf010f7','95efe6da-b0e5-11ef-ad0f-00e04cf010f7','6dc9a5d1-a953-11ef-a9f6-00e04cf010f7','0f5fdeb2-83cd-11ef-8655-00e04cf010f7',1,29.99,29.99,'2024-12-02 19:42:38','2024-12-03 00:42:38'),('a51ffeaa-aba1-11ef-95f5-00e04cf010f7','a51e67c0-aba1-11ef-95f5-00e04cf010f7','6dc9a5d1-a953-11ef-a9f6-00e04cf010f7','0f5fdc63-83cd-11ef-8655-00e04cf010f7',1,29.99,29.99,'2024-11-26 02:53:42','2024-11-26 07:53:42'),('b002da49-b9b8-11ef-bedc-c03fd5ad989d','b002166f-b9b8-11ef-bedc-c03fd5ad989d','6dcc121d-a953-11ef-a9f6-00e04cf010f7','0f5fd5ba-83cd-11ef-8655-00e04cf010f7',1,39.99,39.99,'2024-12-14 01:13:55','2024-12-14 06:13:55'),('b2acb748-a954-11ef-a9f6-00e04cf010f7','b2a9a073-a954-11ef-a9f6-00e04cf010f7','6dcd9e62-a953-11ef-a9f6-00e04cf010f7','0f5fd9f9-83cd-11ef-8655-00e04cf010f7',1,149.99,149.99,'2024-11-25 19:53:18','2024-11-26 00:53:18'),('b3c6e95d-ba28-11ef-a8f5-c03fd5ad989d','b3c653ac-ba28-11ef-a8f5-c03fd5ad989d','6dcc121d-a953-11ef-a9f6-00e04cf010f7','0f5fd5ba-83cd-11ef-8655-00e04cf010f7',1,39.99,39.99,'2024-12-14 14:35:45','2024-12-14 19:35:45'),('e51ae580-b25d-11ef-a732-00e04cf010f7','e5192ffa-b25d-11ef-a732-00e04cf010f7','6dcc9e8e-a953-11ef-a9f6-00e04cf010f7','0f5fdd27-83cd-11ef-8655-00e04cf010f7',1,14.99,14.99,'2024-12-04 16:36:22','2024-12-04 21:36:22');
/*!40000 ALTER TABLE `tb_detalle_compra` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_purchase_update_kardex` AFTER INSERT ON `tb_detalle_compra` FOR EACH ROW BEGIN
    DECLARE v_stock_actual INT;
    
    -- Obtener stock actual del producto
    SELECT COALESCE(stock, 0) INTO v_stock_actual
    FROM tb_productos
    WHERE id_producto = NEW.id_producto;
    
    -- Insertar movimiento en kardex
    INSERT INTO tb_kardex (
        id_producto,
        tipo_movimiento,
        tipo_documento,
        numero_documento,
        cantidad,
        precio_unitario,
        total,
        stock_anterior,
        stock_actual
    )
    SELECT 
        NEW.id_producto,
        'ENTRADA',
        'COMPRA',
        c.numero_documento,
        NEW.cantidad,
        NEW.precio_unitario,
        NEW.subtotal,
        v_stock_actual,
        v_stock_actual + NEW.cantidad
    FROM tb_compra c
    WHERE c.id_compra = NEW.id_compra;
    
    -- Actualizar stock en productos
    UPDATE tb_productos
    SET stock = stock + NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_detalle_venta`
--

DROP TABLE IF EXISTS `tb_detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_detalle_venta` (
  `id_detalle_venta` varchar(36) NOT NULL DEFAULT (uuid()),
  `id_venta` varchar(36) DEFAULT NULL,
  `id_producto` varchar(36) DEFAULT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `descuento` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_detalle_venta`),
  KEY `id_producto` (`id_producto`),
  KEY `id_venta` (`id_venta`),
  CONSTRAINT `tb_detalle_venta_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `tb_productos` (`id_producto`),
  CONSTRAINT `tb_detalle_venta_ibfk_2` FOREIGN KEY (`id_venta`) REFERENCES `tb_ventas` (`id_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_detalle_venta`
--

LOCK TABLES `tb_detalle_venta` WRITE;
/*!40000 ALTER TABLE `tb_detalle_venta` DISABLE KEYS */;
INSERT INTO `tb_detalle_venta` VALUES ('107d7583-baa1-11ef-bd3b-c03fd5ad989d','107c61a8-baa1-11ef-bd3b-c03fd5ad989d','6dcd931f-a953-11ef-a9f6-00e04cf010f7',1,79.99,79.99,NULL,10.00,'2024-12-15 09:57:20'),('1d226edb-b21c-11ef-984d-00e04cf010f7','1d207673-b21c-11ef-984d-00e04cf010f7','6dcd83f1-a953-11ef-a9f6-00e04cf010f7',1,54.99,54.99,NULL,0.00,'2024-12-04 13:45:29'),('1fb70037-b2a4-11ef-833c-00e04cf010f7','1fb19dbd-b2a4-11ef-833c-00e04cf010f7','6dcc786d-a953-11ef-a9f6-00e04cf010f7',1,49.99,49.99,NULL,0.00,'2024-12-05 05:59:05'),('4718cd91-b251-11ef-a732-00e04cf010f7','4717607f-b251-11ef-a732-00e04cf010f7','6dccc78b-a953-11ef-a9f6-00e04cf010f7',1,119.99,119.99,NULL,0.00,'2024-12-04 20:06:03'),('66ef5d6a-b254-11ef-a732-00e04cf010f7','66ee18a9-b254-11ef-a732-00e04cf010f7','6dcc388a-a953-11ef-a9f6-00e04cf010f7',1,199.99,199.99,NULL,100.00,'2024-12-04 20:28:25'),('70ced9d4-ab97-11ef-95f5-00e04cf010f7','1afa1e91-ab97-11ef-95f5-00e04cf010f7','6dcc121d-a953-11ef-a9f6-00e04cf010f7',1,100.00,100.00,118.00,0.00,'2024-11-26 01:40:39'),('7679b5f4-ba1c-11ef-8045-c03fd5ad989d','7678ee38-ba1c-11ef-8045-c03fd5ad989d','e43edf9c-b9af-11ef-b775-c03fd5ad989d',1,1200.00,1200.00,NULL,0.00,'2024-12-14 18:08:08'),('7f848ffc-b24f-11ef-a732-00e04cf010f7','7f77a53a-b24f-11ef-a732-00e04cf010f7','6dcc9e8e-a953-11ef-a9f6-00e04cf010f7',1,14.99,14.99,NULL,0.00,'2024-12-04 19:53:18'),('9c46fb24-ba2d-11ef-a8f5-c03fd5ad989d','9c46701d-ba2d-11ef-a8f5-c03fd5ad989d','6dcc786d-a953-11ef-a9f6-00e04cf010f7',9,49.99,449.91,NULL,0.00,'2024-12-14 20:10:53'),('9ff089db-ba1c-11ef-8045-c03fd5ad989d','9ff00cb2-ba1c-11ef-8045-c03fd5ad989d','e43eec42-b9af-11ef-b775-c03fd5ad989d',1,750.00,750.00,NULL,0.00,'2024-12-14 18:09:18'),('a3588373-b4dd-11ef-b71d-00e04cf010f7','a3555a43-b4dd-11ef-b71d-00e04cf010f7','6dc9a5d1-a953-11ef-a9f6-00e04cf010f7',1,29.99,29.99,NULL,0.00,'2024-12-08 01:55:49'),('b94ca543-b4b2-11ef-b71d-00e04cf010f7','b9439957-b4b2-11ef-b71d-00e04cf010f7','6dc9a5d1-a953-11ef-a9f6-00e04cf010f7',1,29.99,29.99,NULL,0.00,'2024-12-07 20:48:38'),('bbffb822-b4db-11ef-b71d-00e04cf010f7','bbf9f1b1-b4db-11ef-b71d-00e04cf010f7','6dccb06e-a953-11ef-a9f6-00e04cf010f7',2,19.99,39.98,NULL,0.00,'2024-12-08 01:42:12'),('f4bb02cd-b2b0-11ef-833c-00e04cf010f7','f4b27765-b2b0-11ef-833c-00e04cf010f7','6dcc121d-a953-11ef-a9f6-00e04cf010f7',1,39.99,39.99,NULL,10.00,'2024-12-05 07:30:56'),('f4bc73a7-b2b0-11ef-833c-00e04cf010f7','f4b27765-b2b0-11ef-833c-00e04cf010f7','6dcc388a-a953-11ef-a9f6-00e04cf010f7',1,199.99,199.99,NULL,100.00,'2024-12-05 07:30:56'),('f8b0cbeb-ba25-11ef-a8f5-c03fd5ad989d','f8b027c6-ba25-11ef-a8f5-c03fd5ad989d','6dccb06e-a953-11ef-a9f6-00e04cf010f7',2,19.99,39.98,NULL,0.00,'2024-12-14 19:16:12');
/*!40000 ALTER TABLE `tb_detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_sale_detail_insert` AFTER INSERT ON `tb_detalle_venta` FOR EACH ROW BEGIN
    DECLARE v_stock_actual INT;
    DECLARE v_numero_documento VARCHAR(20);
    
    -- Obtener stock actual
    SELECT stock INTO v_stock_actual
    FROM tb_productos
    WHERE id_producto = NEW.id_producto;
    
    -- Obtener número de documento
    SELECT numero_documento INTO v_numero_documento
    FROM tb_ventas
    WHERE id_venta = NEW.id_venta;
    
    -- Validar stock suficiente
    IF v_stock_actual >= NEW.cantidad THEN
        -- Insertar en kardex
        INSERT INTO tb_kardex (
            id_producto,
            tipo_movimiento,
            tipo_documento,
            numero_documento,
            cantidad,
            precio_unitario,
            total,
            stock_anterior,
            stock_actual
        ) VALUES (
            NEW.id_producto,
            'SALIDA',
            'VENTA',
            v_numero_documento,
            NEW.cantidad,
            NEW.precio_unitario,
            NEW.subtotal,
            v_stock_actual,
            v_stock_actual - NEW.cantidad
        );
        
        -- Actualizar stock
        UPDATE tb_productos
        SET 
            stock = v_stock_actual - NEW.cantidad,
            updated_at = CURRENT_TIMESTAMP
        WHERE id_producto = NEW.id_producto;
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Stock insuficiente para realizar la venta';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_direccion`
--

DROP TABLE IF EXISTS `tb_direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_direccion` (
  `id_direccion` varchar(36) NOT NULL DEFAULT (uuid()),
  `direccion` varchar(200) NOT NULL,
  `id_tipo_via` varchar(36) DEFAULT NULL,
  `id_tipo_zona` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id_direccion`),
  KEY `id_tipo_via` (`id_tipo_via`),
  KEY `id_tipo_zona` (`id_tipo_zona`),
  CONSTRAINT `tb_direccion_ibfk_1` FOREIGN KEY (`id_tipo_via`) REFERENCES `tb_tipo_via` (`id_tipo_via`),
  CONSTRAINT `tb_direccion_ibfk_2` FOREIGN KEY (`id_tipo_zona`) REFERENCES `tb_tipo_zona` (`id_tipo_zona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_direccion`
--

LOCK TABLES `tb_direccion` WRITE;
/*!40000 ALTER TABLE `tb_direccion` DISABLE KEYS */;
INSERT INTO `tb_direccion` VALUES ('18be9178-8980-11ef-baca-00e04cf010f7','Galería Grau, Plaza de Armas de Ica, Puesto/49','49422de3-83c5-11ef-8655-00e04cf010f7','2a1c302e-83c6-11ef-8655-00e04cf010f7'),('9a9888e9-83cd-11ef-8655-00e04cf010f7','Av. José Larco 123','49412f5f-83c5-11ef-8655-00e04cf010f7','2a1c302e-83c6-11ef-8655-00e04cf010f7'),('9a98afbf-83cd-11ef-8655-00e04cf010f7','Jirón de la Unión 456','49422187-83c5-11ef-8655-00e04cf010f7','2a1c3518-83c6-11ef-8655-00e04cf010f7'),('9a98b22d-83cd-11ef-8655-00e04cf010f7','Calle Los Olivos 789','4942270b-83c5-11ef-8655-00e04cf010f7','2a1c3670-83c6-11ef-8655-00e04cf010f7'),('9a98c982-83cd-11ef-8655-00e04cf010f7','Pasaje Santa Rosa 101','49422821-83c5-11ef-8655-00e04cf010f7','2a1c3746-83c6-11ef-8655-00e04cf010f7'),('9a98cc2e-83cd-11ef-8655-00e04cf010f7','Alameda de los Pinos 202','4942292f-83c5-11ef-8655-00e04cf010f7','2a1c3807-83c6-11ef-8655-00e04cf010f7');
/*!40000 ALTER TABLE `tb_direccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_encuesta`
--

DROP TABLE IF EXISTS `tb_encuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_encuesta` (
  `id_encuesta` int NOT NULL AUTO_INCREMENT,
  `id_personal` varchar(36) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `calificacion_general` tinyint DEFAULT NULL,
  `recomendacion` tinyint DEFAULT NULL,
  `calidad_sistema` tinyint DEFAULT NULL,
  `facilidad_uso` tinyint DEFAULT NULL,
  `atencion_cliente` tinyint DEFAULT NULL,
  `funcionamiento_sistema` text,
  `proceso_venta` tinyint DEFAULT NULL,
  `comentarios` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_encuesta`),
  KEY `id_personal` (`id_personal`),
  CONSTRAINT `tb_encuesta_ibfk_1` FOREIGN KEY (`id_personal`) REFERENCES `tb_personal` (`id_personal`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_encuesta`
--

LOCK TABLES `tb_encuesta` WRITE;
/*!40000 ALTER TABLE `tb_encuesta` DISABLE KEYS */;
INSERT INTO `tb_encuesta` VALUES (1,'d1236a8d-94d7-11ef-a166-00e04cf010f7','2024-12-18',4,1,5,4,5,'El sistema funciona correctamente y es fácil de usar.',4,'Comentarios adicionales sobre el sistema.','2024-12-19 02:15:48'),(2,'d1236a8d-94d7-11ef-a166-00e04cf010f7','2024-12-19',1,1,2,2,1,'ninguna obsevacion',1,'observacion realizada','2024-12-19 09:14:18'),(3,'9f5fb672-83d6-11ef-8655-00e04cf010f7','2024-12-19',5,1,2,2,3,'ninguna observacion',3,'a mejorar','2024-12-19 09:24:51');
/*!40000 ALTER TABLE `tb_encuesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_inventario`
--

DROP TABLE IF EXISTS `tb_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_inventario` (
  `id_inventario` varchar(36) NOT NULL DEFAULT (uuid()),
  `id_producto` varchar(36) DEFAULT NULL,
  `id_sucursal` varchar(36) DEFAULT NULL,
  `cantidad` int NOT NULL,
  `comentarios` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tipo_movimiento` enum('ENTRADA','SALIDA') NOT NULL,
  `stock_anterior` int NOT NULL,
  `stock_nuevo` int NOT NULL,
  PRIMARY KEY (`id_inventario`),
  KEY `id_producto` (`id_producto`),
  KEY `id_sucursal` (`id_sucursal`),
  CONSTRAINT `tb_inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `tb_productos` (`id_producto`),
  CONSTRAINT `tb_inventario_ibfk_2` FOREIGN KEY (`id_sucursal`) REFERENCES `tb_sucursales` (`id_sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_inventario`
--

LOCK TABLES `tb_inventario` WRITE;
/*!40000 ALTER TABLE `tb_inventario` DISABLE KEYS */;
INSERT INTO `tb_inventario` VALUES ('153af5cd-c31d-11ef-80a2-c03fd5ad989d','1645df7b-b06e-11ef-a589-00e04cf010f7','25955d78-8981-11ef-baca-00e04cf010f7',2,'Probando stock anterior','2024-12-26 05:05:15','2024-12-26 05:05:15','ENTRADA',0,2),('a126685d-c31d-11ef-80a2-c03fd5ad989d','1645df7b-b06e-11ef-a589-00e04cf010f7','25955d78-8981-11ef-baca-00e04cf010f7',2,'Provando la salida de productos','2024-12-26 05:09:10','2024-12-26 05:09:10','SALIDA',15,13),('ad9127ee-c30f-11ef-80a2-c03fd5ad989d','1645df7b-b06e-11ef-a589-00e04cf010f7','25955d78-8981-11ef-baca-00e04cf010f7',2,'Entrada probando','2024-12-26 03:29:18','2024-12-26 03:29:18','ENTRADA',0,2),('bbb937fa-c30f-11ef-80a2-c03fd5ad989d','1645df7b-b06e-11ef-a589-00e04cf010f7','25955d78-8981-11ef-baca-00e04cf010f7',2,'SAlida probando','2024-12-26 03:29:41','2024-12-26 03:29:41','SALIDA',2,0);
/*!40000 ALTER TABLE `tb_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_kardex`
--

DROP TABLE IF EXISTS `tb_kardex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_kardex` (
  `id_kardex` varchar(36) NOT NULL DEFAULT (uuid()),
  `id_producto` varchar(36) DEFAULT NULL,
  `fecha_movimiento` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_movimiento` enum('ENTRADA','SALIDA') DEFAULT NULL,
  `tipo_documento` enum('COMPRA','VENTA') DEFAULT NULL,
  `numero_documento` varchar(20) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `stock_anterior` int DEFAULT NULL,
  `stock_actual` int DEFAULT NULL,
  PRIMARY KEY (`id_kardex`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `tb_kardex_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `tb_productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_kardex`
--

LOCK TABLES `tb_kardex` WRITE;
/*!40000 ALTER TABLE `tb_kardex` DISABLE KEYS */;
INSERT INTO `tb_kardex` VALUES ('0549fbe1-b0e2-11ef-ad0f-00e04cf010f7','6dcd625f-a953-11ef-a9f6-00e04cf010f7','2024-12-02 19:17:06','ENTRADA','COMPRA','COM-1733167026850',1,79.99,79.99,23,24),('0fa1b4e5-abb6-11ef-95f5-00e04cf010f7','6dcd625f-a953-11ef-a9f6-00e04cf010f7','2024-11-26 05:19:50','ENTRADA','COMPRA','COM-1732598390465',1,79.99,79.99,22,23),('107d9ba4-baa1-11ef-bd3b-c03fd5ad989d','6dcd931f-a953-11ef-a9f6-00e04cf010f7','2024-12-15 04:57:20','SALIDA','VENTA','COM-1734238640077',1,79.99,79.99,26,25),('192cfc38-ba2d-11ef-a8f5-c03fd5ad989d','6dcc786d-a953-11ef-a9f6-00e04cf010f7','2024-12-14 15:07:13','ENTRADA','COMPRA','COM-1734188833013',9,49.99,449.91,59,68),('1d242e69-b21c-11ef-984d-00e04cf010f7','6dcd83f1-a953-11ef-a9f6-00e04cf010f7','2024-12-04 08:45:28','SALIDA','VENTA','COM-1733301928904',1,54.99,54.99,40,39),('1fb7ee22-b2a4-11ef-833c-00e04cf010f7','6dcc786d-a953-11ef-a9f6-00e04cf010f7','2024-12-05 00:59:04','SALIDA','VENTA','COM-1733360344707',1,49.99,49.99,60,59),('2686b32d-ab90-11ef-95f5-00e04cf010f7','6dcd625f-a953-11ef-a9f6-00e04cf010f7','2024-11-26 00:48:28','ENTRADA','COMPRA','COM-1732582108101',2,79.99,159.98,20,22),('26899404-ab90-11ef-95f5-00e04cf010f7','6dcd51db-a953-11ef-a9f6-00e04cf010f7','2024-11-26 00:48:28','ENTRADA','COMPRA','COM-1732582108101',1,599.99,599.99,8,9),('461f5c4e-b216-11ef-984d-00e04cf010f7','6dc9a5d1-a953-11ef-a9f6-00e04cf010f7','2024-12-04 08:03:40','ENTRADA','COMPRA','COM-1733299420533',2,29.99,59.98,52,54),('47190ca3-b251-11ef-a732-00e04cf010f7','6dccc78b-a953-11ef-a9f6-00e04cf010f7','2024-12-04 15:06:02','SALIDA','VENTA','COM-1733324762639',1,119.99,119.99,15,14),('66ef98f6-b254-11ef-a732-00e04cf010f7','6dcc388a-a953-11ef-a9f6-00e04cf010f7','2024-12-04 15:28:24','SALIDA','VENTA','COM-1733326104542',1,199.99,199.99,31,30),('70cef336-ab97-11ef-95f5-00e04cf010f7','6dcc121d-a953-11ef-a9f6-00e04cf010f7','2024-11-26 01:40:39','SALIDA','VENTA','B001-00000001',1,100.00,100.00,40,39),('7436bb5a-b06a-11ef-a589-00e04cf010f7','6dccbbd9-a953-11ef-a9f6-00e04cf010f7','2024-12-02 05:01:13','ENTRADA','COMPRA','COM-1733115673190',2,129.99,259.98,21,23),('7679f7c0-ba1c-11ef-8045-c03fd5ad989d','e43edf9c-b9af-11ef-b775-c03fd5ad989d','2024-12-14 13:08:08','SALIDA','VENTA','COM-1734181688098',1,1200.00,1200.00,30,29),('7e30efd1-ba29-11ef-a8f5-c03fd5ad989d','1645df7b-b06e-11ef-a589-00e04cf010f7','2024-12-14 14:41:24','ENTRADA','COMPRA','COM-1734187284505',1,20.00,20.00,12,13),('7f8656c2-b24f-11ef-a732-00e04cf010f7','6dcc9e8e-a953-11ef-a9f6-00e04cf010f7','2024-12-04 14:53:18','SALIDA','VENTA','COM-1733323998164',1,14.99,14.99,100,99),('943709aa-b0e3-11ef-ad0f-00e04cf010f7','6dcd931f-a953-11ef-a9f6-00e04cf010f7','2024-12-02 19:28:16','ENTRADA','COMPRA','COM-1733167696211',1,79.99,79.99,25,26),('95f2479f-b0e5-11ef-ad0f-00e04cf010f7','6dc9a5d1-a953-11ef-a9f6-00e04cf010f7','2024-12-02 19:42:38','ENTRADA','COMPRA','COM-1733168558098',1,29.99,29.99,51,52),('9bb9c803-b0e2-11ef-ad0f-00e04cf010f7','6dccbbd9-a953-11ef-a9f6-00e04cf010f7','2024-12-02 19:21:19','ENTRADA','COMPRA','COM-1733167279335',2,129.99,259.98,23,25),('9c472380-ba2d-11ef-a8f5-c03fd5ad989d','6dcc786d-a953-11ef-a9f6-00e04cf010f7','2024-12-14 15:10:52','SALIDA','VENTA','COM-1734189052983',9,49.99,449.91,68,59),('9ff0a098-ba1c-11ef-8045-c03fd5ad989d','e43eec42-b9af-11ef-b775-c03fd5ad989d','2024-12-14 13:09:17','SALIDA','VENTA','COM-1734181757680',1,750.00,750.00,20,19),('a3593ded-b4dd-11ef-b71d-00e04cf010f7','6dc9a5d1-a953-11ef-a9f6-00e04cf010f7','2024-12-07 20:55:49','SALIDA','VENTA','COM-1733604949213',1,29.99,29.99,53,52),('a5209dd6-aba1-11ef-95f5-00e04cf010f7','6dc9a5d1-a953-11ef-a9f6-00e04cf010f7','2024-11-26 02:53:42','ENTRADA','COMPRA','COM-1732589621729',1,29.99,29.99,50,51),('b0031fe4-b9b8-11ef-bedc-c03fd5ad989d','6dcc121d-a953-11ef-a9f6-00e04cf010f7','2024-12-14 01:13:54','ENTRADA','COMPRA','COM-1734138834960',1,39.99,39.99,38,39),('b2b47b14-a954-11ef-a9f6-00e04cf010f7','6dcd9e62-a953-11ef-a9f6-00e04cf010f7','2024-11-23 04:37:51','ENTRADA','COMPRA','COM-1732336671110',1,149.99,149.99,15,16),('b3c793c1-ba28-11ef-a8f5-c03fd5ad989d','6dcc121d-a953-11ef-a9f6-00e04cf010f7','2024-12-14 14:35:44','ENTRADA','COMPRA','COM-1734186944911',1,39.99,39.99,39,40),('b94fc3fb-b4b2-11ef-b71d-00e04cf010f7','6dc9a5d1-a953-11ef-a9f6-00e04cf010f7','2024-12-07 15:48:37','SALIDA','VENTA','COM-1733586517634',1,29.99,29.99,54,53),('bc00a5af-b4db-11ef-b71d-00e04cf010f7','6dccb06e-a953-11ef-a9f6-00e04cf010f7','2024-12-07 20:42:11','SALIDA','VENTA','COM-1733604131570',2,19.99,39.98,80,78),('c36f582e-aff0-11ef-a589-00e04cf010f7','6dcc388a-a953-11ef-a9f6-00e04cf010f7','2024-12-01 14:30:07','ENTRADA','COMPRA','COM-1733063407639',1,199.99,199.99,30,31),('e217058e-ab2f-11ef-813a-00e04cf010f7','8a7e8f7f-aa92-11ef-ad66-00e04cf010f7','2024-11-25 13:19:21','SALIDA','VENTA','B001-00000001',1,100.00,100.00,12,11),('e51c4e92-b25d-11ef-a732-00e04cf010f7','6dcc9e8e-a953-11ef-a9f6-00e04cf010f7','2024-12-04 16:36:21','ENTRADA','COMPRA','COM-1733330181666',1,14.99,14.99,99,100),('e6909ca3-a956-11ef-a9f6-00e04cf010f7','6dccbbd9-a953-11ef-a9f6-00e04cf010f7','2024-11-23 04:53:37','ENTRADA','COMPRA','COM-1732337617058',1,129.99,129.99,20,21),('f4bc074d-b2b0-11ef-833c-00e04cf010f7','6dcc121d-a953-11ef-a9f6-00e04cf010f7','2024-12-05 02:30:56','SALIDA','VENTA','COM-1733365856031',1,39.99,39.99,39,38),('f4bd7ac3-b2b0-11ef-833c-00e04cf010f7','6dcc388a-a953-11ef-a9f6-00e04cf010f7','2024-12-05 02:30:56','SALIDA','VENTA','COM-1733365856031',1,199.99,199.99,30,29),('f8b10423-ba25-11ef-a8f5-c03fd5ad989d','6dccb06e-a953-11ef-a9f6-00e04cf010f7','2024-12-14 14:16:12','SALIDA','VENTA','COM-1734185772028',2,19.99,39.98,78,76);
/*!40000 ALTER TABLE `tb_kardex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_marcas`
--

DROP TABLE IF EXISTS `tb_marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_marcas` (
  `id_marca` varchar(36) NOT NULL DEFAULT (uuid()),
  `nombre_marca` varchar(100) NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_marca`),
  UNIQUE KEY `nombre_marca_UNIQUE` (`nombre_marca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_marcas`
--

LOCK TABLES `tb_marcas` WRITE;
/*!40000 ALTER TABLE `tb_marcas` DISABLE KEYS */;
INSERT INTO `tb_marcas` VALUES ('4826d230-c3a3-11ef-b7cf-c03fd5ad989d','Prueba',0,'2024-12-26 21:05:51','2024-12-26 21:05:53'),('a1f2057a-83cc-11ef-8655-00e04cf010f7','Samsung',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f20ad7-83cc-11ef-8655-00e04cf010f7','Apple',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f20d08-83cc-11ef-8655-00e04cf010f7','Xiaomi',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f20dea-83cc-11ef-8655-00e04cf010f7','Huawei',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f20eb2-83cc-11ef-8655-00e04cf010f7','Sony',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f20f70-83cc-11ef-8655-00e04cf010f7','Dell',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f21029-83cc-11ef-8655-00e04cf010f7','HP',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f210de-83cc-11ef-8655-00e04cf010f7','Lenovo',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f211a0-83cc-11ef-8655-00e04cf010f7','Logitech',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f21257-83cc-11ef-8655-00e04cf010f7','Razer',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f2130c-83cc-11ef-8655-00e04cf010f7','Asus',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f213c2-83cc-11ef-8655-00e04cf010f7','Microsoft',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f21478-83cc-11ef-8655-00e04cf010f7','Motorola',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('a1f21547-83cc-11ef-8655-00e04cf010f7','OnePlus',1,'2024-10-12 20:40:19','2024-10-12 20:40:19'),('f1497af2-8ab1-11ef-8cb6-00e04cf010f7','Senati Marca',0,'2024-10-15 09:57:11','2024-10-15 09:57:13');
/*!40000 ALTER TABLE `tb_marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_metodo_pago`
--

DROP TABLE IF EXISTS `tb_metodo_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_metodo_pago` (
  `id_metodo_pago` varchar(36) NOT NULL DEFAULT (uuid()),
  `nombre_metodo_pago` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `estado` tinyint DEFAULT '1',
  PRIMARY KEY (`id_metodo_pago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_metodo_pago`
--

LOCK TABLES `tb_metodo_pago` WRITE;
/*!40000 ALTER TABLE `tb_metodo_pago` DISABLE KEYS */;
INSERT INTO `tb_metodo_pago` VALUES ('7ec5764a-a5ed-11ef-84ff-00e04cf010f7','Transferencia Bancaria','Pago mediante transferencia bancaria directa',1),('7ec5850f-a5ed-11ef-84ff-00e04cf010f7','Efectivo','Pago en efectivo',1),('7ec5a6ae-a5ed-11ef-84ff-00e04cf010f7','Tarjeta de Crédito','Pago con tarjeta de crédito empresarial',1),('7ec5a816-a5ed-11ef-84ff-00e04cf010f7','Tarjeta de Débito','Pago con tarjeta de débito empresarial',1),('7ec5a901-a5ed-11ef-84ff-00e04cf010f7','Cheque','Pago mediante cheque empresarial',1),('7ec5a9e3-a5ed-11ef-84ff-00e04cf010f7','Depósito Bancario','Pago mediante depósito en cuenta bancaria',1),('7ec5aab4-a5ed-11ef-84ff-00e04cf010f7','Crédito a 30 días','Pago a crédito con plazo de 30 días',1),('7ec5ab7f-a5ed-11ef-84ff-00e04cf010f7','Crédito a 60 días','Pago a crédito con plazo de 60 días',1),('7ec5ac7c-a5ed-11ef-84ff-00e04cf010f7','Pago Electrónico','Pago mediante plataformas electrónicas autorizadas',1),('7ec5ad4f-a5ed-11ef-84ff-00e04cf010f7','Letra de Cambio','Pago mediante letra de cambio',1),('7ec5ae1b-a5ed-11ef-84ff-00e04cf010f7','Transferencia Interbancaria','Pago mediante transferencia entre diferentes bancos',1),('7ec5ed72-a5ed-11ef-84ff-00e04cf010f7','Compensación','Pago mediante compensación de deudas',1),('7ec5eedd-a5ed-11ef-84ff-00e04cf010f7','Pago Diferido','Pago con fecha futura programada',1);
/*!40000 ALTER TABLE `tb_metodo_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_modulo`
--

DROP TABLE IF EXISTS `tb_modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_modulo` (
  `id_modulo` varchar(36) NOT NULL DEFAULT (uuid()),
  `nombre_modulo` varchar(100) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `estado` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_modulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_modulo`
--

LOCK TABLES `tb_modulo` WRITE;
/*!40000 ALTER TABLE `tb_modulo` DISABLE KEYS */;
INSERT INTO `tb_modulo` VALUES ('2db43b5c-be61-11ef-820c-c03fd5ad989d','personal','Mantenimiento Personal',1),('2db4803b-be61-11ef-820c-c03fd5ad989d','roles','Mantenimiento Roles',1),('2db48232-be61-11ef-820c-c03fd5ad989d','marcas','Mantenimiento Marcas',1),('2db4833f-be61-11ef-820c-c03fd5ad989d','categorias','Mantenimiento Categorias',1),('2db48387-be61-11ef-820c-c03fd5ad989d','productos','Mantenimiento Productos',1),('2db483ca-be61-11ef-820c-c03fd5ad989d','sucursal','Mantenimiento Sucursales',1),('2db48411-be61-11ef-820c-c03fd5ad989d','proveedor','Mantenimiento de Proveedores',1),('2db4845d-be61-11ef-820c-c03fd5ad989d','cliente','Mantenimiento de Clientes',1),('2db484d0-be61-11ef-820c-c03fd5ad989d','compras','Mantenimiento de Compras',1),('2db4852d-be61-11ef-820c-c03fd5ad989d','ventas','Mantenimiento de Ventas',1),('2db4856b-be61-11ef-820c-c03fd5ad989d','kardex','KARDEX',1),('2db485a9-be61-11ef-820c-c03fd5ad989d','informes','INFORMES',1),('2db48ef8-be61-11ef-820c-c03fd5ad989d','graficos','GRAFICOS',1),('2db48fc4-be61-11ef-820c-c03fd5ad989d','recomendaciones','Recomendaciones',1),('2db4906a-be61-11ef-820c-c03fd5ad989d','instrucciones','Instrucciones',1),('5cf3e6c0-c425-11ef-be28-c03fd5ad989d','mensajes','Mantenimiento Mensajes wsp',1),('5cf4b290-c425-11ef-be28-c03fd5ad989d','chat-gpt','Mantenimiento Chat GPT',1),('8ca8dde9-c3bb-11ef-b7cf-c03fd5ad989d','personas','Mantenimiento Personas',1),('f880738b-c1e9-11ef-82a9-c03fd5ad989d','ajuste','Mantenimiento Razon ajuste',1),('f880770b-c1e9-11ef-82a9-c03fd5ad989d','inventario','Mantenimiento de inventario',1);
/*!40000 ALTER TABLE `tb_modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pais`
--

DROP TABLE IF EXISTS `tb_pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_pais` (
  `id_pais` varchar(36) NOT NULL DEFAULT (uuid()),
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pais`
--

LOCK TABLES `tb_pais` WRITE;
/*!40000 ALTER TABLE `tb_pais` DISABLE KEYS */;
INSERT INTO `tb_pais` VALUES ('91627bbe-83c8-11ef-8655-00e04cf010f7','Brasil'),('91628100-83c8-11ef-8655-00e04cf010f7','Argentina'),('9162824c-83c8-11ef-8655-00e04cf010f7','Colombia'),('91628318-83c8-11ef-8655-00e04cf010f7','Chile'),('916283d5-83c8-11ef-8655-00e04cf010f7','Perú'),('9162848b-83c8-11ef-8655-00e04cf010f7','Venezuela'),('91628595-83c8-11ef-8655-00e04cf010f7','Ecuador'),('9162864c-83c8-11ef-8655-00e04cf010f7','Paraguay'),('91628702-83c8-11ef-8655-00e04cf010f7','Uruguay'),('916287b4-83c8-11ef-8655-00e04cf010f7','Bolivia');
/*!40000 ALTER TABLE `tb_pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_permiso`
--

DROP TABLE IF EXISTS `tb_permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_permiso` (
  `id_permiso` varchar(36) NOT NULL DEFAULT (uuid()),
  `id_rol` varchar(36) DEFAULT NULL,
  `id_modulo` varchar(36) DEFAULT NULL,
  `puede_crear` tinyint NOT NULL DEFAULT '0',
  `puede_leer` tinyint NOT NULL DEFAULT '0',
  `puede_actualizar` tinyint NOT NULL DEFAULT '0',
  `puede_eliminar` tinyint NOT NULL DEFAULT '0',
  `estado` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_permiso`),
  UNIQUE KEY `unique_rol_modulo` (`id_rol`,`id_modulo`),
  KEY `idx_permiso_rol` (`id_rol`),
  KEY `idx_permiso_modulo` (`id_modulo`),
  CONSTRAINT `tb_permiso_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `tb_rol` (`id_rol`),
  CONSTRAINT `tb_permiso_ibfk_2` FOREIGN KEY (`id_modulo`) REFERENCES `tb_modulo` (`id_modulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_permiso`
--

LOCK TABLES `tb_permiso` WRITE;
/*!40000 ALTER TABLE `tb_permiso` DISABLE KEYS */;
INSERT INTO `tb_permiso` VALUES ('16d3f70a-bf20-11ef-9c2b-c03fd5ad989d','dc69e7b5-854a-11ef-be95-00155d3bb553','2db483ca-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d6fb6-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db43b5c-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d7f97-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db4803b-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d8136-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db48232-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d839e-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db4833f-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d97f9-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db48387-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d993b-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db483ca-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d9a39-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db48411-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d9b41-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db4845d-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d9c49-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db484d0-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d9d3c-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db4852d-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d9e3c-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db4856b-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4d9f42-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db485a9-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4da062-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db48ef8-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4da167-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db48fc4-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('3b4da27b-be61-11ef-820c-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','2db4906a-be61-11ef-820c-c03fd5ad989d',1,0,1,1,1),('3e9e8d50-c3c8-11ef-9148-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','8ca8dde9-c3bb-11ef-b7cf-c03fd5ad989d',1,1,1,1,1),('879036f7-c425-11ef-be28-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','5cf4b290-c425-11ef-be28-c03fd5ad989d',1,1,1,1,1),('8d7de618-bf24-11ef-9c2b-c03fd5ad989d','dc69e7b5-854a-11ef-be95-00155d3bb553','2db484d0-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('8f2f8b08-c425-11ef-be28-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','5cf3e6c0-c425-11ef-be28-c03fd5ad989d',1,1,1,1,1),('a53baa76-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db43b5c-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bb7d5-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db4803b-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bbbb1-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db48232-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bc23e-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db4833f-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bd210-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db48387-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bd4db-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db483ca-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bd77d-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db48411-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bda01-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db4845d-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bdc81-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db484d0-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53be083-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db4852d-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53be620-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db4856b-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53beb34-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db485a9-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bf023-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db48ef8-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bf35c-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db48fc4-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('a53bf961-bf1f-11ef-9c2b-c03fd5ad989d','75bea34d-83d1-11ef-8655-00e04cf010f7','2db4906a-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc9424d-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db43b5c-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc94bc5-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db4803b-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc950a3-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db48232-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc958e6-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db4833f-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc95e4c-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db48387-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc9627e-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db483ca-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc96696-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db48411-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc96a82-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db4845d-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc96e42-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db484d0-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc97229-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db4852d-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc97638-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db4856b-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc97a36-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db485a9-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc97e3c-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db48ef8-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc98226-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db48fc4-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('abc98729-bf1f-11ef-9c2b-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','2db4906a-be61-11ef-820c-c03fd5ad989d',1,1,1,1,1),('cfb5ad1b-c1ea-11ef-82a9-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','f880738b-c1e9-11ef-82a9-c03fd5ad989d',1,1,1,1,1),('da544369-c1ea-11ef-82a9-c03fd5ad989d','75be9b6d-83d1-11ef-8655-00e04cf010f7','f880770b-c1e9-11ef-82a9-c03fd5ad989d',1,1,1,1,1),('f3db36eb-c1ea-11ef-82a9-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','f880770b-c1e9-11ef-82a9-c03fd5ad989d',1,1,1,1,1),('fa6aae3c-c1ea-11ef-82a9-c03fd5ad989d','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','f880738b-c1e9-11ef-82a9-c03fd5ad989d',1,1,1,1,1);
/*!40000 ALTER TABLE `tb_permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_personal`
--

DROP TABLE IF EXISTS `tb_personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_personal` (
  `id_personal` varchar(36) NOT NULL DEFAULT (uuid()),
  `id_persona` varchar(36) DEFAULT NULL,
  `id_rol` varchar(36) DEFAULT NULL,
  `contrasenia` varchar(100) NOT NULL,
  `email` text,
  `estado` tinyint(1) NOT NULL,
  `personal_img` text,
  `google_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_personal`),
  KEY `id_persona` (`id_persona`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `tb_personal_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `tb_personas` (`id_persona`),
  CONSTRAINT `tb_personal_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `tb_rol` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_personal`
--

LOCK TABLES `tb_personal` WRITE;
/*!40000 ALTER TABLE `tb_personal` DISABLE KEYS */;
INSERT INTO `tb_personal` VALUES ('3aac97ee-94d8-11ef-a166-00e04cf010f7','7f7495ae-942c-11ef-ab9a-00e04cf010f7','dc69e7b5-854a-11ef-be95-00155d3bb553','$2b$10$6ShhIWaAfuc3ggD154YBleDVqEGrDJIpLQ2y/qBVIHqp8iUU03fpK','ryvytoby@mailinator.com',1,'Labore et nisi repre',NULL),('5fb07743-b2b4-11ef-833c-00e04cf010f7','5066785f-94c3-11ef-a166-00e04cf010f7','75be9b6d-83d1-11ef-8655-00e04cf010f7','$2b$10$K3t82C42xA8wO3H6XTQWVunyWDjIs/UIrUKB04lxuDDEW.aXPDZsS','1433044@senati.pe',1,'data:image/jpeg;base64,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',NULL),('983d8571-94d7-11ef-a166-00e04cf010f7','5066785f-94c3-11ef-a166-00e04cf010f7','75be9b6d-83d1-11ef-8655-00e04cf010f7','$2b$10$79IkzPC8qMfNeH.kAFvfZOkbCP9l/TjT3UGHDg0R7EmG6VNCrnV0O','jahyde@mailinator.com',0,'Deserunt cum pariatu',NULL),('9f5fb672-83d6-11ef-8655-00e04cf010f7','f21bfa7f-83d0-11ef-8655-00e04cf010f7','bc11cad9-bed8-11ef-89c1-c03fd5ad989d','$2b$10$9fF19yVb6A.YflktKDKp5OmuMN2z9NyW3thBbxtSaFg70kBoUUKla','valerio@gmail.com',1,'https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/256x256/plain/user.png',NULL),('cbd4f42f-94db-11ef-a166-00e04cf010f7','bb0aab3d-93ef-11ef-ab9a-00e04cf010f7','75bea34d-83d1-11ef-8655-00e04cf010f7','$2b$10$9xpSMKw9eq040US2gWXAyOyaLT/Qya8B7Q0WSfu9o5vd2xy25yLBi','zarome@mailinator.com',1,'Provident deleniti ',NULL),('cf2ab4e6-94d9-11ef-a166-00e04cf010f7','b2a85aa1-94ca-11ef-a166-00e04cf010f7','75be9b6d-83d1-11ef-8655-00e04cf010f7','$2b$10$WHM7D.tSf6nnGzUizYnM9.XxAUi.vxNzogYeDjvyfxI2irtBdWbge','dawe@mailinator.com',0,'Error reprehenderit ',NULL),('d1236a8d-94d7-11ef-a166-00e04cf010f7','bb0aab3d-93ef-11ef-ab9a-\n00e04cf010f','75bea34d-83d1-11ef-8655-00e04cf010f7','$2b$10$Uf2aHi9wFhlPrphlNoqThuiLkJVZm7SzcOpaIOY6ER6JqYrNyvuuO','hyda@mailinator.com',1,'Voluptatem illum r',NULL);
/*!40000 ALTER TABLE `tb_personal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_personas`
--

DROP TABLE IF EXISTS `tb_personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_personas` (
  `id_persona` varchar(36) NOT NULL DEFAULT (uuid()),
  `nombres` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `id_tipo_persona` varchar(36) DEFAULT NULL,
  `id_tipo_documento` varchar(36) DEFAULT NULL,
  `id_sexo` varchar(36) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `id_direccion` varchar(36) DEFAULT NULL,
  `id_pais` varchar(36) DEFAULT NULL,
  `id_tipo_telefono` varchar(36) DEFAULT NULL,
  `apellido_paterno` varchar(50) DEFAULT NULL,
  `apellido_materno` varchar(50) DEFAULT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `razon_social` varchar(250) DEFAULT NULL COMMENT 'Razón social para empresas',
  `estado_documento` varchar(50) DEFAULT NULL COMMENT 'Estado del documento (ACTIVO/INHABILITADO)',
  `condicion_documento` varchar(50) DEFAULT NULL COMMENT 'Condición del documento',
  `distrito` varchar(100) DEFAULT NULL,
  `provincia` varchar(100) DEFAULT NULL,
  `departamento` varchar(100) DEFAULT NULL,
  `tipo_persona` varchar(100) DEFAULT NULL COMMENT 'Tipo de persona (NATURAL/JURIDICA)',
  `actividad_economica` text,
  `direccion_persona` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `id_tipo_persona` (`id_tipo_persona`),
  KEY `id_tipo_documento` (`id_tipo_documento`),
  KEY `id_sexo` (`id_sexo`),
  KEY `id_direccion` (`id_direccion`),
  KEY `id_pais` (`id_pais`),
  KEY `id_tipo_telefono` (`id_tipo_telefono`),
  CONSTRAINT `tb_personas_ibfk_1` FOREIGN KEY (`id_tipo_persona`) REFERENCES `tb_tipo_persona` (`id_tipo_persona`),
  CONSTRAINT `tb_personas_ibfk_2` FOREIGN KEY (`id_tipo_documento`) REFERENCES `tb_tipo_documento` (`id_tipo_documento`),
  CONSTRAINT `tb_personas_ibfk_3` FOREIGN KEY (`id_sexo`) REFERENCES `tb_sexo` (`id_sexo`),
  CONSTRAINT `tb_personas_ibfk_4` FOREIGN KEY (`id_direccion`) REFERENCES `tb_direccion` (`id_direccion`),
  CONSTRAINT `tb_personas_ibfk_5` FOREIGN KEY (`id_pais`) REFERENCES `tb_pais` (`id_pais`),
  CONSTRAINT `tb_personas_ibfk_6` FOREIGN KEY (`id_tipo_telefono`) REFERENCES `tb_tipo_telefono` (`id_tipo_telefono`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_personas`
--

LOCK TABLES `tb_personas` WRITE;
/*!40000 ALTER TABLE `tb_personas` DISABLE KEYS */;
INSERT INTO `tb_personas` VALUES ('00808406-93f0-11ef-ab9a-00e04cf010f7','Juan','kogifa@gmail.com','df09389f-83c7-11ef-8655-00e04cf010f7','3d7caa5b-83c8-11ef-8655-00e04cf010f7','62b6942c-83c8-11ef-8655-00e04cf010f7','2024-10-02','18be9178-8980-11ef-baca-00e04cf010f7','9162864c-83c8-11ef-8655-00e04cf010f7','afb83847-83cb-11ef-8655-00e04cf010f7','Gonzales','Kaneshiro','98765433','+1 (883) 805-2762',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('0a6cda84-c3e7-11ef-9148-c03fd5ad989d','VALERIO','valerio@gmail.com','df09389f-83c7-11ef-8655-00e04cf010f7','3d7caa5b-83c8-11ef-8655-00e04cf010f7','62b68f65-83c8-11ef-8655-00e04cf010f7','2003-12-07',NULL,'916283d5-83c8-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','QUISPE','ALARCON','74225995','987654321',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'San AMertin de Porraz'),('21439fee-93db-11ef-ab9a-00e04cf010f7','Tempor vitae repelle','qybih@gmail.com','df091edc-83c7-11ef-8655-00e04cf010f7','3d7cb0d4-83c8-11ef-8655-00e04cf010f7','62b69643-83c8-11ef-8655-00e04cf010f7','2024-10-26','9a98cc2e-83cd-11ef-8655-00e04cf010f7','9162848b-83c8-11ef-8655-00e04cf010f7','afb83780-83cb-11ef-8655-00e04cf010f7','Dolor voluptatem iru','Elit molestias maxi','Inventore laboris se','+1 (992) 957-7709',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('378cbe85-94ca-11ef-a166-00e04cf010f7','Rerum Nam obcaecati ','cusate@gmail.com','df091edc-83c7-11ef-8655-00e04cf010f7','3d7cb308-83c8-11ef-8655-00e04cf010f7','62b69574-83c8-11ef-8655-00e04cf010f7','2024-10-11','9a9888e9-83cd-11ef-8655-00e04cf010f7','916287b4-83c8-11ef-8655-00e04cf010f7','afb83847-83cb-11ef-8655-00e04cf010f7','Sed nostrud amet do','Labore voluptate odi','Aut perferendis poss','+1 (187) 782-7265',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('5066785f-94c3-11ef-a166-00e04cf010f7','Consequuntur laboris','dabahesi@gmail.com','df091edc-83c7-11ef-8655-00e04cf010f7','3d7caa5b-83c8-11ef-8655-00e04cf010f7','62b68f65-83c8-11ef-8655-00e04cf010f7','2024-10-28','9a98b22d-83cd-11ef-8655-00e04cf010f7','91628702-83c8-11ef-8655-00e04cf010f7','afb836a9-83cb-11ef-8655-00e04cf010f7','Nulla sapiente molli','Dolorem dolore conse','Id aut error omnis l','+1 (255) 733-8093',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('657a926b-94c3-11ef-a166-00e04cf010f7','Esse eius enim ex es','xuzy@gmail.com','df091edc-83c7-11ef-8655-00e04cf010f7','3d7cb008-83c8-11ef-8655-00e04cf010f7','62b6942c-83c8-11ef-8655-00e04cf010f7','2024-10-28','9a98c982-83cd-11ef-8655-00e04cf010f7','91627bbe-83c8-11ef-8655-00e04cf010f7','afb83542-83cb-11ef-8655-00e04cf010f7','Impedit aliquid sae','Ea ad cillum libero ','Deleniti nulla commo','+1 (902) 167-7671',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('6b06e2a8-b0f8-11ef-ad0f-00e04cf010f7',NULL,'eps.gmail.com','df093a97-83c7-11ef-8655-00e04cf010f7','3d7caec9-83c8-11ef-8655-00e04cf010f7','62b68f65-83c8-11ef-8655-00e04cf010f7','2024-12-02','9a9888e9-83cd-11ef-8655-00e04cf010f7','916283d5-83c8-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7',NULL,NULL,'20136353315','987654321','EPS. SEDACUSCO S.A.','ACTIVO','HABIDO','WANCHAQ','CUSCO','CUSCO','SOCIEDAD ANONIMA','CAPTACION TRATAMIENTO Y DISTRIBUCION DE AGUA',NULL),('7b683077-ba99-11ef-bd3b-c03fd5ad989d','VALERIO','valerio@gmail.com','df093a97-83c7-11ef-8655-00e04cf010f7','3d7caa5b-83c8-11ef-8655-00e04cf010f7','62b68f65-83c8-11ef-8655-00e04cf010f7','2003-12-07',NULL,'916283d5-83c8-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','QUISPE','ALARCON','74225995','987654321',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'San martin de porraz'),('7f7495ae-942c-11ef-ab9a-00e04cf010f7','Nobis sed exercitati','cosaj@mailinator.com','df091edc-83c7-11ef-8655-00e04cf010f7','3d7cb0d4-83c8-11ef-8655-00e04cf010f7','62b69643-83c8-11ef-8655-00e04cf010f7','2024-10-27','9a98cc2e-83cd-11ef-8655-00e04cf010f7','91628318-83c8-11ef-8655-00e04cf010f7','afb836a9-83cb-11ef-8655-00e04cf010f7','Exercitationem ipsum','Ad numquam occaecat ','Dolor rerum neque a ','+1 (592) 109-9217',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('945a22ae-94c5-11ef-a166-00e04cf010f7','Aut sit est eius quo','posipi@gmail.com','df091edc-83c7-11ef-8655-00e04cf010f7','3d7caec9-83c8-11ef-8655-00e04cf010f7','62b68f65-83c8-11ef-8655-00e04cf010f7','2024-10-28','18be9178-8980-11ef-baca-00e04cf010f7','91628318-83c8-11ef-8655-00e04cf010f7','afb83542-83cb-11ef-8655-00e04cf010f7','Nostrud ipsum in vo','Ea facere culpa quib','Est ut mollit veniam','+1 (686) 997-4215',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('a3b0e1f7-83d0-11ef-8655-00e04cf010f7','Ximena','ximena.duena@example.com','df093b82-83c7-11ef-8655-00e04cf010f7','3d7caa5b-83c8-11ef-8655-00e04cf010f7','62b6942c-83c8-11ef-8655-00e04cf010f7','1985-05-23','9a98afbf-83cd-11ef-8655-00e04cf010f7','916283d5-83c8-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','López','Martínez','7654321','943061463',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('aa1c1060-935d-11ef-9a0f-00e04cf010f7','Velit quasi est modi','pecalezuk@mailinator.com','df093c5a-83c7-11ef-8655-00e04cf010f7','3d7cb308-83c8-11ef-8655-00e04cf010f7','62b68f65-83c8-11ef-8655-00e04cf010f7','2024-10-26','9a98cc2e-83cd-11ef-8655-00e04cf010f7','91627bbe-83c8-11ef-8655-00e04cf010f7','afb83780-83cb-11ef-8655-00e04cf010f7','Fugit autem nesciun','Omnis necessitatibus','Ut lorem itaque quia','+1 (557) 655-3236',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b2a85aa1-94ca-11ef-a166-00e04cf010f7','Quas debitis unde en','wuravo@admin.com','df091edc-83c7-11ef-8655-00e04cf010f7','3d7cb192-83c8-11ef-8655-00e04cf010f7','62b69702-83c8-11ef-8655-00e04cf010f7','2024-10-18','9a9888e9-83cd-11ef-8655-00e04cf010f7','91628100-83c8-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','Ut aut nihil molesti','Hic veniam dolorem ','Enim voluptate ex vo','+1 (821) 647-3488',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b31d1ece-93ef-11ef-ab9a-00e04cf010f7','Perferendis dolore f','dynyw@gmail.com','df093a97-83c7-11ef-8655-00e04cf010f7','3d7cb0d4-83c8-11ef-8655-00e04cf010f7','62b6942c-83c8-11ef-8655-00e04cf010f7','2024-10-08','9a9888e9-83cd-11ef-8655-00e04cf010f7','9162824c-83c8-11ef-8655-00e04cf010f7','afb83780-83cb-11ef-8655-00e04cf010f7','Dolorem dignissimos ','Laborum laborum numq','987654321','+1 (977) 769-1449',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b54cf50b-94c5-11ef-a166-00e04cf010f7','Nombre','1433044@senati.pe','df091edc-83c7-11ef-8655-00e04cf010f7','3d7cb192-83c8-11ef-8655-00e04cf010f7','62b69702-83c8-11ef-8655-00e04cf010f7','2024-02-22','9a98b22d-83cd-11ef-8655-00e04cf010f7','916283d5-83c8-11ef-8655-00e04cf010f7','afb83780-83cb-11ef-8655-00e04cf010f7','Valerio','Valerio 2','123123','12312',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('bb0aab3d-93ef-11ef-ab9a-00e04cf010f7','Nemo voluptatem Ess','zykiwabec@gmail.com','df091edc-83c7-11ef-8655-00e04cf010f7','3d7caa5b-83c8-11ef-8655-00e04cf010f7','62b69574-83c8-11ef-8655-00e04cf010f7',NULL,'9a98c982-83cd-11ef-8655-00e04cf010f7','916287b4-83c8-11ef-8655-00e04cf010f7','afb83847-83cb-11ef-8655-00e04cf010f7','Expedita ratione off','Ut natus quasi in pa','Id saepe sed quaerat','+1 (334) 427-1432',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('c1386e3e-83d0-11ef-8655-00e04cf010f7','Valerio','valerio.dev@example.com','df093c5a-83c7-11ef-8655-00e04cf010f7','3d7cb008-83c8-11ef-8655-00e04cf010f7','62b68f65-83c8-11ef-8655-00e04cf010f7','1993-03-10','9a98b22d-83cd-11ef-8655-00e04cf010f7','916283d5-83c8-11ef-8655-00e04cf010f7','afb83542-83cb-11ef-8655-00e04cf010f7','Ríos','Hernández','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('cf6e8a48-ab98-11ef-95f5-00e04cf010f7','Proveedor 1','1433044@senati.pe','df093a97-83c7-11ef-8655-00e04cf010f7','3d7caa5b-83c8-11ef-8655-00e04cf010f7','62b68f65-83c8-11ef-8655-00e04cf010f7','2001-11-04','9a98b22d-83cd-11ef-8655-00e04cf010f7','916283d5-83c8-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','Proveedor paterno','Proveedor materno','76543221','944433044',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('d631c2ad-94ca-11ef-a166-00e04cf010f7','Personal','paguvobyqu@gmail.com','df091edc-83c7-11ef-8655-00e04cf010f7','3d7cb308-83c8-11ef-8655-00e04cf010f7','62b69643-83c8-11ef-8655-00e04cf010f7','2024-10-03','9a9888e9-83cd-11ef-8655-00e04cf010f7','9162864c-83c8-11ef-8655-00e04cf010f7','afb83780-83cb-11ef-8655-00e04cf010f7','11','11','Libero obcaecati rer','+1 (993) 299-4455',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e51c6fa5-83d0-11ef-8655-00e04cf010f7','María','maria.fernandez@example.com','df09389f-83c7-11ef-8655-00e04cf010f7','3d7cb0d4-83c8-11ef-8655-00e04cf010f7','62b6942c-83c8-11ef-8655-00e04cf010f7','1991-08-05','9a98c982-83cd-11ef-8655-00e04cf010f7','916283d5-83c8-11ef-8655-00e04cf010f7','afb836a9-83cb-11ef-8655-00e04cf010f7','Fernández','Torres','CLIENTE001','9876544321',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('f21bfa7f-83d0-11ef-8655-00e04cf010f7','Valerio',NULL,'df091edc-83c7-11ef-8655-00e04cf010f7','3d7caa5b-83c8-11ef-8655-00e04cf010f7','62b68f65-83c8-11ef-8655-00e04cf010f7','1990-01-15','9a9888e9-83cd-11ef-8655-00e04cf010f7','916283d5-83c8-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','González','Mendoza','78654321','985839185',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'San Martin Porraz B = 26'),('f6317db2-83d0-11ef-8655-00e04cf010f7','José','jose.martin@example.com','df093a97-83c7-11ef-8655-00e04cf010f7','3d7cb24f-83c8-11ef-8655-00e04cf010f7','62b69574-83c8-11ef-8655-00e04cf010f7','1988-12-12','9a98cc2e-83cd-11ef-8655-00e04cf010f7','916283d5-83c8-11ef-8655-00e04cf010f7','afb83780-83cb-11ef-8655-00e04cf010f7','Martín','Pérez','1020304948','+51 985839185',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tb_personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_productos`
--

DROP TABLE IF EXISTS `tb_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_productos` (
  `id_producto` varchar(36) NOT NULL DEFAULT (uuid()),
  `nombre_producto` varchar(100) NOT NULL,
  `descripcion` text,
  `stock` int NOT NULL,
  `id_categoria` varchar(36) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_marca` varchar(36) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `precio_compra` decimal(10,2) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `producto_img` text,
  `fecha_ingreso` date NOT NULL,
  `codigo_producto` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estado_produto` enum('Disponible','Agotado') DEFAULT 'Disponible',
  `id_sucursal` varchar(36) DEFAULT NULL,
  `id_tipo_propietario` varchar(36) NOT NULL,
  `precio_base_sin_igv` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `nombre_producto_UNIQUE` (`nombre_producto`),
  UNIQUE KEY `codigo_producto` (`codigo_producto`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_marca` (`id_marca`),
  KEY `id_sucursal` (`id_sucursal`),
  KEY `fk_producto_tipo_propietario` (`id_tipo_propietario`),
  CONSTRAINT `fk_producto_tipo_propietario` FOREIGN KEY (`id_tipo_propietario`) REFERENCES `tb_tipo_propietario` (`id_tipo_propietario`),
  CONSTRAINT `tb_productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `tb_categorias` (`id_categoria`),
  CONSTRAINT `tb_productos_ibfk_2` FOREIGN KEY (`id_marca`) REFERENCES `tb_marcas` (`id_marca`),
  CONSTRAINT `tb_productos_ibfk_4` FOREIGN KEY (`id_sucursal`) REFERENCES `tb_sucursales` (`id_sucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_productos`
--

LOCK TABLES `tb_productos` WRITE;
/*!40000 ALTER TABLE `tb_productos` DISABLE KEYS */;
INSERT INTO `tb_productos` VALUES ('1645df7b-b06e-11ef-a589-00e04cf010f7','Auriculares inalámbricos para juegos ASUS ROG Delta S','Especificaciones de ASUS ROG Delta S auriculares de juegos inalámbricos Auricular Diseño de auriculares: Over-ore (circumaural), cerrado Auricular giratorio: No Auricador de conexión / estilo de uso: Venda plegable: Sí Número de auriculares: Auricular dual Campo de sonido: Estereo, borde virtual de 7.1 canales Tamaño del conductor: 2.0 \" / 50 mm Tipo de imán: Neodimio Impedancia: 32 ohmios Cancelación de ruido activo: No Ubicación de los controles/micrófono: Controles: auricular izquierdo Sensores: Ninguno Respuesta frecuente: 20 Hz a 20,000 Hz Limitación de volumen: Ninguno Micrófono Número de micrófonos de voz: 2 Soporte de formación de vigas: Sí Patrón de recogida: Bidireccional Cancelación de ruido: Sí Respuesta frecuente: 100 Hz a 10,000 Hz Sensibilidad: -37 db Conectividad inalámbrica Bluetooth: 5.0 Alcance inalámbrico: 82 \' / 25 m Frecuencia: Analógico: Bluetooth de 2.4 GHz: Soporte multipunto: No NFC: No Conexión del host del transmisor: USB-C Encriptación: Ninguno Conector de audio a fuente: Ninguno Adaptador (incluido): USB-C a USB-A Batería Capacidad (MAH): 1800 mah Tiempo de ejecución: 25 horas (BT) Tiempos de carga rápidos: 15 minutos durante 3 horas Carga inalambrica: Ninguno Puerto de carga: USB-C Longitud del cable de carga: 3.3 \' / 1 m Estación base / transmisor H: 1 x USB -C - Salida de audio Decodificación de audio: DTS Virtual: X Estuche Soporte de plataforma: WindowsPlayStation 4 (con adaptador/cable opcional) PlayStation 5Macnintendo Switch Compatibilidad del sistema operativo: Android *A partir de noviembre de 2022: consulte con el fabricante para obtener la compatibilidad más actualizada Hardware requerido: Puerto USB-A 2.0 Físico Color: Negro Resistencia al agua: Ninguno Clasificación del IP: Ninguno Indicador LED: Sí Peso: 10.9 oz / 310 g Información de embalaje peso del paquete: 2.2 lb Dimensiones de caja (LXWXH): 10 x 8.5 x 4.5 \"',13,'0f5fd5ba-83cd-11ef-8655-00e04cf010f7','2024-12-02 10:27:14','a1f2130c-83cc-11ef-8655-00e04cf010f7',1,12.00,20.00,'data:image/jpeg;base64,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','2024-12-02','AUR-24-00003','2024-12-26 00:09:09','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b4b349-8b6b-11ef-893b-00e04cf010f7',NULL),('4b7150eb-ba6c-11ef-bd3b-c03fd5ad989d','Producto alerta','Alerta producto ',1,'0f5fd763-83cd-11ef-8655-00e04cf010f7','2024-12-15 03:39:36','a1f20f70-83cc-11ef-8655-00e04cf010f7',1,12.00,14.00,'htttps://imagen.jpg','2024-12-14','FUN-24-00003','2024-12-15 03:39:36','Disponible','7ca5a3e7-b1d6-11ef-984d-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',11.86),('6dc9a5d1-a953-11ef-a9f6-00e04cf010f7','Cargador Rápido 25W Samsung','Cargador original Samsung con tecnología de carga rápida 25W',52,'0f5fac59-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f2057a-83cc-11ef-8655-00e04cf010f7',1,15.00,29.99,'cargador_samsung.jpg','2024-10-12','CAR-24-00001','2024-12-07 20:55:49','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcc121d-a953-11ef-a9f6-00e04cf010f7','Cargador iPhone 20W USB-C','Cargador original Apple con puerto USB-C',40,'0f5fac59-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f20ad7-83cc-11ef-8655-00e04cf010f7',1,20.00,39.99,'cargador_apple.jpg','2024-10-12','CAR-24-00002','2024-12-14 14:35:44','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcc388a-a953-11ef-a9f6-00e04cf010f7','Galaxy Buds2 Pro','Auriculares Samsung con audio 360',29,'0f5fd5ba-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f2057a-83cc-11ef-8655-00e04cf010f7',1,150.00,199.99,'galaxy_buds.jpg','2024-10-12','AUR-24-00002','2024-12-05 02:30:56','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcc786d-a953-11ef-a9f6-00e04cf010f7','Funda iPhone 15 Pro Silicona','Funda original Apple de silicona con MagSafe',59,'0f5fd763-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f20ad7-83cc-11ef-8655-00e04cf010f7',1,25.00,49.99,'funda_iphone.jpg','2024-10-12','FUN-24-00001','2024-12-14 15:10:52','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcc8c23-a953-11ef-a9f6-00e04cf010f7','Funda Samsung S24 Ultra Clear','Funda transparente con protección anti-golpes',45,'0f5fd763-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f2057a-83cc-11ef-8655-00e04cf010f7',1,15.00,29.99,'funda_samsung.jpg','2024-10-12','FUN-24-00002','2024-11-23 04:28:46','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcc9e8e-a953-11ef-a9f6-00e04cf010f7','Protector Vidrio iPhone 15','Protector de pantalla de vidrio templado 9H',100,'0f5fd849-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f20ad7-83cc-11ef-8655-00e04cf010f7',1,5.00,14.99,'protector_iphone.jpg','2024-10-12','PRO-24-00001','2024-12-04 16:36:21','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dccb06e-a953-11ef-a9f6-00e04cf010f7','Protector Cerámico S24','Protector cerámico flexible anti-rayones',76,'0f5fd849-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f2057a-83cc-11ef-8655-00e04cf010f7',1,8.00,19.99,'protector_samsung.jpg','2024-10-12','PRO-24-00002','2024-12-14 14:16:12','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dccbbd9-a953-11ef-a9f6-00e04cf010f7','Teclado Mecánico Razer BlackWidow','Teclado gaming mecánico RGB',25,'0f5fd92a-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f21257-83cc-11ef-8655-00e04cf010f7',1,80.00,129.99,'teclado_razer.jpg','2024-10-12','TEC-24-00001','2024-12-02 19:21:19','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dccc78b-a953-11ef-a9f6-00e04cf010f7','Teclado Logitech MX Keys','Teclado inalámbrico premium para productividad',14,'0f5fd92a-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f211a0-83cc-11ef-8655-00e04cf010f7',1,70.00,119.99,'teclado_logitech.jpg','2024-10-12','TEC-24-00002','2024-12-04 15:06:02','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dccd2d5-a953-11ef-a9f6-00e04cf010f7','Mouse Gaming Razer DeathAdder','Mouse gaming con sensor óptico 20K DPI',30,'0f5fd9f9-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f21257-83cc-11ef-8655-00e04cf010f7',1,40.00,69.99,'mouse_razer.jpg','2024-10-12','RAT-24-00001','2024-11-23 04:28:46','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dccdf60-a953-11ef-a9f6-00e04cf010f7','Mouse Logitech MX Master 3S','Mouse premium con scroll electromagnético',25,'0f5fd9f9-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f211a0-83cc-11ef-8655-00e04cf010f7',1,60.00,99.99,'mouse_logitech.jpg','2024-10-12','RAT-24-00002','2024-11-23 04:28:46','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dccef6f-a953-11ef-a9f6-00e04cf010f7','Monitor Gaming ASUS ROG 27\"','Monitor gaming 165Hz 2K',10,'0f5fdac4-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f2130c-83cc-11ef-8655-00e04cf010f7',1,300.00,449.99,'monitor_asus.jpg','2024-10-12','MON-24-00001','2024-11-23 04:28:46','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcd51db-a953-11ef-a9f6-00e04cf010f7','Monitor Dell UltraSharp 32\"','Monitor 4K profesional para diseño',9,'0f5fdac4-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f20f70-83cc-11ef-8655-00e04cf010f7',1,400.00,599.99,'monitor_dell.jpg','2024-10-12','MON-24-00002','2024-11-26 00:48:28','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcd625f-a953-11ef-a9f6-00e04cf010f7','Auriculares Razer Kraken','Auriculares gaming con sonido envolvente 7.1',24,'0f5fdb8f-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f21257-83cc-11ef-8655-00e04cf010f7',1,50.00,79.99,'auriculares_razer.jpg','2024-10-12','ACC-24-00001','2024-12-24 20:37:19','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcd6e47-a953-11ef-a9f6-00e04cf010f7','Mousepad Razer Gigantus V2','Mousepad gaming XXL',40,'0f5fdb8f-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f21257-83cc-11ef-8655-00e04cf010f7',1,15.00,29.99,'mousepad_razer.jpg','2024-10-12','ACC-24-00002','2024-11-23 04:28:46','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcd7928-a953-11ef-a9f6-00e04cf010f7','PowerBank Samsung 10000mAh','Batería externa con carga rápida',50,'0f5fdc63-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f2057a-83cc-11ef-8655-00e04cf010f7',1,25.00,44.99,'powerbank_samsung.jpg','2024-10-12','BAT-24-00001','2024-11-23 04:28:46','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcd83f1-a953-11ef-a9f6-00e04cf010f7','PowerBank Xiaomi 20000mAh','Batería externa de alta capacidad',39,'0f5fdc63-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f20d08-83cc-11ef-8655-00e04cf010f7',1,30.00,54.99,'powerbank_xiaomi.jpg','2024-10-12','BAT-24-00002','2024-12-04 08:45:28','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcd931f-a953-11ef-a9f6-00e04cf010f7','Webcam Logitech C920','Webcam HD 1080p',25,'0f5fdd27-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f211a0-83cc-11ef-8655-00e04cf010f7',1,45.00,79.99,'webcam_logitech.jpg','2024-10-12','WEB-24-00001','2024-12-15 04:57:20','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('6dcd9e62-a953-11ef-a9f6-00e04cf010f7','Webcam Razer Kiyo Pro Modificado','Webcam para streaming 1080p/60fps',16,'0f5fdd27-83cd-11ef-8655-00e04cf010f7','2024-11-23 04:28:46','a1f21257-83cc-11ef-8655-00e04cf010f7',1,100.00,149.99,'webcam_razer.jpg','2024-10-12','WEB-24-00002','2024-11-23 04:37:51','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',127.11),('8a7e8f7f-aa92-11ef-ad66-00e04cf010f7','Producto Prueba','JAJAAA',11,'afcf750e-94eb-11ef-a166-00e04cf010f7','2024-11-24 23:33:04','f1497af2-8ab1-11ef-8cb6-00e04cf010f7',1,1.00,2.00,'https://image.made-in-china.com/202f0j00KyUiAYTMgRrP/New-Product-Cute-Pink-Wireless-Headphone-with-LED-Light-Wireless-Earphone-Gaming-Headset-for-Children.webp','2024-11-24','SEN-24-00001','2024-11-25 13:19:21','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b4b349-8b6b-11ef-893b-00e04cf010f7',NULL),('e43edf9c-b9af-11ef-b775-c03fd5ad989d','Galaxy Z Flip 5','Teléfono plegable con pantalla innovadora',29,'0f5fdc63-83cd-11ef-8655-00e04cf010f7','2024-12-14 05:10:57','a1f2057a-83cc-11ef-8655-00e04cf010f7',1,900.00,1200.00,NULL,'2024-12-14','BAT-24-00005','2024-12-14 13:08:08','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('e43eec42-b9af-11ef-b775-c03fd5ad989d','Galaxy Tab S9','Tablet de alto rendimiento para productividad',19,'0f5fdc63-83cd-11ef-8655-00e04cf010f7','2024-12-14 05:10:57','a1f2057a-83cc-11ef-8655-00e04cf010f7',1,600.00,750.00,NULL,'2024-12-14','BAT-24-00006','2024-12-14 13:09:17','Disponible','25955d78-8981-11ef-baca-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',NULL),('f6ea7ecd-ba81-11ef-bd3b-c03fd5ad989d','Producto Test ','test numero 1',1,'0f5fe03f-83cd-11ef-8655-00e04cf010f7','2024-12-15 06:14:43','a1f21478-83cc-11ef-8655-00e04cf010f7',1,12.00,14.00,'imagen','2024-12-15','EST-24-00001','2024-12-15 06:14:43','Disponible','7ca5a3e7-b1d6-11ef-984d-00e04cf010f7','c7b48bf3-8b6b-11ef-893b-00e04cf010f7',11.86);
/*!40000 ALTER TABLE `tb_productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_producto_insert` BEFORE INSERT ON `tb_productos` FOR EACH ROW BEGIN
    DECLARE categoria_prefijo VARCHAR(3);
    DECLARE siguiente_numero INT;
    DECLARE anio_actual VARCHAR(2);
    
    -- Obtener el año actual (últimos 2 dígitos)
    SET anio_actual = RIGHT(YEAR(CURRENT_DATE), 2);
    
    -- Obtener prefijo de categoría usando nombre_cat
    SELECT UPPER(SUBSTRING(nombre_cat, 1, 3)) INTO categoria_prefijo
    FROM tb_categorias
    WHERE id_categoria = NEW.id_categoria;
    
    -- Si el prefijo es NULL, usar valor por defecto
    SET categoria_prefijo = COALESCE(categoria_prefijo, 'PRD');
    
    -- Obtener el siguiente número secuencial para este año y categoría
    SELECT COALESCE(MAX(
        CAST(
            SUBSTRING(codigo_producto, -5) AS UNSIGNED
        )
    ), 0) + 1
    INTO siguiente_numero
    FROM tb_productos
    WHERE codigo_producto LIKE CONCAT(categoria_prefijo, '-', anio_actual, '%');
    
    -- Generar el nuevo código de producto (SKU)
    -- Formato: CAT-23-00001
    -- CAT: Categoría (3 letras)
    -- 23: Año actual (2 dígitos)
    -- 00001: Número secuencial (5 dígitos)
    SET NEW.codigo_producto = CONCAT(
        categoria_prefijo, '-',
        anio_actual, '-',
        LPAD(siguiente_numero, 5, '0')
    );
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_proveedores`
--

DROP TABLE IF EXISTS `tb_proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_proveedores` (
  `id_proveedor` varchar(36) NOT NULL DEFAULT (uuid()),
  `id_persona` varchar(36) DEFAULT NULL,
  `estado_proveedor` enum('Activo','Inactivo','Suspendido') DEFAULT 'Activo',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `nombre_comercial` varchar(100) DEFAULT NULL,
  `total_compras` decimal(10,2) DEFAULT '0.00',
  `ultima_compra` datetime DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`),
  KEY `id_persona` (`id_persona`),
  CONSTRAINT `tb_proveedores_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `tb_personas` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_proveedores`
--

LOCK TABLES `tb_proveedores` WRITE;
/*!40000 ALTER TABLE `tb_proveedores` DISABLE KEYS */;
INSERT INTO `tb_proveedores` VALUES ('769c41c4-b0e7-11ef-ad0f-00e04cf010f7','b31d1ece-93ef-11ef-ab9a-00e04cf010f7','Inactivo','2024-12-03 00:56:05','2024-12-03 00:56:05','SENATI',0.00,NULL),('9def0c01-a954-11ef-a9f6-00e04cf010f7','6b06e2a8-b0f8-11ef-ad0f-00e04cf010f7','Activo','2024-11-23 04:37:16','2024-12-14 14:41:24','Proveedor Central',135.67,'2024-12-14 09:41:24'),('bc511764-b101-11ef-ad0f-00e04cf010f7','f6317db2-83d0-11ef-8655-00e04cf010f7','Inactivo','2024-12-03 04:04:08','2024-12-14 15:07:13','SENATINO 2',530.89,'2024-12-14 10:07:13'),('d7530666-ab98-11ef-95f5-00e04cf010f7','cf6e8a48-ab98-11ef-95f5-00e04cf010f7','Activo','2024-11-26 06:50:41','2024-12-02 19:42:38','Proveedores',334.15,'2024-12-02 14:42:38');
/*!40000 ALTER TABLE `tb_proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_rol`
--

DROP TABLE IF EXISTS `tb_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_rol` (
  `id_rol` varchar(36) NOT NULL DEFAULT (uuid()),
  `nombre_rol` varchar(100) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_rol`
--

LOCK TABLES `tb_rol` WRITE;
/*!40000 ALTER TABLE `tb_rol` DISABLE KEYS */;
INSERT INTO `tb_rol` VALUES ('75be9b6d-83d1-11ef-8655-00e04cf010f7','Administrador','Puede realizar todas las acciones en el sistemas.',1),('75bea34d-83d1-11ef-8655-00e04cf010f7','Vendedor','Puede realizar ventas, agregar productos y gestionar clientes.',1),('bc11cad9-bed8-11ef-89c1-c03fd5ad989d','Programador','Este es el rol de programador del sistema',1),('dc69e7b5-854a-11ef-be95-00155d3bb553','Senatino','Es un estudiante practicante de Senati',0);
/*!40000 ALTER TABLE `tb_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sexo`
--

DROP TABLE IF EXISTS `tb_sexo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_sexo` (
  `id_sexo` varchar(36) NOT NULL DEFAULT (uuid()),
  `sexo` varchar(20) NOT NULL,
  PRIMARY KEY (`id_sexo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sexo`
--

LOCK TABLES `tb_sexo` WRITE;
/*!40000 ALTER TABLE `tb_sexo` DISABLE KEYS */;
INSERT INTO `tb_sexo` VALUES ('62b68f65-83c8-11ef-8655-00e04cf010f7','Masculino'),('62b6942c-83c8-11ef-8655-00e04cf010f7','Femenino'),('62b69574-83c8-11ef-8655-00e04cf010f7','No binario'),('62b69643-83c8-11ef-8655-00e04cf010f7','Prefiero no decirlo'),('62b69702-83c8-11ef-8655-00e04cf010f7','Otro');
/*!40000 ALTER TABLE `tb_sexo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_sucursales`
--

DROP TABLE IF EXISTS `tb_sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_sucursales` (
  `id_sucursal` varchar(36) NOT NULL DEFAULT (uuid()),
  `nombre_sucursal` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `id_direccion` varchar(36) NOT NULL,
  `id_tipo_telefono` varchar(36) DEFAULT NULL,
  `id_pais` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id_sucursal`),
  KEY `fk_direccion` (`id_direccion`),
  KEY `fk_tipo_telefono` (`id_tipo_telefono`),
  KEY `fk_pais` (`id_pais`),
  CONSTRAINT `fk_direccion` FOREIGN KEY (`id_direccion`) REFERENCES `tb_direccion` (`id_direccion`),
  CONSTRAINT `fk_pais` FOREIGN KEY (`id_pais`) REFERENCES `tb_pais` (`id_pais`),
  CONSTRAINT `fk_tipo_telefono` FOREIGN KEY (`id_tipo_telefono`) REFERENCES `tb_tipo_telefono` (`id_tipo_telefono`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_sucursales`
--

LOCK TABLES `tb_sucursales` WRITE;
/*!40000 ALTER TABLE `tb_sucursales` DISABLE KEYS */;
INSERT INTO `tb_sucursales` VALUES ('25955d78-8981-11ef-baca-00e04cf010f7','Icase\'s Store','+51 986 544 851','xiomaracabezudo@gmail.com','18be9178-8980-11ef-baca-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','916283d5-83c8-11ef-8655-00e04cf010f7'),('57a3d923-94d6-11ef-a166-00e04cf010f7','Et vel molestiae qua','+5194443102','asdasd@senati.pe','9a98afbf-83cd-11ef-8655-00e04cf010f7','afb83542-83cb-11ef-8655-00e04cf010f7','91628702-83c8-11ef-8655-00e04cf010f7'),('7ca5a3e7-b1d6-11ef-984d-00e04cf010f7','SENATI','+51999999999','1433044@senati.pe','9a98c982-83cd-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','916283d5-83c8-11ef-8655-00e04cf010f7'),('b184d089-8a31-11ef-b766-00e04cf010f7','SEnati Venta','+51944431024','1433044@senati.pe','9a98c982-83cd-11ef-8655-00e04cf010f7','afb83780-83cb-11ef-8655-00e04cf010f7','9162848b-83c8-11ef-8655-00e04cf010f7');
/*!40000 ALTER TABLE `tb_sucursales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_telefonos_persona`
--

DROP TABLE IF EXISTS `tb_telefonos_persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_telefonos_persona` (
  `id_telefono` varchar(36) NOT NULL DEFAULT (uuid()),
  `id_persona` varchar(36) DEFAULT NULL,
  `id_tipo_telefono` varchar(36) DEFAULT NULL,
  `numero_telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_telefono`),
  KEY `id_persona` (`id_persona`),
  KEY `id_tipo_telefono` (`id_tipo_telefono`),
  CONSTRAINT `tb_telefonos_persona_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `tb_personas` (`id_persona`),
  CONSTRAINT `tb_telefonos_persona_ibfk_2` FOREIGN KEY (`id_tipo_telefono`) REFERENCES `tb_tipo_telefono` (`id_tipo_telefono`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_telefonos_persona`
--

LOCK TABLES `tb_telefonos_persona` WRITE;
/*!40000 ALTER TABLE `tb_telefonos_persona` DISABLE KEYS */;
INSERT INTO `tb_telefonos_persona` VALUES ('1eb93d41-83d1-11ef-8655-00e04cf010f7','a3b0e1f7-83d0-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','987654321'),('1eb94773-83d1-11ef-8655-00e04cf010f7','c1386e3e-83d0-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','998877665'),('1eb94994-83d1-11ef-8655-00e04cf010f7','e51c6fa5-83d0-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','1234567'),('1eb94b48-83d1-11ef-8655-00e04cf010f7','f21bfa7f-83d0-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','987123456'),('1eb94cec-83d1-11ef-8655-00e04cf010f7','f6317db2-83d0-11ef-8655-00e04cf010f7','afb82fd6-83cb-11ef-8655-00e04cf010f7','2123456');
/*!40000 ALTER TABLE `tb_telefonos_persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tipo_documento`
--

DROP TABLE IF EXISTS `tb_tipo_documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_tipo_documento` (
  `id_tipo_documento` varchar(36) NOT NULL DEFAULT (uuid()),
  `documento` varchar(100) NOT NULL,
  PRIMARY KEY (`id_tipo_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_documento`
--

LOCK TABLES `tb_tipo_documento` WRITE;
/*!40000 ALTER TABLE `tb_tipo_documento` DISABLE KEYS */;
INSERT INTO `tb_tipo_documento` VALUES ('3d7caa5b-83c8-11ef-8655-00e04cf010f7','DNI'),('3d7caec9-83c8-11ef-8655-00e04cf010f7','RUC'),('3d7cb008-83c8-11ef-8655-00e04cf010f7','Pasaporte'),('3d7cb0d4-83c8-11ef-8655-00e04cf010f7','Carné de Extranjería'),('3d7cb192-83c8-11ef-8655-00e04cf010f7','Cédula de Identidad'),('3d7cb24f-83c8-11ef-8655-00e04cf010f7','Libreta Militar'),('3d7cb308-83c8-11ef-8655-00e04cf010f7','Otros');
/*!40000 ALTER TABLE `tb_tipo_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tipo_persona`
--

DROP TABLE IF EXISTS `tb_tipo_persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_tipo_persona` (
  `id_tipo_persona` varchar(36) NOT NULL DEFAULT (uuid()),
  `tipo_persona` varchar(100) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_tipo_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_persona`
--

LOCK TABLES `tb_tipo_persona` WRITE;
/*!40000 ALTER TABLE `tb_tipo_persona` DISABLE KEYS */;
INSERT INTO `tb_tipo_persona` VALUES ('df091edc-83c7-11ef-8655-00e04cf010f7','personal','Persona natural relacionada a la gestión personal.'),('df09389f-83c7-11ef-8655-00e04cf010f7','cliente','Persona o entidad que recibe productos o servicios.'),('df093a97-83c7-11ef-8655-00e04cf010f7','proveedor','Persona o entidad que ofrece productos o servicios.'),('df093b82-83c7-11ef-8655-00e04cf010f7','duenia','Persona que posee un negocio o propiedad.'),('df093c5a-83c7-11ef-8655-00e04cf010f7','desarrollador','Persona involucrada en el desarrollo de software o proyectos.');
/*!40000 ALTER TABLE `tb_tipo_persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tipo_propietario`
--

DROP TABLE IF EXISTS `tb_tipo_propietario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_tipo_propietario` (
  `id_tipo_propietario` varchar(36) NOT NULL DEFAULT (uuid()),
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo_propietario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_propietario`
--

LOCK TABLES `tb_tipo_propietario` WRITE;
/*!40000 ALTER TABLE `tb_tipo_propietario` DISABLE KEYS */;
INSERT INTO `tb_tipo_propietario` VALUES ('c7b48bf3-8b6b-11ef-893b-00e04cf010f7','Tienda'),('c7b4b349-8b6b-11ef-893b-00e04cf010f7','Proveedor Externo');
/*!40000 ALTER TABLE `tb_tipo_propietario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tipo_telefono`
--

DROP TABLE IF EXISTS `tb_tipo_telefono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_tipo_telefono` (
  `id_tipo_telefono` varchar(36) NOT NULL DEFAULT (uuid()),
  `tipo_telefono` varchar(50) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_telefono`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_telefono`
--

LOCK TABLES `tb_tipo_telefono` WRITE;
/*!40000 ALTER TABLE `tb_tipo_telefono` DISABLE KEYS */;
INSERT INTO `tb_tipo_telefono` VALUES ('afb82fd6-83cb-11ef-8655-00e04cf010f7','celular','Teléfono móvil o celular para uso personal.'),('afb83542-83cb-11ef-8655-00e04cf010f7','teléfono fijo','Teléfono conectado a una línea telefónica fija.'),('afb836a9-83cb-11ef-8655-00e04cf010f7','teléfono de VoIP','Teléfono que utiliza tecnología de voz sobre IP.'),('afb83780-83cb-11ef-8655-00e04cf010f7','teléfono de línea directa','Teléfono con conexión directa sin intermediarios.'),('afb83847-83cb-11ef-8655-00e04cf010f7','teléfono público','Teléfono de uso público, generalmente en espacios públicos.');
/*!40000 ALTER TABLE `tb_tipo_telefono` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tipo_via`
--

DROP TABLE IF EXISTS `tb_tipo_via`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_tipo_via` (
  `id_tipo_via` varchar(36) NOT NULL DEFAULT (uuid()),
  `codigo` varchar(10) DEFAULT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id_tipo_via`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_via`
--

LOCK TABLES `tb_tipo_via` WRITE;
/*!40000 ALTER TABLE `tb_tipo_via` DISABLE KEYS */;
INSERT INTO `tb_tipo_via` VALUES ('49412f5f-83c5-11ef-8655-00e04cf010f7','01','Avenida'),('49422187-83c5-11ef-8655-00e04cf010f7','02','Jirón'),('4942270b-83c5-11ef-8655-00e04cf010f7','03','Calle'),('49422821-83c5-11ef-8655-00e04cf010f7','04','Pasaje'),('4942292f-83c5-11ef-8655-00e04cf010f7','05','Alameda'),('49422b49-83c5-11ef-8655-00e04cf010f7','06','Malecón'),('49422c4e-83c5-11ef-8655-00e04cf010f7','07','Óvalo'),('49422d14-83c5-11ef-8655-00e04cf010f7','08','Parque'),('49422de3-83c5-11ef-8655-00e04cf010f7','09','Plaza'),('49422ea1-83c5-11ef-8655-00e04cf010f7','10','Carretera'),('49422f5c-83c5-11ef-8655-00e04cf010f7','11','Block'),('4942301a-83c5-11ef-8655-00e04cf010f7','12','Otros');
/*!40000 ALTER TABLE `tb_tipo_via` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tipo_zona`
--

DROP TABLE IF EXISTS `tb_tipo_zona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_tipo_zona` (
  `id_tipo_zona` varchar(36) NOT NULL DEFAULT (uuid()),
  `codigo` varchar(10) DEFAULT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id_tipo_zona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tipo_zona`
--

LOCK TABLES `tb_tipo_zona` WRITE;
/*!40000 ALTER TABLE `tb_tipo_zona` DISABLE KEYS */;
INSERT INTO `tb_tipo_zona` VALUES ('2a1c302e-83c6-11ef-8655-00e04cf010f7','01','Urbanización'),('2a1c3518-83c6-11ef-8655-00e04cf010f7','02','Pueblo Joven'),('2a1c3670-83c6-11ef-8655-00e04cf010f7','03','Unidad Vecinal'),('2a1c3746-83c6-11ef-8655-00e04cf010f7','04','Conjunto Habitacional'),('2a1c3807-83c6-11ef-8655-00e04cf010f7','05','Asentamiento Humano'),('2a1c38cd-83c6-11ef-8655-00e04cf010f7','06','Cooperativa'),('2a1c398b-83c6-11ef-8655-00e04cf010f7','07','Residencial'),('2a1c3a44-83c6-11ef-8655-00e04cf010f7','08','Zona Industrial'),('2a1c3b0b-83c6-11ef-8655-00e04cf010f7','09','Grupo'),('2a1c3bca-83c6-11ef-8655-00e04cf010f7','10','Caserío'),('2a1c3c83-83c6-11ef-8655-00e04cf010f7','11','Fundo'),('2a1c3d3a-83c6-11ef-8655-00e04cf010f7','12','Otros');
/*!40000 ALTER TABLE `tb_tipo_zona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_ventas`
--

DROP TABLE IF EXISTS `tb_ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_ventas` (
  `id_venta` varchar(36) NOT NULL DEFAULT (uuid()),
  `fecha_venta` date DEFAULT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `tipo_documento` enum('FACTURA','BOLETA','NOTA_CREDITO','NOTA_DEBITO') NOT NULL DEFAULT 'BOLETA',
  `subtotal` decimal(10,2) NOT NULL,
  `impuesto` decimal(10,2) DEFAULT NULL,
  `precio_total` decimal(10,2) DEFAULT NULL,
  `id_cliente` varchar(36) DEFAULT NULL,
  `id_metodo_pago` varchar(36) DEFAULT NULL,
  `id_sucursal` varchar(36) DEFAULT NULL,
  `id_personal` varchar(36) DEFAULT NULL,
  `estado_venta` enum('PENDIENTE','COMPLETADA','ANULADA') NOT NULL DEFAULT 'COMPLETADA',
  `serie_documento` varchar(25) DEFAULT NULL,
  `observaciones` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_venta`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_metodo_pago` (`id_metodo_pago`),
  KEY `id_sucursal` (`id_sucursal`),
  KEY `id_personal` (`id_personal`),
  CONSTRAINT `tb_ventas_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `tb_cliente` (`id_cliente`),
  CONSTRAINT `tb_ventas_ibfk_3` FOREIGN KEY (`id_metodo_pago`) REFERENCES `tb_metodo_pago` (`id_metodo_pago`),
  CONSTRAINT `tb_ventas_ibfk_4` FOREIGN KEY (`id_sucursal`) REFERENCES `tb_sucursales` (`id_sucursal`),
  CONSTRAINT `tb_ventas_ibfk_5` FOREIGN KEY (`id_personal`) REFERENCES `tb_personal` (`id_personal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_ventas`
--

LOCK TABLES `tb_ventas` WRITE;
/*!40000 ALTER TABLE `tb_ventas` DISABLE KEYS */;
INSERT INTO `tb_ventas` VALUES ('107c61a8-baa1-11ef-bd3b-c03fd5ad989d',NULL,'COM-1734238640077','BOLETA',79.99,14.40,94.39,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1734238640077','Probando maldit boob','2024-12-15 09:57:20','2024-12-15 09:57:20'),('1afa1e91-ab97-11ef-95f5-00e04cf010f7',NULL,'B001-00000001','BOLETA',100.00,18.00,118.00,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7','25955d78-8981-11ef-baca-00e04cf010f7','9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','B001','Venta de prueba','2024-11-26 01:38:15','2024-11-26 01:38:15'),('1d207673-b21c-11ef-984d-00e04cf010f7',NULL,'COM-1733301928904','BOLETA',54.99,9.90,64.89,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5ab7f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1733301928904','VENTAAA','2024-12-04 13:45:29','2024-12-04 13:45:29'),('1fb19dbd-b2a4-11ef-833c-00e04cf010f7',NULL,'COM-1733360344707','BOLETA',49.99,9.00,58.99,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1733360344707','PROBANDO BOLETA\n','2024-12-05 05:59:05','2024-12-05 05:59:05'),('4717607f-b251-11ef-a732-00e04cf010f7',NULL,'COM-1733324762639','BOLETA',119.99,21.60,141.59,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1733324762639','PROBANDO EL COSO','2024-12-04 20:06:03','2024-12-04 20:06:03'),('66ee18a9-b254-11ef-a732-00e04cf010f7',NULL,'COM-1733326104542','NOTA_CREDITO',199.99,36.00,235.99,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5aab4-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1733326104542','Probando descuento','2024-12-04 20:28:25','2024-12-04 20:28:25'),('7678ee38-ba1c-11ef-8045-c03fd5ad989d',NULL,'COM-1734181688098','BOLETA',1200.00,216.00,1416.00,'5bf2dc52-b2d1-11ef-833c-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1734181688098','Provnado articulo mas vendido','2024-12-14 18:08:08','2024-12-14 18:08:08'),('7f77a53a-b24f-11ef-a732-00e04cf010f7',NULL,'COM-1733323998164','BOLETA',14.99,2.70,17.69,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1733323998164','PROBANDO VENTA DEL DIA','2024-12-04 19:53:18','2024-12-04 19:53:18'),('9c46701d-ba2d-11ef-a8f5-c03fd5ad989d',NULL,'COM-1734189052983','BOLETA',449.91,80.98,530.89,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1734189052983','Venta Probnado','2024-12-14 20:10:53','2024-12-14 20:10:53'),('9ff00cb2-ba1c-11ef-8045-c03fd5ad989d',NULL,'COM-1734181757680','FACTURA',750.00,135.00,885.00,'5bf2dc52-b2d1-11ef-833c-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1734181757680','Venta ','2024-12-14 18:09:18','2024-12-14 18:09:18'),('a3555a43-b4dd-11ef-b71d-00e04cf010f7',NULL,'COM-1733604949213','BOLETA',29.99,5.40,35.39,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1733604949213','JA','2024-12-08 01:55:49','2024-12-08 01:55:49'),('b9439957-b4b2-11ef-b71d-00e04cf010f7',NULL,'COM-1733586517634','FACTURA',29.99,5.40,35.39,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1733586517634','Probando Ventas Sale ','2024-12-07 20:48:38','2024-12-07 20:48:38'),('bbf9f1b1-b4db-11ef-b71d-00e04cf010f7',NULL,'COM-1733604131570','BOLETA',39.98,7.20,47.18,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1733604131570','Agregamos\n','2024-12-08 01:42:12','2024-12-08 01:42:12'),('f4b27765-b2b0-11ef-833c-00e04cf010f7',NULL,'COM-1733365856031','FACTURA',239.98,43.20,283.18,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1733365856031','PROBANDO 2 ventas','2024-12-05 07:30:56','2024-12-05 07:30:56'),('f8b027c6-ba25-11ef-a8f5-c03fd5ad989d',NULL,'COM-1734185772028','BOLETA',39.98,7.20,47.18,'7de31aee-ab95-11ef-95f5-00e04cf010f7','7ec5850f-a5ed-11ef-84ff-00e04cf010f7',NULL,'9f5fb672-83d6-11ef-8655-00e04cf010f7','COMPLETADA','SERIE-1734185772028','Probando coso','2024-12-14 19:16:12','2024-12-14 19:16:12');
/*!40000 ALTER TABLE `tb_ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_cliente_after_insert` AFTER INSERT ON `tb_ventas` FOR EACH ROW BEGIN
    -- Declarar variable para manejar posibles errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Puedes registrar el error en una tabla de log si lo deseas
        INSERT INTO error_log (error_message, fecha)
        VALUES ('Error en trigger actualizar_cliente_after_insert', NOW());
        RESIGNAL;
    END;

    -- Verificar si la venta está completada
    IF NEW.estado_venta = 'COMPLETADA' THEN
        -- Verificar si el cliente existe antes de actualizar
        IF EXISTS (SELECT 1 FROM tb_cliente WHERE id_cliente = NEW.id_cliente) THEN
            -- Actualizar última compra y total de compras
            UPDATE tb_cliente 
            SET 
                ultima_compra = COALESCE(NEW.fecha_venta, NOW()),
                total_compras = (
                    SELECT COALESCE(SUM(precio_total), 0) 
                    FROM tb_ventas 
                    WHERE id_cliente = NEW.id_cliente 
                    AND estado_venta = 'COMPLETADA'
                )
            WHERE id_cliente = NEW.id_cliente;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'db_icase_seminario'
--

--
-- Dumping routines for database 'db_icase_seminario'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-27 11:51:20
