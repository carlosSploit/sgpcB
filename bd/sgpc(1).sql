-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-03-2023 a las 09:52:39
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

DROP PROCEDURE IF EXISTS `comp_correo_login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `comp_correo_login` (IN `username` VARCHAR(100))   BEGIN

SELECT us.usaio, clan.photo, clan.correo
FROM usuarios us 
INNER JOIN clientanali clan ON clan.id_cliente = us.id_inform 
WHERE us.tip_user = 'C' 
AND us.usaio = username 
AND us.estade = 1
LIMIT 1;

END$$

DROP PROCEDURE IF EXISTS `comp_loginUserbd`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `comp_loginUserbd` (IN `usuario` VARCHAR(100), IN `passwor` VARCHAR(100))   BEGIN

SELECT us.id_usuario , us.tip_user, us.id_inform FROM usuarios us WHERE us.usaio = usuario AND us.pass = passwor ;

END$$

DROP PROCEDURE IF EXISTS `delete_activos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_activos` (IN `id_activo` INT)   BEGIN

UPDATE activos act SET act.estade = 0 WHERE act.id_activo = id_activo ;

END$$

DROP PROCEDURE IF EXISTS `delete_activproces`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_activproces` (IN `id_activproc` INT)   BEGIN

UPDATE activproces activpro SET activpro.estade = 0 WHERE activpro.id_activproc = id_activproc ;

END$$

DROP PROCEDURE IF EXISTS `delete_areasempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_areasempresa` (IN `id_areEmpre` INT)   BEGIN

UPDATE areasempresa ampre SET ampre.estade = 0 WHERE ampre.id_areempre = id_areEmpre ;

END$$

DROP PROCEDURE IF EXISTS `delete_depentactiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_depentactiv` (IN `id_depenActiv` INT)   BEGIN

UPDATE depentactiv depact SET depact.estade = 0 WHERE depact.id_depenActiv = id_depenActiv ;

END$$

DROP PROCEDURE IF EXISTS `delete_empresa_enlace`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_empresa_enlace` (IN `id_empresa` INT, IN `id_clienAnalit` INT)   BEGIN

UPDATE analisisempresa analiEmp SET analiEmp.estade = 0 WHERE analiEmp.id_empresa = id_empresa AND analiEmp.id_cliente = id_clienAnalit ;

END$$

DROP PROCEDURE IF EXISTS `delete_objempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_objempresa` (IN `id_objEmpresa` INT)   BEGIN

UPDATE objempresa objem SET objem.estade = 0 WHERE objem.id_objempresa = id_objEmpresa ;

END$$

DROP PROCEDURE IF EXISTS `delete_proceempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_proceempresa` (IN `id_proceso` INT)   BEGIN

UPDATE proceempresa proem SET proem.estade = 0 WHERE proem.id_proceso = id_proceso ;

END$$

DROP PROCEDURE IF EXISTS `delete_resposproce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_resposproce` (IN `id_resposProce` INT)   BEGIN

UPDATE resposproce respo SET respo.estade = 0 WHERE respo.id_resposProce = id_resposProce ;

END$$

DROP PROCEDURE IF EXISTS `delete_trabajempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_trabajempresa` (IN `id_trabajador` INT)   BEGIN

UPDATE trabajempresa tbrem SET tbrem.estade = 0 WHERE tbrem.Id_trabajador = id_trabajador ;

END$$

DROP PROCEDURE IF EXISTS `delete_versionanali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_versionanali` (IN `id_versionAnali` INT)   BEGIN

UPDATE versionanali veranl SET veranl.estade = 0 WHERE veranl.id_versionAnali = id_versionAnali ;

END$$

DROP PROCEDURE IF EXISTS `delet_areainterproce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delet_areainterproce` (IN `id_areaProce` INT)   BEGIN

UPDATE areainterproce arepro SET arepro.estade = 0 WHERE arepro.id_areaProce = id_areaProce ; 

END$$

DROP PROCEDURE IF EXISTS `insert_activo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_activo` (IN `nombre_Activo` VARCHAR(100), IN `descripc` VARCHAR(300), IN `id_empresa` INT, IN `id_tipoActiv` INT)   BEGIN

INSERT INTO `activos` (`id_empresa`, `nombre_Activo`, `descripc`, `id_tipoActiv`, `estade`) VALUES (id_empresa, nombre_Activo, descripc, id_tipoActiv, 1);

END$$

DROP PROCEDURE IF EXISTS `insert_activproces`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_activproces` (IN `id_proceso` INT, IN `id_activo` INT)   BEGIN

INSERT INTO `activproces`( `id_proceso`, `id_activo`, `fechaenlace`, `estade`) VALUES (id_proceso, id_activo, NOW(), 1);

END$$

DROP PROCEDURE IF EXISTS `insert_areainterproce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_areainterproce` (IN `id_areaEmpre` INT, IN `id_proceso` INT)   BEGIN

INSERT INTO `areainterproce`(`id_areaEmpre`, `id_proceso`, `fechaEnlace`, `estade`) VALUES (id_areaEmpre, id_proceso, now(), 1);

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

DROP PROCEDURE IF EXISTS `insert_depentactiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_depentactiv` (IN `id_activProc` INT, IN `id_depActiv` INT)   BEGIN

INSERT INTO `depentactiv`(`id_activProc`, `id_depActiv`, `fechaDepent`, `estade`) VALUES (id_activProc, id_depActiv, now(), 1);

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

DROP PROCEDURE IF EXISTS `insert_proceempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_proceempresa` (IN `nombreProce` VARCHAR(100), IN `descripccion` VARCHAR(300), IN `id_gerarProc` INT, IN `id_tipProce` INT, IN `isDepProcPadre` INT, IN `id_DepentProc` INT, IN `id_empresa` INT)   BEGIN

DECLARE idproceses int(11);
DECLARE idescalaRPO int(11);
DECLARE idescalaRTO int(11);

INSERT INTO `proceempresa`(`nombreProce`, `descripccion`, `id_gerarProc`, `id_tipProce`, `isDepProcPadre`, `id_DepentProc`, `id_empresa`, `estade`) VALUES (nombreProce, descripccion, id_gerarProc, id_tipProce, isDepProcPadre, id_DepentProc, id_empresa, 1);

SET idproceses = (SELECT procem.id_proceso FROM proceempresa procem WHERE procem.estade = 1 ORDER BY procem.id_proceso DESC LIMIT 1);
SET idescalaRPO = (SELECT escrpo.id_escalaRPO FROM escalarpo escrpo WHERE escrpo.estade = 1 ORDER BY escrpo.id_escalaRPO DESC LIMIT 1);
SET idescalaRTO = (SELECT escrto.id_escalaRTO FROM escalarto escrto WHERE escrto.estade = 1 ORDER BY escrto.id_escalaRTO DESC LIMIT 1);

INSERT INTO `valorproces`(`id_proceso`, `id_escalaRTO`, `id_escalaRPO`, `valorMDT`, `estade`) VALUES (idproceses, idescalaRPO, idescalaRTO, 0, 1);

END$$

DROP PROCEDURE IF EXISTS `insert_resposproce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_resposproce` (IN `id_trabajador` INT, IN `id_proceso` INT)   BEGIN

INSERT INTO `resposproce`(`id_trabajador`, `id_proceso`, `estade`, `fechaEnlace`) VALUES (id_trabajador, id_proceso, 1, NOW());

END$$

DROP PROCEDURE IF EXISTS `insert_trabajempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_trabajempresa` (IN `nombre` VARCHAR(100), IN `cargo` VARCHAR(100), IN `descripc` VARCHAR(300), IN `telefono` VARCHAR(20), IN `correo` VARCHAR(100), IN `codTrabajo` VARCHAR(20), IN `id_empresa` INT)   BEGIN

INSERT INTO `trabajempresa`(`nombre_apellido`, `cargo`, `descripc`, `telefono`, `correo`, `codTrabajo`, `estade`, `id_empresa`) VALUES (nombre, cargo, descripc, telefono, correo, codTrabajo, 1, id_empresa);

END$$

DROP PROCEDURE IF EXISTS `insert_versionanali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_versionanali` (IN `id_proceso` INT)   BEGIN

DECLARE cantVersion int(11);
DECLARE id_version  int(11);

SET cantVersion = (SELECT COUNT(*) FROM versionanali veranl WHERE veranl.estade = 1 AND veranl.id_proceso = id_proceso) + 1 ;
INSERT INTO `versionanali`(`id_proceso`, `abreb`, `fechaVersionAnali`, `estade`) VALUES (id_proceso, CONCAT('V', cantVersion), now(), 1);

SET id_version = (SELECT veranl.id_versionAnali FROM versionanali veranl WHERE veranl.estade = 1 AND veranl.id_proceso = id_proceso ORDER BY veranl.id_versionAnali DESC LIMIT 1);
INSERT INTO `activprosveranali`(`id_versonAnali`, `id_activProc`, `estade`) SELECT id_version, act.id_activproc, 1 FROM activproces act WHERE act.id_proceso = id_proceso ;

END$$

DROP PROCEDURE IF EXISTS `list_activos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_activos` (IN `id_empresa` INT)   BEGIN

SELECT * FROM activos actv WHERE actv.id_empresa = id_empresa AND actv.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_activproces`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_activproces` (IN `id_proceso` INT)   BEGIN

SELECT actpro.id_activproc, actpro.id_activo, activ.nombre_Activo, activ.descripc, activ.id_tipoActiv, tpactiv.dependAbreb 
FROM activproces actpro 
INNER JOIN activos activ ON activ.id_activo = actpro.id_activo 
INNER JOIN tipoactivo tpactiv ON activ.id_tipoActiv = tpactiv.id_tipoActivo 
WHERE actpro.estade = 1 
AND actpro.id_proceso = id_proceso ;
 
END$$

DROP PROCEDURE IF EXISTS `list_areainterproce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_areainterproce` (IN `id_proceso` INT)   BEGIN

SELECT arepro.id_areaProce, arem.id_areempre, arem.nombrearea, arem.descriparea
FROM areainterproce arepro 
INNER JOIN areasempresa arem ON arem.id_areempre = arepro.id_areaEmpre
WHERE arepro.id_proceso = id_proceso 
AND arepro.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_areasempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_areasempresa` (IN `id_empresa` INT)   BEGIN

SELECT * FROM areasempresa arem WHERE arem.id_empresa = id_empresa AND arem.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_depentactiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_depentactiv` (IN `id_activproc` INT)   BEGIN

SELECT depativ.id_depenActiv, depativ.id_depActiv, act.nombre_Activo, act.descripc, act.id_tipoActiv, tipact.dependAbreb 
FROM depentactiv depativ 
INNER JOIN activos act ON act.id_activo = depativ.id_depActiv 
INNER JOIN tipoactivo tipact ON tipact.id_tipoActivo = act.id_tipoActiv 
WHERE depativ.id_activProc = id_activproc 
AND depativ.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_empresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_empresa` (IN `id_clientAnalitic` INT)   BEGIN

IF id_clientAnalitic = 0 THEN
SELECT em.id_empresa, em.nombreempresa, em.ruc, em.descripc, em.telefono, em.rubroEmpresa, em.mision, em.vision
FROM empresa em 
WHERE em.estade = 1;
ELSE
SELECT em.id_empresa, em.nombreempresa, em.ruc, em.descripc, em.telefono, em.rubroEmpresa, em.mision, em.vision
FROM empresa em 
INNER JOIN analisisempresa analempre ON analempre.id_empresa = em.id_empresa
WHERE analempre.id_cliente = id_clientAnalitic 
AND analempre.estade = 1
AND em.estade = 1;
END IF;

END$$

DROP PROCEDURE IF EXISTS `list_escalarpo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_escalarpo` ()   BEGIN

SELECT * FROM escalarpo escrpo WHERE escrpo.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_escalarto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_escalarto` ()   BEGIN

SELECT * FROM escalarto escrto WHERE escrto.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_gerarProce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_gerarProce` ()   BEGIN

SELECT * FROM gerarproce genpro WHERE genpro.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_objempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_objempresa` (IN `id_empresa` INT)   BEGIN

SELECT * FROM objempresa objem WHERE objem.id_empresa = id_empresa AND objem.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_proceempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_proceempresa` (IN `id_empresa` INT)   BEGIN

SELECT * FROM proceempresa proem WHERE proem.estade = 1 AND proem.id_empresa = id_empresa ;

END$$

DROP PROCEDURE IF EXISTS `list_resposproce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_resposproce` (IN `id_proceso` INT)   BEGIN

SELECT respro.id_resposProce, trabem.Id_trabajador, trabem.nombre_apellido, trabem.cargo, trabem.descripc 
FROM resposproce respro 
INNER JOIN trabajempresa trabem ON trabem.Id_trabajador = respro.id_trabajador 
WHERE respro.id_proceso = id_proceso 
AND respro.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_tipoActiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tipoActiv` (IN `codeAbre` INT(11))   BEGIN

IF codeAbre = 0 THEN
SELECT * FROM tipoactivo tipact WHERE tipact.estade = 1 ;
ELSE
SELECT * FROM tipoactivo tipact WHERE tipact.estade = 1 AND  tipact.id_dependeTipoPad = codeAbre;
END IF;

END$$

DROP PROCEDURE IF EXISTS `list_tipProce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tipProce` ()   BEGIN

SELECT * FROM tipproce tipro WHERE tipro.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_trabajempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_trabajempresa` (IN `id_empresa` INT)   BEGIN

SELECT * FROM trabajempresa trbem WHERE trbem.estade = 1 AND trbem.id_empresa = id_empresa ;

END$$

DROP PROCEDURE IF EXISTS `list_versionanali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_versionanali` (IN `id_proceso` INT)   BEGIN

SELECT veranl.id_versionAnali, veranl.abreb, veranl.fechaVersionAnali FROM versionanali veranl WHERE veranl.id_proceso = id_proceso AND veranl.estade = 1 ;

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

DROP PROCEDURE IF EXISTS `read_valorproces`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_valorproces` (IN `id_proceso` INT)   BEGIN

SELECT valpro.id_valorProc, valpro.id_escalaRTO, valpro.id_escalaRPO, valpro.valorMDT 
FROM valorproces valpro 
WHERE valpro.estade = 1 
AND valpro.id_proceso = id_proceso 
ORDER BY valpro.id_valorProc 
DESC LIMIT 1 ;

END$$

DROP PROCEDURE IF EXISTS `update_acivos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_acivos` (IN `nombre_Activo` VARCHAR(100), IN `descrip` VARCHAR(300), IN `id_tipoActiv` INT, IN `id_activo` INT)   BEGIN

UPDATE activos act SET  act.nombre_Activo = nombre_Activo , act.descripc = descrip , act.id_tipoActiv = id_tipoActiv WHERE act.id_activo = id_activo ;

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

DROP PROCEDURE IF EXISTS `update_objempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_objempresa` (IN `nombreObje` VARCHAR(300), IN `id_objEmpresa` INT)   BEGIN

UPDATE objempresa objem SET objem.nombreobj = nombreObje WHERE objem.id_objempresa = id_objEmpresa ;

END$$

DROP PROCEDURE IF EXISTS `update_proceempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_proceempresa` (IN `nombreProce` VARCHAR(100), IN `descripccion` VARCHAR(300), IN `id_gerarProc` INT, IN `id_tipProce` INT, IN `isDepProcPadre` INT, IN `id_DepentProc` INT, IN `id_proceso` INT)   BEGIN

UPDATE proceempresa proem SET proem.nombreProce = nombreProce , proem.descripccion = descripccion, proem.id_gerarProc = id_gerarProc , proem.id_tipProce = id_tipProce , proem.isDepProcPadre = isDepProcPadre, proem.id_DepentProc = id_DepentProc WHERE proem.id_proceso = id_proceso ;

END$$

DROP PROCEDURE IF EXISTS `update_trabajempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_trabajempresa` (IN `nombre` VARCHAR(100), IN `cargo` VARCHAR(100), IN `descripc` VARCHAR(300), IN `telefono` VARCHAR(20), IN `correo` VARCHAR(100), IN `codTrabajo` VARCHAR(20), IN `Id_trabajador` INT)   BEGIN

UPDATE trabajempresa tbrem SET tbrem.nombre_apellido = nombre, tbrem.cargo = cargo, tbrem.descripc= descripc, tbrem.telefono = telefono, tbrem.correo = correo, tbrem.codTrabajo = codTrabajo WHERE tbrem.Id_trabajador = Id_trabajador ;

END$$

DROP PROCEDURE IF EXISTS `update_valorproces`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_valorproces` (IN `id_escalaRTO` INT, IN `id_escalaRPO` INT, IN `valorMDT` INT, IN `id_valorProc` INT)   BEGIN

UPDATE valorproces valproc SET valproc.id_escalaRTO = id_escalaRTO, valproc.id_escalaRPO = id_escalaRPO, valproc.valorMDT = valorMDT 
WHERE valproc.id_valorProc = id_valorProc ;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activos`
--

DROP TABLE IF EXISTS `activos`;
CREATE TABLE `activos` (
  `id_activo` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `nombre_Activo` varchar(100) NOT NULL,
  `descripc` varchar(300) NOT NULL,
  `id_tipoActiv` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `activos`
--

INSERT INTO `activos` VALUES
(1, 1, 'Sistema E-learning', 'Sistema donde se realiza todos los procesos de enseñansa, control, monitoreo, registro de cursos.', 1, 1),
(2, 1, 'PC', 'Computador que usan los trabajadores para procesos externos o para tener acceso al Sistema E-learning.', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activproces`
--

DROP TABLE IF EXISTS `activproces`;
CREATE TABLE `activproces` (
  `id_activproc` int(11) NOT NULL,
  `id_proceso` int(11) NOT NULL,
  `id_activo` int(11) NOT NULL,
  `fechaenlace` datetime NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `activproces`
--

INSERT INTO `activproces` VALUES
(4, 1, 1, '2023-03-06 20:51:05', 1),
(6, 1, 2, '2023-03-06 20:58:57', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `activprosveranali`
--

DROP TABLE IF EXISTS `activprosveranali`;
CREATE TABLE `activprosveranali` (
  `id_activProsVerAnali` int(11) NOT NULL,
  `id_versonAnali` int(11) NOT NULL,
  `id_activProc` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `activprosveranali`
--

INSERT INTO `activprosveranali` VALUES
(1, 4, 4, 1),
(2, 4, 6, 1);

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
(1, 2, 1, '2023-03-05 00:41:54', 1),
(2, 1, 1, '2023-03-05 02:35:49', 1),
(3, 2, 2, '2023-03-08 23:24:42', 1),
(4, 2, 0, '2023-03-09 03:36:45', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areainterproce`
--

DROP TABLE IF EXISTS `areainterproce`;
CREATE TABLE `areainterproce` (
  `id_areaProce` int(11) NOT NULL,
  `id_areaEmpre` int(11) NOT NULL,
  `id_proceso` int(11) NOT NULL,
  `fechaEnlace` datetime NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `areainterproce`
--

INSERT INTO `areainterproce` VALUES
(10, 1, 1, '2023-03-06 04:10:52', 1);

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
(2, 'Area de Recursos Humanos', 'Encargado de velar solo por mi.', 1, 1);

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
(2, 'Pedro Juan Miguel', 'Guevara Castillo', '989796307', 'pedrna15@gmail.com', 'http://res.cloudinary.com/canvarith/image/upload/v1678264605/Images/trybgwcbxlzcebveswf7.jpg'),
(3, 'Estefany Guerrero ', 'Gerrero', '969280255', 'canvaritech@gmail.com', 'https://nyrevconnect.com/wp-content/uploads/2017/06/Placeholder_staff_photo-e1505825573317.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `depentactiv`
--

DROP TABLE IF EXISTS `depentactiv`;
CREATE TABLE `depentactiv` (
  `id_depenActiv` int(11) NOT NULL,
  `id_activProc` int(11) NOT NULL,
  `id_depActiv` int(11) NOT NULL,
  `fechaDepent` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `depentactiv`
--

INSERT INTO `depentactiv` VALUES
(1, 2, 1, 2147483647, 1),
(2, 1, 2, 2147483647, 0);

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
(1, 'Canvaritech', '74546546587', 'Empresa de entretenimiento y apremdisaje para niños.', '985796307', 'Entretenimiento y  Cursos en linea', 'Somos la mejor empresa que aya existido', 'Ser unas de las empresas mas prestigiosas sobre el entretenimiento y aprendisaje en el año 2023.', 1),
(2, 'Lo Nuestro productos del perreo', '9867827827', 'Esta enpresa es la mera verga', '985796307', 'Sector Publico', 'sjadklasjkldjaskldjaskljkldas', 'kasldkas;ldkasl;kdasl;kd', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escalarpo`
--

DROP TABLE IF EXISTS `escalarpo`;
CREATE TABLE `escalarpo` (
  `id_escalaRPO` int(11) NOT NULL,
  `criterioValor` varchar(100) NOT NULL,
  `descripcCriter` varchar(300) NOT NULL,
  `valorCrite` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `escalarpo`
--

INSERT INTO `escalarpo` VALUES
(1, 'Muy Tolerable', 'Se puede Tolerar mas tiempo la perdida.', 1, 1),
(2, 'Tolerable', 'Tolera pedida de datos por 72 horas.', 2, 1),
(3, 'Medianamente Tolerable', 'Tolera pedida de datos por 24 horas.', 3, 1),
(4, 'Intolerable', 'Tolera pedida de datos por 8 horas.', 4, 1),
(5, 'Muy Intelerable', 'Requiere disponer del 100% de los datos.', 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escalarto`
--

DROP TABLE IF EXISTS `escalarto`;
CREATE TABLE `escalarto` (
  `id_escalaRTO` int(11) NOT NULL,
  `criterioValor` varchar(100) NOT NULL,
  `descripcCriter` varchar(200) NOT NULL,
  `valorCrite` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `escalarto`
--

INSERT INTO `escalarto` VALUES
(1, 'Muy Baja Timpo DIsp.', 'Requiere Alta disponibilidad (100%)', 1, 1),
(2, 'Bajo Timpo DIsp.', 'No puede estar interrumpida mas de 8 horas', 2, 1),
(3, 'Media Timpo DIsp.', 'No puede estar interrumpida mas de 24 horas', 3, 1),
(4, 'Alta Timpo DIsp.', 'No puede estar interrumpida mas de 72 horas', 4, 1),
(5, 'Muy Alta Timpo DIsp.', 'Se puede intterumpir mas tiempo', 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gerarproce`
--

DROP TABLE IF EXISTS `gerarproce`;
CREATE TABLE `gerarproce` (
  `id_gerarProc` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `gerarproce`
--

INSERT INTO `gerarproce` VALUES
(1, 'Macroproceso', 1),
(2, 'Proceso', 1),
(3, 'SubProceso', 1);

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
(8, '8fce5e9d-713a-432e-82c4-71c21da174ed', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-04 20:58:19', 2),
(9, '4cf736b4-c51d-48d6-80af-b3a276d37a50', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 09:45:14', 1),
(10, 'bfca9d27-a221-4597-aa15-a8848ece31fc', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:47:58', 1),
(11, 'fb5d992f-7b9d-4d10-a33d-f019793a888d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:48:17', 1),
(12, '6ac97146-1aa8-49a1-b675-cbece46ed6a6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:48:18', 1),
(13, '1ca106ed-c885-4c1c-aeb9-dec43f4a1569', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:48:20', 1),
(14, '438fc00e-4fc8-42af-b313-e519048dd696', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:48:47', 1),
(15, '1cbe02eb-2e68-4511-83ce-cf6b920e4161', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:52:34', 1),
(16, 'b3e88786-b874-490f-89c6-34858f418b77', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:52:59', 1),
(17, 'd44a887d-8b15-4f44-883d-10ffe6a136ec', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:55:14', 1),
(18, 'e429839f-3624-4999-a78a-338635f78c4e', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:55:55', 1),
(19, 'be9c6903-5fb2-42c4-b6f4-591aa7de0af4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:56:30', 1),
(20, '4e10f169-5864-4e83-9884-ec77de74ea3e', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:58:49', 1),
(21, '4b96a27d-7216-4205-aed8-18e9fb70d1ad', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:59:18', 1),
(22, '3c9b059a-2077-4390-beb3-26764c87fdca', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 10:59:48', 1),
(23, 'bc8b1e51-63a0-4a48-a9d6-6c898ae00d83', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 11:00:10', 1),
(24, '13cd9b41-95d6-4db0-8c4b-8889aa0be296', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 11:01:14', 1),
(25, '2a0b527c-2d75-438f-bf2a-f96e5793313d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 14:31:52', 3),
(26, '009da7d7-8902-4eac-91d2-532956689f10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 15:23:16', 3),
(27, '2d9e6c37-ef1e-4d2a-b54d-3226ff23011c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWF', '2023-03-07 23:54:20', 2);

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

--
-- Volcado de datos para la tabla `objempresa`
--

INSERT INTO `objempresa` VALUES
(1, 1, 'Ser una de las empresas del mundo', 1),
(2, 1, 'Tener la maxima cantidad de ventas', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proceempresa`
--

DROP TABLE IF EXISTS `proceempresa`;
CREATE TABLE `proceempresa` (
  `id_proceso` int(11) NOT NULL,
  `nombreProce` varchar(100) NOT NULL,
  `descripccion` varchar(300) NOT NULL,
  `id_gerarProc` int(11) NOT NULL,
  `id_tipProce` int(11) NOT NULL,
  `isDepProcPadre` int(11) NOT NULL,
  `id_DepentProc` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proceempresa`
--

INSERT INTO `proceempresa` VALUES
(1, 'Proceso de dictado de cursos.', 'Proceso donde un procesor dicta el cursos en un sistema E-learning a un alumnos.', 2, 1, 0, 0, 1, 0),
(2, 'Proceso de dictado de cursos.', 'Proceso donde un procesor dicta el cursos en un sistema E-learning a un alumnos.', 3, 2, 1, 1, 1, 0),
(3, 'Proceso de Ingreso de cursos.', 'Proceso donde se sube un curso en el sistema E-learning  para posteriormente usarlo en el dictado de cursos..', 2, 1, 0, 0, 1, 0),
(4, 'Proceso de Ingreso de cursos.', 'Proceso donde se sube un curso en el sistema E-learning  para posteriormente usarlo en el dictado de cursos..', 2, 1, 0, 0, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resposproce`
--

DROP TABLE IF EXISTS `resposproce`;
CREATE TABLE `resposproce` (
  `id_resposProce` int(11) NOT NULL,
  `id_trabajador` int(11) NOT NULL,
  `id_proceso` int(11) NOT NULL,
  `estade` int(11) NOT NULL,
  `fechaEnlace` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `resposproce`
--

INSERT INTO `resposproce` VALUES
(1, 2, 1, 1, '2023-03-06 03:02:39'),
(2, 3, 1, 0, '2023-03-06 03:02:55'),
(3, 3, 1, 1, '2023-03-06 04:17:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoactivo`
--

DROP TABLE IF EXISTS `tipoactivo`;
CREATE TABLE `tipoactivo` (
  `id_tipoActivo` int(11) NOT NULL,
  `nombreTipoActivo` varchar(300) NOT NULL,
  `abrebiat` varchar(150) NOT NULL,
  `dependAbreb` varchar(150) NOT NULL,
  `isDependeTipoPad` int(11) NOT NULL,
  `id_dependeTipoPad` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipoactivo`
--

INSERT INTO `tipoactivo` VALUES
(1, 'Activos esenciales', 'essential', 'essential', 0, 0, 1),
(2, 'Informaci�n', 'info', 'essential.info', 1, 1, 1),
(3, 'informacion empresa', 'biz', 'essential.info.biz', 1, 2, 1),
(4, 'informacion comercial', 'com', 'essential.info.com', 1, 2, 1),
(5, 'Datos de inter�s para la administraci�n p�blica', 'adm', 'essential.info.adm', 1, 2, 1),
(6, 'Datos vitales (registros de la organizaci�n)', 'vr', 'essential.info.vr', 1, 2, 1),
(7, 'datos de car�cter personal', 'per', 'essential.info.per', 1, 2, 1),
(8, 'datos de persona normal', 'normal', 'essential.info.per.normal', 1, 7, 1),
(9, '[identification data (name and surname, id, postal address, email address, telephone, ...)', '1', 'essential.info.per.normal.1', 1, 8, 1),
(10, 'personal characteristics (civil status, date and place of birth, age, sex, nationality, ...)', '2', 'essential.info.per.normal.2', 1, 8, 1),
(11, 'academic data', '3', 'essential.info.per.normal.3', 1, 8, 1),
(12, 'professional data', '4', 'essential.info.per.normal.4', 1, 8, 1),
(13, 'bank data', '5', 'essential.info.per.normal.5', 1, 8, 1),
(14, 'regular personal data', 'regular', 'essential.info.per.regular', 1, 7, 1),
(15, 'economic', '1', 'essential.info.per.regular.1', 1, 14, 1),
(16, 'cultural identity', '2', 'essential.info.per.regular.2', 1, 14, 1),
(17, 'social idemtity', '3', 'essential.info.per.regular.3', 1, 14, 1),
(18, 'online identity', '4', 'essential.info.per.regular.4', 1, 14, 1),
(19, 'location', '5', 'essential.info.per.regular.5', 1, 14, 1),
(20, 'pseudonymous data (art. 4, 6, 25, 32, 40, 89)', 'pseudonymous', 'essential.info.per.pseudonymous', 1, 7, 1),
(21, 'sensitive personal data (art. 9)', 'sensitive', 'essential.info.per.sensitive', 1, 7, 1),
(22, 'racial', '1', 'essential.info.per.sensitive.1', 1, 21, 1),
(23, 'ethnic origin', '2', 'essential.info.per.sensitive.2', 1, 21, 1),
(24, 'political opinions', '3', 'essential.info.per.sensitive.3', 1, 21, 1),
(25, 'religions beliefs', '4', 'essential.info.per.sensitive.4', 1, 21, 1),
(26, 'philosophical beliefs', '5', 'essential.info.per.sensitive.5', 1, 21, 1),
(27, 'trade-union membership', '6', 'essential.info.per.sensitive.6', 1, 21, 1),
(28, 'health', '7', 'essential.info.per.sensitive.7', 1, 21, 1),
(29, 'physical', '1', 'essential.info.per.sensitive.7.1', 1, 28, 1),
(30, 'physiological', '2', 'essential.info.per.sensitive.7.2', 1, 28, 1),
(31, 'mental', '3', 'essential.info.per.sensitive.7.3', 1, 28, 1),
(32, 'health care services', '4', 'essential.info.per.sensitive.7.4', 1, 28, 1),
(33, 'health status', '5', 'essential.info.per.sensitive.7.5', 1, 28, 1),
(34, 'sex life', '8', 'essential.info.per.sensitive.8', 1, 21, 1),
(35, 'sexual orientation', '9', 'essential.info.per.sensitive.9', 1, 21, 1),
(36, 'genetic data', '10', 'essential.info.per.sensitive.10', 1, 21, 1),
(37, 'biometric data', '11', 'essential.info.per.sensitive.11', 1, 21, 1),
(38, 'children', 'children', 'essential.info.per.children', 1, 7, 1),
(39, 'criminal law (art. 10)', 'criminal', 'essential.info.per.criminal', 1, 7, 1),
(40, 'criminal offences', '1', 'essential.info.per.criminal.1', 1, 39, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipproce`
--

DROP TABLE IF EXISTS `tipproce`;
CREATE TABLE `tipproce` (
  `id_tipProce` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipproce`
--

INSERT INTO `tipproce` VALUES
(1, 'Procesos primarios', 1),
(2, 'Procesos de apoyo', 1),
(3, 'Procesos de gestion', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajempresa`
--

DROP TABLE IF EXISTS `trabajempresa`;
CREATE TABLE `trabajempresa` (
  `Id_trabajador` int(11) NOT NULL,
  `nombre_apellido` varchar(100) NOT NULL,
  `cargo` varchar(100) NOT NULL,
  `descripc` varchar(300) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `codTrabajo` varchar(100) NOT NULL,
  `estade` int(11) NOT NULL,
  `id_empresa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `trabajempresa`
--

INSERT INTO `trabajempresa` VALUES
(2, 'Carlos Arturo Guerrero Castillo', 'Gerente General', 'Encargado de la parte tecnica de la empreasa', '985796307', 'arturo14212000@gmail.com', 'cod-23674382647', 1, 1),
(3, 'Luis enrique morocho', 'Jefa de recursos humanos', 'Encargado de monitorias a los trabajadores', '985796307', 'LuismorochoFebres@gmail.com', 'cod-23674382647', 1, 1),
(4, 'Luis enrique morocho', 'Jefa de recursos humanos', 'Encargado de monitorias a los trabajadores', '985796307', 'LuismorochoFebres@gmail.com', 'cod-23674382647', 0, 1);

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
(2, '@pedrna15', 'perrito59', 2, 'C', 1),
(3, '@canvaritech', '123456', 3, 'C', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valorproces`
--

DROP TABLE IF EXISTS `valorproces`;
CREATE TABLE `valorproces` (
  `id_valorProc` int(11) NOT NULL,
  `id_proceso` int(11) NOT NULL,
  `id_escalaRTO` int(11) NOT NULL,
  `id_escalaRPO` int(11) NOT NULL,
  `valorMDT` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `valorproces`
--

INSERT INTO `valorproces` VALUES
(1, 4, 2, 2, 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `versionanali`
--

DROP TABLE IF EXISTS `versionanali`;
CREATE TABLE `versionanali` (
  `id_versionAnali` int(11) NOT NULL,
  `id_proceso` int(11) NOT NULL,
  `abreb` varchar(40) NOT NULL,
  `fechaVersionAnali` datetime NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `versionanali`
--

INSERT INTO `versionanali` VALUES
(1, 1, '0', '2023-03-07 02:35:51', 1),
(2, 1, 'V2', '2023-03-07 02:37:23', 1),
(3, 1, 'V3', '2023-03-07 02:48:07', 0),
(4, 1, 'V3', '2023-03-07 03:08:57', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `activos`
--
ALTER TABLE `activos`
  ADD PRIMARY KEY (`id_activo`),
  ADD KEY `id_empresa` (`id_empresa`),
  ADD KEY `id_tipoActiv` (`id_tipoActiv`);

--
-- Indices de la tabla `activproces`
--
ALTER TABLE `activproces`
  ADD PRIMARY KEY (`id_activproc`),
  ADD KEY `id_activo` (`id_activo`),
  ADD KEY `id_proceso` (`id_proceso`);

--
-- Indices de la tabla `activprosveranali`
--
ALTER TABLE `activprosveranali`
  ADD PRIMARY KEY (`id_activProsVerAnali`),
  ADD KEY `id_activProc` (`id_activProc`),
  ADD KEY `id_versonAnali` (`id_versonAnali`);

--
-- Indices de la tabla `analisisempresa`
--
ALTER TABLE `analisisempresa`
  ADD PRIMARY KEY (`id_analisempresa`);

--
-- Indices de la tabla `areainterproce`
--
ALTER TABLE `areainterproce`
  ADD PRIMARY KEY (`id_areaProce`);

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
-- Indices de la tabla `depentactiv`
--
ALTER TABLE `depentactiv`
  ADD PRIMARY KEY (`id_depenActiv`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id_empresa`);

--
-- Indices de la tabla `escalarpo`
--
ALTER TABLE `escalarpo`
  ADD PRIMARY KEY (`id_escalaRPO`);

--
-- Indices de la tabla `escalarto`
--
ALTER TABLE `escalarto`
  ADD PRIMARY KEY (`id_escalaRTO`);

--
-- Indices de la tabla `gerarproce`
--
ALTER TABLE `gerarproce`
  ADD PRIMARY KEY (`id_gerarProc`);

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
-- Indices de la tabla `proceempresa`
--
ALTER TABLE `proceempresa`
  ADD PRIMARY KEY (`id_proceso`),
  ADD KEY `id_gerarProc` (`id_gerarProc`),
  ADD KEY `id_tipProce` (`id_tipProce`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `resposproce`
--
ALTER TABLE `resposproce`
  ADD PRIMARY KEY (`id_resposProce`);

--
-- Indices de la tabla `tipoactivo`
--
ALTER TABLE `tipoactivo`
  ADD PRIMARY KEY (`id_tipoActivo`);

--
-- Indices de la tabla `tipproce`
--
ALTER TABLE `tipproce`
  ADD PRIMARY KEY (`id_tipProce`);

--
-- Indices de la tabla `trabajempresa`
--
ALTER TABLE `trabajempresa`
  ADD PRIMARY KEY (`Id_trabajador`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `valorproces`
--
ALTER TABLE `valorproces`
  ADD PRIMARY KEY (`id_valorProc`),
  ADD KEY `id_proceso` (`id_proceso`),
  ADD KEY `id_escalaRTO` (`id_escalaRTO`),
  ADD KEY `id_escalaRPO` (`id_escalaRPO`);

--
-- Indices de la tabla `versionanali`
--
ALTER TABLE `versionanali`
  ADD PRIMARY KEY (`id_versionAnali`),
  ADD KEY `id_proceso` (`id_proceso`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `activos`
--
ALTER TABLE `activos`
  MODIFY `id_activo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `activproces`
--
ALTER TABLE `activproces`
  MODIFY `id_activproc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `activprosveranali`
--
ALTER TABLE `activprosveranali`
  MODIFY `id_activProsVerAnali` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `analisisempresa`
--
ALTER TABLE `analisisempresa`
  MODIFY `id_analisempresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `areainterproce`
--
ALTER TABLE `areainterproce`
  MODIFY `id_areaProce` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `areasempresa`
--
ALTER TABLE `areasempresa`
  MODIFY `id_areempre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `clientanali`
--
ALTER TABLE `clientanali`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `depentactiv`
--
ALTER TABLE `depentactiv`
  MODIFY `id_depenActiv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `escalarpo`
--
ALTER TABLE `escalarpo`
  MODIFY `id_escalaRPO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `escalarto`
--
ALTER TABLE `escalarto`
  MODIFY `id_escalaRTO` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `gerarproce`
--
ALTER TABLE `gerarproce`
  MODIFY `id_gerarProc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `loginuser`
--
ALTER TABLE `loginuser`
  MODIFY `id_loginUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `objempresa`
--
ALTER TABLE `objempresa`
  MODIFY `id_objempresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `proceempresa`
--
ALTER TABLE `proceempresa`
  MODIFY `id_proceso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `resposproce`
--
ALTER TABLE `resposproce`
  MODIFY `id_resposProce` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipoactivo`
--
ALTER TABLE `tipoactivo`
  MODIFY `id_tipoActivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `tipproce`
--
ALTER TABLE `tipproce`
  MODIFY `id_tipProce` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `trabajempresa`
--
ALTER TABLE `trabajempresa`
  MODIFY `Id_trabajador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `valorproces`
--
ALTER TABLE `valorproces`
  MODIFY `id_valorProc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `versionanali`
--
ALTER TABLE `versionanali`
  MODIFY `id_versionAnali` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `activos`
--
ALTER TABLE `activos`
  ADD CONSTRAINT `activos_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`),
  ADD CONSTRAINT `activos_ibfk_2` FOREIGN KEY (`id_tipoActiv`) REFERENCES `tipoactivo` (`id_tipoActivo`);

--
-- Filtros para la tabla `activproces`
--
ALTER TABLE `activproces`
  ADD CONSTRAINT `activproces_ibfk_1` FOREIGN KEY (`id_activo`) REFERENCES `activos` (`id_activo`),
  ADD CONSTRAINT `activproces_ibfk_2` FOREIGN KEY (`id_proceso`) REFERENCES `proceempresa` (`id_proceso`);

--
-- Filtros para la tabla `activprosveranali`
--
ALTER TABLE `activprosveranali`
  ADD CONSTRAINT `activprosveranali_ibfk_1` FOREIGN KEY (`id_activProc`) REFERENCES `activproces` (`id_activproc`),
  ADD CONSTRAINT `activprosveranali_ibfk_2` FOREIGN KEY (`id_versonAnali`) REFERENCES `versionanali` (`id_versionAnali`);

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

--
-- Filtros para la tabla `proceempresa`
--
ALTER TABLE `proceempresa`
  ADD CONSTRAINT `proceempresa_ibfk_1` FOREIGN KEY (`id_gerarProc`) REFERENCES `gerarproce` (`id_gerarProc`),
  ADD CONSTRAINT `proceempresa_ibfk_2` FOREIGN KEY (`id_tipProce`) REFERENCES `tipproce` (`id_tipProce`),
  ADD CONSTRAINT `proceempresa_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`);

--
-- Filtros para la tabla `trabajempresa`
--
ALTER TABLE `trabajempresa`
  ADD CONSTRAINT `trabajempresa_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`);

--
-- Filtros para la tabla `valorproces`
--
ALTER TABLE `valorproces`
  ADD CONSTRAINT `valorproces_ibfk_1` FOREIGN KEY (`id_proceso`) REFERENCES `proceempresa` (`id_proceso`),
  ADD CONSTRAINT `valorproces_ibfk_2` FOREIGN KEY (`id_escalaRTO`) REFERENCES `escalarto` (`id_escalaRTO`),
  ADD CONSTRAINT `valorproces_ibfk_3` FOREIGN KEY (`id_escalaRPO`) REFERENCES `escalarpo` (`id_escalaRPO`);

--
-- Filtros para la tabla `versionanali`
--
ALTER TABLE `versionanali`
  ADD CONSTRAINT `versionanali_ibfk_1` FOREIGN KEY (`id_proceso`) REFERENCES `proceempresa` (`id_proceso`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
