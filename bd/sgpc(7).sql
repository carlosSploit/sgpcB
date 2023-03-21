-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-03-2023 a las 09:27:53
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

DROP PROCEDURE IF EXISTS `delete_activprosveranali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_activprosveranali` (IN `id_activProsVerAnali` INT)   BEGIN

UPDATE activprosveranali actval SET actval.estade = 0 WHERE actval.id_activProsVerAnali = id_activProsVerAnali ;

END$$

DROP PROCEDURE IF EXISTS `delete_afectaactiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_afectaactiv` (IN `id_afectaActiv` INT)   BEGIN

UPDATE afectaactiv afeactiv SET afeactiv.estade = 0 WHERE afeactiv.id_afectaActiv = id_afectaActiv ;

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

DROP PROCEDURE IF EXISTS `delete_objversanali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_objversanali` (IN `id_objVersAnali` INT)   BEGIN

UPDATE objversanali objver SET objver.estade = 0 WHERE objver.id_objVersAnali = id_objVersAnali ;

END$$

DROP PROCEDURE IF EXISTS `delete_proceempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_proceempresa` (IN `id_proceso` INT)   BEGIN

UPDATE proceempresa proem SET proem.estade = 0 WHERE proem.id_proceso = id_proceso ;

END$$

DROP PROCEDURE IF EXISTS `delete_responanalis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_responanalis` (IN `id_responAnalis` INT)   BEGIN

UPDATE responanalis resana SET resana.estade = 0 WHERE resana.id_responAnalis = id_responAnalis ;

END$$

DROP PROCEDURE IF EXISTS `delete_resposproce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_resposproce` (IN `id_resposProce` INT)   BEGIN

UPDATE resposproce respo SET respo.estade = 0 WHERE respo.id_resposProce = id_resposProce ;

END$$

DROP PROCEDURE IF EXISTS `delete_trabajempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_trabajempresa` (IN `id_trabajador` INT)   BEGIN

UPDATE trabajempresa tbrem SET tbrem.estade = 0 WHERE tbrem.Id_trabajador = id_trabajador ;

END$$

DROP PROCEDURE IF EXISTS `delete_valorafectamenDim`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_valorafectamenDim` (IN `id_valAfectAmenDimen` INT)   BEGIN

UPDATE valafectamendimen valafdim SET valafdim.estade = 0 WHERE valafdim.id_valAfectAmenDimen = id_valAfectAmenDimen ;

END$$

DROP PROCEDURE IF EXISTS `delete_valoriActivDimen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_valoriActivDimen` (IN `id_valorActiDimen` INT)   BEGIN

UPDATE valoractivdimen valdim SET valdim.estade = 0 WHERE valdim.id_valorActiDimen = id_valorActiDimen ;

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

DROP PROCEDURE IF EXISTS `insert_activprosveranali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_activprosveranali` (IN `id_versonAnali` INT, IN `id_activProc` INT)   BEGIN

INSERT INTO `activprosveranali`(`id_versonAnali`, `id_activProc`, `estade`) VALUES ( id_versonAnali, id_activProc,'1') ;

END$$

DROP PROCEDURE IF EXISTS `insert_afectaactiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_afectaactiv` (IN `id_activProsVerAnali` INT, IN `id_amenaza` INT)   BEGIN

INSERT INTO `afectaactiv`(`id_activProsVerAnali`, `id_amenaza`, `esenario`, `estade`) VALUES (id_activProsVerAnali, id_amenaza, '', '1');

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

DROP PROCEDURE IF EXISTS `insert_objversanali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_objversanali` (IN `id_versionAnali` INT, IN `nombreObj` VARCHAR(100))   BEGIN

INSERT INTO `objversanali`(`id_versionAnali`, `nombreObj`, `estade`) VALUES ( id_versionAnali, nombreObj, 1);

END$$

DROP PROCEDURE IF EXISTS `insert_proceempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_proceempresa` (IN `nombreProce` VARCHAR(100), IN `descripccion` VARCHAR(300), IN `id_gerarProc` INT, IN `id_tipProce` INT, IN `isDepProcPadre` INT, IN `id_DepentProc` INT, IN `id_empresa` INT)   BEGIN

INSERT INTO `proceempresa`(`nombreProce`, `descripccion`, `id_gerarProc`, `id_tipProce`, `isDepProcPadre`, `id_DepentProc`, `id_empresa`, `estade`) VALUES (nombreProce, descripccion, id_gerarProc, id_tipProce, isDepProcPadre, id_DepentProc, id_empresa, 1);

END$$

DROP PROCEDURE IF EXISTS `insert_responanalis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_responanalis` (IN `id_versionAnali` INT, IN `id_cliente` INT, IN `id_rolRespon` INT)   BEGIN

INSERT INTO `responanalis`(`id_versionAnali`, `id_cliente`, `id_rolRespon`, `estade`) VALUES (id_versionAnali, id_cliente, id_rolRespon, 1);

END$$

DROP PROCEDURE IF EXISTS `insert_resposproce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_resposproce` (IN `id_trabajador` INT, IN `id_proceso` INT)   BEGIN

INSERT INTO `resposproce`(`id_trabajador`, `id_proceso`, `estade`, `fechaEnlace`) VALUES (id_trabajador, id_proceso, 1, NOW());

END$$

DROP PROCEDURE IF EXISTS `insert_trabajempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_trabajempresa` (IN `nombre` VARCHAR(100), IN `cargo` VARCHAR(100), IN `descripc` VARCHAR(300), IN `telefono` VARCHAR(20), IN `correo` VARCHAR(100), IN `codTrabajo` VARCHAR(20), IN `id_empresa` INT)   BEGIN

INSERT INTO `trabajempresa`(`nombre_apellido`, `cargo`, `descripc`, `telefono`, `correo`, `codTrabajo`, `estade`, `id_empresa`) VALUES (nombre, cargo, descripc, telefono, correo, codTrabajo, 1, id_empresa);

END$$

DROP PROCEDURE IF EXISTS `insert_valoractiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_valoractiv` (IN `id_activProsVerAnali` INT, IN `valorActivCuanti` INT)   BEGIN

INSERT INTO `valoractiv`(`id_activProsVerAnali`, `valorActivCuanti`, `promValorCuanti`, `nunValorDimen`, `fechaValorizacion`, `estade`) VALUES (id_activProsVerAnali, valorActivCuanti, 0, 0, now(), 1);

END$$

DROP PROCEDURE IF EXISTS `insert_valorafectamen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_valorafectamen` (IN `id_afectaActiv` INT, IN `id_escalaFrecuen` INT)   BEGIN

INSERT INTO `valorafectamen`(`id_afectaActiv`, `id_escalaFrecuen`, `promEscalDregad`, `impactCuanti`, `riesgoCuanti`, `numValDim`, `estade`) VALUES (id_afectaActiv, id_escalaFrecuen, 0, 0, 0, 0, 1);

END$$

DROP PROCEDURE IF EXISTS `insert_valorAfectAmenDim`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_valorAfectAmenDim` (IN `id_valorAfectAmen` INT, IN `id_dimension` INT, IN `id_escalDegrad` INT, IN `valorDegrad` INT)   BEGIN

DECLARE countValDimension int(11);
DECLARE id_valorActiDimen int(11);

# SE VERIFICA SI EL USUARIO YA ISO UNA VALORIZACION DE LAS AMENAZAS
SET countValDimension = (SELECT COUNT(*) FROM valafectamendimen valrdim WHERE valrdim.estade = 1 AND valrdim.id_dimension = id_dimension AND valrdim.id_valorAfectAmen = id_valorAfectAmen ORDER BY valrdim.id_valAfectAmenDimen DESC LIMIT 1);

# SI NO SE REALIZO UNA VALORIZACION DEL ACTIVO
IF countValDimension = 0 THEN

INSERT INTO `valafectamendimen`(`id_valorAfectAmen`, `id_dimension`, `id_escalDegrad`, `valorDegrad`, `id_escaleImpac`, `valorImpacto`, `id_escalRiesgo`, `valNivelRiesgo`, `estade`) VALUES (id_valorAfectAmen, id_dimension, id_escalDegrad, valorDegrad, 0, 0, 0, 0, 1);

# SI SE REALIZO UNA VALORIZACION DEL ACTIVO
ELSE
# CAPTURAR EL ID DE LAS DIMENSIONES 
SET id_valorActiDimen = (SELECT valrdim.id_valAfectAmenDimen FROM valafectamendimen valrdim WHERE valrdim.estade = 1 AND valrdim.id_dimension = id_dimension AND valrdim.id_valorAfectAmen = id_valorAfectAmen ORDER BY valrdim.id_valAfectAmenDimen DESC LIMIT 1);

UPDATE valafectamendimen valAfectDim SET valAfectDim.id_escalDegrad = id_escalDegrad, valAfectDim.valorDegrad = valorDegrad WHERE valAfectDim.id_valAfectAmenDimen =  id_valorActiDimen;

END IF;

END$$

DROP PROCEDURE IF EXISTS `insert_valoriActivDimen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_valoriActivDimen` (IN `id_valorActiv` INT, IN `id_dimension` INT, IN `valorAcivCualit` INT, IN `id_varlotActivCualit` INT, IN `tipValoActivDimen` VARCHAR(5), IN `id_nivelCritec` INT)   BEGIN

DECLARE countValDimension int(11);
DECLARE id_valorActiDimen int(11);

# SE VERIFICA SI EL USUARIO YA ISO UNA VALORIZACION DE LAS AMENAZAS
SET countValDimension = (SELECT COUNT(*) FROM valoractivdimen valrdim WHERE valrdim.estade = 1 AND valrdim.id_dimension = id_dimension AND valrdim.id_valorActiv = id_valorActiv ORDER BY valrdim.id_valorActiDimen DESC LIMIT 1);

# SI NO SE REALIZO UNA VALORIZACION DEL ACTIVO
IF countValDimension = 0 THEN

INSERT INTO `valoractivdimen`(`id_valorActiv`, `id_dimension`, `valorAcivCualit`, `id_varlotActivCualit`, `tipValoActivDimen`, `estade`, `id_nivelCritec`) VALUES (id_valorActiv, id_dimension, valorAcivCualit, id_varlotActivCualit, tipValoActivDimen, 1, id_nivelCritec);

# SI SE REALIZO UNA VALORIZACION DEL ACTIVO
ELSE
# CAPTURAR EL ID DE LAS DIMENSIONES 
SET id_valorActiDimen = (SELECT valrdim.id_valorActiDimen FROM valoractivdimen valrdim WHERE valrdim.estade = 1 AND valrdim.id_dimension = id_dimension AND valrdim.id_valorActiv = id_valorActiv ORDER BY valrdim.id_valorActiDimen DESC LIMIT 1);

UPDATE valoractivdimen valdim SET  valdim.valorAcivCualit = valorAcivCualit, valdim.id_varlotActivCualit = id_varlotActivCualit, valdim.tipValoActivDimen = tipValoActivDimen, valdim.id_nivelCritec = id_nivelCritec WHERE valdim.id_valorActiDimen = id_valorActiDimen ;

END IF;

END$$

DROP PROCEDURE IF EXISTS `insert_versionanali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_versionanali` (IN `id_proceso` INT)   BEGIN

DECLARE cantVersion int(11);
DECLARE id_version  int(11);
DECLARE idproceses int(11);
DECLARE idescalaRPO int(11);
DECLARE idescalaRTO int(11);

# INSERTAR UNA VERSION DE ANALISIS DE UN PROCESO
SET cantVersion = (SELECT COUNT(*) FROM versionanali veranl WHERE veranl.estade = 1 AND veranl.id_proceso = id_proceso) + 1 ;
INSERT INTO `versionanali`(`id_proceso`, `abreb`, `fechaVersionAnali`, `estade`) VALUES (id_proceso, CONCAT('V', cantVersion), now(), 1);

# INSERTAR LOS ACTIVOS QUE SE VAN A ANALIZAR
SET id_version = (SELECT veranl.id_versionAnali FROM versionanali veranl WHERE veranl.estade = 1 AND veranl.id_proceso = id_proceso ORDER BY veranl.id_versionAnali DESC LIMIT 1);
INSERT INTO `activprosveranali`(`id_versonAnali`, `id_activProc`, `estade`) SELECT id_version, act.id_activproc, 1 FROM activproces act WHERE act.id_proceso = id_proceso AND act.estade = 1 ;
INSERT INTO `valoractiv`(`id_activProsVerAnali`, `valorActivCuanti`, `promValorCuanti`, `nunValorDimen`, `fechaValorizacion`, `estade`) SELECT actvpro.id_activProsVerAnali, 0, 0,0, now(), 1 FROM activprosveranali actvpro WHERE actvpro.estade = 1 AND actvpro.id_versonAnali = id_version ;

# INSERTAR LA VALORIZACION GENERICA DE UN PROCESO
SET idproceses = (SELECT procem.id_proceso FROM proceempresa procem WHERE procem.estade = 1 ORDER BY procem.id_proceso DESC LIMIT 1);
SET idescalaRPO = (SELECT escrpo.id_escalaRPO FROM escalarpo escrpo WHERE escrpo.estade = 1 ORDER BY escrpo.id_escalaRPO DESC LIMIT 1);
SET idescalaRTO = (SELECT escrto.id_escalaRTO FROM escalarto escrto WHERE escrto.estade = 1 ORDER BY escrto.id_escalaRTO DESC LIMIT 1);
INSERT INTO `valorproces`(`id_versionAnali`, `id_escalaRTO`, `id_escalaRPO`, `valorMDT`, `estade`) VALUES (id_version, idescalaRPO, idescalaRTO, 0, 1);

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

DROP PROCEDURE IF EXISTS `list_activprosveranali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_activprosveranali` (IN `id_versonAnali` INT)   BEGIN

SELECT actanal.id_activProsVerAnali, actanal.id_activProc, actv.nombre_Activo, actv.id_tipoActiv, tipac.dependAbreb 
FROM activprosveranali actanal 
INNER JOIN activproces actpro ON actpro.id_activproc = actanal.id_activProc 
INNER JOIN activos actv ON actv.id_activo = actpro.id_activo 
INNER JOIN tipoactivo tipac ON tipac.id_tipoActivo = actv.id_tipoActiv 
WHERE actanal.estade = 1 
AND actanal.id_versonAnali = id_versonAnali ;

END$$

DROP PROCEDURE IF EXISTS `list_afectaactiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_afectaactiv` (IN `id_activProsVerAnali` INT)   BEGIN

SELECT afact.id_afectaActiv, afact.id_activProsVerAnali, afact.id_amenaza, afact.esenario, am.abreb, am.nombreAmena, am.id_tipoActiv, tipam.abreb, tipam.nombreTipoActiv 
FROM afectaactiv afact 
INNER JOIN amenazas am ON am.id_amenaza = afact.id_amenaza 
INNER JOIN tipoamen tipam ON tipam.id_tipoActiv = am.id_tipoActiv 
WHERE afact.estade = 1 
AND afact.id_activProsVerAnali = id_activProsVerAnali ;

END$$

DROP PROCEDURE IF EXISTS `list_afectaDimem`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_afectaDimem` ()   BEGIN

SELECT afecdi.id_afectDimen, afecdi.id_amenaza, afecdi.id_dimension, dimal.abreb
FROM afectadimen afecdi 
INNER JOIN dimensionanalisis dimal ON dimal.id_dimension = afecdi.id_dimension 
WHERE afecdi.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_afectaTip`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_afectaTip` (IN `id_libreryAmen` INT)   BEGIN

SELECT afectip.id_amenazas, afectip.id_libreryAmen, libm.nombreLibreyAmen, afectip.id_tipoActivo, tipac.dependAbreb
FROM afectatip afectip 
INNER JOIN libreyamen libm ON libm.id_libreryAmen = afectip.id_libreryAmen 
INNER JOIN tipoactivo tipac ON tipac.id_tipoActivo = afectip.id_tipoActivo 
WHERE afectip.estade = 1 
AND afectip.id_libreryAmen = id_libreryAmen ;

END$$

DROP PROCEDURE IF EXISTS `list_amenas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_amenas` (IN `id_tipoActiv` INT)   BEGIN

IF id_tipoActiv = 0 THEN

SELECT * FROM amenazas amen WHERE amen.estade = 1 ;

ELSE

SELECT * FROM amenazas amen WHERE amen.estade = 1 AND amen.id_tipoActiv = id_tipoActiv ;

END IF;

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

DROP PROCEDURE IF EXISTS `list_clienAnalit`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_clienAnalit` ()   SELECT  us.id_usuario, us.usaio, us.pass, us.tip_user, clan.id_cliente, clan.nombre, clan.apellidos, clan.telefono, clan.correo, clan.photo
FROM usuarios us 
INNER JOIN clientanali clan ON clan.id_cliente = us.id_inform
WHERE us.tip_user = 'C'
AND us.estade = 1$$

DROP PROCEDURE IF EXISTS `list_criteriosValori`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_criteriosValori` ()   BEGIN

SELECT * FROM criteriosvalor crival WHERE crival.estade = 1 ;

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

DROP PROCEDURE IF EXISTS `list_dimensionanalisis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_dimensionanalisis` ()   BEGIN

SELECT * FROM dimensionanalisis dimanal WHERE dimanal.estade = 1;

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

DROP PROCEDURE IF EXISTS `list_escaladegrad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_escaladegrad` ()   BEGIN

SELECT * FROM escaladegrad escdes WHERE escdes.estade = 1 ; 

END$$

DROP PROCEDURE IF EXISTS `list_escalafrecuencia`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_escalafrecuencia` ()   BEGIN

SELECT * FROM escalafrecuencia escfreg WHERE escfreg.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_escalaimpacto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_escalaimpacto` ()   BEGIN

SELECT * FROM escalaimpacto esim WHERE esim.estade = 1 ; 

END$$

DROP PROCEDURE IF EXISTS `list_escalariesgo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_escalariesgo` ()   BEGIN

SELECT * FROM escalariesgo escRies WHERE escRies.estade = 1 ;

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

DROP PROCEDURE IF EXISTS `list_nivelvalor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_nivelvalor` ()   BEGIN

SELECT * FROM nivelvalor nilval WHERE nilval.estade = 1;

END$$

DROP PROCEDURE IF EXISTS `list_objempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_objempresa` (IN `id_empresa` INT)   BEGIN

SELECT * FROM objempresa objem WHERE objem.id_empresa = id_empresa AND objem.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_objversanali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_objversanali` (IN `id_versionAnali` INT)   BEGIN

SELECT * FROM objversanali objal WHERE objal.estade = 1 AND objal.id_versionAnali = id_versionAnali ;

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

DROP PROCEDURE IF EXISTS `list_responanalis`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_responanalis` (IN `id_versionAnali` INT)   BEGIN

SELECT respan.id_responAnalis, respan.id_cliente, CONCAT(clian.nombre,' ',clian.apellidos) AS nombre, clian.photo, respan.id_rolRespon, rolre.nombreRolRespon
FROM responanalis respan 
INNER JOIN clientanali clian ON clian.id_cliente = respan.id_cliente 
INNER JOIN rolrespon rolre ON rolre.id_rolRespon = respan.id_rolRespon 
WHERE respan.estade = 1 
AND respan.id_versionAnali = id_versionAnali ;

END$$

DROP PROCEDURE IF EXISTS `list_resposproce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_resposproce` (IN `id_proceso` INT)   BEGIN

SELECT respro.id_resposProce, trabem.Id_trabajador, trabem.nombre_apellido, trabem.cargo, trabem.descripc 
FROM resposproce respro 
INNER JOIN trabajempresa trabem ON trabem.Id_trabajador = respro.id_trabajador 
WHERE respro.id_proceso = id_proceso 
AND respro.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_rolrespon`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_rolrespon` ()   BEGIN

SELECT * FROM rolrespon rolre WHERE rolre.estade = 1;

END$$

DROP PROCEDURE IF EXISTS `list_tipoActiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tipoActiv` (IN `codeAbre` INT(11))   BEGIN

IF codeAbre = 0 THEN
SELECT * FROM tipoactivo tipact WHERE tipact.estade = 1 ;
ELSE
SELECT * FROM tipoactivo tipact WHERE tipact.estade = 1 AND  tipact.id_dependeTipoPad = codeAbre;
END IF;

END$$

DROP PROCEDURE IF EXISTS `list_tipoAmenasa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tipoAmenasa` ()   BEGIN

SELECT * FROM tipoamen tipam WHERE tipam.estade = 1 ; 

END$$

DROP PROCEDURE IF EXISTS `list_tipocritervalor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tipocritervalor` ()   BEGIN

SELECT * FROM tipocritervalor tipval WHERE tipval.estade = 1;

END$$

DROP PROCEDURE IF EXISTS `list_tipProce`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tipProce` ()   BEGIN

SELECT * FROM tipproce tipro WHERE tipro.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_trabajempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_trabajempresa` (IN `id_empresa` INT)   BEGIN

SELECT * FROM trabajempresa trbem WHERE trbem.estade = 1 AND trbem.id_empresa = id_empresa ;

END$$

DROP PROCEDURE IF EXISTS `list_valAfectAmenDimen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_valAfectAmenDimen` (IN `id_valorAfectAmen` INT)   BEGIN

SELECT * FROM valafectamendimen valafamdim WHERE valafamdim.estade = 1 AND valafamdim.id_valorAfectAmen = id_valorAfectAmen ;

END$$

DROP PROCEDURE IF EXISTS `list_valoractiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_valoractiv` (IN `id_activProsVerAnali` INT)   BEGIN

SELECT * FROM valoractiv valact WHERE valact.estade = 1 AND valact.id_activProsVerAnali = id_activProsVerAnali ;

END$$

DROP PROCEDURE IF EXISTS `list_valorafectamen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_valorafectamen` (IN `id_afectaActiv` INT)   BEGIN

SELECT * FROM valorafectamen valafamen WHERE valafamen.estade = 1 AND valafamen.id_afectaActiv = id_afectaActiv ;

END$$

DROP PROCEDURE IF EXISTS `list_valoriActivDimen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_valoriActivDimen` (IN `id_valorActiv` INT)   BEGIN

SELECT valdim.id_valorActiDimen, valdim.id_dimension, valdim.valorAcivCualit, valdim.id_varlotActivCualit, valdim.tipValoActivDimen FROM valoractivdimen valdim WHERE valdim.id_valorActiv = id_valorActiv AND valdim.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `list_versionanali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `list_versionanali` (IN `id_proceso` INT)   BEGIN

SELECT veranl.id_versionAnali, veranl.abreb, veranl.fechaVersionAnali FROM versionanali veranl WHERE veranl.id_proceso = id_proceso AND veranl.estade = 1 ;

END$$

DROP PROCEDURE IF EXISTS `loadProm_valoractiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `loadProm_valoractiv` (IN `id_valorActiv` INT)   BEGIN

DECLARE promValor int(11);
DECLARE countVal int(11);
SET promValor = (SELECT AVG(valdim.valorAcivCualit) FROM valoractivdimen valdim WHERE valdim.estade = 1 AND valdim.id_valorActiv = id_valorActiv) ;
SET countVal = (SELECT COUNT(*) FROM valoractivdimen valdim WHERE valdim.estade = 1 AND valdim.id_valorActiv = id_valorActiv) ;

UPDATE valoractiv val SET val.promValorCuanti = promValor, val.nunValorDimen = countVal WHERE val.id_valorActiv = id_valorActiv ;

END$$

DROP PROCEDURE IF EXISTS `loadProm_valorAfectAmen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `loadProm_valorAfectAmen` (IN `id_valorAfectAmen` INT)   BEGIN

DECLARE promEscalDregad int(11);
DECLARE impacto int(11);
DECLARE riesgo int(11);
DECLARE frecuenDegr double;
DECLARE valActivo int(11);
DECLARE countDimen int(11);

SET countDimen = (SELECT count(*) FROM valafectamendimen valafdim WHERE valafdim.id_valorAfectAmen = id_valorAfectAmen AND valafdim.estade = 1);
SET promEscalDregad = (SELECT MAX(valafdim.valorDegrad) FROM valafectamendimen valafdim WHERE valafdim.id_valorAfectAmen = id_valorAfectAmen AND valafdim.estade = 1);
SET frecuenDegr = (SELECT escfre.valFrecuncia
                   FROM  valorafectamen valafame  
                   INNER JOIN escalafrecuencia escfre ON escfre.id_escalaFrecuenc = valafame.id_escalaFrecuen
                   WHERE valafame.estade = 1
                   AND valafame.id_valorAfectAmen = id_valorAfectAmen
                  );
SET valActivo = (SELECT valact.valorActivCuanti 
                 FROM valoractiv valact 
                 INNER JOIN afectaactiv afecamen ON afecamen.id_activProsVerAnali = valact.id_activProsVerAnali 
                 INNER JOIN valorafectamen valoaf ON valoaf.id_afectaActiv = afecamen.id_afectaActiv 
                 WHERE valact.estade = 1 
                 AND valoaf.id_valorAfectAmen = id_valorAfectAmen 
                 LIMIT 1 
                );
SET impacto = (valActivo * promEscalDregad) ; 
SET riesgo = (impacto * frecuenDegr) ; 

UPDATE valorafectamen valafam SET valafam.promEscalDregad = promEscalDregad, valafam.impactCuanti = impacto, valafam.riesgoCuanti = riesgo , valafam.numValDim = countDimen WHERE valafam.id_valorAfectAmen = id_valorAfectAmen ;

END$$

DROP PROCEDURE IF EXISTS `loadProm_valorAfectAmenDim`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `loadProm_valorAfectAmenDim` (IN `id_valAfectAmenDimen` INT, IN `id_escaleImpac` INT, IN `valorImpacto` INT, IN `id_escalRiesgo` INT, IN `valNivelRiesgo` INT)   BEGIN

UPDATE valafectamendimen valamdim SET valamdim.id_escaleImpac = id_escaleImpac, valamdim.valorImpacto = valorImpacto, valamdim.id_escalRiesgo = id_escalRiesgo, valamdim.valNivelRiesgo = valNivelRiesgo WHERE valamdim.id_valAfectAmenDimen = id_valAfectAmenDimen ;

END$$

DROP PROCEDURE IF EXISTS `read_activprosveranali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_activprosveranali` (IN `id_activProsVerAnali` INT)   BEGIN

SELECT actanal.id_activProsVerAnali, actanal.id_activProc, actv.nombre_Activo, actv.id_tipoActiv, tipac.dependAbreb 
FROM activprosveranali actanal 
INNER JOIN activproces actpro ON actpro.id_activproc = actanal.id_activProc 
INNER JOIN activos actv ON actv.id_activo = actpro.id_activo 
INNER JOIN tipoactivo tipac ON tipac.id_tipoActivo = actv.id_tipoActiv 
WHERE actanal.estade = 1 
AND actanal.id_activProsVerAnali = id_activProsVerAnali ;

END$$

DROP PROCEDURE IF EXISTS `read_afectaactiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_afectaactiv` (IN `id_afectaActiv` INT)   BEGIN

SELECT afact.id_afectaActiv, afact.id_activProsVerAnali, afact.id_amenaza, am.abreb, am.nombreAmena, am.id_tipoActiv, tipam.abreb, tipam.nombreTipoActiv 
FROM afectaactiv afact 
INNER JOIN amenazas am ON am.id_amenaza = afact.id_amenaza 
INNER JOIN tipoamen tipam ON tipam.id_tipoActiv = am.id_tipoActiv 
WHERE afact.estade = 1 
AND afact.id_afectaActiv = id_afectaActiv ;

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

DROP PROCEDURE IF EXISTS `read_valorafectamen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_valorafectamen` (IN `id_valorAfectAmen` INT)   BEGIN

SELECT * FROM valorafectamen valafamen WHERE valafamen.estade = 1 AND valafamen.id_valorAfectAmen = id_valorAfectAmen ;

END$$

DROP PROCEDURE IF EXISTS `read_valorproces`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_valorproces` (IN `id_versionAnali` INT)   BEGIN

SELECT valpro.id_valorProc, valpro.id_escalaRTO, valpro.id_escalaRPO, valpro.valorMDT 
FROM valorproces valpro 
WHERE valpro.estade = 1 
AND valpro.id_versionAnali = id_versionAnali 
ORDER BY valpro.id_valorProc 
DESC LIMIT 1 ;

END$$

DROP PROCEDURE IF EXISTS `update_acivos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_acivos` (IN `nombre_Activo` VARCHAR(100), IN `descrip` VARCHAR(300), IN `id_tipoActiv` INT, IN `id_activo` INT)   BEGIN

UPDATE activos act SET  act.nombre_Activo = nombre_Activo , act.descripc = descrip , act.id_tipoActiv = id_tipoActiv WHERE act.id_activo = id_activo ;

END$$

DROP PROCEDURE IF EXISTS `update_afectaativ`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_afectaativ` (IN `esenario` VARCHAR(400), IN `id_afectaActiv` INT)   BEGIN

UPDATE afectaactiv actactiv SET actactiv.esenario = esenario WHERE actactiv.id_afectaActiv = id_afectaActiv ;

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

DROP PROCEDURE IF EXISTS `update_objversanali`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_objversanali` (IN `nombreObj` VARCHAR(100), IN `id_objVersAnali` INT)   BEGIN

UPDATE objversanali objAnali SET objAnali.nombreObj = nombreObj WHERE objAnali.id_objVersAnali = id_objVersAnali;

END$$

DROP PROCEDURE IF EXISTS `update_proceempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_proceempresa` (IN `nombreProce` VARCHAR(100), IN `descripccion` VARCHAR(300), IN `id_gerarProc` INT, IN `id_tipProce` INT, IN `isDepProcPadre` INT, IN `id_DepentProc` INT, IN `id_proceso` INT)   BEGIN

UPDATE proceempresa proem SET proem.nombreProce = nombreProce , proem.descripccion = descripccion, proem.id_gerarProc = id_gerarProc , proem.id_tipProce = id_tipProce , proem.isDepProcPadre = isDepProcPadre, proem.id_DepentProc = id_DepentProc WHERE proem.id_proceso = id_proceso ;

END$$

DROP PROCEDURE IF EXISTS `update_trabajempresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_trabajempresa` (IN `nombre` VARCHAR(100), IN `cargo` VARCHAR(100), IN `descripc` VARCHAR(300), IN `telefono` VARCHAR(20), IN `correo` VARCHAR(100), IN `codTrabajo` VARCHAR(20), IN `Id_trabajador` INT)   BEGIN

UPDATE trabajempresa tbrem SET tbrem.nombre_apellido = nombre, tbrem.cargo = cargo, tbrem.descripc= descripc, tbrem.telefono = telefono, tbrem.correo = correo, tbrem.codTrabajo = codTrabajo WHERE tbrem.Id_trabajador = Id_trabajador ;

END$$

DROP PROCEDURE IF EXISTS `update_valoractiv`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_valoractiv` (IN `id_valorActiv` INT, IN `valorActivCuanti` INT)   BEGIN

UPDATE valoractiv valact SET valact.valorActivCuanti = valorActivCuanti WHERE valact.id_valorActiv = id_valorActiv ;

END$$

DROP PROCEDURE IF EXISTS `update_valorafectamen`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_valorafectamen` (IN `id_afectaActiv` INT, IN `id_escalaFrecuen` INT)   BEGIN

UPDATE valorafectamen valafame SET valafame.id_escalaFrecuen = id_escalaFrecuen WHERE valafame.id_afectaActiv = id_afectaActiv ;

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
(6, 1, 'Navegador web Chrome', 'Sistema que nos permite poder acceder al sistema E-learning y otros servicios web.', 229, 0),
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
(1, 4, 4, 0),
(2, 4, 6, 1),
(3, 6, 4, 1),
(4, 6, 6, 1),
(5, 6, 7, 1),
(6, 6, 8, 1),
(7, 6, 9, 1),
(8, 6, 10, 1),
(9, 6, 11, 1),
(10, 6, 12, 1),
(11, 4, 7, 0),
(12, 4, 7, 0),
(13, 4, 7, 0),
(14, 4, 7, 1),
(15, 4, 8, 1),
(16, 7, 4, 0),
(17, 7, 6, 1),
(18, 7, 7, 1),
(19, 7, 8, 1),
(20, 7, 9, 1),
(21, 7, 10, 1),
(22, 7, 11, 1),
(23, 7, 12, 1),
(31, 8, 4, 0),
(32, 8, 6, 1),
(33, 8, 7, 1),
(34, 8, 8, 1),
(35, 8, 9, 1),
(36, 8, 10, 1),
(37, 8, 11, 1),
(38, 8, 12, 1),
(39, 9, 4, 0),
(40, 9, 6, 1),
(41, 9, 7, 1),
(42, 9, 8, 1),
(43, 9, 9, 1),
(44, 9, 10, 1),
(45, 9, 11, 1),
(46, 9, 12, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `afectaactiv`
--

DROP TABLE IF EXISTS `afectaactiv`;
CREATE TABLE `afectaactiv` (
  `id_afectaActiv` int(11) NOT NULL,
  `id_activProsVerAnali` int(11) NOT NULL,
  `id_amenaza` int(11) NOT NULL,
  `esenario` varchar(300) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `afectaactiv`
--

INSERT INTO `afectaactiv` VALUES
(4, 4, 32, '', 1),
(5, 4, 38, '', 1),
(6, 4, 52, '', 1),
(7, 4, 1, '', 0),
(8, 4, 1, 'No se en que suceso se puede dar', 1),
(9, 22, 9, '', 1),
(10, 22, 21, '', 1),
(11, 22, 28, '', 1),
(12, 22, 29, '', 1),
(13, 22, 39, '', 1),
(14, 22, 49, '', 1),
(15, 22, 38, '', 1),
(16, 37, 9, '', 1),
(17, 37, 21, '', 1),
(18, 37, 28, '', 1),
(19, 37, 29, '', 1),
(20, 37, 39, 'Cuando a el navegador web le injectan un virus por descargar archivos maliciososos.', 1),
(21, 37, 49, '', 1),
(22, 37, 38, '', 1),
(23, 37, 12, '', 0),
(24, 37, 51, '', 0),
(25, 34, 25, '', 0),
(26, 34, 26, '', 0),
(27, 34, 27, '', 0),
(28, 34, 46, '', 0),
(29, 34, 47, '', 0),
(30, 34, 48, '', 0),
(31, 34, 55, '', 0),
(32, 34, 56, '', 0),
(33, 34, 57, '', 0),
(34, 34, 20, '', 1),
(35, 34, 27, '', 1),
(36, 34, 33, '', 1),
(37, 34, 55, '', 0),
(38, 34, 56, '', 1),
(39, 34, 57, '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `afectadimen`
--

DROP TABLE IF EXISTS `afectadimen`;
CREATE TABLE `afectadimen` (
  `id_afectDimen` int(11) NOT NULL,
  `id_dimension` int(11) NOT NULL,
  `id_amenaza` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `afectadimen`
--

INSERT INTO `afectadimen` VALUES
(1, 1, 1, 1),
(2, 1, 2, 1),
(3, 1, 3, 1),
(4, 1, 4, 1),
(5, 1, 5, 1),
(6, 1, 6, 1),
(7, 1, 7, 1),
(8, 1, 8, 1),
(9, 1, 9, 1),
(10, 1, 10, 1),
(11, 1, 11, 1),
(12, 1, 12, 1),
(13, 1, 13, 1),
(14, 1, 14, 1),
(15, 3, 15, 1),
(16, 1, 16, 1),
(17, 2, 16, 1),
(18, 3, 16, 1),
(19, 1, 17, 1),
(20, 2, 17, 1),
(21, 3, 17, 1),
(22, 2, 18, 1),
(23, 5, 18, 1),
(24, 2, 19, 1),
(25, 1, 20, 1),
(26, 1, 21, 1),
(27, 2, 21, 1),
(28, 3, 21, 1),
(29, 3, 22, 1),
(30, 2, 23, 1),
(31, 3, 24, 1),
(32, 2, 25, 1),
(33, 1, 26, 1),
(34, 3, 27, 1),
(35, 2, 28, 1),
(36, 1, 28, 1),
(37, 3, 28, 1),
(38, 2, 29, 1),
(39, 1, 29, 1),
(40, 1, 30, 1),
(41, 1, 31, 1),
(42, 1, 32, 1),
(43, 3, 32, 1),
(44, 1, 33, 1),
(45, 2, 34, 1),
(46, 5, 34, 1),
(47, 2, 35, 1),
(48, 3, 35, 1),
(49, 1, 35, 1),
(50, 3, 36, 1),
(51, 4, 36, 1),
(52, 2, 36, 1),
(53, 3, 37, 1),
(54, 2, 37, 1),
(55, 1, 37, 1),
(56, 1, 38, 1),
(57, 3, 38, 1),
(58, 2, 38, 1),
(59, 1, 39, 1),
(60, 2, 39, 1),
(61, 3, 39, 1),
(62, 3, 40, 1),
(63, 2, 41, 1),
(64, 3, 42, 1),
(65, 2, 42, 1),
(66, 3, 43, 1),
(67, 2, 44, 1),
(68, 5, 44, 1),
(69, 3, 45, 1),
(70, 2, 46, 1),
(71, 1, 47, 1),
(72, 3, 48, 1),
(73, 3, 49, 1),
(74, 2, 49, 1),
(75, 1, 49, 1),
(76, 3, 50, 1),
(77, 1, 50, 1),
(78, 1, 51, 1),
(79, 1, 52, 1),
(80, 3, 52, 1),
(81, 1, 53, 1),
(82, 1, 54, 1),
(83, 3, 54, 1),
(84, 1, 55, 1),
(85, 3, 56, 1),
(86, 2, 56, 1),
(87, 1, 56, 1),
(88, 3, 57, 1),
(89, 2, 57, 1),
(90, 1, 57, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `afectatip`
--

DROP TABLE IF EXISTS `afectatip`;
CREATE TABLE `afectatip` (
  `id_adectTip` int(11) NOT NULL,
  `id_amenazas` int(11) NOT NULL,
  `id_libreryAmen` int(11) NOT NULL,
  `id_tipoActivo` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `afectatip`
--

INSERT INTO `afectatip` VALUES
(1, 1, 1, 258, 1),
(2, 1, 1, 323, 1),
(3, 1, 1, 344, 1),
(4, 1, 1, 360, 1),
(5, 2, 1, 258, 1),
(6, 2, 1, 323, 1),
(7, 2, 1, 344, 1),
(8, 2, 1, 360, 1),
(9, 3, 1, 258, 1),
(10, 3, 1, 323, 1),
(11, 3, 1, 344, 1),
(12, 3, 1, 360, 1),
(13, 4, 1, 258, 1),
(14, 4, 1, 323, 1),
(15, 4, 1, 344, 1),
(16, 4, 1, 360, 1),
(17, 5, 1, 258, 1),
(18, 5, 1, 323, 1),
(19, 5, 1, 344, 1),
(20, 5, 1, 360, 1),
(21, 6, 1, 258, 1),
(22, 6, 1, 323, 1),
(23, 6, 1, 344, 1),
(24, 6, 1, 360, 1),
(25, 7, 1, 258, 1),
(26, 7, 1, 323, 1),
(27, 7, 1, 344, 1),
(28, 8, 1, 258, 1),
(29, 8, 1, 323, 1),
(30, 8, 1, 344, 1),
(31, 9, 1, 225, 1),
(32, 9, 1, 258, 1),
(33, 9, 1, 323, 1),
(34, 9, 1, 344, 1),
(35, 10, 1, 258, 1),
(36, 10, 1, 323, 1),
(37, 10, 1, 344, 1),
(38, 11, 1, 258, 1),
(39, 11, 1, 323, 1),
(40, 11, 1, 344, 1),
(41, 12, 1, 305, 1),
(42, 13, 1, 344, 1),
(43, 14, 1, 323, 1),
(44, 15, 1, 258, 1),
(45, 15, 1, 323, 1),
(46, 15, 1, 344, 1),
(47, 15, 1, 360, 1),
(48, 16, 1, 110, 1),
(49, 16, 1, 129, 1),
(50, 16, 1, 146, 1),
(51, 16, 1, 225, 1),
(52, 16, 1, 323, 1),
(53, 17, 1, 110, 1),
(54, 17, 1, 129, 1),
(55, 17, 1, 146, 1),
(56, 17, 1, 225, 1),
(57, 17, 1, 258, 1),
(58, 17, 1, 305, 1),
(59, 17, 1, 323, 1),
(60, 18, 1, 122, 1),
(61, 19, 1, 117, 1),
(62, 20, 1, 373, 1),
(63, 21, 1, 225, 1),
(64, 22, 1, 146, 1),
(65, 22, 1, 225, 1),
(66, 22, 1, 305, 1),
(67, 23, 1, 146, 1),
(68, 23, 1, 225, 1),
(69, 23, 1, 305, 1),
(70, 25, 1, 110, 1),
(71, 25, 1, 129, 1),
(72, 25, 1, 146, 1),
(73, 25, 1, 225, 1),
(74, 25, 1, 305, 1),
(75, 25, 1, 323, 1),
(76, 25, 1, 360, 1),
(77, 26, 1, 110, 1),
(78, 26, 1, 129, 1),
(79, 26, 1, 146, 1),
(80, 26, 1, 225, 1),
(81, 26, 1, 305, 1),
(82, 26, 1, 323, 1),
(83, 26, 1, 360, 1),
(84, 27, 1, 110, 1),
(85, 27, 1, 129, 1),
(86, 27, 1, 146, 1),
(87, 27, 1, 225, 1),
(88, 27, 1, 305, 1),
(89, 27, 1, 323, 1),
(90, 27, 1, 360, 1),
(91, 27, 1, 373, 1),
(92, 28, 1, 225, 1),
(93, 29, 1, 225, 1),
(94, 30, 1, 258, 1),
(95, 30, 1, 323, 1),
(96, 30, 1, 344, 1),
(97, 31, 1, 146, 1),
(98, 31, 1, 258, 1),
(99, 31, 1, 305, 1),
(100, 32, 1, 258, 1),
(101, 32, 1, 323, 1),
(102, 32, 1, 344, 1),
(103, 33, 1, 373, 1),
(104, 34, 1, 122, 1),
(105, 35, 1, 122, 1),
(106, 36, 1, 110, 1),
(107, 36, 1, 129, 1),
(108, 36, 1, 146, 1),
(109, 36, 1, 225, 1),
(110, 36, 1, 305, 1),
(111, 37, 1, 110, 1),
(112, 37, 1, 129, 1),
(113, 37, 1, 146, 1),
(114, 37, 1, 225, 1),
(115, 37, 1, 258, 1),
(116, 37, 1, 305, 1),
(117, 38, 1, 146, 1),
(118, 38, 1, 225, 1),
(119, 38, 1, 258, 1),
(120, 38, 1, 305, 1),
(121, 38, 1, 323, 1),
(122, 38, 1, 344, 1),
(123, 38, 1, 360, 1),
(124, 39, 1, 225, 1),
(125, 40, 1, 146, 1),
(126, 40, 1, 225, 1),
(127, 40, 1, 305, 1),
(128, 41, 1, 146, 1),
(129, 41, 1, 225, 1),
(130, 41, 1, 305, 1),
(131, 42, 1, 110, 1),
(132, 42, 1, 129, 1),
(133, 42, 1, 146, 1),
(134, 42, 1, 225, 1),
(135, 42, 1, 258, 1),
(136, 42, 1, 305, 1),
(137, 42, 1, 323, 1),
(138, 42, 1, 344, 1),
(139, 42, 1, 360, 1),
(140, 43, 1, 305, 1),
(141, 44, 1, 146, 1),
(142, 44, 1, 122, 1),
(143, 45, 1, 305, 1),
(144, 46, 1, 110, 1),
(145, 46, 1, 129, 1),
(146, 46, 1, 146, 1),
(147, 46, 1, 225, 1),
(148, 46, 1, 305, 1),
(149, 46, 1, 323, 1),
(150, 46, 1, 360, 1),
(151, 47, 1, 110, 1),
(152, 47, 1, 129, 1),
(153, 47, 1, 146, 1),
(154, 47, 1, 225, 1),
(155, 47, 1, 323, 1),
(156, 47, 1, 360, 1),
(157, 48, 1, 110, 1),
(158, 48, 1, 129, 1),
(159, 48, 1, 146, 1),
(160, 48, 1, 225, 1),
(161, 48, 1, 305, 1),
(162, 48, 1, 323, 1),
(163, 48, 1, 360, 1),
(164, 49, 1, 225, 1),
(165, 50, 1, 258, 1),
(166, 50, 1, 323, 1),
(167, 50, 1, 344, 1),
(168, 51, 1, 146, 1),
(169, 51, 1, 258, 1),
(170, 51, 1, 305, 1),
(171, 52, 1, 258, 1),
(172, 52, 1, 323, 1),
(173, 52, 1, 344, 1),
(174, 53, 1, 258, 1),
(175, 53, 1, 323, 1),
(176, 53, 1, 344, 1),
(177, 53, 1, 360, 1),
(178, 54, 1, 360, 1),
(179, 55, 1, 373, 1),
(180, 56, 1, 373, 1),
(181, 57, 1, 373, 1),
(182, 25, 2, 110, 1),
(183, 26, 2, 110, 1),
(184, 27, 2, 110, 1),
(185, 36, 2, 110, 1),
(186, 37, 2, 110, 1),
(187, 42, 2, 110, 1),
(188, 25, 2, 117, 1),
(189, 27, 2, 117, 1),
(190, 19, 2, 117, 1),
(191, 37, 2, 117, 1),
(192, 42, 2, 117, 1),
(193, 35, 2, 117, 1),
(194, 27, 2, 122, 1),
(195, 18, 2, 122, 1),
(196, 34, 2, 122, 1),
(197, 25, 2, 129, 1),
(198, 26, 2, 129, 1),
(199, 27, 2, 129, 1),
(200, 36, 2, 129, 1),
(201, 37, 2, 129, 1),
(202, 42, 2, 129, 1),
(203, 16, 2, 151, 1),
(204, 17, 2, 151, 1),
(205, 25, 2, 151, 1),
(206, 26, 2, 151, 1),
(207, 27, 2, 151, 1),
(208, 31, 2, 151, 1),
(209, 36, 2, 151, 1),
(210, 37, 2, 151, 1),
(211, 38, 2, 151, 1),
(212, 42, 2, 151, 1),
(213, 44, 2, 151, 1),
(214, 46, 2, 151, 1),
(215, 47, 2, 151, 1),
(216, 48, 2, 151, 1),
(217, 51, 2, 151, 1),
(218, 13, 2, 186, 1),
(219, 25, 2, 186, 1),
(220, 26, 2, 186, 1),
(221, 27, 2, 186, 1),
(222, 36, 2, 186, 1),
(223, 44, 2, 186, 1),
(224, 46, 2, 186, 1),
(225, 47, 2, 186, 1),
(226, 48, 2, 186, 1),
(227, 51, 2, 186, 1),
(228, 12, 2, 187, 1),
(229, 13, 2, 187, 1),
(230, 12, 2, 188, 1),
(231, 13, 2, 188, 1),
(232, 9, 2, 225, 1),
(233, 21, 2, 225, 1),
(234, 28, 2, 225, 1),
(235, 29, 2, 225, 1),
(236, 39, 2, 225, 1),
(237, 49, 2, 225, 1),
(238, 1, 2, 258, 1),
(239, 2, 2, 258, 1),
(240, 3, 2, 258, 1),
(241, 4, 2, 258, 1),
(242, 5, 2, 258, 1),
(243, 6, 2, 258, 1),
(244, 7, 2, 258, 1),
(245, 8, 2, 258, 1),
(246, 9, 2, 258, 1),
(247, 10, 2, 258, 1),
(248, 11, 2, 258, 1),
(249, 15, 2, 258, 1),
(250, 17, 2, 258, 1),
(251, 30, 2, 258, 1),
(252, 31, 2, 258, 1),
(253, 32, 2, 258, 1),
(254, 37, 2, 258, 1),
(255, 38, 2, 258, 1),
(256, 42, 2, 258, 1),
(257, 50, 2, 258, 1),
(258, 51, 2, 258, 1),
(259, 52, 2, 258, 1),
(260, 53, 2, 258, 1),
(261, 32, 2, 259, 1),
(262, 38, 2, 259, 1),
(263, 52, 2, 259, 1),
(264, 32, 2, 260, 1),
(265, 38, 2, 260, 1),
(266, 52, 2, 260, 1),
(267, 32, 2, 261, 1),
(268, 38, 2, 261, 1),
(269, 52, 2, 261, 1),
(270, 32, 2, 262, 1),
(271, 38, 2, 262, 1),
(272, 52, 2, 262, 1),
(273, 32, 2, 264, 1),
(274, 38, 2, 264, 1),
(275, 1, 2, 265, 1),
(276, 2, 2, 265, 1),
(277, 3, 2, 265, 1),
(278, 4, 2, 265, 1),
(279, 5, 2, 265, 1),
(280, 6, 2, 265, 1),
(281, 7, 2, 265, 1),
(282, 8, 2, 265, 1),
(283, 10, 2, 265, 1),
(284, 11, 2, 265, 1),
(285, 15, 2, 265, 1),
(286, 32, 2, 265, 1),
(287, 50, 2, 265, 1),
(288, 52, 2, 265, 1),
(289, 53, 2, 265, 1),
(290, 9, 2, 266, 1),
(291, 50, 2, 266, 1),
(292, 30, 2, 268, 1),
(293, 32, 2, 268, 1),
(294, 37, 2, 268, 1),
(295, 38, 2, 268, 1),
(296, 42, 2, 268, 1),
(297, 50, 2, 268, 1),
(298, 52, 2, 268, 1),
(299, 7, 2, 275, 1),
(300, 8, 2, 275, 1),
(301, 9, 2, 275, 1),
(302, 10, 2, 275, 1),
(303, 11, 2, 275, 1),
(304, 30, 2, 275, 1),
(305, 50, 2, 275, 1),
(306, 32, 2, 278, 1),
(307, 38, 2, 278, 1),
(308, 50, 2, 278, 1),
(309, 52, 2, 278, 1),
(310, 12, 2, 305, 1),
(311, 17, 2, 305, 1),
(312, 22, 2, 305, 1),
(313, 23, 2, 305, 1),
(314, 25, 2, 305, 1),
(315, 27, 2, 305, 1),
(316, 31, 2, 305, 1),
(317, 36, 2, 305, 1),
(318, 37, 2, 305, 1),
(319, 38, 2, 305, 1),
(320, 40, 2, 305, 1),
(321, 41, 2, 305, 1),
(322, 42, 2, 305, 1),
(323, 43, 2, 305, 1),
(324, 45, 2, 305, 1),
(325, 46, 2, 305, 1),
(326, 47, 2, 305, 1),
(327, 48, 2, 305, 1),
(328, 51, 2, 305, 1),
(329, 45, 2, 311, 1),
(330, 45, 2, 312, 1),
(331, 45, 2, 314, 1),
(332, 45, 2, 315, 1),
(333, 12, 2, 316, 1),
(334, 45, 2, 316, 1),
(335, 42, 2, 322, 1),
(336, 45, 2, 322, 1),
(337, 12, 2, 319, 1),
(338, 22, 2, 319, 1),
(339, 23, 2, 319, 1),
(340, 25, 2, 319, 1),
(341, 40, 2, 319, 1),
(342, 43, 2, 319, 1),
(343, 45, 2, 319, 1),
(344, 46, 2, 319, 1),
(345, 1, 2, 323, 1),
(346, 2, 2, 323, 1),
(347, 3, 2, 323, 1),
(348, 4, 2, 323, 1),
(349, 5, 2, 323, 1),
(350, 6, 2, 323, 1),
(351, 7, 2, 323, 1),
(352, 11, 2, 323, 1),
(353, 14, 2, 323, 1),
(354, 16, 2, 323, 1),
(355, 25, 2, 323, 1),
(356, 26, 2, 323, 1),
(357, 27, 2, 323, 1),
(358, 32, 2, 323, 1),
(359, 38, 2, 323, 1),
(360, 42, 2, 323, 1),
(361, 46, 2, 323, 1),
(362, 47, 2, 323, 1),
(363, 48, 2, 323, 1),
(364, 52, 2, 323, 1),
(365, 53, 2, 323, 1),
(366, 8, 2, 324, 1),
(367, 9, 2, 324, 1),
(368, 10, 2, 324, 1),
(369, 15, 2, 324, 1),
(370, 30, 2, 324, 1),
(371, 50, 2, 324, 1),
(372, 1, 2, 344, 1),
(373, 2, 2, 344, 1),
(374, 3, 2, 344, 1),
(375, 4, 2, 344, 1),
(376, 5, 2, 344, 1),
(377, 6, 2, 344, 1),
(378, 7, 2, 344, 1),
(379, 30, 2, 344, 1),
(380, 38, 2, 344, 1),
(381, 50, 2, 344, 1),
(382, 52, 2, 344, 1),
(383, 53, 2, 344, 1),
(384, 38, 2, 345, 1),
(385, 50, 2, 345, 1),
(386, 52, 2, 345, 1),
(387, 53, 2, 345, 1),
(388, 1, 2, 346, 1),
(389, 2, 2, 346, 1),
(390, 3, 2, 346, 1),
(391, 4, 2, 346, 1),
(392, 5, 2, 346, 1),
(393, 6, 2, 346, 1),
(394, 7, 2, 346, 1),
(395, 30, 2, 346, 1),
(396, 38, 2, 346, 1),
(397, 50, 2, 346, 1),
(398, 52, 2, 346, 1),
(399, 53, 2, 346, 1),
(400, 1, 2, 347, 1),
(401, 2, 2, 347, 1),
(402, 3, 2, 347, 1),
(403, 4, 2, 347, 1),
(404, 5, 2, 347, 1),
(405, 6, 2, 347, 1),
(406, 7, 2, 347, 1),
(407, 13, 2, 347, 1),
(408, 30, 2, 347, 1),
(409, 38, 2, 347, 1),
(410, 50, 2, 347, 1),
(411, 52, 2, 347, 1),
(412, 53, 2, 347, 1),
(413, 1, 2, 348, 1),
(414, 2, 2, 348, 1),
(415, 3, 2, 348, 1),
(416, 4, 2, 348, 1),
(417, 5, 2, 348, 1),
(418, 6, 2, 348, 1),
(419, 7, 2, 348, 1),
(420, 10, 2, 348, 1),
(421, 13, 2, 348, 1),
(422, 30, 2, 348, 1),
(423, 38, 2, 348, 1),
(424, 50, 2, 348, 1),
(425, 52, 2, 348, 1),
(426, 53, 2, 348, 1),
(427, 8, 2, 349, 1),
(428, 15, 2, 349, 1),
(429, 30, 2, 349, 1),
(430, 42, 2, 349, 1),
(431, 50, 2, 349, 1),
(432, 52, 2, 349, 1),
(433, 53, 2, 349, 1),
(434, 8, 2, 351, 1),
(435, 15, 2, 351, 1),
(436, 42, 2, 351, 1),
(437, 1, 2, 355, 1),
(438, 2, 2, 355, 1),
(439, 3, 2, 355, 1),
(440, 4, 2, 355, 1),
(441, 5, 2, 355, 1),
(442, 6, 2, 355, 1),
(443, 7, 2, 355, 1),
(444, 30, 2, 355, 1),
(445, 38, 2, 355, 1),
(446, 50, 2, 355, 1),
(447, 52, 2, 355, 1),
(448, 53, 2, 355, 1),
(449, 1, 2, 356, 1),
(450, 2, 2, 356, 1),
(451, 3, 2, 356, 1),
(452, 4, 2, 356, 1),
(453, 5, 2, 356, 1),
(454, 6, 2, 356, 1),
(455, 7, 2, 356, 1),
(456, 30, 2, 356, 1),
(457, 38, 2, 356, 1),
(458, 50, 2, 356, 1),
(459, 52, 2, 356, 1),
(460, 53, 2, 356, 1),
(461, 52, 2, 357, 1),
(462, 52, 2, 358, 1),
(463, 1, 2, 360, 1),
(464, 2, 2, 360, 1),
(465, 3, 2, 360, 1),
(466, 4, 2, 360, 1),
(467, 5, 2, 360, 1),
(468, 6, 2, 360, 1),
(469, 7, 2, 360, 1),
(470, 8, 2, 360, 1),
(471, 37, 2, 360, 1),
(472, 38, 2, 360, 1),
(473, 53, 2, 360, 1),
(474, 54, 2, 360, 1),
(475, 25, 2, 373, 1),
(476, 26, 2, 373, 1),
(477, 27, 2, 373, 1),
(478, 46, 2, 373, 1),
(479, 47, 2, 373, 1),
(480, 48, 2, 373, 1),
(481, 55, 2, 373, 1),
(482, 56, 2, 373, 1),
(483, 57, 2, 373, 1),
(484, 27, 2, 374, 1),
(485, 48, 2, 374, 1),
(486, 55, 2, 374, 1),
(487, 56, 2, 374, 1),
(488, 57, 2, 374, 1),
(489, 27, 2, 375, 1),
(490, 33, 2, 375, 1),
(491, 48, 2, 375, 1),
(492, 55, 2, 375, 1),
(493, 56, 2, 375, 1),
(494, 57, 2, 375, 1),
(495, 27, 2, 376, 1),
(496, 33, 2, 376, 1),
(497, 48, 2, 376, 1),
(498, 55, 2, 376, 1),
(499, 56, 2, 376, 1),
(500, 57, 2, 376, 1),
(501, 27, 2, 377, 1),
(502, 33, 2, 377, 1),
(503, 48, 2, 377, 1),
(504, 55, 2, 377, 1),
(505, 56, 2, 377, 1),
(506, 57, 2, 377, 1),
(507, 27, 2, 378, 1),
(508, 33, 2, 378, 1),
(509, 48, 2, 378, 1),
(510, 55, 2, 378, 1),
(511, 56, 2, 378, 1),
(512, 57, 2, 378, 1),
(513, 27, 2, 379, 1),
(514, 33, 2, 379, 1),
(515, 48, 2, 379, 1),
(516, 55, 2, 379, 1),
(517, 56, 2, 379, 1),
(518, 57, 2, 379, 1),
(519, 27, 2, 380, 1),
(520, 33, 2, 380, 1),
(521, 48, 2, 380, 1),
(522, 55, 2, 380, 1),
(523, 56, 2, 380, 1),
(524, 57, 2, 380, 1),
(525, 27, 2, 381, 1),
(526, 33, 2, 381, 1),
(527, 48, 2, 381, 1),
(528, 55, 2, 381, 1),
(529, 56, 2, 381, 1),
(530, 57, 2, 381, 1),
(531, 44, 2, 1, 1),
(532, 38, 2, 129, 1),
(533, 38, 2, 225, 1),
(534, 32, 2, 360, 1),
(535, 52, 2, 360, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `amenazas`
--

DROP TABLE IF EXISTS `amenazas`;
CREATE TABLE `amenazas` (
  `id_amenaza` int(11) NOT NULL,
  `nombreAmena` varchar(100) NOT NULL,
  `abreb` varchar(100) NOT NULL,
  `descripc` varchar(300) NOT NULL,
  `id_tipoActiv` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `amenazas`
--

INSERT INTO `amenazas` VALUES
(1, 'Fuego', 'N.1', 'Incendios: posibilidad de que el fuego acabe con recursos del sistema.', 1, 1),
(2, 'Daños por agua', 'N.2', 'Inundaciones: posibilidad de que el agua acabe con recursos del sistema', 1, 1),
(3, 'Desastres naturales', 'N.*', 'Otros incidentes que se producen sin intervención humana: rayo', 1, 1),
(4, 'Fuego', 'I.1', 'incendio: posibilidad de que el fuego acabe con los recursos del sistema.', 2, 1),
(5, 'Daños por agua', 'I.2', 'escapes', 2, 1),
(6, 'Desastres industriales', 'I.*', 'otros desastres debidos a la actividad humana: explosiones', 2, 1),
(7, 'Contaminación mecánica', 'I.3', 'vibraciones', 2, 1),
(8, 'Contaminación electromagnética', 'I.4', 'interferencias de radio', 2, 1),
(9, 'Avería de origen físico o lógico', 'I.5', 'fallos en los equipos y/o fallos en los programas. Puede ser debida a un defecto de origen o sobrevenida durante el funcionamiento del sistema.', 2, 1),
(10, 'Corte del suministro eléctrico', 'I.6', 'cese de la alimentación de potencia o electricidad', 2, 1),
(11, 'Condiciones inadecuadas de temperatura o humedad', 'I.7', 'deficiencias en la aclimatación de los locales', 2, 1),
(12, 'Fallo de servicios de comunicaciones', 'I.8', 'cese de la capacidad de transmitir datos de un sitio a otro. Típicamente se debe a la destrucción física de los medios físicos de transporte o a la detención de los centros de conmutación', 2, 1),
(13, 'Interrupción de otros servicios y suministros esenciales', 'I.9', 'otros servicios o recursos de los que depende la operación de los equipos; por ejemplo', 2, 1),
(14, 'Degradación de los soportes de almacenamiento de la informacion', 'I.10', 'como consecuencia del paso del tiempo', 2, 1),
(15, 'Emanaciones electromagnéticas', 'I.11', 'Prácticamente todos los dispositivos electrónicos emiten radiaciones al exterior que pudieran ser interceptadas por otros equipos (receptores de radio) derivándose una fuga de información.', 2, 1),
(16, 'Errores de los usuarios', 'E.1', 'equivocaciones de las personas cuando usan los servicios', 3, 1),
(17, 'Errores del administrador', 'E.2', 'equivocaciones de personas con responsabilidades de instalación y operación', 3, 1),
(18, 'Errores de monitorizacion', 'E.3', 'inadecuado registro de actividades: falta de registros', 3, 1),
(19, 'Errores de configuracion', 'E.4', 'introducción de datos de configuración erróneos. Prácticamente todos los activos dependen de su configuración y ésta de la diligencia del administrador: privilegios de acceso', 3, 1),
(20, 'Deficiencias en la organizacion', 'E.7', 'cuando no está claro quién tiene que hacer exactamente qué y cuándo', 2, 1),
(21, 'Difusión de software dañino', 'E.8', 'propagación inocente de virus', 3, 1),
(22, 'Errores de [re-]encaminamiento', 'E.9', 'envío de información a través de un sistema o una red usando', 2, 1),
(23, 'Errores de secuencia', 'E.10', 'alteración accidental del orden de los mensajes transmitidos.', 2, 1),
(24, 'Escapes de información', 'E.14', 'la información llega accidentalmente al conocimiento de personas que no deberían tener conocimiento de ella', 3, 1),
(25, 'Alteracion accidental de la informacion', 'E.15', 'alteración accidental de la información. Esta amenaza sólo se identifica sobre datos en general', 3, 1),
(26, 'Destrucción de información', 'E.18', 'pérdida accidental de información. Esta amenaza sólo se identifica sobre datos en general', 3, 1),
(27, 'Fugas de información', 'E.19', 'revelación por indiscreción. Incontinencia verbal', 3, 1),
(28, 'Vulnerabilidades de los programas (software)', 'E.20', 'defectos en el código que dan pie a una operación defectuosa sin intención por parte del usuario pero con consecuencias sobre la integridad de los datos o la capacidad misma de operar.', 2, 1),
(29, 'Errores de mantenimiento / actualización de programas (software)', 'E.21', 'defectos en los procedimientos o controles de actualización del código que permiten que sigan utilizándose programas con defectos conocidos y reparados por el fabricante.', 2, 1),
(30, 'Errores de mantenimiento / actualización de equipos (hardware)', 'E.23', 'defectos en los procedimientos o controles de actualización de los equipos que permiten que sigan utilizándose más allá del tiempo nominal de uso.', 2, 1),
(31, 'Caída del sistema por agotamiento de recursos', 'E.24', 'la carencia de recursos suficientes provoca la caída del sistema cuando la carga de trabajo es desmesurada.', 2, 1),
(32, 'Pérdida de equipos', 'E.25', 'la pérdida de equipos provoca directamente la carencia de un medio para prestar los servicios', 3, 1),
(33, 'Indisponibilidad del personal', 'E.28', 'ausencia accidental del puesto de trabajo: enfermedad', 3, 1),
(34, 'Manipulación de los registros de actividad (log)', 'A.3', '0', 4, 1),
(35, 'Manipulación de la configuración', 'A.4', 'prácticamente todos los activos dependen de su configuración y ésta de la diligencia del administrador: privilegios de acceso', 4, 1),
(36, 'Suplantación de la identidad del usuario', 'A.5', 'escripción: cuando un atacante consigue hacerse pasar por un usuario autorizado', 4, 1),
(37, 'Abuso de privilegios de acceso', 'A.6', 'cada usuario disfruta de un nivel de privilegios para un determinado propósito; cuando un usuario abusa de su nivel de privilegios para realizar tareas que no son de su competencia', 3, 1),
(38, 'Uso no previsto', 'A.7', 'utilización de los recursos del sistema para fines no previstos', 3, 1),
(39, 'Difusión de software dañino', 'A.8', 'propagación intencionada de virus', 4, 1),
(40, '[Re-]encaminamiento de mensajes', 'A.9', 'envío de información a un destino incorrecto a través de un sistema o una red', 2, 1),
(41, 'Alteración de secuencia', 'A.10', 'alteración del orden de los mensajes transmitidos. Con ánimo de que el nuevo orden altere el significado del conjunto de mensajes', 2, 1),
(42, 'Acceso no autorizado', 'A.11', 'el atacante consigue acceder a los recursos del sistema sin tener autorización para ello', 4, 1),
(43, 'Análisis de tráfico', 'A.12', 'el atacante', 4, 1),
(44, 'Repudio', 'A.13', 'negación a posteriori de actuaciones o compromisos adquiridos en el pasado. Repudio de origen: negación de ser el remitente u origen de un mensaje o comunicación. Repudio de recepción: negación de haber recibido un mensaje o comunicación. Repudio de entrega: negación de haber recibido un mensaje p', 4, 1),
(45, 'Interceptación de información (escucha)', 'A.14', 'el atacante llega a tener acceso a información que no le corresponde', 4, 1),
(46, 'Modificación deliberada de la información', 'A.15', 'alteración intencional de la información', 4, 1),
(47, 'Destrucción de información', 'A.18', 'eliminación intencional de información', 4, 1),
(48, 'Divulgación de información', 'A.19', 'revelación de información.', 4, 1),
(49, 'Manipulación de programas', 'A.22', 'alteración intencionada del funcionamiento de los programas', 4, 1),
(50, 'Manipulación de los equipos', 'A.23', 'alteración intencionada del funcionamiento de los programas', 4, 1),
(51, 'Denegación de servicio', 'A.24', 'la carencia de recursos suficientes provoca la caída del sistema cuando la carga de trabajo es desmesurada.', 4, 1),
(52, 'Robo', 'A.25', 'la sustracción de equipamiento provoca directamente la carencia de un medio para prestar los servicios', 4, 1),
(53, 'Ataque destructivo', 'A.26', 'vandalismo', 4, 1),
(54, 'Ocupación enemiga', 'A.27', 'cuando los locales han sido invadidos y se carece de control sobre los propios medios de trabajo.', 4, 1),
(55, 'Indisponibilidad del personal', 'A.28', 'ausencia deliberada del puesto de trabajo: como huelgas', 3, 1),
(56, 'Extorsión', 'A.29', 'presión que', 4, 1),
(57, 'Ingeniería social (picaresca)', 'A.30', 'abuso de la buena fe de las personas para que realicen actividades que interesan a un tercero.', 4, 1);

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
-- Estructura de tabla para la tabla `criteriosvalor`
--

DROP TABLE IF EXISTS `criteriosvalor`;
CREATE TABLE `criteriosvalor` (
  `id_criteriosValor` int(11) NOT NULL,
  `id_tipoCriterValor` int(11) NOT NULL,
  `abreb` varchar(100) NOT NULL,
  `valori` int(11) NOT NULL,
  `descripcCriterio` varchar(300) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `criteriosvalor`
--

INSERT INTO `criteriosvalor` VALUES
(1, 1, '6.pi1', 6, 'probablemente afecte gravemente a un grupo de individuos', 1),
(2, 1, '6.pi2', 6, 'probablemente quebrante seriamente la ley o algún reglamento de protección de información personal', 1),
(3, 1, '5.pi1', 5, 'probablemente afecte gravemente a un individuo', 1),
(4, 1, '5.pi2', 5, 'probablemente quebrante seriamente leyes o regulaciones', 1),
(5, 1, '4.pi1', 4, 'probablemente afecte a un grupo de individuos', 1),
(6, 1, '4.pi2', 4, 'probablemente quebrante leyes o regulaciones', 1),
(7, 1, '3.pi1', 3, 'probablemente afecte a un individuo', 1),
(8, 1, '3.pi2', 3, 'probablemente suponga el incumplimiento de una ley o regulación', 1),
(9, 1, '2.pi1', 2, 'pudiera causar molestias a un individuo', 1),
(10, 1, '2.pi2', 2, 'pudiera quebrantar de forma leve leyes o regulaciones', 1),
(11, 1, '1.pi1', 1, 'pudiera causar molestias a un individuo', 1),
(12, 2, '9.lro', 9, 'probablemente cause un incumplimiento excepcionalmente grave de una ley o regulación', 1),
(13, 2, '7.lro', 7, 'probablemente cause un incumplimiento grave de una ley o regulación', 1),
(14, 2, '5.lro', 5, 'probablemente sea causa de incumplimiento de una ley o regulación', 1),
(15, 2, '3.lro', 3, 'probablemente sea causa de incumplimiento leve o técnico de una ley o regulación', 1),
(16, 2, '1.lro', 1, 'pudiera causar el incumplimiento leve o técnico de una ley o regulación', 1),
(17, 3, '10.si', 10, 'probablemente sea causa de un incidente excepcionalmente serio de seguridad o dificulte la investigación de incidentes excepcionalmente serios', 1),
(18, 3, '9.si', 9, 'probablemente sea causa de un serio incidente de seguridad o dificulte la investigación de incidentes serios', 1),
(19, 3, '7.si', 7, 'probablemente sea causa de un grave incidente de seguridad o dificulte la investigación de incidentes graves', 1),
(20, 3, '3.si', 3, 'probablemente sea causa de una merma en la seguridad o dificulte la investigación de un incidente', 1),
(21, 3, '1.si', 1, 'pudiera causar una merma en la seguridad o dificultar la investigación de un incidente', 1),
(22, 4, '9.cei.a', 9, 'de enorme interés para la competencia', 1),
(23, 4, '9.cei.b', 9, 'de muy elevado valor comercial', 1),
(24, 4, '9.cei.c', 9, 'causa de pérdidas económicas excepcionalmente elevadas', 1),
(25, 4, '9.cei.d', 9, 'causa de muy significativas ganancias o ventajas para individuos u organizaciones', 1),
(26, 4, '9.cei.e', 9, 'constituye un incumplimiento excepcionalmente grave de las obligaciones contractuales relativas a la seguridad de la información proporcionada por terceros', 1),
(27, 4, '7.cei.a', 7, 'de alto interés para la competencia', 1),
(28, 4, '7.cei.b', 7, 'de elevado valor comercial', 1),
(29, 4, '7.cei.c', 7, 'causa de graves pérdidas económicas', 1),
(30, 4, '7.cei.d', 7, 'proporciona ganancias o ventajas desmedidas a individuos u organizaciones', 1),
(31, 4, '7.cei.e', 7, 'constituye un serio incumplimiento de obligaciones contractuales relativas a la seguridad de la información proporcionada por terceros', 1),
(32, 4, '3.cei.a', 3, 'de cierto interés para la competencia', 1),
(33, 4, '3.cei.b', 3, 'de cierto valor comercia', 1),
(34, 4, '3.cei.c', 3, 'causa de pérdidas financieras o merma de ingresos', 1),
(35, 4, '3.cei.d', 3, 'facilita ventajas desproporcionadas a individuos u organizaciones', 1),
(36, 4, '3.cei.e', 3, 'constituye un incumplimiento leve de obligaciones contractuales para mantener la seguridad de la información proporcionada por terceros', 1),
(37, 4, '2.cei.a', 2, 'de bajo interés para la competencia', 1),
(38, 4, '2.cei.b', 2, 'de bajo valor comercial', 1),
(39, 4, '1.cei.a', 1, 'de pequeño interés para la competencia', 1),
(40, 4, '1.cei.b', 1, 'de pequeño valor comercial', 1),
(41, 4, '0.3', 0, 'supondría pérdidas económicas mínimas', 1),
(42, 5, '9.da', 9, 'Probablemente cause una interrupción excepcionalmente seria de las actividades propias de la Organización con un serio impacto en otras organizaciones', 1),
(43, 5, '9.da2', 9, 'Probablemente tenga un serio impacto en otras organizaciones', 1),
(44, 5, '7.da', 7, 'Probablemente cause una interrupción seria de las actividades propias de la Organización con un impacto significativo en otras organizaciones', 1),
(45, 5, '7.da2', 7, 'Probablemente tenga un gran impacto en otras organizaciones', 1),
(46, 5, '5.da', 5, 'Probablemente cause la interrupción de actividades propias de la Organización con impacto en otras organizaciones', 1),
(47, 5, '5.da2', 5, 'Probablemente cause la interrupción de actividades propias de la Organización', 1),
(48, 5, '3.da', 3, 'Probablemente cause la interrupción de actividades propias de la Organización', 1),
(49, 5, '1.da', 1, 'Pudiera causar la interrupción de actividades propias de la Organización', 1),
(50, 6, '9.po', 9, 'alteración seria del orden público', 1),
(51, 6, '6.po', 6, '\"probablemente cause manifestaciones', 1),
(52, 6, '3.po', 3, 'causa de protestas puntuales', 1),
(53, 6, '1.po', 1, 'pudiera causar protestas puntuales', 1),
(54, 7, '10.olm', 10, 'Probablemente cause un daño excepcionalmente serio a la eficacia o seguridad de la misión operativa o logística', 1),
(55, 7, '9..olm', 9, 'Probablemente cause un daño serio a la eficacia o seguridad de la misión operativa o logística', 1),
(56, 7, '7..olm', 7, 'Probablemente perjudique la eficacia o seguridad de la misión operativa o logística', 1),
(57, 7, '5..olm', 5, 'Probablemente merme la eficacia o seguridad de la misión operativa o logística más allá del ámbito local', 1),
(58, 7, '3..olm', 3, 'Probablemente merme la eficacia o seguridad de la misión operativa o logística (alcance local)', 1),
(59, 7, '1..olm', 1, 'Pudiera mermar la eficacia o seguridad de la misión operativa o logística (alcance local)', 1),
(60, 8, '9..adm', 9, '\"probablemente impediría seriamente la operación efectiva de la Organización', 1),
(61, 8, '7.adm', 7, 'probablemente impediría la operación efectiva de la Organización', 1),
(62, 8, '5.adm', 5, 'probablemente impediría la operación efectiva de más de una parte de la Organización', 1),
(63, 8, '3.adm', 3, 'probablemente impediría la operación efectiva de una parte de la Organización', 1),
(64, 8, '1.adm', 1, 'pudiera impedir la operación efectiva de una parte de la Organización', 1),
(65, 9, '9.lg.a', 9, 'Probablemente causaría una publicidad negativa generalizada por afectar de forma excepcionalmente grave a las relaciones a las relaciones con otras organizaciones', 1),
(66, 9, '9.lg.b', 9, 'Probablemente causaría una publicidad negativa generalizada por afectar de forma excepcionalmente grave a las relaciones a las relaciones con el público en general', 1),
(67, 9, '7.lg.a', 7, 'Probablemente causaría una publicidad negativa generalizada por afectar gravemente a las relaciones con otras organizaciones', 1),
(68, 9, '7.lg.b', 7, 'Probablemente causaría una publicidad negativa generalizada por afectar gravemente a las relaciones con el público en general', 1),
(69, 9, '5.lg.a', 5, 'Probablemente sea causa una cierta publicidad negativa por afectar negativamente a las relaciones con otras organizaciones', 1),
(70, 9, '5.lg.b', 5, 'Probablemente sea causa una cierta publicidad negativa por afectar negativamente a las relaciones con el público', 1),
(71, 9, '3.lg', 3, 'Probablemente afecte negativamente a las relaciones internas de la Organización', 1),
(72, 9, '2.lg', 2, 'Probablemente cause una pérdida menor de la confianza dentro de la Organización', 1),
(73, 9, '1.lg', 1, 'Pudiera causar una pérdida menor de la confianza dentro de la Organización', 1),
(74, 9, '0.4', 0, 'no supondría daño a la reputación o buena imagen de las personas u organizaciones', 1),
(75, 10, '8.crm', 8, 'Impida la investigación de delitos graves o facilite su comisión', 1),
(76, 10, '4.crm', 4, 'Dificulte la investigación o facilite la comisión de delitos', 1),
(77, 11, '7.rto', 7, 'RTO < 4 horas', 1),
(78, 11, '4.rto', 4, '4 horas < RTO < 1 día', 1),
(79, 11, '1.rto', 1, '1 día < RTO < 5 días', 1),
(80, 11, '0.rto', 0, '5 días < RTO', 1),
(81, 12, '10.lbl', 10, 'Secreto', 1),
(82, 12, '9.lbl', 9, 'Reservado', 1),
(83, 12, '8.lbl', 8, 'Confidencial', 1),
(84, 12, '7.lbl', 7, 'Confidencial', 1),
(85, 12, '6.lbl', 6, 'Difusión limitada', 1),
(86, 12, '5.lbl', 5, 'Difusión limitada', 1),
(87, 12, '4.lbl', 4, 'Difusión limitada', 1),
(88, 12, '3.lbl', 3, 'Difusión limitada', 1),
(89, 12, '2.lbl', 2, 'Sin clasificar', 1),
(90, 12, '1.lbl', 1, 'Sin clasificar', 1),
(91, 13, '10.ue', 10, 'TRES SECRET UE', 1),
(92, 13, '9.ue', 9, 'SECRET UE', 1),
(93, 13, '8.ue', 8, 'CONFIDENTIEL UE', 1),
(94, 13, '7.ue', 7, 'CONFIDENTIEL UE', 1),
(95, 13, '6.ue', 6, 'RESTREINT UE', 1),
(96, 13, '5.ue', 5, 'RESTREINT UE', 1),
(97, 13, '4.ue', 4, 'RESTREINT UE', 1),
(98, 13, '3.ue', 3, 'RESTREINT UE', 1);

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
-- Estructura de tabla para la tabla `dimensionanalisis`
--

DROP TABLE IF EXISTS `dimensionanalisis`;
CREATE TABLE `dimensionanalisis` (
  `id_dimension` int(11) NOT NULL,
  `nombreDimens` varchar(100) NOT NULL,
  `abreb` varchar(100) NOT NULL,
  `descripc` varchar(300) NOT NULL,
  `preguAnalis` varchar(200) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `dimensionanalisis`
--

INSERT INTO `dimensionanalisis` VALUES
(1, 'Disponibilidad', 'D', 'Propiedad o característica de los activos consistente en que las entidades o procesos autorizados tienen acceso a los mismos cuando lo requieren', '¿Qué importancia tendría que el activo no estuviera disponible?', 1),
(2, 'Integridad de los datos', 'I', 'Propiedad o característica consistente en que el activo de información no ha sido alterado  de manera no autorizada.', '¿Qué importancia tendría que los datos fueran modificados fuera de control?', 1),
(3, 'Confidencialidad de la información', 'C', '\"Propiedad o característica consistente en que la información ni se pone a disposición', ' ni se revela a individuos', 1),
(4, 'Autenticidad', 'A', 'Propiedad o característica consistente en que una entidad es quien dice ser o bien que garantiza la fuente de la que proceden los datos.', '\"¿Qué importancia tendría que quien accede al servicio no sea realmente quien se cree?', 1),
(5, 'Trazabilidad', 'T', 'Propiedad o característica consistente en que las actuaciones de una entidad pueden ser imputadas exclusivamente a dicha entidad.', '\"¿Qué importancia tendría que no quedara constancia fehaciente del uso del servicio?', 1);

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
-- Estructura de tabla para la tabla `escaladegrad`
--

DROP TABLE IF EXISTS `escaladegrad`;
CREATE TABLE `escaladegrad` (
  `id_escalDegrad` int(11) NOT NULL,
  `nombreEscalDreg` varchar(100) NOT NULL,
  `abreb` varchar(5) NOT NULL,
  `rangeValid` varchar(50) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `escaladegrad`
--

INSERT INTO `escaladegrad` VALUES
(1, 'Muy Alto', 'MA', '90 - 100', 1),
(2, 'Alto', 'A', '70 - 80', 1),
(3, 'Medio', 'M', '40 - 60', 1),
(4, 'Bajo', 'B', '20 - 30', 1),
(5, 'Despresiable', 'D', '0 - 10', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escalafrecuencia`
--

DROP TABLE IF EXISTS `escalafrecuencia`;
CREATE TABLE `escalafrecuencia` (
  `id_escalaFrecuenc` int(11) NOT NULL,
  `nombreEscalFrecuenc` varchar(100) NOT NULL,
  `abreb` varchar(5) NOT NULL,
  `valFrecuncia` double NOT NULL,
  `descripc` varchar(300) NOT NULL,
  `estade` int(11) NOT NULL,
  `valueCuali` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `escalafrecuencia`
--

INSERT INTO `escalafrecuencia` VALUES
(1, 'Muy frecuente', 'CS', 100, 'A diario', 1, 5),
(2, 'Frecuente', 'MA', 10, 'Semanal', 1, 4),
(3, 'Posible', 'P', 1, 'Mensual', 1, 3),
(4, 'Poco frecuente', 'PP', 0.1, 'Anual', 1, 2),
(5, 'Muy poco frecuente', 'MB', 0.01, 'Varios Años', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escalaimpacto`
--

DROP TABLE IF EXISTS `escalaimpacto`;
CREATE TABLE `escalaimpacto` (
  `id_escaleImpac` int(11) NOT NULL,
  `nombreEscalImpac` varchar(100) NOT NULL,
  `abreb` varchar(5) NOT NULL,
  `valor` int(11) NOT NULL,
  `rangeValid` varchar(100) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `escalaimpacto`
--

INSERT INTO `escalaimpacto` VALUES
(1, 'Muy Alto', 'MA', 5, '9 - 10', 1),
(2, 'Alto', 'A', 4, '6 - 8', 1),
(3, 'Medio', 'M', 3, '3 - 5', 1),
(4, 'Bajo', 'B', 2, '1 - 2', 1),
(5, 'Despresiable', 'D', 1, '0 - 0', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escalariesgo`
--

DROP TABLE IF EXISTS `escalariesgo`;
CREATE TABLE `escalariesgo` (
  `id_escalRiesgo` int(11) NOT NULL,
  `nombreEscalRiesgo` varchar(100) NOT NULL,
  `abreb` varchar(5) NOT NULL,
  `valor` int(11) NOT NULL,
  `rangeValid` varchar(100) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `escalariesgo`
--

INSERT INTO `escalariesgo` VALUES
(1, 'Controlable', 'C', 1, '0 - 0', 1),
(2, 'Aceptable', 'A', 2, '1 - 5', 1),
(3, 'Tolerable', 'T', 3, '6 - 16', 1),
(4, 'Intolerable', 'I', 4, '17 - 30', 1),
(5, 'Extremo', 'E', 5, '31 - 50', 1);

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
(5, 'Muy Intolerable', 'Requiere disponer del 100% de los datos.', 5, 1);

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
-- Estructura de tabla para la tabla `libreyamen`
--

DROP TABLE IF EXISTS `libreyamen`;
CREATE TABLE `libreyamen` (
  `id_libreryAmen` int(11) NOT NULL,
  `nombreLibreyAmen` varchar(100) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `libreyamen`
--

INSERT INTO `libreyamen` VALUES
(1, 'Magerit', 1),
(2, 'Pilar', 1);

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
-- Estructura de tabla para la tabla `nivelvalor`
--

DROP TABLE IF EXISTS `nivelvalor`;
CREATE TABLE `nivelvalor` (
  `id_nivelValor` int(11) NOT NULL,
  `nombreNivelValo` varchar(100) NOT NULL,
  `abreb` varchar(100) NOT NULL,
  `rangValid` varchar(30) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `nivelvalor`
--

INSERT INTO `nivelvalor` VALUES
(1, 'Despresiable', 'D', '0 - 0', 1),
(2, 'Bajo', 'B', '1 - 2', 1),
(3, 'Medio', 'M', '3 - 5', 1),
(4, 'Alto', 'A', '6 - 8', 1),
(5, 'Muy Alto', 'MA', '9 - 10', 1);

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
-- Estructura de tabla para la tabla `objversanali`
--

DROP TABLE IF EXISTS `objversanali`;
CREATE TABLE `objversanali` (
  `id_objVersAnali` int(11) NOT NULL,
  `id_versionAnali` int(11) NOT NULL,
  `nombreObj` varchar(100) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `objversanali`
--

INSERT INTO `objversanali` VALUES
(1, 4, 'Tener la maxima cantidad de ventas', 1),
(2, 4, 'Mitigar los riesgos de los activos alineados al proceso.', 1),
(3, 2, 'Intentar solucionar todos los probleasm que pueda presentar el sistema', 1),
(4, 2, 'dsfjsdkfjdsklfjdksljfsdklfjlsdf', 0),
(5, 2, 'Ser una empresa muy kiwt', 1),
(6, 9, 'Solucionar los problemas que esten alineados a los activos', 1),
(7, 9, 'Ser los mas pendejos', 0);

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
(2, 'Proceso de Creacion de Cursos', 'Proceso donde un procesor dicta el cursos en un sistema E-learning a un alumnos.', 2, 2, 0, 0, 1, 1),
(3, 'Proceso de Ingreso de cursos.', 'Proceso donde se sube un curso en el sistema E-learning  para posteriormente usarlo en el dictado de cursos..', 2, 1, 0, 0, 1, 0),
(4, 'Proceso de Ingreso de cursos.', 'Proceso donde se sube un curso en el sistema E-learning  para posteriormente usarlo en el dictado de cursos..', 2, 1, 0, 0, 1, 1),
(5, 'fdgfdgdf', 'gdfgdfgdfgdf', 2, 1, 1, 4, 1, 0),
(6, 'jkdfjdjskjflsdk', 'sdjfksdjflksdjfklsd', 2, 1, 1, 5, 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `responanalis`
--

DROP TABLE IF EXISTS `responanalis`;
CREATE TABLE `responanalis` (
  `id_responAnalis` int(11) NOT NULL,
  `id_versionAnali` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_rolRespon` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `responanalis`
--

INSERT INTO `responanalis` VALUES
(1, 2, 1, 1, 0),
(2, 2, 1, 1, 1),
(3, 2, 2, 2, 0),
(4, 9, 1, 1, 1),
(5, 9, 2, 2, 1);

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
-- Estructura de tabla para la tabla `rolrespon`
--

DROP TABLE IF EXISTS `rolrespon`;
CREATE TABLE `rolrespon` (
  `id_rolRespon` int(11) NOT NULL,
  `nombreRolRespon` varchar(100) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rolrespon`
--

INSERT INTO `rolrespon` VALUES
(1, 'Analista de Riesgos', 1),
(2, 'Gestor de Riesgos', 1),
(3, 'Analista de contexto de la empresa', 1);

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
(2, 'Información', 'info', 'essential.info', 1, 1, 1),
(3, 'Información Empresa', 'biz', 'essential.info.biz', 1, 2, 1),
(4, 'Información Comercial', 'com', 'essential.info.com', 1, 2, 1),
(5, 'Datos de interés para la administración de pública', 'adm', 'essential.info.adm', 1, 2, 1),
(6, 'Datos Vitales (Registros de la Organización)', 'vr', 'essential.info.vr', 1, 2, 1),
(7, 'datos de carácter personal', 'per', 'essential.info.per', 1, 2, 1),
(8, 'datos de persona normal', 'normal', 'essential.info.per.normal', 1, 7, 1),
(9, '\"[Datos de identificación (nombre y apellido', '1', 'essential.info.per.normal.1', 1, 0, 1),
(10, '\"Características personales (estado civil', '2', 'essential.info.per.normal.2', 1, 0, 1),
(11, 'datos académicos', '3', 'essential.info.per.normal.3', 1, 8, 1),
(12, 'datos profesionales', '4', 'essential.info.per.normal.4', 1, 8, 1),
(13, 'datos bancarios', '5', 'essential.info.per.normal.5', 1, 8, 1),
(14, 'Datos personales regulares', 'regular', 'essential.info.per.regular', 1, 7, 1),
(15, 'económico', '1', 'essential.info.per.regular.1', 1, 14, 1),
(16, 'identidad cultural', '2', 'essential.info.per.regular.2', 1, 14, 1),
(17, 'idemtidad social', '3', 'essential.info.per.regular.3', 1, 14, 1),
(18, 'identidad en línea', '4', 'essential.info.per.regular.4', 1, 14, 1),
(19, 'ubicación', '5', 'essential.info.per.regular.5', 1, 14, 1),
(20, '\"Datos seudónimos (Art. 4', 'pseudonymous', 'essential.info.per.pseudonymous', 1, 6, 1),
(21, 'Datos personales confidenciales (Art. 9)', 'sensitive', 'essential.info.per.sensitive', 1, 7, 1),
(22, 'racial', '1', 'essential.info.per.sensitive.1', 1, 21, 1),
(23, 'origen étnico', '2', 'essential.info.per.sensitive.2', 1, 21, 1),
(24, 'opiniones políticas', '3', 'essential.info.per.sensitive.3', 1, 21, 1),
(25, 'creencias de religiones', '4', 'essential.info.per.sensitive.4', 1, 21, 1),
(26, 'creencias filosóficas', '5', 'essential.info.per.sensitive.5', 1, 21, 1),
(27, 'membresía de unión comercial', '6', 'essential.info.per.sensitive.6', 1, 21, 1),
(28, 'salud', '7', 'essential.info.per.sensitive.7', 1, 21, 1),
(29, 'físico', '1', 'essential.info.per.sensitive.7.1', 1, 28, 1),
(30, 'fisiológico', '2', 'essential.info.per.sensitive.7.2', 1, 28, 1),
(31, 'mental', '3', 'essential.info.per.sensitive.7.3', 1, 28, 1),
(32, 'servicios de atención médica', '4', 'essential.info.per.sensitive.7.4', 1, 28, 1),
(33, 'Estado de salud', '5', 'essential.info.per.sensitive.7.5', 1, 28, 1),
(34, 'vida sexual', '8', 'essential.info.per.sensitive.8', 1, 21, 1),
(35, 'orientación sexual', '9', 'essential.info.per.sensitive.9', 1, 21, 1),
(36, 'datos genéticos', '10', 'essential.info.per.sensitive.10', 1, 21, 1),
(37, 'Información biométrica', '11', 'essential.info.per.sensitive.11', 1, 21, 1),
(38, 'niños', 'children', 'essential.info.per.children', 1, 7, 1),
(39, 'Derecho penal (Art. 10)', 'criminal', 'essential.info.per.criminal', 1, 7, 1),
(40, 'ofensas criminales', '1', 'essential.info.per.criminal.1', 1, 39, 1),
(41, 'convicción', '2', 'essential.info.per.criminal.2', 1, 39, 1),
(42, 'Alto de Nivel', 'A', 'essential.info.per.A', 1, 7, 1),
(43, 'nivel medio', 'M', 'essential.info.per.M', 1, 7, 1),
(44, 'Nivel Bajo', 'B', 'essential.info.per.B', 1, 7, 1),
(45, 'datos Clasificados', 'classified', 'essential.info.classified', 1, 2, 1),
(46, 'ULTRA SECRETO', 'TS', 'essential.info.classified.TS', 1, 45, 1),
(47, 'SECRETO', 'S', 'essential.info.classified.S', 1, 45, 1),
(48, 'Nivel Confidencial', 'C', 'essential.info.classified.C', 1, 45, 1),
(49, 'difusión limitada', 'R', 'essential.info.classified.R', 1, 45, 1),
(50, 'Sin Clasificar', 'UC', 'essential.info.classified.UC', 1, 45, 1),
(51, 'De Carácter Público', 'pub', 'essential.info.classified.pub', 1, 45, 1),
(52, 'servicio', 'service', 'essential.service', 1, 1, 1),
(53, 'operaciones', 'operations', 'essential.service.operations', 1, 52, 1),
(54, 'logística', 'logistics', 'essential.service.logistics', 1, 52, 1),
(55, 'inteligencia', 'intelligence', 'essential.service.intelligence', 1, 52, 1),
(56, 'personal', 'personnel', 'essential.service.personnel', 1, 52, 1),
(57, 'financiero', 'financial', 'essential.service.financial', 1, 52, 1),
(58, 'administrativo', 'administrative', 'essential.service.administrative', 1, 52, 1),
(59, 'programa', 'programme', 'essential.service.programme', 1, 52, 1),
(60, 'proyecto', 'project', 'essential.service.project', 1, 52, 1),
(61, 'procesos de negocio', 'bp', 'essential.bp', 1, 1, 1),
(62, 'Procesamiento de datos personales', 'pdd', 'essential.ppd', 1, 1, 1),
(63, 'Hacer o analizar perfiles', '1', 'essential.ppd.1', 1, 62, 1),
(64, 'Anuncio y prospección comercial masiva a clientes potenciales', '2', 'essential.ppd.2', 1, 62, 1),
(65, 'Provisión de servicios para la operación de redes públicas o servicios de comunicación electrónica (proveedor de servicios de Internet)', '3', 'essential.ppd.3', 1, 62, 1),
(66, '\"Gestionar asociados o miembros de partidos políticos', '4', 'essential.ppd.4', 1, 0, 1),
(67, '\"Gestión', '5', 'essential.ppd.5', 1, 0, 1),
(68, 'Historial clínico o de salud', '6', 'essential.ppd.6', 1, 62, 1),
(69, 'Arquitectura del sistema', 'arch', 'arch', 0, 0, 1),
(70, 'punto de [acceso al] servicio', 'sap', 'arch.sap', 1, 69, 1),
(71, 'punto de interconexión', 'ip', 'arch.ip', 1, 69, 1),
(72, 'ninguno', '0', 'arch.ip.0', 1, 71, 1),
(73, 'Filtro de paquetes (nivel 3)', 'pkt', 'arch.ip.pkt', 1, 71, 1),
(74, 'Firewall (control de sesión)', 'firewall', 'arch.ip.firewall', 1, 71, 1),
(75, 'Monitoreo de la aplicación (nivel 7)', 'proxy', 'arch.ip.proxy', 1, 71, 1),
(76, '1 firewall (2 puertos) + proxy', 'r2p', 'arch.ip.r2p', 1, 71, 1),
(77, '1 firewall (3 puertos) + proxy', 'r3p', 'arch.ip.r3p', 1, 71, 1),
(78, '2 firewalls + DMZ + proxy', 'dmz', 'arch.ip.dmz', 1, 71, 1),
(79, 'puerta de enlace (cambio de protocolo)', 'gtwy', 'arch.ip.gtwy', 1, 71, 1),
(80, 'diodo (dispositivo unidireccional)', 'diode', 'arch.ip.diode', 1, 71, 1),
(81, 'espacio de aire (pared de aire)', 'gap', 'arch.ip.gap', 1, 71, 1),
(82, 'Sistema de protección del perímetro físico', 'pps', 'arch.pps', 1, 69, 1),
(83, 'Protección contra emanaciones electromagnéticas', 'tempest', 'arch.tempest', 1, 69, 1),
(84, 'Zona 0: Efectivo si el atacante está muy cerca', '0', 'arch.tempest.0', 1, 83, 1),
(85, 'Zona 1: Efectivo si el atacante está a 20 m de distancia', '1', 'arch.tempest.1', 1, 83, 1),
(86, 'Zona 2: Efectivo si el atacante está a 100 metros de distancia', '2', 'arch.tempest.2', 1, 83, 1),
(87, 'Zona 3: Efectivo si el atacante está a 500 m de distancia', '3', 'arch.tempest.3', 1, 83, 1),
(88, 'alternativa', 'or', 'arch.alternativas', 1, 69, 1),
(89, 'Características', 'qualifier', 'qualifier', 0, 0, 1),
(90, 'independiente (sin valor heredado del dominio)', 'independent', 'qualifier.independent', 1, 89, 1),
(91, 'no almacena datos', 'no_data', 'qualifier.no_data', 1, 89, 1),
(92, 'Sin amenazas', 'no threats', 'qualifier.no_threats', 1, 89, 1),
(93, 'Fuera de servicio', 'dead', 'qualifier.dead', 1, 89, 1),
(94, 'no existe', 'not_exists', 'qualifier.not_exists', 1, 89, 1),
(95, 'invisible', 'invisible', 'qualifier.invisible', 1, 89, 1),
(96, 'negro (información cifrada)', 'black', 'qualifier.black', 1, 89, 1),
(97, 'Disponibilidad', 'availability', 'qualifier.availability', 1, 89, 1),
(98, 'Fácil de reemplazar', 'easy', 'qualifier.availability.easy', 1, 97, 1),
(99, 'Sin problemas de disponibilidad', 'none', 'qualifier.availability.none', 1, 97, 1),
(100, 'Productos o servicios evaluados', 'evaluated', 'qualifier.evaluated', 1, 89, 1),
(101, 'certificado (evaluado por un tercero)', 'certified', 'qualifier.evaluated.certified', 1, 100, 1),
(102, 'acreditado (evaluado por un tercero)', 'accredited', 'qualifier.evaluated.accredited', 1, 100, 1),
(103, 'sin apoyo (sin mantenimiento del fabricante)', 'unsupported', 'qualifier.unsupported', 1, 89, 1),
(104, 'Zonificación de equipos (tempestad)', 'tempest', 'qualifier.tempest', 1, 89, 1),
(105, 'Garantía máxima', 'A', 'qualifier.tempest.A', 1, 104, 1),
(106, 'Garantía media', 'B', 'qualifier.tempest.B', 1, 104, 1),
(107, 'Garantía mínima', 'C', 'qualifier.tempest.C', 1, 104, 1),
(108, 'Sin garantía', 'D', 'qualifier.tempest.D', 1, 104, 1),
(109, 'proporciado por terceros', 'ext', 'arch.ext', 1, 69, 1),
(110, 'Datos / información', 'D', 'D', 0, 0, 1),
(111, 'ficheros', 'files', 'D.files', 1, 110, 1),
(112, 'archivos de datos cifrados', 'e-files', 'D.e-files', 1, 110, 1),
(113, 'registros de organización', 'records', 'D.records', 1, 110, 1),
(114, 'Mensajes (enviados a lo largo de canales de comunicación)', 'msg', 'D.msg', 1, 110, 1),
(115, 'mensajes cifrados', 'e-msg', 'D.e-msg', 1, 110, 1),
(116, 'Copias de Respaldo', 'backup', 'D.backup', 1, 110, 1),
(117, 'Datos de configuración', 'conf', 'D.conf', 1, 110, 1),
(118, 'Datos de Gestiónón', 'int', 'D.int', 1, 110, 1),
(119, 'credenciales (EJ. Contraseñas)', 'password', 'D.password', 1, 110, 1),
(120, 'Datos de Validacia de Credenciales', 'auth', 'D.auth', 1, 110, 1),
(121, 'datos de control de access', 'acl', 'D.acl', 1, 110, 1),
(122, 'Registro de actividad', 'log', 'D.log', 1, 110, 1),
(123, 'voz', 'voice', 'D.voice', 1, 110, 1),
(124, 'multimedia', 'multimedia', 'D.multimedia', 1, 110, 1),
(125, 'código fuente', 'source', 'D.source', 1, 110, 1),
(126, 'código ejecutable', 'exe', 'D.exe', 1, 110, 1),
(127, 'datos de prueba', 'test', 'D.test', 1, 110, 1),
(128, 'otro', 'other', 'D.other ...', 1, 110, 1),
(129, 'Claves criptográficas', 'keys', 'keys', 0, 0, 1),
(130, 'protección de la información', 'info', 'keys.info', 1, 129, 1),
(131, 'claves de cifra', 'encrypt', 'keys.info.encrypt', 1, 130, 1),
(132, 'secreto compartido (clave simétrica)', 'shared_secret', 'keys.info.encrypt.shared_secret', 1, 131, 1),
(133, 'clave pública de cifra', 'public_encryption', 'keys.info.encrypt.public_encryption', 1, 131, 1),
(134, 'clave privada de descifrado', 'public_decryption', 'keys.info.encrypt.public_decryption', 1, 131, 1),
(135, 'claves de firma', 'sign', 'keys.info.sign', 1, 130, 1),
(136, 'secreto compartido (clave simétrica)', 'shared_secret', 'keys.info.sign.shared_secret', 1, 135, 1),
(137, 'clave privada de firma', 'public_signature', 'keys.info.sign.public_signature', 1, 135, 1),
(138, 'clave pública de verificación de firma', 'public_verification', 'keys.info.sign.public_verification', 1, 135, 1),
(139, 'protección de las comunicaciones', 'com', 'keys.com', 1, 129, 1),
(140, 'claves de cifrado del canal', 'channel', 'keys.com.channel', 1, 139, 1),
(141, 'claves de autenticación', 'authentication', 'keys.com.authentication', 1, 139, 1),
(142, 'claves de verificación de autenticación', 'verification', 'keys.com.verification', 1, 139, 1),
(143, 'cifrado de soportes de información', 'disk', 'keys.disk', 1, 129, 1),
(144, 'claves de cifra', 'encrypt', 'keys.disk.encrypt', 1, 143, 1),
(145, 'certificados de clave pública', 'x509', 'keys.x509', 1, 129, 1),
(146, 'Servicios', 'S', 'S', 0, 0, 1),
(147, 'Usado por nosotros', 'client', 'S.client', 1, 146, 1),
(148, 'correo electrónico', 'email', 'S.client.email', 1, 147, 1),
(149, 'buscando en la web', 'www', 'S.client.www', 1, 147, 1),
(150, 'teletrabajo', 'telework', 'S.client.telework', 1, 147, 1),
(151, 'proporcionado por nosotros', 'prov', 'S.prov', 1, 146, 1),
(152, 'administracion del sistema', 'sysadm', 'S.prov.sysadm', 1, 151, 1),
(153, 'Anónimo (sin identificación)', 'anon', 'S.prov.anon', 1, 151, 1),
(154, 'Abierto al público (sin contrato)', 'pub', 'S.prov.pub', 1, 151, 1),
(155, 'Usuarios externos (bajo contrato)', 'ext', 'S.prov.ext', 1, 151, 1),
(156, 'interno (los usuarios y los medios pertenecen a la organización)', 'int', 'S.prov.int', 1, 151, 1),
(157, 'World Wide Web', 'www', 'S.prov.www', 1, 151, 1),
(158, 'acceso remoto', 'remote_access', 'S.prov.remote_access', 1, 151, 1),
(159, 'correo electrónico', 'email', 'S.prov.email', 1, 151, 1),
(160, 'voz sobre IP', 'voip', 'S.prov.voip', 1, 151, 1),
(161, 'Servicio de archivo (almacenamiento)', 'file', 'S.prov.file', 1, 151, 1),
(162, 'servicio de impresión', 'print', 'S.prov.print', 1, 151, 1),
(163, 'transferencia de archivos', 'ft', 'S.prov.ft', 1, 151, 1),
(164, 'servicio de respaldo', 'backup', 'S.prov.backup', 1, 151, 1),
(165, 'servicio de tiempo', 'time', 'S.prov.time', 1, 151, 1),
(166, 'EDI - Intercambio electrónico de datos', 'edi', 'S.prov.edi', 1, 151, 1),
(167, 'directorio de Servicios', 'dir', 'S.prov.dir', 1, 151, 1),
(168, 'servidor de nombres de dominio', 'dns', 'S.prov.dns', 1, 151, 1),
(169, 'gestión de identidad', 'idm', 'S.prov.idm', 1, 151, 1),
(170, 'gestión de privilegios', 'ipm', 'S.prov.ipm', 1, 151, 1),
(171, 'registro de actividades', 'log', 'S.prov.log', 1, 151, 1),
(172, 'servicios criptográficos', 'crypto', 'S.prov.crypto', 1, 151, 1),
(173, 'generación de claves', '.key_gen', 'S.prov.crypto.key_gen', 1, 172, 1),
(174, 'protección contra la integridad', 'integrity', 'S.prov.crypto.integrity', 1, 172, 1),
(175, 'encriptación', 'encryption', 'S.prov.crypto.encryption', 1, 172, 1),
(176, 'autenticación', 'auth', 'S.prov.crypto.auth', 1, 172, 1),
(177, 'firma electronica', 'sign', 'S.prov.crypto.sign', 1, 172, 1),
(178, 'servicio de estampado de tiempo', 'time', 'S.prov.crypto.time', 1, 172, 1),
(179, 'PKI - Infraestructura de clave pública', 'pki', 'S.prov.pki', 1, 151, 1),
(180, 'autoridad de certificación', 'ca', 'S.prov.pki.ca', 1, 179, 1),
(181, 'Autoridad de Registro', 'ra', 'S.prov.pki.ra', 1, 179, 1),
(182, 'autoridad de validación', 'va', 'S.prov.pki.va', 1, 179, 1),
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
(193, 'Certificación (PKI)', 'ca', 'S.3rd.ca', 1, 186, 1),
(194, 'Atributos (PKI)', 'aa', 'S.3rd.aa', 1, 186, 1),
(195, 'Validación (PKI)', 'va', 'S.3rd.va', 1, 186, 1),
(196, 'Marcando la hora', 'tsa', 'S.3rd.tsa', 1, 186, 1),
(197, '\"Directorio (LDAP', 'dir', 'S.3rd.dir', 1, 0, 1),
(198, 'impresión', 'print', 'S.3rd.print', 1, 186, 1),
(199, 'correo electrónico', 'email', 'S.3rd.email', 1, 186, 1),
(200, 'alojamiento de servidor web', 'www', 'S.3rd.www', 1, 186, 1),
(201, 'alojamiento', 'hosting', 'S.3rd.hosting', 1, 186, 1),
(202, 'alojamiento', 'housing', 'S.3rd.housing housing', 1, 186, 1),
(203, 'nube', 'cloud', 'S.3rd.cloud', 1, 186, 1),
(204, 'Software como servicio', 'SaaS', 'S.3rd.cloud.SaaS', 1, 203, 1),
(205, 'Plataforma como servicio', 'PaaS', 'S.3rd.cloud.PaaS', 1, 203, 1),
(206, 'Infraestructura como un servicio', 'IaaS', 'S.3rd.cloud.IaaS', 1, 203, 1),
(207, 'registro de actividades', 'log', 'S.3rd.log', 1, 186, 1),
(208, 'mantenimiento', 'care', 'S.3rd.care', 1, 186, 1),
(209, 'proveedor de energía', 'power', 'S.3rd.power', 1, 186, 1),
(210, 'otro ...', 'other', 'S.3rd.other', 1, 186, 1),
(211, 'anónimo (sin requerir identificación del usuario)', 'anon', 'S.anon', 1, 146, 1),
(212, 'al público en general (sin relación contractual)', 'pub', 'S.pub', 1, 146, 1),
(213, 'a usuarios externos (bajo una relación contractual)', 'ext', 'S.ext', 1, 146, 1),
(214, 'interno (a usuarios de la propia organización)', 'int', 'S.int', 1, 146, 1),
(215, 'world wide web', 'www', 'S.www', 1, 146, 1),
(216, 'acceso remoto a cuenta local', 'telnet', 'S.telnet', 1, 146, 1),
(217, 'correo electrónico', 'email', 'S.email', 1, 146, 1),
(218, 'almacenamiento de ficheros', 'file', 'S.file', 1, 146, 1),
(219, 'almacenamiento de ficheros', 'ftp', 'S.ftp', 1, 146, 1),
(220, 'intercambio electrónico de datos', 'edi', 'S.edi', 1, 146, 1),
(221, 'servicio de directorio', 'dir', 'S.dir', 1, 146, 1),
(222, 'gestión de identidades', 'idm', 'S.idm', 1, 146, 1),
(223, 'gestión de privilegios', 'ipm', 'S.ipm', 1, 146, 1),
(224, 'PKI - infraestructura de clave pública', 'pki', 'S.pki', 1, 146, 1),
(225, 'Aplicaciones (software)', 'SW', 'SW', 0, 0, 1),
(226, 'Desarrollo Propio (en casa)', 'prp', 'SW.prp', 1, 225, 1),
(227, 'Desarrollo a Medida (subcontratado)', 'sub', 'SW.sub', 1, 225, 1),
(228, 'Estándar (en el estante)', 'std', 'SW.std', 1, 225, 1),
(229, 'Web Navegador', 'browser', 'SW.std.browser', 1, 228, 1),
(230, 'servidor de presente', 'www', 'SW.std.www', 1, 228, 1),
(231, 'Servidor de Aplicaciones', 'app', 'SW.std.app', 1, 228, 1),
(232, 'Cliente de Correo Electrónico', 'email_client', 'SW.std.email_client', 1, 228, 1),
(233, 'Servidor de Correo Electrónico', 'email_server', 'SW.std.email_server', 1, 228, 1),
(234, 'servidor de directorio', 'directry', 'SW.std.directory', 1, 228, 1),
(235, 'servidor de ficheros', 'file', 'SW.std.file', 1, 228, 1),
(236, 'Sistema de Gestión de Bases de Datos', 'dbms', 'SW.std.dbms', 1, 228, 1),
(237, 'monitorear transaccional', 'tm', 'SW.std.tm', 1, 228, 1),
(238, 'Ofimática', 'office', 'SW.std.office', 1, 228, 1),
(239, 'anti virus', 'av', 'SW.std.av', 1, 228, 1),
(240, 'Sistema operativo', 'os', 'SW.std.os', 1, 228, 1),
(241, 'Windows', 'windows', 'SW.std.os.windows', 1, 240, 1),
(242, 'solaris', 'solaris', 'SW.std.os.solaris', 1, 240, 1),
(243, 'Linux', 'linux', 'SW.std.os.linux', 1, 240, 1),
(244, 'Mac OS X', 'macosx', 'SW.std.os.macosx', 1, 240, 1),
(245, 'otro ...', 'other', 'SW.std.os.other', 1, 240, 1),
(246, 'Gestor de Máquinas Virtuales', 'hypervisor', 'SW.std.hypervisor', 1, 228, 1),
(247, 'Hypervisor Tipo 1 (Bare-Metal | Nativo)', 'type1', 'SW.std.hypervisor.type1', 1, 246, 1),
(248, 'Hypervisor tipo 2 (alojado)', 'type2', 'SW.std.hypervisor.type2', 1, 246, 1),
(249, 'servidor de terminales', 'ts', 'SW.std.ts', 1, 228, 1),
(250, 'Sistema de respaldo', 'backup', 'SW.std.backup', 1, 228, 1),
(251, 'otro ...', 'other', 'SW.std.other', 1, 228, 1),
(252, 'herramientas de seguridad', 'sec', 'SW.sec', 1, 225, 1),
(253, 'anti virus', 'av', 'SW.sec.av', 1, 252, 1),
(254, 'IDS / IPS (detección / prevención de intrusos)', 'ids', 'SW.sec.ids', 1, 252, 1),
(255, 'prevención de pérdida de datos', 'dip', 'SW.sec.dlp', 1, 252, 1),
(256, 'Análisis de tráfico', 'traf', 'SW.sec.traf', 1, 252, 1),
(257, 'tarro de miel', 'hp', 'SW.sec.hp', 1, 252, 1),
(258, 'Equipos informática (hardware)', 'HW', 'HW', 0, 0, 1),
(259, 'Grandes equipos', 'host', 'HW.host', 1, 258, 1),
(260, 'equipos medios', 'mid', 'HW.mid', 1, 258, 1),
(261, 'informática personal', 'pc', 'HW.pc', 1, 258, 1),
(262, 'informática móvil', 'mobile', 'HW.mobile', 1, 258, 1),
(263, 'dispositivos de mano', 'hand-held', 'HW.hand-held', 1, 258, 1),
(264, 'agendas electálicas', 'pda', 'HW.pda', 1, 258, 1),
(265, 'Equipo virtual', 'vhost', 'HW.vhost', 1, 258, 1),
(266, 'grupo', 'cluster', 'HW.cluster', 1, 258, 1),
(267, 'Equipamiento de Respaldo', 'backup', 'HW.backup', 1, 258, 1),
(268, 'Datos de almacenamiento', 'data', 'HW.data', 1, 258, 1),
(269, 'periféricos', 'peripheral', 'HW.peripheral', 1, 258, 1),
(270, 'medios de impresión', 'print', 'HW.peripheral.print', 1, 269, 1),
(271, 'escálenes', 'scan', 'HW.peripheral.scan', 1, 269, 1),
(272, 'Dispositivos Criptogrrafos', 'crypto', 'HW.peripheral.crypto', 1, 269, 1),
(273, 'otro ...', 'other', 'HW.peripheral.other', 1, 269, 1),
(274, 'Dispositivo de Frontera', 'bp', 'HW.bp', 1, 258, 1),
(275, 'robots', 'robot', 'HW.robot', 1, 258, 1),
(276, 'cinta ...', 'tape', 'HW.robot.tape', 1, 275, 1),
(277, 'disco ...', 'disk', 'HW.robot.disk', 1, 275, 1),
(278, 'Soporte de la Red', 'network', 'HW.network', 1, 258, 1),
(279, 'módems', 'modem', 'HW.network.modem', 1, 278, 1),
(280, 'concentradoras', 'hub', 'HW.network.hub', 1, 278, 1),
(281, 'conmutadores', 'switch', 'HW.network.switch', 1, 278, 1),
(282, 'encaminadores', 'router', 'HW.network.router', 1, 278, 1),
(283, 'pasarelas', 'bridge', 'HW.network.bridge', 1, 278, 1),
(284, 'cortafuegos', 'firewall', 'HW.network.firewall', 1, 278, 1),
(285, 'punto de acceso inalámbrico', 'wap', 'HW.network.wap', 1, 278, 1),
(286, 'otro ...', 'other', 'HW.network.other', 1, 278, 1),
(287, 'Centralita Telefónica', 'pabx', 'HW.pabx', 1, 258, 1),
(288, 'Teléfono IP', 'ipphone', 'HW.ipphone', 1, 258, 1),
(289, 'otro ...', 'other', 'HW.other', 1, 258, 1),
(290, 'Sistemas de control industrial', 'ics', 'HW.ics', 1, 258, 1),
(291, 'RTU - Unidad de terminal remoto', 'rtu', 'HW.ics.rtu', 1, 290, 1),
(292, 'PLC - Controlador lógico programable', 'plc', 'HW.ics.plc', 1, 290, 1),
(293, 'PAC - Controlador de automatización programable', 'pac', 'HW.ics.pac', 1, 290, 1),
(294, 'IED - Dispositivo electrónico inteligente', 'ied', 'HW.ics.ied', 1, 290, 1),
(295, 'Metro', 'meter', 'HW.ics.meter', 1, 290, 1),
(296, 'Puente', 'bridge', 'HW.ics.bridge', 1, 290, 1),
(297, 'HMI - Interfaz de máquina humana', 'hmi', 'HW.ics.hmi', 1, 290, 1),
(298, 'Servidor', 'server', 'HW.ics.server', 1, 290, 1),
(299, 'Historiador', 'historian', 'HW.ics.historian', 1, 290, 1),
(300, 'Telemetría', 'telemetry', 'HW.ics.telemetry', 1, 290, 1),
(301, 'EMS - Sistema de gestión de energía', 'ems', 'HW.ics.ems', 1, 290, 1),
(302, 'DMS - Sistema de gestión de distribución', 'dms', 'HW.ics.dms', 1, 290, 1),
(303, 'Red de control doméstico', 'home', 'HW.ics.home', 1, 290, 1),
(304, '\"HVAC - Calefacción', 'hvac', 'HW.ics.hvac', 1, 0, 1),
(305, 'Redes de comunicaciones', 'COM', 'COM', 0, 0, 1),
(306, 'red telefónica', 'PSTN', 'COM.PSTN', 1, 305, 1),
(307, 'RDSI (Red Digital)', 'ISDN', 'COM.ISDN', 1, 305, 1),
(308, 'X25 (Red de datos)', 'X25', 'COM.X25', 1, 305, 1),
(309, 'ADSL', 'ADSL', 'COM.ADSL', 1, 305, 1),
(310, 'PUNTO A PUNTO', 'pp', 'COM.pp', 1, 305, 1),
(311, 'radio de comunicaciones', 'radio', 'COM.radio', 1, 305, 1),
(312, 'inalmbrica rojo', 'wifi', 'COM.wifi', 1, 305, 1),
(313, 'telefonía móvil', 'mobile', 'COM.mobile', 1, 305, 1),
(314, 'por satélita', 'sat', 'COM.sat', 1, 305, 1),
(315, 'local rojo', 'LAN', 'COM.LAN', 1, 305, 1),
(316, 'LAN virtual', 'VLAN', 'COM.VLAN', 1, 305, 1),
(317, 'red metropolitana', 'MAN', 'COM.MAN', 1, 305, 1),
(318, 'red de área amplia', 'WAN', 'COM.WAN', 1, 305, 1),
(319, 'canal cifrado (red privada virtual)', 'vpn', 'COM.vpn', 1, 305, 1),
(320, 'Comunicaciones de respaldo', 'backup', 'COM.backup', 1, 305, 1),
(321, 'otro ...', 'other', 'COM.other', 1, 305, 1),
(322, 'Internet', 'Internet', 'COM.Internet', 1, 305, 1),
(323, 'Soportes de información', 'Media', 'Media', 0, 0, 1),
(324, 'electrónicos', 'electronic', 'Media.electronic', 1, 323, 1),
(325, 'discos', 'disk', 'Media.electronic.disk', 1, 324, 1),
(326, 'discos virtuales', 'vdisk', 'Media.electronic.vdisk', 1, 324, 1),
(327, 'almacenamiento en red', 'san', 'Media.electronic.san', 1, 324, 1),
(328, 'disquetes', 'disquette', 'Media.electronic.disquette', 1, 324, 1),
(329, 'cederrón (CD-ROM)', 'cd', 'Media.electronic.cd', 1, 324, 1),
(330, 'memorias USB', 'usb', 'Media.electronic.usb', 1, 324, 1),
(331, 'DVD', 'dvd', 'Media.electronic.dvd', 1, 324, 1),
(332, 'cinta magnética', 'tape', 'Media.electronic.tape', 1, 324, 1),
(333, 'tarjetas de memoria', 'mc', 'Media.electronic.mc', 1, 324, 1),
(334, 'tarjetas inteligentes', 'ic', 'Media.electronic.ic', 1, 324, 1),
(335, '\"memoria volátil (por ejemplo', 'volatile', 'Media.electronic.volatile', 1, 0, 1),
(336, '\"Memoria no volátil (por ejemplo', 'non-volatile', 'Media.electronic.non-volatile', 1, 0, 1),
(337, 'otro ...', 'other', 'Media.electronic.other', 1, 324, 1),
(338, 'No electrónicos', 'non_electronic', 'Media.non_electronic', 1, 323, 1),
(339, 'incremento de material', 'printed', 'Media.non_electronic.printed', 1, 338, 1),
(340, 'Cinta de Papel', 'tape', 'Media.non_electronic.tape', 1, 338, 1),
(341, 'microfilm', 'film', 'Media.non_electronic.film', 1, 338, 1),
(342, 'Tarjetas perforadas', 'cards', 'Media.non_electronic.cards', 1, 338, 1),
(343, 'otro ...', 'other', 'Media.non_electronic.other', 1, 338, 1),
(344, 'Equipamiento auxiliar', 'AUX', 'AUX', 0, 0, 1),
(345, 'Fuentes de Alimentación', 'power', 'AUX.power', 1, 344, 1),
(346, 'sistemas de alimentación ininterrumpida', 'ups', 'AUX.ups', 1, 344, 1),
(347, 'generadores eléctricos', 'gen', 'AUX.gen', 1, 344, 1),
(348, 'equipos de climatización', 'ac', 'AUX.ac', 1, 344, 1),
(349, 'cableado', 'cabling', 'AUX.cabling', 1, 344, 1),
(350, 'cable Eléctrico', 'wire', 'AUX.cabling.wire', 1, 349, 1),
(351, 'fibra óptica', 'fiber', 'AUX.cabling.fiber', 1, 349, 1),
(352, 'robots', 'robot', 'AUX.robot', 1, 344, 1),
(353, 'de cintas', 'tape', 'AUX.robot.tape', 1, 352, 1),
(354, 'de discos', 'disk', 'AUX.robot.disk', 1, 352, 1),
(355, 'Suministros esenciales', 'supply', 'AUX.supply', 1, 344, 1),
(356, 'Equipos de Destrución de Soportes de Información', 'destroy', 'AUX.destroy', 1, 344, 1),
(357, '\"Mobiliario: armario', 'furniture', 'AUX.furniture', 1, 0, 1),
(358, 'Cajas Fuertes', 'safe', 'AUX.safe', 1, 344, 1),
(359, 'otro ...', 'other', 'AUX.other', 1, 344, 1),
(360, 'Instalaciones', 'L', 'L', 0, 0, 1),
(361, 'recinto', 'site', 'L.site', 1, 360, 1),
(362, 'edificio', 'building', 'L.building', 1, 360, 1),
(363, 'cuarto', 'local', 'L.local', 1, 360, 1),
(364, 'local', 'mobile', 'L.mobile', 1, 360, 1),
(365, '\"vehículo terrestre: coche', 'car', 'L.mobile.car', 1, 0, 1),
(366, '\"vehículo aéreo: avión', 'plane', 'L.mobile.plane', 1, 0, 1),
(367, '\"vehículo marítimo: buque', 'ship', 'L.mobile.ship', 1, 0, 1),
(368, 'contenedores', 'shelter', 'L.mobile.shelter', 1, 364, 1),
(369, 'túnel', 'tunnel', 'L.tunnel', 1, 364, 1),
(370, 'canalización', 'channel', 'L.channel', 1, 360, 1),
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
-- Estructura de tabla para la tabla `tipoamen`
--

DROP TABLE IF EXISTS `tipoamen`;
CREATE TABLE `tipoamen` (
  `id_tipoActiv` int(11) NOT NULL,
  `nombreTipoActiv` varchar(100) NOT NULL,
  `abreb` varchar(100) NOT NULL,
  `descripc` varchar(300) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipoamen`
--

INSERT INTO `tipoamen` VALUES
(1, 'Desastres naturales', 'N', 'Sucesos que pueden ocurrir sin intervenci¢n de los seres humanos como causa directa o indirecta', 1),
(2, 'De origen industrial', 'I', '\"Sucesos que pueden ocurrir de forma accidental', 1),
(3, 'Errores y fallos no intencionados', 'E', 'Fallos no intencionales causados por las personas.', 1),
(4, 'Ataques intencionados', 'A', 'Fallos deliberados causados por las personas.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipocritervalor`
--

DROP TABLE IF EXISTS `tipocritervalor`;
CREATE TABLE `tipocritervalor` (
  `id_tipoCriterValor` int(11) NOT NULL,
  `abreb` varchar(100) NOT NULL,
  `nombreTipCrit` varchar(200) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipocritervalor`
--

INSERT INTO `tipocritervalor` VALUES
(1, 'pi', 'Información de carácter personal', 1),
(2, 'lpo', 'Obligaciones legales', 1),
(3, 'si', 'Seguridad', 1),
(4, 'cei', 'Intereses comerciales o económicos', 1),
(5, 'da', 'Interrupción del servicio', 1),
(6, 'po', 'Orden público', 1),
(7, 'olm', 'Operaciones', 1),
(8, 'adm', 'Administración y gestión', 1),
(9, 'lg', 'Pérdida de confianza (reputación)', 1),
(10, 'crm', 'Persecución de delitos', 1),
(11, 'rto', 'Tiempo de recuperación del servicio', 1),
(12, 'lbl.nat', 'Información clasificada (nacional)', 1),
(13, 'lbl.ue', 'Información clasificada (Unión Europea)', 1);

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
-- Estructura de tabla para la tabla `valafectamendimen`
--

DROP TABLE IF EXISTS `valafectamendimen`;
CREATE TABLE `valafectamendimen` (
  `id_valAfectAmenDimen` int(11) NOT NULL,
  `id_valorAfectAmen` int(11) NOT NULL,
  `id_dimension` int(11) NOT NULL,
  `id_escalDegrad` int(11) NOT NULL,
  `valorDegrad` int(11) NOT NULL,
  `id_escaleImpac` int(11) NOT NULL,
  `valorImpacto` int(11) NOT NULL,
  `id_escalRiesgo` int(11) NOT NULL,
  `valNivelRiesgo` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `valafectamendimen`
--

INSERT INTO `valafectamendimen` VALUES
(1, 2, 1, 2, 80, 3, 4, 3, 12, 1),
(2, 2, 2, 3, 60, 4, 2, 3, 6, 1),
(3, 2, 3, 3, 60, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoractiv`
--

DROP TABLE IF EXISTS `valoractiv`;
CREATE TABLE `valoractiv` (
  `id_valorActiv` int(11) NOT NULL,
  `id_activProsVerAnali` int(11) NOT NULL,
  `valorActivCuanti` int(11) NOT NULL,
  `promValorCuanti` int(11) NOT NULL,
  `nunValorDimen` int(11) NOT NULL,
  `fechaValorizacion` datetime NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `valoractiv`
--

INSERT INTO `valoractiv` VALUES
(1, 1, 1000, 5, 3, '2023-03-13 23:04:09', 1),
(2, 3, 0, 0, 0, '2023-03-14 02:03:52', 1),
(3, 4, 1000, 5, 3, '2023-03-14 02:03:52', 1),
(4, 5, 0, 0, 0, '2023-03-14 02:03:52', 1),
(5, 6, 0, 0, 0, '2023-03-14 02:03:52', 1),
(6, 7, 0, 0, 0, '2023-03-14 02:03:52', 1),
(7, 8, 0, 0, 0, '2023-03-14 02:03:52', 1),
(8, 9, 0, 0, 0, '2023-03-14 02:03:52', 1),
(9, 10, 0, 0, 0, '2023-03-14 02:03:52', 1),
(10, 16, 0, 0, 0, '2023-03-17 02:01:07', 1),
(11, 17, 0, 0, 0, '2023-03-17 02:01:07', 1),
(12, 18, 0, 0, 0, '2023-03-17 02:01:07', 1),
(13, 19, 0, 0, 0, '2023-03-17 02:01:07', 1),
(14, 20, 0, 0, 0, '2023-03-17 02:01:07', 1),
(15, 21, 0, 0, 0, '2023-03-17 02:01:07', 1),
(16, 22, 0, 0, 0, '2023-03-17 02:01:07', 1),
(17, 23, 0, 0, 0, '2023-03-17 02:01:07', 1),
(25, 31, 0, 0, 0, '2023-03-17 02:01:14', 1),
(26, 32, 0, 0, 0, '2023-03-17 02:01:14', 1),
(27, 33, 0, 0, 0, '2023-03-17 02:01:14', 1),
(28, 34, 0, 0, 0, '2023-03-17 02:01:14', 1),
(29, 35, 0, 6, 2, '2023-03-17 02:01:14', 1),
(30, 36, 0, 0, 0, '2023-03-17 02:01:14', 1),
(31, 37, 0, 7, 2, '2023-03-17 02:01:14', 1),
(32, 38, 1000, 0, 0, '2023-03-17 02:01:14', 1),
(33, 39, 0, 0, 0, '2023-03-17 14:34:51', 1),
(34, 40, 0, 0, 0, '2023-03-17 14:34:51', 1),
(35, 41, 0, 0, 0, '2023-03-17 14:34:51', 1),
(36, 42, 0, 0, 0, '2023-03-17 14:34:51', 1),
(37, 43, 0, 0, 0, '2023-03-17 14:34:51', 1),
(38, 44, 0, 0, 0, '2023-03-17 14:34:51', 1),
(39, 45, 0, 0, 0, '2023-03-17 14:34:51', 1),
(40, 46, 0, 0, 0, '2023-03-17 14:34:51', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoractivdimen`
--

DROP TABLE IF EXISTS `valoractivdimen`;
CREATE TABLE `valoractivdimen` (
  `id_valorActiDimen` int(11) NOT NULL,
  `id_valorActiv` int(11) NOT NULL,
  `id_dimension` int(11) NOT NULL,
  `valorAcivCualit` int(11) NOT NULL,
  `id_varlotActivCualit` int(11) NOT NULL,
  `tipValoActivDimen` varchar(5) NOT NULL,
  `estade` int(11) NOT NULL,
  `id_nivelCritec` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `valoractivdimen`
--

INSERT INTO `valoractivdimen` VALUES
(1, 1, 1, 5, 0, 'N', 1, 3),
(2, 1, 2, 6, 12, 'C', 0, 0),
(3, 1, 3, 14, 12, 'C', 0, 0),
(4, 1, 4, 6, 12, 'C', 1, 4),
(5, 1, 2, 4, 12, 'C', 1, 3),
(6, 3, 1, 5, 0, '0', 1, 3),
(7, 3, 2, 4, 12, '0', 1, 3),
(8, 3, 4, 6, 12, '0', 1, 4),
(9, 29, 3, 6, 2, 'C', 1, 4),
(10, 31, 3, 6, 2, 'C', 1, 4),
(11, 29, 2, 6, 0, 'N', 1, 4),
(12, 31, 2, 7, 0, 'N', 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valorafectamen`
--

DROP TABLE IF EXISTS `valorafectamen`;
CREATE TABLE `valorafectamen` (
  `id_valorAfectAmen` int(11) NOT NULL,
  `id_afectaActiv` int(11) NOT NULL,
  `id_escalaFrecuen` int(11) NOT NULL,
  `promEscalDregad` int(11) NOT NULL,
  `impactCuanti` int(11) NOT NULL,
  `riesgoCuanti` int(11) NOT NULL,
  `numValDim` int(11) NOT NULL,
  `estade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `valorafectamen`
--

INSERT INTO `valorafectamen` VALUES
(1, 7, 2, 0, 0, 0, 0, 1),
(2, 8, 3, 80, 80000, 80000, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valorproces`
--

DROP TABLE IF EXISTS `valorproces`;
CREATE TABLE `valorproces` (
  `id_valorProc` int(11) NOT NULL,
  `id_escalaRTO` int(11) NOT NULL,
  `id_escalaRPO` int(11) NOT NULL,
  `valorMDT` int(11) NOT NULL,
  `estade` int(11) NOT NULL,
  `id_versionAnali` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `valorproces`
--

INSERT INTO `valorproces` VALUES
(1, 2, 2, 5, 1, 1),
(2, 2, 4, 8, 1, 2),
(3, 5, 5, 0, 1, 3),
(4, 5, 5, 0, 1, 5),
(5, 5, 5, 0, 1, 6),
(6, 5, 5, 200, 1, 7),
(7, 3, 2, 30, 1, 8),
(8, 3, 2, 50, 1, 9);

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
(2, 2, 'V2', '2023-03-07 02:37:23', 1),
(3, 1, 'V3', '2023-03-07 02:48:07', 0),
(4, 2, 'V3', '2023-03-07 03:08:57', 1),
(5, 2, 'V4', '2023-03-14 01:43:12', 0),
(6, 2, 'V1', '2023-03-14 02:03:52', 0),
(7, 2, 'V4', '2023-03-17 02:01:07', 1),
(8, 2, 'V5', '2023-03-17 02:01:14', 1),
(9, 2, 'V5', '2023-03-17 14:34:51', 1);

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
-- Indices de la tabla `afectaactiv`
--
ALTER TABLE `afectaactiv`
  ADD PRIMARY KEY (`id_afectaActiv`);

--
-- Indices de la tabla `afectadimen`
--
ALTER TABLE `afectadimen`
  ADD PRIMARY KEY (`id_afectDimen`);

--
-- Indices de la tabla `afectatip`
--
ALTER TABLE `afectatip`
  ADD PRIMARY KEY (`id_adectTip`);

--
-- Indices de la tabla `amenazas`
--
ALTER TABLE `amenazas`
  ADD PRIMARY KEY (`id_amenaza`);

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
-- Indices de la tabla `criteriosvalor`
--
ALTER TABLE `criteriosvalor`
  ADD PRIMARY KEY (`id_criteriosValor`);

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
-- Indices de la tabla `dimensionanalisis`
--
ALTER TABLE `dimensionanalisis`
  ADD PRIMARY KEY (`id_dimension`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id_empresa`);

--
-- Indices de la tabla `escaladegrad`
--
ALTER TABLE `escaladegrad`
  ADD PRIMARY KEY (`id_escalDegrad`);

--
-- Indices de la tabla `escalafrecuencia`
--
ALTER TABLE `escalafrecuencia`
  ADD PRIMARY KEY (`id_escalaFrecuenc`);

--
-- Indices de la tabla `escalaimpacto`
--
ALTER TABLE `escalaimpacto`
  ADD PRIMARY KEY (`id_escaleImpac`);

--
-- Indices de la tabla `escalariesgo`
--
ALTER TABLE `escalariesgo`
  ADD PRIMARY KEY (`id_escalRiesgo`);

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
-- Indices de la tabla `libreyamen`
--
ALTER TABLE `libreyamen`
  ADD PRIMARY KEY (`id_libreryAmen`);

--
-- Indices de la tabla `loginuser`
--
ALTER TABLE `loginuser`
  ADD PRIMARY KEY (`id_loginUser`);

--
-- Indices de la tabla `nivelvalor`
--
ALTER TABLE `nivelvalor`
  ADD PRIMARY KEY (`id_nivelValor`);

--
-- Indices de la tabla `objempresa`
--
ALTER TABLE `objempresa`
  ADD PRIMARY KEY (`id_objempresa`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `objversanali`
--
ALTER TABLE `objversanali`
  ADD PRIMARY KEY (`id_objVersAnali`),
  ADD KEY `id_versionAnali` (`id_versionAnali`);

--
-- Indices de la tabla `proceempresa`
--
ALTER TABLE `proceempresa`
  ADD PRIMARY KEY (`id_proceso`),
  ADD KEY `id_gerarProc` (`id_gerarProc`),
  ADD KEY `id_tipProce` (`id_tipProce`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `responanalis`
--
ALTER TABLE `responanalis`
  ADD PRIMARY KEY (`id_responAnalis`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_versionAnali` (`id_versionAnali`);

--
-- Indices de la tabla `resposproce`
--
ALTER TABLE `resposproce`
  ADD PRIMARY KEY (`id_resposProce`);

--
-- Indices de la tabla `rolrespon`
--
ALTER TABLE `rolrespon`
  ADD PRIMARY KEY (`id_rolRespon`);

--
-- Indices de la tabla `tipoactivo`
--
ALTER TABLE `tipoactivo`
  ADD PRIMARY KEY (`id_tipoActivo`);

--
-- Indices de la tabla `tipoamen`
--
ALTER TABLE `tipoamen`
  ADD PRIMARY KEY (`id_tipoActiv`);

--
-- Indices de la tabla `tipocritervalor`
--
ALTER TABLE `tipocritervalor`
  ADD PRIMARY KEY (`id_tipoCriterValor`);

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
-- Indices de la tabla `valafectamendimen`
--
ALTER TABLE `valafectamendimen`
  ADD PRIMARY KEY (`id_valAfectAmenDimen`);

--
-- Indices de la tabla `valoractiv`
--
ALTER TABLE `valoractiv`
  ADD PRIMARY KEY (`id_valorActiv`);

--
-- Indices de la tabla `valoractivdimen`
--
ALTER TABLE `valoractivdimen`
  ADD PRIMARY KEY (`id_valorActiDimen`);

--
-- Indices de la tabla `valorafectamen`
--
ALTER TABLE `valorafectamen`
  ADD PRIMARY KEY (`id_valorAfectAmen`);

--
-- Indices de la tabla `valorproces`
--
ALTER TABLE `valorproces`
  ADD PRIMARY KEY (`id_valorProc`),
  ADD KEY `id_escalaRTO` (`id_escalaRTO`),
  ADD KEY `id_escalaRPO` (`id_escalaRPO`),
  ADD KEY `id_versionAnali` (`id_versionAnali`);

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
  MODIFY `id_activProsVerAnali` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `afectaactiv`
--
ALTER TABLE `afectaactiv`
  MODIFY `id_afectaActiv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `afectadimen`
--
ALTER TABLE `afectadimen`
  MODIFY `id_afectDimen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT de la tabla `afectatip`
--
ALTER TABLE `afectatip`
  MODIFY `id_adectTip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=536;

--
-- AUTO_INCREMENT de la tabla `amenazas`
--
ALTER TABLE `amenazas`
  MODIFY `id_amenaza` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

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
-- AUTO_INCREMENT de la tabla `criteriosvalor`
--
ALTER TABLE `criteriosvalor`
  MODIFY `id_criteriosValor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

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
-- AUTO_INCREMENT de la tabla `dimensionanalisis`
--
ALTER TABLE `dimensionanalisis`
  MODIFY `id_dimension` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `escaladegrad`
--
ALTER TABLE `escaladegrad`
  MODIFY `id_escalDegrad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `escalafrecuencia`
--
ALTER TABLE `escalafrecuencia`
  MODIFY `id_escalaFrecuenc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `escalaimpacto`
--
ALTER TABLE `escalaimpacto`
  MODIFY `id_escaleImpac` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `escalariesgo`
--
ALTER TABLE `escalariesgo`
  MODIFY `id_escalRiesgo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
-- AUTO_INCREMENT de la tabla `libreyamen`
--
ALTER TABLE `libreyamen`
  MODIFY `id_libreryAmen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `loginuser`
--
ALTER TABLE `loginuser`
  MODIFY `id_loginUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `nivelvalor`
--
ALTER TABLE `nivelvalor`
  MODIFY `id_nivelValor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `objempresa`
--
ALTER TABLE `objempresa`
  MODIFY `id_objempresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `objversanali`
--
ALTER TABLE `objversanali`
  MODIFY `id_objVersAnali` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `proceempresa`
--
ALTER TABLE `proceempresa`
  MODIFY `id_proceso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `responanalis`
--
ALTER TABLE `responanalis`
  MODIFY `id_responAnalis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `resposproce`
--
ALTER TABLE `resposproce`
  MODIFY `id_resposProce` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `rolrespon`
--
ALTER TABLE `rolrespon`
  MODIFY `id_rolRespon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipoactivo`
--
ALTER TABLE `tipoactivo`
  MODIFY `id_tipoActivo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=386;

--
-- AUTO_INCREMENT de la tabla `tipoamen`
--
ALTER TABLE `tipoamen`
  MODIFY `id_tipoActiv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipocritervalor`
--
ALTER TABLE `tipocritervalor`
  MODIFY `id_tipoCriterValor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
-- AUTO_INCREMENT de la tabla `valafectamendimen`
--
ALTER TABLE `valafectamendimen`
  MODIFY `id_valAfectAmenDimen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `valoractiv`
--
ALTER TABLE `valoractiv`
  MODIFY `id_valorActiv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `valoractivdimen`
--
ALTER TABLE `valoractivdimen`
  MODIFY `id_valorActiDimen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `valorafectamen`
--
ALTER TABLE `valorafectamen`
  MODIFY `id_valorAfectAmen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `valorproces`
--
ALTER TABLE `valorproces`
  MODIFY `id_valorProc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `versionanali`
--
ALTER TABLE `versionanali`
  MODIFY `id_versionAnali` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
-- Filtros para la tabla `objversanali`
--
ALTER TABLE `objversanali`
  ADD CONSTRAINT `objversanali_ibfk_1` FOREIGN KEY (`id_versionAnali`) REFERENCES `versionanali` (`id_versionAnali`);

--
-- Filtros para la tabla `proceempresa`
--
ALTER TABLE `proceempresa`
  ADD CONSTRAINT `proceempresa_ibfk_1` FOREIGN KEY (`id_gerarProc`) REFERENCES `gerarproce` (`id_gerarProc`),
  ADD CONSTRAINT `proceempresa_ibfk_2` FOREIGN KEY (`id_tipProce`) REFERENCES `tipproce` (`id_tipProce`),
  ADD CONSTRAINT `proceempresa_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`);

--
-- Filtros para la tabla `responanalis`
--
ALTER TABLE `responanalis`
  ADD CONSTRAINT `responanalis_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientanali` (`id_cliente`),
  ADD CONSTRAINT `responanalis_ibfk_2` FOREIGN KEY (`id_versionAnali`) REFERENCES `versionanali` (`id_versionAnali`);

--
-- Filtros para la tabla `trabajempresa`
--
ALTER TABLE `trabajempresa`
  ADD CONSTRAINT `trabajempresa_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id_empresa`);

--
-- Filtros para la tabla `valorproces`
--
ALTER TABLE `valorproces`
  ADD CONSTRAINT `valorproces_ibfk_2` FOREIGN KEY (`id_escalaRTO`) REFERENCES `escalarto` (`id_escalaRTO`),
  ADD CONSTRAINT `valorproces_ibfk_3` FOREIGN KEY (`id_escalaRPO`) REFERENCES `escalarpo` (`id_escalaRPO`),
  ADD CONSTRAINT `valorproces_ibfk_4` FOREIGN KEY (`id_versionAnali`) REFERENCES `versionanali` (`id_versionAnali`);

--
-- Filtros para la tabla `versionanali`
--
ALTER TABLE `versionanali`
  ADD CONSTRAINT `versionanali_ibfk_1` FOREIGN KEY (`id_proceso`) REFERENCES `proceempresa` (`id_proceso`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
