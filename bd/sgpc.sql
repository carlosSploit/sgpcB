-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-03-2023 a las 23:31:05
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sgpc`
--
CREATE DATABASE IF NOT EXISTS `sgpc` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sgpc`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `comp_correo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `comp_correo` (IN `correo` VARCHAR(100))   BEGIN

SELECT COUNT(*) as userEnlance FROM usuarios us INNER JOIN clientanali clan ON clan.id_cliente = us.id_inform WHERE us.tip_user = 'C' AND clan.correo = correo ;

END$$

DROP PROCEDURE IF EXISTS `comp_loginUserbd`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `comp_loginUserbd` (IN `usuario` VARCHAR(100), IN `passwor` VARCHAR(100))   BEGIN

SELECT us.id_usuario , us.tip_user, us.id_inform FROM usuarios us WHERE us.usaio = usuario AND us.pass = passwor ;

END$$

DROP PROCEDURE IF EXISTS `delete_areasempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_areasempresa` (IN `id_areEmpre` INT)   BEGIN

UPDATE areasempresa ampre SET ampre.estade = 0 WHERE ampre.id_areempre = id_areEmpre ;

END$$

DROP PROCEDURE IF EXISTS `delete_empresa_enlace`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_empresa_enlace` (IN `id_empresa` INT, IN `id_clienAnalit` INT)   BEGIN

UPDATE analisisempresa analiEmp SET analiEmp.estade = 0 WHERE analiEmp.id_empresa = id_empresa AND analiEmp.id_cliente = id_clienAnalit ;

END$$

DROP PROCEDURE IF EXISTS `insert_areasempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_areasempresa` (IN `nombrearea` VARCHAR(100), IN `descriparea` VARCHAR(300), IN `id_empresa` INT)   BEGIN

INSERT INTO `areasempresa`(`nombrearea`, `descriparea`, `id_empresa`, `estade`) VALUES (nombrearea, descriparea, id_empresa, 1);

END$$

DROP PROCEDURE IF EXISTS `insert_clientAnali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_clientAnali` (IN `nombre` VARCHAR(100), IN `apellidos` VARCHAR(100), IN `telefono` VARCHAR(20), IN `correo` VARCHAR(100), IN `pass` VARCHAR(50), IN `nombre_usuario` VARCHAR(100), IN `photo` VARCHAR(1000))   BEGIN

DECLARE id_clienteAn int(11);
INSERT INTO `clientanali`(`nombre`, `apellidos`, `telefono`, `correo`, `photo`) VALUES (nombre, apellidos, telefono, correo, photo);
SET id_clienteAn = (SELECT clan.id_cliente FROM clientanali clan WHERE 1 ORDER BY clan.id_cliente DESC LIMIT 1);
INSERT INTO `usuarios`(`usaio`, `pass`, `id_inform`, `tip_user`, `estade`) VALUES (nombre_usuario, pass, id_clienteAn, 'C', 1);

END$$

DROP PROCEDURE IF EXISTS `insert_empresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_empresa` (IN `id_clienAnalit` INT, IN `nombreempresa` VARCHAR(100), IN `ruc` VARCHAR(11), IN `descripc` VARCHAR(200), IN `telefono` VARCHAR(20), IN `rubroempresa` VARCHAR(100), IN `misio` VARCHAR(300), IN `vision` VARCHAR(300))   BEGIN

DECLARE id_empresa int(11);
INSERT INTO `empresa`(`nombreempresa`, `ruc`, `descripc`, `telefono`, `rubroEmpresa`, `mision`, `vision`, `estade`) VALUES (nombreempresa, ruc, descripc, telefono, rubroempresa, misio, vision, 1);
SET id_empresa = (SELECT em.id_empresa FROM empresa em WHERE em.estade = 1 ORDER BY em.id_empresa DESC LIMIT 1);
INSERT INTO `analisisempresa`(`id_cliente`, `id_empresa`, `fechaenlace`, `estade`) VALUES (id_clienAnalit, id_empresa, now(), 1);

END$$

DROP PROCEDURE IF EXISTS `insert_empresa_enlace`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_empresa_enlace` (IN `id_empresa` INT, IN `id_clienAnalit` INT)   BEGIN

DECLARE camtiEnla int(11);
SET camtiEnla = (SELECT COUNT(*) FROM analisisempresa anEmp WHERE anEmp.id_cliente = id_clienAnalit AND anEmp.id_empresa = id_empresa);

IF camtiEnla = 0 THEN
INSERT INTO `analisisempresa`(`id_cliente`, `id_empresa`, `fechaenlace`, `estade`) VALUES (id_clienAnalit, id_empresa, now(), 1);
ELSE
UPDATE analisisempresa analiEmp SET analiEmp.estade = 1 WHERE analiEmp.id_empresa = id_empresa AND analiEmp.id_cliente = id_clienAnalit ;
END IF;

END$$

DROP PROCEDURE IF EXISTS `insert_loginInfoUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_loginInfoUser` (IN `idusuario` INT, IN `seccionkey` VARCHAR(200), IN `apikey` VARCHAR(200))   BEGIN

INSERT INTO `loginuser`(`seccion_key`, `apikey`, `fechaPeticion`, `id_usuario`) VALUES (seccionkey, apikey, now(), idusuario);

END$$

DROP PROCEDURE IF EXISTS `insert_objempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_objempresa` (IN `id_empresa` INT, IN `nombreObje` VARCHAR(300))   BEGIN

INSERT INTO `objempresa`(`id_empresa`, `nombreobj`, `estade`) VALUES (id_empresa, nombreObje, 1);

END$$

DROP PROCEDURE IF EXISTS `list_areasempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_areasempresa` (IN `id_empresa` INT)   BEGIN

SELECT * FROM areasempresa arem WHERE arem.id_empresa = id_empresa AND arem.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_empresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_empresa` (IN `id_clientAnalitic` INT)   BEGIN

SELECT em.id_empresa, em.nombreempresa, em.ruc, em.descripc, em.telefono, em.rubroEmpresa, em.mision, em.vision
FROM empresa em 
INNER JOIN analisisempresa analempre ON analempre.id_empresa = em.id_empresa
WHERE analempre.id_cliente = id_clientAnalitic 
AND analempre.estade = 1
AND em.estade = 0;

END$$

DROP PROCEDURE IF EXISTS `read_clientAnali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_clientAnali` (IN `id_cliente` INT)   BEGIN

SELECT  us.id_usuario, us.usaio, us.pass, us.tip_user, clan.id_cliente, clan.nombre, clan.apellidos, clan.telefono, clan.correo, clan.photo
FROM usuarios us 
INNER JOIN clientanali clan ON clan.id_cliente = us.id_inform
WHERE us.tip_user = 'C'
AND clan.id_cliente = id_cliente ;

END$$

DROP PROCEDURE IF EXISTS `read_loginApiKey`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_loginApiKey` (IN `seccion_key` VARCHAR(100))   BEGIN

SELECT 
lgus.apikey, lgus.seccion_key
FROM loginuser lgus
INNER JOIN usuarios us ON us.id_usuario = lgus.id_usuario
WHERE lgus.seccion_key = seccion_key ;

END$$

DROP PROCEDURE IF EXISTS `read_loginInfoUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_loginInfoUser` (IN `seccion_key` VARCHAR(100))   BEGIN

SELECT 
us.id_usuario, us.tip_user, us.id_inform, lgus.seccion_key
FROM loginuser lgus
INNER JOIN usuarios us ON us.id_usuario = lgus.id_usuario
WHERE lgus.seccion_key = seccion_key ;

END$$

DROP PROCEDURE IF EXISTS `update_areasempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_areasempresa` (IN `nombreArea` VARCHAR(100), IN `descripArea` VARCHAR(300), IN `id_areEmpre` INT)   BEGIN

UPDATE areasempresa ampre SET ampre.nombrearea = nombreArea , ampre.descriparea = descripArea WHERE ampre.id_areempre = id_areEmpre ;

END$$

DROP PROCEDURE IF EXISTS `update_clienAnalitInfoUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_clienAnalitInfoUser` (IN `correo` VARCHAR(100), IN `usser` VARCHAR(100), IN `pass` VARCHAR(100), IN `id_cliente` INT)   BEGIN

UPDATE usuarios us 
INNER JOIN clientanali clan ON clan.id_cliente = us.id_inform 
SET us.usaio = usser , us.pass = pass 
WHERE us.tip_user = 'C' 
AND clan.id_cliente = id_cliente ;

UPDATE clientanali clan 
SET clan.correo = correo 
WHERE clan.id_cliente = id_cliente ;

END$$

DROP PROCEDURE IF EXISTS `update_clientAnali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_clientAnali` (IN `nombre` VARCHAR(100), IN `apellidos` VARCHAR(100), IN `telefono` VARCHAR(20), IN `photo` VARCHAR(1000), IN `id_cliente` INT)   BEGIN

UPDATE clientanali clan SET `nombre`= nombre, `apellidos`= apellidos, `telefono`= telefono, `photo`= photo WHERE clan.id_cliente = id_cliente ;

END$$

DROP PROCEDURE IF EXISTS `update_empresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_empresa` (IN `id_empresa` INT, IN `nombreempresa` VARCHAR(100), IN `ruc` VARCHAR(11), IN `descripc` VARCHAR(200), IN `telefono` VARCHAR(20), IN `rubroempresa` VARCHAR(100), IN `misio` VARCHAR(300), IN `vision` VARCHAR(300))   BEGIN

UPDATE empresa em SET em.nombreempresa = nombreempresa , em.ruc = ruc , em.descripc = descripc , em.telefono = telefono , em.rubroEmpresa = rubroempresa , em.mision = misio, em.vision = vision WHERE em.id_empresa = id_empresa ;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `analisisempresa`
--

DROP TABLE IF EXISTS `analisisempresa`;
CREATE TABLE `analisisempresa` (
  `id_analisempresa` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `fechaenlace` datetime NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `analisisempresa`
--

INSERT INTO `analisisempresa` VALUES
(1, 2, 1, '2023-03-05 00:41:54', 0),
(2, 1, 1, '2023-03-05 02:35:49', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areasempresa`
--

DROP TABLE IF EXISTS `areasempresa`;
CREATE TABLE `areasempresa` (
  `id_areempre` int(11) NOT NULL,
  `nombrearea` varchar(100) NOT NULL,
  `descriparea` varchar(300) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `areasempresa`
--

INSERT INTO `areasempresa` VALUES
(1, 'Administracion', 'Encargado de verlar por todas las areas de la empresa.', 1, 1),
(2, 'Area de Recursos Humanos', 'Encargado de velar solo por mi.', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientanali`
--

DROP TABLE IF EXISTS `clientanali`;
CREATE TABLE `clientanali` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `photo` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientanali`
--

INSERT INTO `clientanali` VALUES
(1, 'Carlos Arturo', 'Guerrero Castillo', '969280255', 'arturo14212000@gmail.com', 'https://nyrevconnect.com/wp-content/uploads/2017/06/Placeholder_staff_photo-e1505825573317.png'),
(2, 'Pedro Rodrigues', 'Guevara Castillo', '985796307', 'pedrna155@gmail.com', 'https://nyrevconnect.com/wp-content/uploads/2017/06/Placeholder_staff_photo-e1505825573317.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

DROP TABLE IF EXISTS `empresa`;
CREATE TABLE `empresa` (
  `id_empresa` int(11) NOT NULL,
  `nombreempresa` varchar(100) NOT NULL,
  `ruc` varchar(11) NOT NULL,
  `descripc` varchar(300) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `rubroEmpresa` varchar(100) DEFAULT NULL,
  `mision` varchar(300) DEFAULT NULL,
  `vision` varchar(300) DEFAULT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` VALUES
(1, 'Lo nuestro Productos Rejionales', '74546546587', 'Empresa de entretenimiento y apremdisaje para niños.', '985796307', 'Entretenimiento y  Cursos en linea', 'Somos la mejor empresa que aya existido', 'Ser unas de las empresas mas prestigiosas sobre el entretenimiento y aprendisaje en el año 2023.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `loginuser`
--

DROP TABLE IF EXISTS `loginuser`;
CREATE TABLE `loginuser` (
  `id_loginUser` int(11) NOT NULL,
  `seccion_key` varchar(100) NOT NULL,
  `apikey` varchar(100) NOT NULL,
  `fechaPeticion` datetime NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `loginuser`
--

INSERT INTO `loginuser` VALUES
(1, '3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-04 20:09:24', 2),
(2, '160282', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-04 20:11:53', 2),
(3, '9372', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-04 20:12:27', 2),
(4, '7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-04 20:14:26', 2),
(5, '0', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-04 20:19:44', 2),
(6, '4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-04 20:24:16', 2),
(7, '0', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-04 20:54:39', 2),
(8, '8fce5e9d-713a-432e-82c4-71c21da174ed', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-04 20:58:19', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objempresa`
--

DROP TABLE IF EXISTS `objempresa`;
CREATE TABLE `objempresa` (
  `id_objempresa` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `nombreobj` varchar(100) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `usaio` varchar(100) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `id_inform` int(11) NOT NULL,
  `tip_user` varchar(3) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` VALUES
(1, '@arturo14212000', 'perritocom', 1, 'C', 1),
(2, '@pedrna155', 'perrito55', 2, 'C', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `analisisempresa`
--
ALTER TABLE `analisisempresa`
  ADD PRIMARY KEY (`id_analisempresa`);

--
-- Indices de la tabla `areasempresa`
--
ALTER TABLE `areasempresa`
  ADD PRIMARY KEY (`id_areempre`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `clientanali`
--
ALTER TABLE `clientanali`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id_empresa`);

--
-- Indices de la tabla `loginuser`
--
ALTER TABLE `loginuser`
  ADD PRIMARY KEY (`id_loginUser`);

--
-- Indices de la tabla `objempresa`
--
ALTER TABLE `objempresa`
  ADD PRIMARY KEY (`id_objempresa`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `analisisempresa`
--
ALTER TABLE `analisisempresa`
  MODIFY `id_analisempresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `areasempresa`
--
ALTER TABLE `areasempresa`
  MODIFY `id_areempre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `clientanali`
--
ALTER TABLE `clientanali`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `loginuser`
--
ALTER TABLE `loginuser`
  MODIFY `id_loginUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `objempresa`
--
ALTER TABLE `objempresa`
  MODIFY `id_objempresa` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `areasempresa`
--
ALTER TABLE `areasempresa`
  ADD CONSTRAINT `areasempresa_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`);

--
-- Filtros para la tabla `objempresa`
--
ALTER TABLE `objempresa`
  ADD CONSTRAINT `objempresa_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
