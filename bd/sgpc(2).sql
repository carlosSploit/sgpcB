-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-03-2023 a las 09:22:28
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

SELECT actv.id_activo, actv.nombre_Activo, actv.descripc, actv.id_tipoActiv, tipac.dependAbreb
FROM activos actv 
INNER JOIN tipoactivo tipac ON tipac.id_tipoActivo = actv.id_tipoActiv
WHERE actv.id_empresa = id_empresa 
AND actv.estade = 1 ;

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
INNER JOIN activproces actproc ON actproc.id_activproc = depativ.id_depActiv
INNER JOIN activos act ON act.id_activo = actproc.id_activo 
INNER JOIN tipoactivo tipact ON tipact.id_tipoActivo = act.id_tipoActiv 
WHERE depativ.id_activProc = id_activproc  
AND depativ.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_depentactivarbol`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_depentactivarbol` ()   BEGIN

SELECT 
depearb.id_dependActivArbol, 
depearb.id_tipoActivo, 
(SELECT tipac.dependAbreb FROM tipoactivo tipac WHERE tipac.estade = 1 AND tipac.id_tipoActivo = depearb.id_tipoActivo) as abreb, 
depearb.id_ActiviDepent, 
(SELECT tipac.dependAbreb FROM tipoactivo tipac WHERE tipac.estade = 1 AND tipac.id_tipoActivo = depearb.id_ActiviDepent) as depenabreb
FROM dependactivarbol depearb 
WHERE depearb.estade = 1;

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

SELECT proem.id_proceso, proem.nombreProce, proem.descripccion, proem.id_gerarProc, gerap.nombre, proem.id_tipProce, tiproc.nombre as nombreTip, proem.isDepProcPadre, proem.id_DepentProc 
FROM proceempresa proem 
INNER JOIN gerarproce gerap ON gerap.id_gerarProc = proem.id_gerarProc 
INNER JOIN tipproce tiproc ON tiproc.id_tipProce = proem.id_tipProce
WHERE proem.estade = 1 
AND proem.id_empresa = id_empresa ;

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
(1, 1, 'Sistema E-learning5', 'Sistema donde se realiza todos los procesos de enseñansa, control, monitoreo, registro de cursos.', 227, 1),
(2, 1, 'PC', 'Computador que usan los trabajadores para procesos externos o para tener acceso al Sistema E-learning.', 261, 1),
(3, 1, 'Administrador de los Cursos', 'Encardado de poder administrar el sistema E-learning y permitir el registro de cursos.', 383, 1),
(4, 1, 'Internet movistar', 'Servicio que permite al navegador y al sistema E-leaning', 316, 1),
(5, 1, 'Moden Movistar', 'Dispositivo que nos permite tener un punto de internet.', 285, 1),
(6, 1, 'Navegador web Chrome', 'Sistema que nos permite poder acceder al sistema E-learning y otros servicios web.', 229, 1),
(7, 1, 'Sistema Operativo Windows', 'Sistema que nos permite poder acceder a las aplicacions de la computadora o PC.', 241, 1);

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
(4, 2, 1, '2023-03-06 20:51:05', 0),
(6, 2, 2, '2023-03-06 20:58:57', 1),
(7, 2, 1, '2023-03-11 01:57:10', 1),
(8, 2, 3, '2023-03-11 21:57:02', 1),
(9, 2, 4, '2023-03-11 22:01:24', 1),
(10, 2, 5, '2023-03-11 22:01:34', 1),
(11, 2, 6, '2023-03-11 22:01:38', 1),
(12, 2, 7, '2023-03-11 22:01:42', 1);

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
(10, 1, 2, '2023-03-06 04:10:52', 1),
(11, 4, 2, '2023-03-10 23:28:16', 0),
(12, 2, 2, '2023-03-10 23:28:28', 1);

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
(1, 'Area de Administracion', 'Encargado de verlar por todas las areas de la empresa.', 1, 1),
(2, 'Area de Recursos Humanos', 'Encargado de velar solo por mi.', 1, 0),
(3, 'Area de Desarrollo', 'Es el encargado de desarrollar los sistemas de informacion.', 1, 0),
(4, 'Area de Contabilidad', 'Area encargada de realizar los libros contables dentro de la empresa.', 1, 1);

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
-- Estructura de tabla para la tabla `dependactivarbol`
--

DROP TABLE IF EXISTS `dependactivarbol`;
CREATE TABLE `dependactivarbol` (
  `id_dependActivArbol` int(11) NOT NULL,
  `id_tipoActivo` int(11) NOT NULL,
  `id_ActiviDepent` int(11) NOT NULL,
  `estade` int(11) NOT NULL,
  `fechaEnlace` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `dependactivarbol`
--

INSERT INTO `dependactivarbol` VALUES
(1, 146, 225, 1, '0000-00-00 00:00:00'),
(2, 146, 1, 1, '0000-00-00 00:00:00'),
(3, 1, 225, 1, '0000-00-00 00:00:00'),
(4, 225, 258, 1, '0000-00-00 00:00:00'),
(5, 360, 258, 1, '0000-00-00 00:00:00'),
(6, 305, 258, 1, '0000-00-00 00:00:00'),
(7, 344, 258, 1, '0000-00-00 00:00:00'),
(8, 373, 1, 1, '0000-00-00 00:00:00'),
(9, 69, 0, 1, '0000-00-00 00:00:00'),
(10, 110, 0, 1, '0000-00-00 00:00:00'),
(11, 129, 0, 1, '0000-00-00 00:00:00'),
(12, 323, 0, 1, '0000-00-00 00:00:00');

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
(2, 1, 2, 2147483647, 0),
(3, 11, 6, 2147483647, 0),
(4, 11, 6, 2147483647, 0),
(5, 11, 10, 2147483647, 0),
(6, 11, 6, 2147483647, 1),
(7, 11, 11, 2147483647, 0),
(8, 11, 10, 2147483647, 0),
(9, 11, 12, 2147483647, 0),
(10, 11, 10, 2147483647, 0),
(11, 12, 6, 2147483647, 1),
(12, 9, 6, 2147483647, 1),
(13, 7, 6, 2147483647, 1),
(14, 7, 11, 2147483647, 1);

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
(1, 'Canviritech', '74546546587', 'Empresa de entretenimiento y apremdisaje para niños.', '985796307', 'Entretenimiento y  Cursos en linea', 'Somos la mejor empresa que aya existido', 'Ser unas de las empresas mas prestigiosas sobre el entretenimiento y aprendisaje en el año 2023.', 1),
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
(2, 1, 'Tener la maxima cantidad de ventas', 0),
(3, 1, 'Tener la maxima cantidad de ventas', 1),
(4, 1, 'Ser una de las mejores emrpresas en el mundo', 0);

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
(2, 'Proceso de Creacion de Cursos', 'Proceso donde un procesor dicta el cursos en un sistema E-learning a un alumnos.', 2, 1, 0, 0, 1, 1),
(3, 'Proceso de Ingreso de cursos.', 'Proceso donde se sube un curso en el sistema E-learning  para posteriormente usarlo en el dictado de cursos..', 2, 1, 0, 0, 1, 0),
(4, 'Proceso de Ingreso de cursos.', 'Proceso donde se sube un curso en el sistema E-learning  para posteriormente usarlo en el dictado de cursos..', 2, 1, 0, 0, 1, 1),
(5, 'fdgfdgdf', 'gdfgdfgdfgdf', 2, 1, 1, 4, 1, 0),
(6, 'jkdfjdjskjflsdk', 'sdjfksdjflksdjfklsd', 2, 1, 1, 5, 1, 0);

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
(1, 2, 2, 1, '2023-03-06 03:02:39'),
(2, 3, 2, 0, '2023-03-06 03:02:55'),
(3, 3, 2, 0, '2023-03-06 04:17:59'),
(4, 3, 2, 0, '2023-03-11 00:22:07'),
(5, 4, 2, 0, '2023-03-11 00:22:17'),
(6, 3, 2, 0, '2023-03-11 00:22:32');

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
(3, 'Informaci�n Empresa', 'biz', 'essential.info.biz', 1, 2, 1),
(4, 'Informaci�n Comercial', 'com', 'essential.info.com', 1, 2, 1),
(5, 'Datos de inter�s para la administraci�n de p�blica', 'adm', 'essential.info.adm', 1, 2, 1),
(6, 'Datos Vitales (Registros de la Organizaci�n)', 'vr', 'essential.info.vr', 1, 2, 1),
(7, 'datos de car�cter personal', 'per', 'essential.info.per', 1, 2, 1),
(8, 'datos de persona normal', 'normal', 'essential.info.per.normal', 1, 7, 1),
(9, '[Datos de identificaci�n (nombre y apellido, ID, direcci�n postal, direcci�n de correo electr�nico, tel�fono, ...)', '1', 'essential.info.per.normal.1', 1, 8, 1),
(10, 'Caracter�sticas personales (estado civil, fecha y lugar de nacimiento, edad, sexo, nacionalidad, ...)', '2', 'essential.info.per.normal.2', 1, 8, 1),
(11, 'datos acad�micos', '3', 'essential.info.per.normal.3', 1, 8, 1),
(12, 'datos profesionales', '4', 'essential.info.per.normal.4', 1, 8, 1),
(13, 'datos bancarios', '5', 'essential.info.per.normal.5', 1, 8, 1),
(14, 'Datos personales regulares', 'regular', 'essential.info.per.regular', 1, 7, 1),
(15, 'econ�mico', '1', 'essential.info.per.regular.1', 1, 14, 1),
(16, 'identidad cultural', '2', 'essential.info.per.regular.2', 1, 14, 1),
(17, 'idemtidad social', '3', 'essential.info.per.regular.3', 1, 14, 1),
(18, 'identidad en l�nea', '4', 'essential.info.per.regular.4', 1, 14, 1),
(19, 'ubicaci�n', '5', 'essential.info.per.regular.5', 1, 14, 1),
(20, 'Datos seud�nimos (Art. 4, 6, 25, 32, 40, 89)', 'pseudonymous', 'essential.info.per.pseudonymous', 1, 7, 1),
(21, 'Datos personales confidenciales (Art. 9)', 'sensitive', 'essential.info.per.sensitive', 1, 7, 1),
(22, 'racial', '1', 'essential.info.per.sensitive.1', 1, 21, 1),
(23, 'origen �tnico', '2', 'essential.info.per.sensitive.2', 1, 21, 1),
(24, 'opiniones pol�ticas', '3', 'essential.info.per.sensitive.3', 1, 21, 1),
(25, 'creencias de religiones', '4', 'essential.info.per.sensitive.4', 1, 21, 1),
(26, 'creencias filos�ficas', '5', 'essential.info.per.sensitive.5', 1, 21, 1),
(27, 'membres�a de uni�n comercial', '6', 'essential.info.per.sensitive.6', 1, 21, 1),
(28, 'salud', '7', 'essential.info.per.sensitive.7', 1, 21, 1),
(29, 'f�sico', '1', 'essential.info.per.sensitive.7.1', 1, 28, 1),
(30, 'fisiol�gico', '2', 'essential.info.per.sensitive.7.2', 1, 28, 1),
(31, 'mental', '3', 'essential.info.per.sensitive.7.3', 1, 28, 1),
(32, 'servicios de atenci�n m�dica', '4', 'essential.info.per.sensitive.7.4', 1, 28, 1),
(33, 'Estado de salud', '5', 'essential.info.per.sensitive.7.5', 1, 28, 1),
(34, 'vida sexual', '8', 'essential.info.per.sensitive.8', 1, 21, 1),
(35, 'orientaci�n sexual', '9', 'essential.info.per.sensitive.9', 1, 21, 1),
(36, 'datos gen�ticos', '10', 'essential.info.per.sensitive.10', 1, 21, 1),
(37, 'Informaci�n biom�trica', '11', 'essential.info.per.sensitive.11', 1, 21, 1),
(38, 'ni�os', 'children', 'essential.info.per.children', 1, 7, 1),
(39, 'Derecho penal (Art. 10)', 'criminal', 'essential.info.per.criminal', 1, 7, 1),
(40, 'ofensas criminales', '1', 'essential.info.per.criminal.1', 1, 39, 1),
(41, 'convicci�n', '2', 'essential.info.per.criminal.2', 1, 39, 1),
(42, 'Alto de Nivel', 'A', 'essential.info.per.A', 1, 7, 1),
(43, 'nivel medio', 'M', 'essential.info.per.M', 1, 7, 1),
(44, 'Nivel Bajo', 'B', 'essential.info.per.B', 1, 7, 1),
(45, 'datos Clasificados', 'classified', 'essential.info.classified', 1, 2, 1),
(46, 'ULTRA SECRETO', 'TS', 'essential.info.classified.TS', 1, 45, 1),
(47, 'SECRETO', 'S', 'essential.info.classified.S', 1, 45, 1),
(48, 'Nivel Confidencial', 'C', 'essential.info.classified.C', 1, 45, 1),
(49, 'difusi�n limitada', 'R', 'essential.info.classified.R', 1, 45, 1),
(50, 'Sin Clasificar', 'UC', 'essential.info.classified.UC', 1, 45, 1),
(51, 'De Car�cter P�blico', 'pub', 'essential.info.classified.pub', 1, 45, 1),
(52, 'servicio', 'service', 'essential.service', 1, 1, 1),
(53, 'operaciones', 'operations', 'essential.service.operations', 1, 52, 1),
(54, 'log�stica', 'logistics', 'essential.service.logistics', 1, 52, 1),
(55, 'inteligencia', 'intelligence', 'essential.service.intelligence', 1, 52, 1),
(56, 'personal', 'personnel', 'essential.service.personnel', 1, 52, 1),
(57, 'financiero', 'financial', 'essential.service.financial', 1, 52, 1),
(58, 'administrativo', 'administrative', 'essential.service.administrative', 1, 52, 1),
(59, 'programa', 'programme', 'essential.service.programme', 1, 52, 1),
(60, 'proyecto', 'project', 'essential.service.project', 1, 52, 1),
(61, 'procesos de negocio', 'bp', 'essential.bp', 1, 1, 1),
(62, 'Procesamiento de datos personales', 'pdd', 'essential.ppd', 1, 1, 1),
(63, 'Hacer o analizar perfiles', '1', 'essential.ppd.1', 1, 62, 1),
(64, 'Anuncio y prospecci�n comercial masiva a clientes potenciales', '2', 'essential.ppd.2', 1, 62, 1),
(65, 'Provisi�n de servicios para la operaci�n de redes p�blicas o servicios de comunicaci�n electr�nica (proveedor de servicios de Internet)', '3', 'essential.ppd.3', 1, 62, 1),
(66, 'Gestionar asociados o miembros de partidos pol�ticos, sindicatos, iglesias, confesiones o comunidades religiosas, fundaciones y otras entidades sin fines de lucro, cuyo prop�sito es pol�tico, filos�fico, religioso o sindicato', '4', 'essential.ppd.4', 1, 62, 1),
(67, 'Gesti�n, control sanitario o venta de medicamentos', '5', 'essential.ppd.5', 1, 62, 1),
(68, 'Historial cl�nico o de salud', '6', 'essential.ppd.6', 1, 62, 1),
(69, 'Arquitectura del sistema', 'arch', 'arch', 0, 0, 1),
(70, 'punto de [acceso al] servicio', 'sap', 'arch.sap', 1, 69, 1),
(71, 'punto de interconexi�n', 'ip', 'arch.ip', 1, 69, 1),
(72, 'ninguno', '0', 'arch.ip.0', 1, 71, 1),
(73, 'Filtro de paquetes (nivel 3)', 'pkt', 'arch.ip.pkt', 1, 71, 1),
(74, 'Firewall (control de sesi�n)', 'firewall', 'arch.ip.firewall', 1, 71, 1),
(75, 'Monitoreo de la aplicaci�n (nivel 7)', 'proxy', 'arch.ip.proxy', 1, 71, 1),
(76, '1 firewall (2 puertos) + proxy', 'r2p', 'arch.ip.r2p', 1, 71, 1),
(77, '1 firewall (3 puertos) + proxy', 'r3p', 'arch.ip.r3p', 1, 71, 1),
(78, '2 firewalls + DMZ + proxy', 'dmz', 'arch.ip.dmz', 1, 71, 1),
(79, 'puerta de enlace (cambio de protocolo)', 'gtwy', 'arch.ip.gtwy', 1, 71, 1),
(80, 'diodo (dispositivo unidireccional)', 'diode', 'arch.ip.diode', 1, 71, 1),
(81, 'espacio de aire (pared de aire)', 'gap', 'arch.ip.gap', 1, 71, 1),
(82, 'Sistema de protecci�n del per�metro f�sico', 'pps', 'arch.pps', 1, 69, 1),
(83, 'Protecci�n contra emanaciones electromagn�ticas', 'tempest', 'arch.tempest', 1, 69, 1),
(84, 'Zona 0: Efectivo si el atacante est� muy cerca', '0', 'arch.tempest.0', 1, 83, 1),
(85, 'Zona 1: Efectivo si el atacante est� a 20 m de distancia', '1', 'arch.tempest.1', 1, 83, 1),
(86, 'Zona 2: Efectivo si el atacante est� a 100 metros de distancia', '2', 'arch.tempest.2', 1, 83, 1),
(87, 'Zona 3: Efectivo si el atacante est� a 500 m de distancia', '3', 'arch.tempest.3', 1, 83, 1),
(88, 'alternativa', 'or', 'arch.alternativas', 1, 69, 1),
(89, 'Caracter�sticas', 'qualifier', 'qualifier', 0, 0, 1),
(90, 'independiente (sin valor heredado del dominio)', 'independent', 'qualifier.independent', 1, 89, 1),
(91, 'no almacena datos', 'no_data', 'qualifier.no_data', 1, 89, 1),
(92, 'Sin amenazas', 'no threats', 'qualifier.no_threats', 1, 89, 1),
(93, 'Fuera de servicio', 'dead', 'qualifier.dead', 1, 89, 1),
(94, 'no existe', 'not_exists', 'qualifier.not_exists', 1, 89, 1),
(95, 'invisible', 'invisible', 'qualifier.invisible', 1, 89, 1),
(96, 'negro (informaci�n cifrada)', 'black', 'qualifier.black', 1, 89, 1),
(97, 'Disponibilidad', 'availability', 'qualifier.availability', 1, 89, 1),
(98, 'F�cil de reemplazar', 'easy', 'qualifier.availability.easy', 1, 97, 1),
(99, 'Sin problemas de disponibilidad', 'none', 'qualifier.availability.none', 1, 97, 1),
(100, 'Productos o servicios evaluados', 'evaluated', 'qualifier.evaluated', 1, 89, 1),
(101, 'certificado (evaluado por un tercero)', 'certified', 'qualifier.evaluated.certified', 1, 100, 1),
(102, 'acreditado (evaluado por un tercero)', 'accredited', 'qualifier.evaluated.accredited', 1, 100, 1),
(103, 'sin apoyo (sin mantenimiento del fabricante)', 'unsupported', 'qualifier.unsupported', 1, 89, 1),
(104, 'Zonificaci�n de equipos (tempestad)', 'tempest', 'qualifier.tempest', 1, 89, 1),
(105, 'Garant�a m�xima', 'A', 'qualifier.tempest.A', 1, 104, 1),
(106, 'Garant�a media', 'B', 'qualifier.tempest.B', 1, 104, 1),
(107, 'Garant�a m�nima', 'C', 'qualifier.tempest.C', 1, 104, 1),
(108, 'Sin garant�a', 'D', 'qualifier.tempest.D', 1, 104, 1),
(109, 'proporciado por terceros', 'ext', 'arch.ext', 1, 69, 1),
(110, 'Datos / informaci�n', 'D', 'D', 0, 0, 1),
(111, 'ficheros', 'files', 'D.files', 1, 110, 1),
(112, 'archivos de datos cifrados', 'e-files', 'D.e-files', 1, 110, 1),
(113, 'registros de organizaci�n', 'records', 'D.records', 1, 110, 1),
(114, 'Mensajes (enviados a lo largo de canales de comunicaci�n)', 'msg', 'D.msg', 1, 110, 1),
(115, 'mensajes cifrados', 'e-msg', 'D.e-msg', 1, 110, 1),
(116, 'Copias de Respaldo', 'backup', 'D.backup', 1, 110, 1),
(117, 'Datos de configuraci�n', 'conf', 'D.conf', 1, 110, 1),
(118, 'Datos de Gesti�n�n', 'int', 'D.int', 1, 110, 1),
(119, 'credenciales (EJ. Contrase�as)', 'password', 'D.password', 1, 110, 1),
(120, 'Datos de Validacia de Credenciales', 'auth', 'D.auth', 1, 110, 1),
(121, 'datos de control de access', 'acl', 'D.acl', 1, 110, 1),
(122, 'Registro de actividad', 'log', 'D.log', 1, 110, 1),
(123, 'voz', 'voice', 'D.voice', 1, 110, 1),
(124, 'multimedia', 'multimedia', 'D.multimedia', 1, 110, 1),
(125, 'c�digo fuente', 'source', 'D.source', 1, 110, 1),
(126, 'c�digo ejecutable', 'exe', 'D.exe', 1, 110, 1),
(127, 'datos de prueba', 'test', 'D.test', 1, 110, 1),
(128, 'otro', 'other', 'D.other ...', 1, 110, 1),
(129, 'Claves criptogr�ficas', 'keys', 'keys', 0, 0, 1),
(130, 'protecci�n de la informaci�n', 'info', 'keys.info', 1, 129, 1),
(131, 'claves de cifra', 'encrypt', 'keys.info.encrypt', 1, 130, 1),
(132, 'secreto compartido (clave sim�trica)', 'shared_secret', 'keys.info.encrypt.shared_secret', 1, 131, 1),
(133, 'clave p�blica de cifra', 'public_encryption', 'keys.info.encrypt.public_encryption', 1, 131, 1),
(134, 'clave privada de descifrado', 'public_decryption', 'keys.info.encrypt.public_decryption', 1, 131, 1),
(135, 'claves de firma', 'sign', 'keys.info.sign', 1, 130, 1),
(136, 'secreto compartido (clave sim�trica)', 'shared_secret', 'keys.info.sign.shared_secret', 1, 135, 1),
(137, 'clave privada de firma', 'public_signature', 'keys.info.sign.public_signature', 1, 135, 1),
(138, 'clave p�blica de verificaci�n de firma', 'public_verification', 'keys.info.sign.public_verification', 1, 135, 1),
(139, 'protecci�n de las comunicaciones', 'com', 'keys.com', 1, 129, 1),
(140, 'claves de cifrado del canal', 'channel', 'keys.com.channel', 1, 139, 1),
(141, 'claves de autenticaci�n', 'authentication', 'keys.com.authentication', 1, 139, 1),
(142, 'claves de verificaci�n de autenticaci�n', 'verification', 'keys.com.verification', 1, 139, 1),
(143, 'cifrado de soportes de informaci�n', 'disk', 'keys.disk', 1, 129, 1),
(144, 'claves de cifra', 'encrypt', 'keys.disk.encrypt', 1, 143, 1),
(145, 'certificados de clave p�blica', 'x509', 'keys.x509', 1, 129, 1),
(146, 'Servicios', 'S', 'S', 0, 0, 1),
(147, 'Usado por nosotros', 'client', 'S.client', 1, 146, 1),
(148, 'correo electr�nico', 'email', 'S.client.email', 1, 147, 1),
(149, 'buscando en la web', 'www', 'S.client.www', 1, 147, 1),
(150, 'teletrabajo', 'telework', 'S.client.telework', 1, 147, 1),
(151, 'proporcionado por nosotros', 'prov', 'S.prov', 1, 146, 1),
(152, 'administracion del sistema', 'sysadm', 'S.prov.sysadm', 1, 151, 1),
(153, 'An�nimo (sin identificaci�n)', 'anon', 'S.prov.anon', 1, 151, 1),
(154, 'Abierto al p�blico (sin contrato)', 'pub', 'S.prov.pub', 1, 151, 1),
(155, 'Usuarios externos (bajo contrato)', 'ext', 'S.prov.ext', 1, 151, 1),
(156, 'interno (los usuarios y los medios pertenecen a la organizaci�n)', 'int', 'S.prov.int', 1, 151, 1),
(157, 'World Wide Web', 'www', 'S.prov.www', 1, 151, 1),
(158, 'acceso remoto', 'remote_access', 'S.prov.remote_access', 1, 151, 1),
(159, 'correo electr�nico', 'email', 'S.prov.email', 1, 151, 1),
(160, 'voz sobre IP', 'voip', 'S.prov.voip', 1, 151, 1),
(161, 'Servicio de archivo (almacenamiento)', 'file', 'S.prov.file', 1, 151, 1),
(162, 'servicio de impresi�n', 'print', 'S.prov.print', 1, 151, 1),
(163, 'transferencia de archivos', 'ft', 'S.prov.ft', 1, 151, 1),
(164, 'servicio de respaldo', 'backup', 'S.prov.backup', 1, 151, 1),
(165, 'servicio de tiempo', 'time', 'S.prov.time', 1, 151, 1),
(166, 'EDI - Intercambio electr�nico de datos', 'edi', 'S.prov.edi', 1, 151, 1),
(167, 'directorio de Servicios', 'dir', 'S.prov.dir', 1, 151, 1),
(168, 'servidor de nombres de dominio', 'dns', 'S.prov.dns', 1, 151, 1),
(169, 'gesti�n de identidad', 'idm', 'S.prov.idm', 1, 151, 1),
(170, 'gesti�n de privilegios', 'ipm', 'S.prov.ipm', 1, 151, 1),
(171, 'registro de actividades', 'log', 'S.prov.log', 1, 151, 1),
(172, 'servicios criptogr�ficos', 'crypto', 'S.prov.crypto', 1, 151, 1),
(173, 'generaci�n de claves', '.key_gen', 'S.prov.crypto.key_gen', 1, 172, 1),
(174, 'protecci�n contra la integridad', 'integrity', 'S.prov.crypto.integrity', 1, 172, 1),
(175, 'encriptaci�n', 'encryption', 'S.prov.crypto.encryption', 1, 172, 1),
(176, 'autenticaci�n', 'auth', 'S.prov.crypto.auth', 1, 172, 1),
(177, 'firma electronica', 'sign', 'S.prov.crypto.sign', 1, 172, 1),
(178, 'servicio de estampado de tiempo', 'time', 'S.prov.crypto.time', 1, 172, 1),
(179, 'PKI - Infraestructura de clave p�blica', 'pki', 'S.prov.pki', 1, 151, 1),
(180, 'autoridad de certificaci�n', 'ca', 'S.prov.pki.ca', 1, 179, 1),
(181, 'Autoridad de Registro', 'ra', 'S.prov.pki.ra', 1, 179, 1),
(182, 'autoridad de validaci�n', 'va', 'S.prov.pki.va', 1, 179, 1),
(183, 'autoridad de estampado de tiempo', 'tsa', 'S.prov.pki.tsa', 1, 179, 1),
(184, 'autoridad de atributo', 'aa', 'S.prov.pki.aa', 1, 179, 1),
(185, 'otro ...', 'other ...', 'S.prov.other', 1, 151, 1),
(186, 'proporcionado por una fiesta externa', '3rd', 'S.3rd', 1, 146, 1),
(187, 'Proveedor de servicios de Internet', 'ISP', 'S.3rd.ISP', 1, 186, 1),
(188, 'Transporte / Comunicaciones', 'comms', 'S.3rd.comms', 1, 186, 1),
(189, 'proveedor de procesamiento', 'proc', 'S.3rd.proc', 1, 186, 1),
(190, 'almacenamiento', 'file', 'S.3rd.file', 1, 186, 1),
(191, 'respaldo', 'backup', 'S.3rd.backup', 1, 186, 1),
(192, 'identidad', 'id', 'S.3rd.id', 1, 186, 1),
(193, 'Certificaci�n (PKI)', 'ca', 'S.3rd.ca', 1, 186, 1),
(194, 'Atributos (PKI)', 'aa', 'S.3rd.aa', 1, 186, 1),
(195, 'Validaci�n (PKI)', 'va', 'S.3rd.va', 1, 186, 1),
(196, 'Marcando la hora', 'tsa', 'S.3rd.tsa', 1, 186, 1),
(197, 'Directorio (LDAP, DNS, ...)', 'dir', 'S.3rd.dir', 1, 186, 1),
(198, 'impresi�n', 'print', 'S.3rd.print', 1, 186, 1),
(199, 'correo electr�nico', 'email', 'S.3rd.email', 1, 186, 1),
(200, 'alojamiento de servidor web', 'www', 'S.3rd.www', 1, 186, 1),
(201, 'alojamiento', 'hosting', 'S.3rd.hosting', 1, 186, 1),
(202, 'alojamiento', 'housing', 'S.3rd.housing housing', 1, 186, 1),
(203, 'nube', 'cloud', 'S.3rd.cloud', 1, 186, 1),
(204, 'Software como servicio', 'SaaS', 'S.3rd.cloud.SaaS', 1, 203, 1),
(205, 'Plataforma como servicio', 'PaaS', 'S.3rd.cloud.PaaS', 1, 203, 1),
(206, 'Infraestructura como un servicio', 'IaaS', 'S.3rd.cloud.IaaS', 1, 203, 1),
(207, 'registro de actividades', 'log', 'S.3rd.log', 1, 186, 1),
(208, 'mantenimiento', 'care', 'S.3rd.care', 1, 186, 1),
(209, 'proveedor de energ�a', 'power', 'S.3rd.power', 1, 186, 1),
(210, 'otro ...', 'other', 'S.3rd.other', 1, 186, 1),
(211, 'an�nimo (sin requerir identificaci�n del usuario)', 'anon', 'S.anon', 1, 146, 1),
(212, 'al p�blico en general (sin relaci�n contractual)', 'pub', 'S.pub', 1, 146, 1),
(213, 'a usuarios externos (bajo una relaci�n contractual)', 'ext', 'S.ext', 1, 146, 1),
(214, 'interno (a usuarios de la propia organizaci�n)', 'int', 'S.int', 1, 146, 1),
(215, 'world wide web', 'www', 'S.www', 1, 146, 1),
(216, 'acceso remoto a cuenta local', 'telnet', 'S.telnet', 1, 146, 1),
(217, 'correo electr�nico', 'email', 'S.email', 1, 146, 1),
(218, 'almacenamiento de ficheros', 'file', 'S.file', 1, 146, 1),
(219, 'almacenamiento de ficheros', 'ftp', 'S.ftp', 1, 146, 1),
(220, 'intercambio electr�nico de datos', 'edi', 'S.edi', 1, 146, 1),
(221, 'servicio de directorio', 'dir', 'S.dir', 1, 146, 1),
(222, 'gesti�n de identidades', 'idm', 'S.idm', 1, 146, 1),
(223, 'gesti�n de privilegios', 'ipm', 'S.ipm', 1, 146, 1),
(224, 'PKI - infraestructura de clave p�blica', 'pki', 'S.pki', 1, 146, 1),
(225, 'Aplicaciones (software)', 'SW', 'SW', 0, 0, 1),
(226, 'Desarrollo Propio (en casa)', 'prp', 'SW.prp', 1, 225, 1),
(227, 'Desarrollo a Medida (subcontratado)', 'sub', 'SW.sub', 1, 225, 1),
(228, 'Est�ndar (en el estante)', 'std', 'SW.std', 1, 225, 1),
(229, 'Web Navegador', 'browser', 'SW.std.browser', 1, 228, 1),
(230, 'servidor de presente', 'www', 'SW.std.www', 1, 228, 1),
(231, 'Servidor de Aplicaciones', 'app', 'SW.std.app', 1, 228, 1),
(232, 'Cliente de Correo Electr�nico', 'email_client', 'SW.std.email_client', 1, 228, 1),
(233, 'Servidor de Correo Electr�nico', 'email_server', 'SW.std.email_server', 1, 228, 1),
(234, 'servidor de directorio', 'directry', 'SW.std.directory', 1, 228, 1),
(235, 'servidor de ficheros', 'file', 'SW.std.file', 1, 228, 1),
(236, 'Sistema de Gesti�n de Bases de Datos', 'dbms', 'SW.std.dbms', 1, 228, 1),
(237, 'monitorear transaccional', 'tm', 'SW.std.tm', 1, 228, 1),
(238, 'Ofim�tica', 'office', 'SW.std.office', 1, 228, 1),
(239, 'anti virus', 'av', 'SW.std.av', 1, 228, 1),
(240, 'Sistema operativo', 'os', 'SW.std.os', 1, 228, 1),
(241, 'Windows', 'windows', 'SW.std.os.windows', 1, 240, 1),
(242, 'solaris', 'solaris', 'SW.std.os.solaris', 1, 240, 1),
(243, 'Linux', 'linux', 'SW.std.os.linux', 1, 240, 1),
(244, 'Mac OS X', 'macosx', 'SW.std.os.macosx', 1, 240, 1),
(245, 'otro ...', 'other', 'SW.std.os.other', 1, 240, 1),
(246, 'Gestor de M�quinas Virtuales', 'hypervisor', 'SW.std.hypervisor', 1, 228, 1),
(247, 'Hypervisor Tipo 1 (Bare-Metal | Nativo)', 'type1', 'SW.std.hypervisor.type1', 1, 246, 1),
(248, 'Hypervisor tipo 2 (alojado)', 'type2', 'SW.std.hypervisor.type2', 1, 246, 1),
(249, 'servidor de terminales', 'ts', 'SW.std.ts', 1, 228, 1),
(250, 'Sistema de respaldo', 'backup', 'SW.std.backup', 1, 228, 1),
(251, 'otro ...', 'other', 'SW.std.other', 1, 228, 1),
(252, 'herramientas de seguridad', 'sec', 'SW.sec', 1, 225, 1),
(253, 'anti virus', 'av', 'SW.sec.av', 1, 252, 1),
(254, 'IDS / IPS (detecci�n / prevenci�n de intrusos)', 'ids', 'SW.sec.ids', 1, 252, 1),
(255, 'prevenci�n de p�rdida de datos', 'dip', 'SW.sec.dlp', 1, 252, 1),
(256, 'An�lisis de tr�fico', 'traf', 'SW.sec.traf', 1, 252, 1),
(257, 'tarro de miel', 'hp', 'SW.sec.hp', 1, 252, 1),
(258, 'Equipos inform�tica (hardware)', 'HW', 'HW', 0, 0, 1),
(259, 'Grandes equipos', 'host', 'HW.host', 1, 258, 1),
(260, 'equipos medios', 'mid', 'HW.mid', 1, 258, 1),
(261, 'inform�tica personal', 'pc', 'HW.pc', 1, 258, 1),
(262, 'inform�tica m�vil', 'mobile', 'HW.mobile', 1, 258, 1),
(263, 'dispositivos de mano', 'hand-held', 'HW.hand-held', 1, 258, 1),
(264, 'agendas elect�licas', 'pda', 'HW.pda', 1, 258, 1),
(265, 'Equipo virtual', 'vhost', 'HW.vhost', 1, 258, 1),
(266, 'grupo', 'cluster', 'HW.cluster', 1, 258, 1),
(267, 'Equipamiento de Respaldo', 'backup', 'HW.backup', 1, 258, 1),
(268, 'Datos de almacenamiento', 'data', 'HW.data', 1, 258, 1),
(269, 'perif�ricos', 'peripheral', 'HW.peripheral', 1, 258, 1),
(270, 'medios de impresi�n', 'print', 'HW.peripheral.print', 1, 269, 1),
(271, 'esc�lenes', 'scan', 'HW.peripheral.scan', 1, 269, 1),
(272, 'Dispositivos Criptogrrafos', 'crypto', 'HW.peripheral.crypto', 1, 269, 1),
(273, 'otro ...', 'other', 'HW.peripheral.other', 1, 269, 1),
(274, 'Dispositivo de Frontera', 'bp', 'HW.bp', 1, 258, 1),
(275, 'robots', 'robot', 'HW.robot', 1, 258, 1),
(276, 'cinta ...', 'tape', 'HW.robot.tape', 1, 275, 1),
(277, 'disco ...', 'disk', 'HW.robot.disk', 1, 275, 1),
(278, 'Soporte de la Red', 'network', 'HW.network', 1, 258, 1),
(279, 'm�dems', 'modem', 'HW.network.modem', 1, 278, 1),
(280, 'concentradoras', 'hub', 'HW.network.hub', 1, 278, 1),
(281, 'conmutadores', 'switch', 'HW.network.switch', 1, 278, 1),
(282, 'encaminadores', 'router', 'HW.network.router', 1, 278, 1),
(283, 'pasarelas', 'bridge', 'HW.network.bridge', 1, 278, 1),
(284, 'cortafuegos', 'firewall', 'HW.network.firewall', 1, 278, 1),
(285, 'punto de acceso inal�mbrico', 'wap', 'HW.network.wap', 1, 278, 1),
(286, 'otro ...', 'other', 'HW.network.other', 1, 278, 1),
(287, 'Centralita Telef�nica', 'pabx', 'HW.pabx', 1, 258, 1),
(288, 'Tel�fono IP', 'ipphone', 'HW.ipphone', 1, 258, 1),
(289, 'otro ...', 'other', 'HW.other', 1, 258, 1),
(290, 'Sistemas de control industrial', 'ics', 'HW.ics', 1, 258, 1),
(291, 'RTU - Unidad de terminal remoto', 'rtu', 'HW.ics.rtu', 1, 290, 1),
(292, 'PLC - Controlador l�gico programable', 'plc', 'HW.ics.plc', 1, 290, 1),
(293, 'PAC - Controlador de automatizaci�n programable', 'pac', 'HW.ics.pac', 1, 290, 1),
(294, 'IED - Dispositivo electr�nico inteligente', 'ied', 'HW.ics.ied', 1, 290, 1),
(295, 'Metro', 'meter', 'HW.ics.meter', 1, 290, 1),
(296, 'Puente', 'bridge', 'HW.ics.bridge', 1, 290, 1),
(297, 'HMI - Interfaz de m�quina humana', 'hmi', 'HW.ics.hmi', 1, 290, 1),
(298, 'Servidor', 'server', 'HW.ics.server', 1, 290, 1),
(299, 'Historiador', 'historian', 'HW.ics.historian', 1, 290, 1),
(300, 'Telemetr�a', 'telemetry', 'HW.ics.telemetry', 1, 290, 1),
(301, 'EMS - Sistema de gesti�n de energ�a', 'ems', 'HW.ics.ems', 1, 290, 1),
(302, 'DMS - Sistema de gesti�n de distribuci�n', 'dms', 'HW.ics.dms', 1, 290, 1),
(303, 'Red de control dom�stico', 'home', 'HW.ics.home', 1, 290, 1),
(304, 'HVAC - Calefacci�n, ventilaci�n y aire acondicionado', 'hvac', 'HW.ics.hvac', 1, 290, 1),
(305, 'Redes de comunicaciones', 'COM', 'COM', 0, 0, 1),
(306, 'red telef�nica', 'PSTN', 'COM.PSTN', 1, 305, 1),
(307, 'RDSI (Red Digital)', 'ISDN', 'COM.ISDN', 1, 305, 1),
(308, 'X25 (Red de datos)', 'X25', 'COM.X25', 1, 305, 1),
(309, 'ADSL', 'ADSL', 'COM.ADSL', 1, 305, 1),
(310, 'PUNTO A PUNTO', 'pp', 'COM.pp', 1, 305, 1),
(311, 'radio de comunicaciones', 'radio', 'COM.radio', 1, 305, 1),
(312, 'inalmbrica rojo', 'wifi', 'COM.wifi', 1, 305, 1),
(313, 'telefon�a m�vil', 'mobile', 'COM.mobile', 1, 305, 1),
(314, 'por sat�lita', 'sat', 'COM.sat', 1, 305, 1),
(315, 'local rojo', 'LAN', 'COM.LAN', 1, 305, 1),
(316, 'LAN virtual', 'VLAN', 'COM.VLAN', 1, 305, 1),
(317, 'red metropolitana', 'MAN', 'COM.MAN', 1, 305, 1),
(318, 'red de �rea amplia', 'WAN', 'COM.WAN', 1, 305, 1),
(319, 'canal cifrado (red privada virtual)', 'vpn', 'COM.vpn', 1, 305, 1),
(320, 'Comunicaciones de respaldo', 'backup', 'COM.backup', 1, 305, 1),
(321, 'otro ...', 'other', 'COM.other', 1, 305, 1),
(322, 'Internet', 'Internet', 'COM.Internet', 1, 305, 1),
(323, 'Soportes de informaci�n', 'Media', 'Media', 0, 0, 1),
(324, 'electr�nicos', 'electronic', 'Media.electronic', 1, 323, 1),
(325, 'discos', 'disk', 'Media.electronic.disk', 1, 324, 1),
(326, 'discos virtuales', 'vdisk', 'Media.electronic.vdisk', 1, 324, 1),
(327, 'almacenamiento en red', 'san', 'Media.electronic.san', 1, 324, 1),
(328, 'disquetes', 'disquette', 'Media.electronic.disquette', 1, 324, 1),
(329, 'cederr�n (CD-ROM)', 'cd', 'Media.electronic.cd', 1, 324, 1),
(330, 'memorias USB', 'usb', 'Media.electronic.usb', 1, 324, 1),
(331, 'DVD', 'dvd', 'Media.electronic.dvd', 1, 324, 1),
(332, 'cinta magn�tica', 'tape', 'Media.electronic.tape', 1, 324, 1),
(333, 'tarjetas de memoria', 'mc', 'Media.electronic.mc', 1, 324, 1),
(334, 'tarjetas inteligentes', 'ic', 'Media.electronic.ic', 1, 324, 1),
(335, 'memoria vol�til (por ejemplo, RAM)', 'volatile', 'Media.electronic.volatile', 1, 324, 1),
(336, 'Memoria no vol�til (por ejemplo, EPROM)', 'non-volatile', 'Media.electronic.non-volatile', 1, 324, 1),
(337, 'otro ...', 'other', 'Media.electronic.other', 1, 324, 1),
(338, 'No electr�nicos', 'non_electronic', 'Media.non_electronic', 1, 323, 1),
(339, 'incremento de material', 'printed', 'Media.non_electronic.printed', 1, 338, 1),
(340, 'Cinta de Papel', 'tape', 'Media.non_electronic.tape', 1, 338, 1),
(341, 'microfilm', 'film', 'Media.non_electronic.film', 1, 338, 1),
(342, 'Tarjetas perforadas', 'cards', 'Media.non_electronic.cards', 1, 338, 1),
(343, 'otro ...', 'other', 'Media.non_electronic.other', 1, 338, 1),
(344, 'Equipamiento auxiliar', 'AUX', 'AUX', 0, 0, 1),
(345, 'Fuentes de Alimentaci�n', 'power', 'AUX.power', 1, 344, 1),
(346, 'sistemas de alimentaci�n ininterrumpida', 'ups', 'AUX.ups', 1, 344, 1),
(347, 'generadores el�ctricos', 'gen', 'AUX.gen', 1, 344, 1),
(348, 'equipos de climatizaci�n', 'ac', 'AUX.ac', 1, 344, 1),
(349, 'cableado', 'cabling', 'AUX.cabling', 1, 344, 1),
(350, 'cable El�ctrico', 'wire', 'AUX.cabling.wire', 1, 349, 1),
(351, 'fibra �ptica', 'fiber', 'AUX.cabling.fiber', 1, 349, 1),
(352, 'robots', 'robot', 'AUX.robot', 1, 344, 1),
(353, 'de cintas', 'tape', 'AUX.robot.tape', 1, 352, 1),
(354, 'de discos', 'disk', 'AUX.robot.disk', 1, 352, 1),
(355, 'Suministros esenciales', 'supply', 'AUX.supply', 1, 344, 1),
(356, 'Equipos de Destruci�n de Soportes de Informaci�n', 'destroy', 'AUX.destroy', 1, 344, 1),
(357, 'Mobiliario: armario, etc.', 'furniture', 'AUX.furniture', 1, 344, 1),
(358, 'Cajas Fuertes', 'safe', 'AUX.safe', 1, 344, 1),
(359, 'otro ...', 'other', 'AUX.other', 1, 344, 1),
(360, 'Instalaciones', 'L', 'L', 0, 0, 1),
(361, 'recinto', 'site', 'L.site', 1, 360, 1),
(362, 'edificio', 'building', 'L.building', 1, 360, 1),
(363, 'cuarto', 'local', 'L.local', 1, 360, 1),
(364, 'local', 'mobile', 'L.mobile', 1, 360, 1),
(365, 'veh�culo terrestre: coche, cami�n, etc.', 'car', 'L.mobile.car', 1, 364, 1),
(366, 'veh�culo a�reo: avi�n, etc', 'plane', 'L.mobile.plane', 1, 364, 1),
(367, 'veh�culo mar�timo: buque, lancha, etc.', 'ship', 'L.mobile.ship', 1, 364, 1),
(368, 'contenedores', 'shelter', 'L.mobile.shelter', 1, 364, 1),
(369, 't�nel', 'tunnel', 'L.tunnel', 1, 364, 1),
(370, 'canalizaci�n', 'channel', 'L.channel', 1, 360, 1),
(371, 'instalaciones de respaldo', 'backup', 'L.backup', 1, 360, 1),
(372, 'otro ...', 'other', 'L.other', 1, 360, 1),
(373, 'Personal', 'P', 'P', 0, 0, 1),
(374, 'usuarios externos', 'ue', 'P.ue', 1, 373, 1),
(375, 'usuarios internos', 'ui', 'P.ui', 1, 373, 1),
(376, 'operadores', 'op', 'P.op', 1, 373, 1),
(377, 'administradores de sistemas', 'adm', 'P.adm', 1, 373, 1),
(378, 'administradores de comunicaciones', 'com', 'P.com', 1, 373, 1),
(379, 'administradores de BBDD', 'dba', 'P.dba', 1, 373, 1),
(380, 'administradores de seguridad', 'sec', 'P.sec', 1, 373, 1),
(381, 'desarrolladores / programadores', 'dev', 'P.dev', 1, 373, 1),
(382, 'subcontratas', 'sub', 'P.sub', 1, 373, 1),
(383, 'proveedores', 'prov', 'P.prov', 1, 373, 1),
(384, 'otro ...', 'other', 'P.other', 1, 373, 1),
(385, 'Otras clases', 'other', 'other', 0, 0, 1);

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
(2, 'Carlos Arturo Guevara Ernandes guerrero', 'Jefe Contable', 'Encargado de la parte tecnica de la empreasa', '985796307', 'arturo14212000@gmail.com', 'cod-23674382647', 1, 1),
(3, 'Luis enrique morocho', 'Jefa de recursos humanos', 'Encargado de monitorias a los trabajadores', '985796307', 'LuismorochoFebres@gmail.com', 'cod-23674382647', 1, 1),
(4, 'Luis enrique morocho', 'Jefa de recursos humanos', 'Encargado de monitorias a los trabajadores', '985796307', 'LuismorochoFebres@gmail.com', 'cod-23674382647', 1, 1),
(9, 'hsadsadsad', 'sadasdsad', 'asdasdsadasd', '969280255', 'anamariacastillodelgado@gmail.com', 'E-1273891273', 0, 1),
(10, 'shdjashdksa', 'asjdksajdklsjad', 'asjdksaljdklsad', '985796307', 'caguerrero155464@gmail.com', 'askdlaskd;laskdl;', 0, 1),
(11, 'shdjashdksa', 'asjdksajdklsjad', 'asjdksaljdklsad', '985796307', 'caguerrero155464@gmail.com', 'askdlaskd;laskdl;', 0, 1);

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
(1, 4, 2, 2, 5, 1),
(2, 5, 5, 5, 0, 1),
(3, 6, 5, 5, 0, 1);

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
-- Indices de la tabla `dependactivarbol`
--
ALTER TABLE `dependactivarbol`
  ADD PRIMARY KEY (`id_dependActivArbol`);

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
  MODIFY `id_activo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `activproces`
--
ALTER TABLE `activproces`
  MODIFY `id_activproc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `id_areaProce` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `areasempresa`
--
ALTER TABLE `areasempresa`
  MODIFY `id_areempre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clientanali`
--
ALTER TABLE `clientanali`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `dependactivarbol`
--
ALTER TABLE `dependactivarbol`
  MODIFY `id_dependActivArbol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `depentactiv`
--
ALTER TABLE `depentactiv`
  MODIFY `id_depenActiv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
  MODIFY `id_objempresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `proceempresa`
--
ALTER TABLE `proceempresa`
  MODIFY `id_proceso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `resposproce`
--
ALTER TABLE `resposproce`
  MODIFY `id_resposProce` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tipoactivo`
--
ALTER TABLE `tipoactivo`
  MODIFY `id_tipoActivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=386;

--
-- AUTO_INCREMENT de la tabla `tipproce`
--
ALTER TABLE `tipproce`
  MODIFY `id_tipProce` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `trabajempresa`
--
ALTER TABLE `trabajempresa`
  MODIFY `Id_trabajador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `valorproces`
--
ALTER TABLE `valorproces`
  MODIFY `id_valorProc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  ADD CONSTRAINT `activos_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`);

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
