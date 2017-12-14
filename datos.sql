CREATE DATABASE  IF NOT EXISTS `conferenceonline` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `conferenceonline`;
CREATE USER 'java2017'@'localhost' IDENTIFIED BY '2017';
CREATE USER 'java2017'@'%' IDENTIFIED BY '2017';
GRANT ALL PRIVILEGES ON conferenceonline . * TO 'java2017'@'localhost';
GRANT ALL PRIVILEGES ON conferenceonline . * TO 'java2017'@'%';

-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: conferenceonline
-- ------------------------------------------------------
-- Server version	5.7.16-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `canales`
--

DROP TABLE IF EXISTS `canales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canales` (
  `idCanal` int(11) NOT NULL,
  `descripcion` text,
  `titulo` varchar(45) DEFAULT NULL,
  `imgUsuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCanal`),
  KEY `imgUsuario_idx` (`imgUsuario`),
  CONSTRAINT `imgUsuario` FOREIGN KEY (`imgUsuario`) REFERENCES `imagenes` (`idImagen`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canales`
--

LOCK TABLES `canales` WRITE;
/*!40000 ALTER TABLE `canales` DISABLE KEYS */;
INSERT INTO `canales` VALUES (3,'Pues esta canal como se puede ver es muy bonito y en el vamos a hablar de muchas cosas y muy variadas como por ejemplo: cómo funciona la web.','Este es el canal del creador de la web',1),(4,'Este es el canal del señor delegado de la clase que no se sabe aún si me querrá ayudar con la presentación del proyecto o no, ya veremos ese día qué ocurre','Canal del señor delegado de la clase',2),(5,'','',3),(6,'Otro posible candidato para ayudarme con la presentación pero quién sabe qué ocurrirá.','Canal de Adri o Adrian2.0 según se mire',4);
/*!40000 ALTER TABLE `canales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `idCategoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(15) NOT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Tutoriales'),(2,'Política'),(3,'Ciencia'),(4,'Tecnología'),(5,'Programación');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `directos`
--

DROP TABLE IF EXISTS `directos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directos` (
  `idDirecto` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  PRIMARY KEY (`idDirecto`),
  KEY `usuarioDirecto_idx` (`idUsuario`),
  KEY `categoriaDirecto_idx` (`idCategoria`),
  CONSTRAINT `categoriaDirecto` FOREIGN KEY (`idCategoria`) REFERENCES `categorias` (`idCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `usuarioDirecto` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `directos`
--

LOCK TABLES `directos` WRITE;
/*!40000 ALTER TABLE `directos` DISABLE KEYS */;
/*!40000 ALTER TABLE `directos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagenes`
--

DROP TABLE IF EXISTS `imagenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagenes` (
  `idImagen` int(11) NOT NULL AUTO_INCREMENT,
  `imagen` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idImagen`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagenes`
--

LOCK TABLES `imagenes` WRITE;
/*!40000 ALTER TABLE `imagenes` DISABLE KEYS */;
INSERT INTO `imagenes` VALUES (1,'3Imagen.gif'),(2,'4Imagen.gif'),(3,'5Imagen.gif'),(4,'6Imagen.gif');
/*!40000 ALTER TABLE `imagenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suscripciones`
--

DROP TABLE IF EXISTS `suscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suscripciones` (
  `idSuscripcion` int(11) NOT NULL AUTO_INCREMENT,
  `suscriptor` int(11) NOT NULL,
  `usuarioSeguir` int(11) NOT NULL,
  PRIMARY KEY (`idSuscripcion`),
  KEY `seguido_idx` (`usuarioSeguir`),
  KEY `seguidor` (`suscriptor`),
  CONSTRAINT `seguido` FOREIGN KEY (`usuarioSeguir`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `seguidor` FOREIGN KEY (`suscriptor`) REFERENCES `usuarios` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suscripciones`
--

LOCK TABLES `suscripciones` WRITE;
/*!40000 ALTER TABLE `suscripciones` DISABLE KEYS */;
INSERT INTO `suscripciones` VALUES (2,3,6),(3,3,4);
/*!40000 ALTER TABLE `suscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(15) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(50) NOT NULL,
  `tipo` set('n','a','b') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','admin@admin.com','ISMvKXpXpadDiUoOSoAfww==','a'),(3,'Mario','mario@mario.com','3i8V0BTUC5NXjSVeYiH9YA==','n'),(4,'Adrian','adrian@adrian.com','jEIF7DPY9srqqqDBChQTjA==','n'),(5,'Victor','victor@victor.com','/8FQoWDTfpIBLBlravQWDQ==','b'),(6,'Adrian2','adrian2@adrian2.com','QZUp4qq6FBkdrHnaF3vsNA==','n');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-14 21:55:42
