-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-11-2022 a las 04:49:36
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
-- Base de datos: `canvarit_practica`
--
CREATE DATABASE IF NOT EXISTS `canvarit_practica` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `canvarit_practica`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `analitic_ciclo_sincrono` (IN `id_curso` INT)   BEGIN
# LISTAR TODOS LOS CICLOS CON SUS ANALISIS RESPECTIVOS CON SUS INSCRITOS, SUS GANACIAS Y COMO LES FUE EN EL REGISTRO
SELECT dataanl.id_ciclo_curso, dataanl.fecha_init, dataanl.fecha_fin, dataanl.cantinscrip, dataanl.ganacia, dataanl.promedioasis,
CASE
    WHEN dataanl.promedioasis <= 36 THEN "MALO"
    WHEN dataanl.promedioasis >= 36 THEN "MEDIO"
    WHEN dataanl.promedioasis <= 75 THEN "MEDIO"
    WHEN dataanl.promedioasis >= 76 THEN "ALTO"
    ELSE "DESCONOCIDO"
END as analitliker
FROM (SELECT 
cc.id_ciclo_curso , 
cc.fecha_init,
cc.fecha_fin,
(SELECT COUNT(ins.id_inscrip) FROM inscripcciones ins INNER JOIN ciclo_curso cch ON cch.id_ciclo_curso = ins.id_ciclo_curso WHERE cch.id_ciclo_curso = cc.id_ciclo_curso) as cantinscrip , 
(SELECT ((SELECT cch3.presio_inscri FROM ciclo_curso cch3 WHERE cch3.id_ciclo_curso = cc.id_ciclo_curso) * (SELECT COUNT(ins.id_inscrip) FROM inscripcciones ins INNER JOIN ciclo_curso cch2 ON cch2.id_ciclo_curso = ins.id_ciclo_curso WHERE cch2.id_ciclo_curso = cc.id_ciclo_curso))) as ganacia,
promedio_asisten_ciclo (cc.id_ciclo_curso) as promedioasis
FROM ciclo_curso cc 
WHERE cc.id_curso = id_curso) as dataanl;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `analitic_ciclo_sincrono_pru` (IN `id_curso` INT)   BEGIN
# LISTAR TODOS LOS CICLOS CON SUS ANALISIS RESPECTIVOS CON SUS INSCRITOS, SUS GANACIAS Y COMO LES FUE EN EL REGISTRO
SELECT dataanl.id_ciclo_curso, dataanl.fecha_init, dataanl.fecha_fin, dataanl.cantinscrip, dataanl.ganacia, dataanl.promedioasis,
CASE
    WHEN dataanl.promedioasis <= 36 THEN "MALO"
    WHEN dataanl.promedioasis >= 36 THEN "MEDIO"
    WHEN dataanl.promedioasis <= 75 THEN "MEDIO"
    WHEN dataanl.promedioasis >= 76 THEN "ALTO"
    ELSE "DESCONOCIDO"
END as analitliker
FROM (SELECT 
cc.id_ciclo_curso , 
cc.fecha_init,
cc.fecha_fin,
(SELECT COUNT(ins.id_inscrip) FROM inscripcciones ins INNER JOIN ciclo_curso cch ON cch.id_ciclo_curso = ins.id_ciclo_curso WHERE cch.id_ciclo_curso = cc.id_ciclo_curso) as cantinscrip , 
(SELECT ((SELECT cch3.presio_inscri FROM ciclo_curso cch3 WHERE cch3.id_ciclo_curso = cc.id_ciclo_curso) * (SELECT COUNT(ins.id_inscrip) FROM inscripcciones ins INNER JOIN ciclo_curso cch2 ON cch2.id_ciclo_curso = ins.id_ciclo_curso WHERE cch2.id_ciclo_curso = cc.id_ciclo_curso))) as ganacia,
promedio_asisten_ciclo (cc.id_ciclo_curso) as promedioasis
FROM ciclo_curso cc 
WHERE cc.id_curso = id_curso) as dataanl;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `analitic_ciclo_sincrono_puntos` (IN `id_ciclocurso` INT)   BEGIN

# ANALIZA LOS PUNTOS DADOS EN UN ALUMNO EN UNA SESION
SELECT insdat.id_ciclo_curso, insdat.id_inscrip, insdat.nombre,  insdat.photo, (SELECT SUM(pc.value_point) as sumatotal 
FROM inscrip_point_sesion ips 
INNER JOIN puntosclass pc ON pc.id_tipo_puntos = ips.id_tipo_punto 
INNER JOIN inscripcciones ins ON ins.id_inscrip = ips.id_inscrip 
INNER JOIN sesiones ss ON ss.id_sesion = ips.id_sesion 
INNER JOIN ciclo_curso cc ON cc.id_ciclo_curso = ss.id_ciclocurso 
AND ins.id_ciclo_curso = cc.id_ciclo_curso 
AND ins.id_inscrip = insdat.id_inscrip
AND ips.stade <> 0) as sumatotal
FROM (SELECT cc.id_ciclo_curso, ins.id_inscrip, us.nombre, us.photo 
FROM inscripcciones ins 
INNER JOIN alumno al ON al.id_alumno = ins.id_alumno 
INNER JOIN usuario us ON us.id_usuario = al.id_usuario 
INNER JOIN ciclo_curso cc ON cc.id_ciclo_curso = ins.id_ciclo_curso 
AND cc.id_ciclo_curso = id_ciclocurso 
AND ins.estado <> 0) as insdat ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compru_api_key` (IN `seccion_key` VARCHAR(100))  NO SQL BEGIN
# COMPRUEBA API KEY
SELECT sil.api_key FROM sing_log sil WHERE sil.seccion_key = seccion_key;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Compru_datuserlog` (IN `seccion_key` VARCHAR(100))  NO SQL BEGIN
# EXTRAE EL ID DEL USUARIO DE LA TABLA
SET @id_user = (SELECT sl.id_usuario FROM sing_log sl WHERE sl.seccion_key =  seccion_key);
# EXTRAE LOS DATOS DEL USUARIO Y EL TIPO DE USUARIO QUE ES
SET @tipo_user = (SELECT us.tipo_user FROM usuario us WHERE us.id_usuario = @id_user);
# IMPRIMIR DATOS
SELECT @id_user as id_user, @tipo_user as tipo_user, (CASE
WHEN @tipo_user = 'P' THEN (SELECT p.id_profesor FROM profesor p WHERE p.id_usuario = @id_user)
WHEN @tipo_user = 'C' THEN (SELECT al.id_alumno  FROM alumno al WHERE al.id_usuario = @id_user) END) as id_info;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compru_logusser` (IN `usser` VARCHAR(100), IN `pass` VARCHAR(15))  NO SQL BEGIN
SELECT us.id_usuario , us.nombre , us.photo, us.tipo_user 
FROM usuario us 
WHERE us.usser = usser 
AND us.pass = pass
AND us.estado <> 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Compru_rescupass` (IN `correo` VARCHAR(100))  NO SQL BEGIN
# RECUPERAR LA CONTRASEÑA DE UN USUARIO
SELECT us.pass, us.nombre FROM usuario us WHERE us.usser = correo AND us.tipo_user = 'C' ORDER BY us.id_usuario DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_admin` (IN `id_adm` INT)  NO SQL BEGIN
# EXTRAER EL ID DE USUARIO DEL ADMIN
set @id_user = (SELECT ad.id_usuario FROM admin ad WHERE ad.id_admin = id_adm);
# ACTUALIZAR
UPDATE `usuario` SET `estado`= 0 WHERE `id_usuario` = @id_user;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_alumno` (IN `id_alum` INT)  NO SQL BEGIN 
# EXTRAER EL ID DE USUARIO DEL ADMIN 
set @id_user = (SELECT al.id_usuario FROM alumno al WHERE al.id_alumno = id_alum);
# ACTUALIZAR 
UPDATE `usuario` SET `estado`= 0 WHERE `id_usuario` = @id_user;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_ciclocurso` (IN `id_ciclocurso` INT)  NO SQL BEGIN
# ELIMINAR EL CICLO DE UN CURSO
UPDATE `ciclo_curso` SET `estado`= 0 WHERE `ciclo_curso`.`id_ciclo_curso` = id_ciclocurso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_contsessi` (IN `id_conteses` INT)  NO SQL BEGIN
# ELIMINAR EL CONTENIDO DE UNA SESSION
UPDATE `conte_sesion` SET `estado`= 0 WHERE `conte_sesion`.`id_conte_sesion`= id_conteses ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_conttarea` (IN `id_contacti` INT)  NO SQL BEGIN
# ELIMINAR UN CONTENIDO DE TAREA
UPDATE `conte_tarea` SET `estado`= 0 WHERE `conte_tarea`.`id_conte_tarea` = id_contacti ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_curso` (IN `id_curso` INT)  NO SQL BEGIN
# ELIMINAR EL CURSO
UPDATE `curso` SET `estado`= 0 WHERE `curso`.`id_curso` = id_curso ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_inscripuntclas` (IN `id_sesion` INT, IN `id_inscrip` INT, IN `id_tipopunt` INT)   BEGIN
# ELIMINAR LOS PUNTOS DE UN INSCRITO
SET @id_user = (SELECT ips.id_inscrip_p_sea FROM inscrip_point_sesion ips WHERE ips.id_inscrip = id_inscrip AND ips.id_sesion =  id_sesion AND ips.id_tipo_punto = id_tipopunt AND ips.stade <> 0 ORDER BY ips.id_inscrip_p_sea DESC LIMIT 1);
UPDATE `inscrip_point_sesion` SET `stade` = 0 WHERE id_inscrip_p_sea =  @id_user ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_pointclas` (IN `id_pointclass` INT)   BEGIN
# ELIMINAR UN PUNTO
UPDATE `puntosclass` SET stade = 0 WHERE id_tipo_puntos = id_pointclass;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_profe` (IN `id_profe` INT)  NO SQL BEGIN
# EXTRAER EL ID DE USUARIO DEL ADMIN 
set @id_user = (SELECT pro.id_usuario FROM profesor pro WHERE pro.id_profesor = id_profe);
# ACTUALIZAR 
UPDATE `usuario` SET `estado`= 0 WHERE `id_usuario` = @id_user;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_sesion` (IN `id_sesion` INT)  NO SQL BEGIN
# ELIMINAR LA SESION DEL CURSO
UPDATE `sesiones` SET `estado`= 0 WHERE `sesiones`.`id_sesion` = id_sesion ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_tareainscr` (IN `id_tareinsc` INT)  NO SQL BEGIN
# ELIMINAR UNA TAREA DE UN INSCRITO
UPDATE `tarea_conte_inscr` SET `estado`= 0 WHERE `tarea_conte_inscr`.`id_tarea_inscri` = id_tareinsc ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delect_tipocurso` (IN `id_tipocurso` INT)  NO SQL BEGIN
# ELIMINAR UN TIPO DE CURSO
UPDATE `tipo_curso` SET `estado` = '0' WHERE `tipo_curso`.`id_tipocurso` = id_tipocurso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_admin` (IN `name` VARCHAR(100), IN `telf` INT(9), IN `correo` VARCHAR(100), IN `pass` VARCHAR(15), IN `tipo_admin` VARCHAR(100), IN `photo` VARCHAR(400))  NO SQL BEGIN
# INSERTAR LOS DATOS AL USUARIO
INSERT INTO `usuario`(`tipo_user`, `usser`, `pass`, `nombre`, `telf`, `correo`, `estado`, `photo`) VALUES ('A' , correo , pass , name , telf , correo , 1 , photo);
# EXTRAER ULTIMO ADMIN INSERTADO
set @id_user = (SELECT id_usuario FROM usuario WHERE tipo_user = 'A' AND estado = 1 ORDER BY id_usuario DESC LIMIT 1);
# INSERTAR EN ADMIN
INSERT INTO `admin`(`tipo_trabajador`, `id_usuario`) VALUES (tipo_admin , @id_user);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_alumno` (IN `name` VARCHAR(100), IN `telf` INT(9), IN `correo` VARCHAR(100), IN `pass` VARCHAR(15), IN `photo` VARCHAR(400), IN `name_tutor` VARCHAR(100), IN `edad` INT(3), IN `id_tutoralumno` INT)  NO SQL BEGIN 
# INSERTAR LOS DATOS AL USUARIO 
INSERT INTO `usuario`(`tipo_user`, `usser`, `pass`, `nombre`, `telf`, `correo`, `estado`, `photo`) VALUES ('C' , correo , pass , name , telf , correo , 1 , photo); 
# EXTRAER ULTIMO ADMIN INSERTADO 
set @id_user = (SELECT id_usuario FROM usuario WHERE tipo_user = 'C' AND estado = 1 ORDER BY id_usuario DESC LIMIT 1); 
# INSERTAR EN ALUMNO
INSERT INTO `alumno`(`edad`,`id_tutor_alumno`,`name_tutor`, `telf_tutor`, `id_usuario`) VALUES ( edad ,id_tutoralumno, name_tutor , telf , @id_user);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_apertureasist` (IN `id_sesion` INT)   BEGIN
# APERTURAR UNA ASISTENCIA
INSERT INTO `asistencia`(`fecha_asist`,`id_sesion`) VALUES (now(), id_sesion) ;
# SE INSERTAN A TODOS LOS ESTUDIANTES PARA EDITAR LAS ASISTENCIAS.
SET @id = (SELECT asis.id_asisten FROM asistencia asis ORDER BY asis.id_asisten DESC LIMIT 1 );
# INSERTAMOS LAS ASISTENCIAS DE LOS ALUMNOS
INSERT INTO `asist_inscrip`(`id_inscrip`, `id_asisten`, `estado_asistenc`) 
SELECT insp.id_inscrip, @id , 0 
FROM inscripcciones insp 
INNER JOIN ciclo_curso cc ON cc.id_ciclo_curso = insp.id_ciclo_curso 
INNER JOIN sesiones sc ON sc.id_ciclocurso = cc.id_ciclo_curso 
WHERE sc.id_sesion = id_sesion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_ciclocurso` (IN `id_curso` INT, IN `id_profesor` INT, IN `fechaini` DATE, IN `fechafin` DATE, IN `diasdur` INT, IN `presio` DECIMAL)  NO SQL BEGIN
# INSERTAR UN NUEVO CICLO DE CURSO
INSERT INTO `ciclo_curso` (`id_ciclo_curso`, `id_curso`, `id_profesor`, `fecha_init`, `fecha_fin`, `presio_inscri`, `dias_durac`, `estado`) VALUES (NULL, id_curso , id_profesor, fechaini ,fechafin , presio , diasdur , 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_contsession` (IN `id_sesion` INT, IN `id_tipoconte` INT, IN `name` VARCHAR(100), IN `descripcc` VARCHAR(300), IN `url_cont` VARCHAR(400))  NO SQL BEGIN
# INSERTAR UN CONTENIDO DE SECION
INSERT INTO `conte_sesion`(`id_sesion`, `id_tipo_conte`, `nombre_conte`, `descripccion`, `url_contenido`, `estado`) VALUES (id_sesion, id_tipoconte, name, descripcc, url_cont, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_conttarea` (IN `id_sesion` INT, IN `name` VARCHAR(100), IN `descripcc` VARCHAR(300), IN `url_cont` VARCHAR(400))  NO SQL BEGIN
# INSERTAR CONTENIDO DE TAREA
INSERT INTO `conte_tarea`(`id_sesion`, `nombre`, `descripc`, `urlconte`, `point_max`, `estado`) VALUES (id_sesion, name, descripcc, url_cont, 5, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_curso` (IN `idtipcur` INT, IN `name` VARCHAR(100), IN `descr` VARCHAR(500), IN `alcan` VARCHAR(500), IN `contvid` VARCHAR(2000), IN `photpo` VARCHAR(400))  NO SQL BEGIN
# INSERTAR CURSO
INSERT INTO `curso`(`id_tipo_curso`, `nombre`, `descripccion`, `alcance`,`content_video`, `photoport`, `estado`) VALUES (idtipcur, name , descr, alcan , contvid , photpo ,1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_inscrip` (IN `idalumn` INT, IN `idciclcurso` INT, IN `idtipoinscrip` INT, IN `urlvoucher` VARCHAR(400))  NO SQL BEGIN
# INSERTAR UNA INSCRIPCCION
# -- si es una inscripccion en un curso gratis
IF idtipoinscrip = 1 THEN
INSERT INTO `inscripcciones`(`id_alumno`, `id_ciclo_curso`, `id_tipo_inscrip`, `fechainscri`, `url_voucher`, `estado`) VALUES (idalumn, idciclcurso, idtipoinscrip,now(),'',1);
END IF;
# -- si es una inacripccion en un curso de pago
IF idtipoinscrip = 2 THEN
INSERT INTO `inscripcciones`(`id_alumno`, `id_ciclo_curso`, `id_tipo_inscrip`, `fechainscri`, `url_voucher`, `estado`) VALUES (idalumn, idciclcurso, idtipoinscrip,now(), urlvoucher,2);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_inscripuntclas` (IN `id_inscri` INT, IN `id_tipopunt` INT, IN `id_sesion` INT)   BEGIN
# INSERTAR PUNTOS A UN INSCRITO EN UNA SECION EN ESPECIFICA, DE UN CURSO O CICLO DE CURSO.
INSERT INTO `inscrip_point_sesion`(`id_inscrip`, `id_tipo_punto`, `id_sesion`, `fecha_point`, `stade`) VALUES ( id_inscri, id_tipopunt, id_sesion, now(), 1) ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pointclas` (IN `name` VARCHAR(100), IN `valpoint` INT, IN `photo` VARCHAR(400), IN `id_prof` INT, IN `isacumulado` INT, IN `isdefault` INT)   BEGIN
#INSERTAR UNOS PUNTOS
INSERT INTO `puntosclass`(`nombre`, `value_point`, `photo`, `id_profesor`, `stade`,`isacumulado`,`isdefault`) VALUES (name  , valpoint , photo  , id_prof , 1, isacumulado, isdefault);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_profe` (IN `name` VARCHAR(100), IN `telf` INT(9), IN `correo` VARCHAR(100), IN `pass` VARCHAR(15), IN `photo` VARCHAR(400), IN `estudios` VARCHAR(200))  NO SQL BEGIN 
# INSERTAR LOS DATOS AL USUARIO 
INSERT INTO `usuario`(`tipo_user`, `usser`, `pass`, `nombre`, `telf`, `correo`, `estado`, `photo`) VALUES ('P' , correo , pass , name , telf , correo , 1 , photo); 
# EXTRAER ULTIMO ADMIN INSERTADO 
set @id_user = (SELECT id_usuario FROM usuario WHERE tipo_user = 'P' AND estado = 1 ORDER BY id_usuario DESC LIMIT 1);
# INSERTAR EN PROFESOR 
INSERT INTO `profesor`(`estudios`, `id_usuario`) VALUES (estudios, @id_user);
# EXTRAER EL ULTIMO PROFESOR INSERTADO
set @id_prof = (SELECT p.id_profesor FROM profesor p INNER JOIN usuario us ON us.id_usuario = p.id_usuario WHERE us.estado = 1 ORDER BY p.id_profesor DESC LIMIT 1);
SELECT @id_prof as id_prof ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_sesion` (IN `name` VARCHAR(100), IN `id_ciclocurso` INT)  NO SQL BEGIN
# INSERTAR SESION DEL CURSO
INSERT INTO `sesiones`(`id_ciclocurso`, `nombre`, `estado`) VALUES (id_ciclocurso, name, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_singlog` (IN `id_usser` INT, IN `seccion_key` VARCHAR(100), IN `api_ley` VARCHAR(400))  NO SQL BEGIN
# INSERTAR UN SINGLOG
INSERT INTO `sing_log`(`seccion_key`, `api_key`, `fecha_peticion`, `id_usuario`) VALUES (seccion_key,api_ley, now() , id_usser);
# CAPTURAR LOS ULTIMOS
SELECT sil.seccion_key FROM sing_log sil WHERE sil.id_usuario = id_usser ORDER BY sil.id_sing_log DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_tareainscr` (IN `id_inscr` INT, IN `id_conttar` INT, IN `urlconte` VARCHAR(400))  NO SQL BEGIN
# INGRESAR UNA TAREA
INSERT INTO `tarea_conte_inscr`(`id_inscrip`, `id_conte_tarea`, `urlconte`, `puntos`, `estado`) VALUES (id_inscr, id_conttar, urlconte, 0, 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_tipocurso` (IN `name` VARCHAR(100))  NO SQL BEGIN
# INSERT TIPO DE CURSO
INSERT INTO `tipo_curso`(`name`, `estado`) VALUES (name,1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_tutAlumn` (IN `nombre_tutAlum` VARCHAR(100), IN `correo` VARCHAR(200), IN `telf` VARCHAR(9), IN `photo` VARCHAR(500), IN `pass` VARCHAR(15))   BEGIN
# INSERTAR LOS DATOS AL USUARIO 
INSERT INTO `usuario`(`tipo_user`, `usser`, `pass`, `nombre`, `telf`, `correo`, `estado`, `photo`) VALUES ('PA' , correo , pass , nombre_tutAlum , telf , correo , 1 , photo); 
# EXTRAER ULTIMO ADMIN INSERTADO 
set @id_user = (SELECT id_usuario FROM usuario WHERE tipo_user = 'PA' AND estado = 1 ORDER BY id_usuario DESC LIMIT 1); 
# INSERTAR EN PROFESOR 
INSERT INTO `tutor_alumno`( `nombre_tutAlum`, `id_usuario`) VALUES (nombre_tutAlum , @id_user );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_admin` (IN `name` VARCHAR(100))  NO SQL BEGIN
# LISTAR TODOS LOS USUARIOS ACTIVOS
SELECT ad.id_admin ,us.nombre, us.correo, us.telf, us.pass, us.photo,  ad.tipo_trabajador
FROM admin ad
INNER JOIN usuario us ON us.id_usuario = ad.id_usuario 
WHERE us.estado = 1
AND us.nombre LIKE CONCAT('%', name ,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_alumno` (IN `name` VARCHAR(100))  NO SQL BEGIN
# LISTAR TODOS LOS USUARIOS ACTIVOS
SELECT al.id_alumno ,us.nombre, us.correo, us.telf, us.pass, us.photo, al.edad, al.name_tutor, al.id_tutor_alumno
FROM alumno al 
INNER JOIN usuario us ON us.id_usuario = al.id_usuario WHERE us.estado = 1 
AND us.nombre LIKE CONCAT('%',name,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_apertureasis` (IN `id_ciclocurso` INT)   BEGIN
# LISTA TODAS LAS INSCRIPCCIONES DE UN USUARIO
SELECT ass.id_asisten , ass.fecha_asist, ass.id_sesion, sc.nombre
FROM asistencia ass 
INNER JOIN asist_inscrip assi ON assi.id_asisten = ass.id_asisten
INNER JOIN inscripcciones ins ON ins.id_inscrip = assi.id_inscrip
INNER JOIN sesiones sc ON sc.id_ciclocurso = ins.id_ciclo_curso 
WHERE ins.id_ciclo_curso = id_ciclocurso 
GROUP BY ass.id_asisten, ass.fecha_asist;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_ciclocursoCurso` (IN `id_curso` INT)  NO SQL BEGIN
# LISTAR LOS CICLOS DE UN CURSO EN ESPESIFICO
SELECT * FROM ciclo_curso cc WHERE cc.estado <> 0 AND cc.id_curso = id_curso ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_coment_canv` ()  NO SQL BEGIN
SELECT * FROM correoslp WHERE 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_contsesi` (IN `id_sesion` INT)  NO SQL BEGIN
# LISTAR LOS CONTENIDOS POR SESSION
SELECT * FROM conte_sesion cs WHERE cs.id_sesion = id_sesion AND cs.estado <> 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_conttarea` (IN `id_sesion` INT)  NO SQL BEGIN
SELECT * FROM conte_tarea ct WHERE ct.estado <> 0 AND ct.id_sesion = id_sesion ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_curso` (IN `name` VARCHAR(100))  NO SQL BEGIN
# LISTAR LOS CURSOS ACTIVOS
SELECT cu.id_curso, cu.id_tipo_curso, tp.name as nametipocu, cu.nombre, cu.descripccion, cu.alcance, cu.content_video, cu.photoport
FROM curso cu
INNER JOIN tipo_curso tp ON tp.id_tipocurso = cu.id_tipo_curso
WHERE cu.estado <> 0 
AND cu.nombre LIKE CONCAT('%',name,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_inscripasisten` (IN `id_apertuasis` INT)   BEGIN
# LISTAR ASISTENCIAS DE LOS ALUMNOS
SELECT us.id_usuario, us.nombre, ansins.id_asis_inscrip,  ansins.estado_asistenc
FROM asist_inscrip ansins
INNER JOIN inscripcciones ins ON ins.id_inscrip = ansins.id_inscrip
INNER JOIN alumno alun ON alun.id_alumno = ins.id_alumno
INNER JOIN usuario us ON us.id_usuario = alun.id_usuario
WHERE ansins.id_asisten = id_apertuasis ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_inscripuntclas` (IN `id_inscri` INT, IN `id_sesion` INT, IN `id_ciclo` INT)   BEGIN
# LISTAR LOS PUNTOS DE UN ALUMNO EN UNA SESION
IF id_sesion <> 0 THEN
SELECT ips.id_inscrip_p_sea, ips.id_inscrip, ips.id_sesion, pc.id_tipo_puntos, pc.nombre, pc.value_point, pc.photo, count(*) as suma
FROM inscrip_point_sesion ips
INNER JOIN puntosclass pc on pc.id_tipo_puntos = ips.id_tipo_punto
WHERE ips.id_inscrip = id_inscri
AND ips.id_sesion = id_sesion
AND ips.stade <> 0
GROUP BY pc.id_tipo_puntos;
END IF ;
# LISTAR LOS PUNTOS DE UN ALUMNO EN UN CLICLO DE CURSO
IF id_sesion = 0 THEN
SELECT ips.id_inscrip_p_sea, ips.id_inscrip, ips.id_sesion, pc.id_tipo_puntos, pc.nombre, pc.value_point, pc.photo
FROM inscrip_point_sesion ips
INNER JOIN puntosclass pc on pc.id_tipo_puntos = ips.id_tipo_punto
INNER JOIN sesiones sc on sc.id_sesion = ips.id_sesion
INNER JOIN ciclo_curso cc on cc.id_ciclo_curso = sc.id_ciclocurso
WHERE ips.id_inscrip = id_inscri
AND cc.id_ciclo_curso = id_ciclo
AND ips.stade <> 0 ;
END IF ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_inscri_alumn` (IN `id_ciclocur` INT)  NO SQL BEGIN
# LISTAR LOS ALUMNOS INSCRITOS POR CURSO
SELECT ins.id_inscrip, alu.id_alumno, us.nombre, us.photo
FROM inscripcciones ins 
INNER JOIN alumno alu ON ins.id_alumno = alu.id_alumno
INNER JOIN usuario us ON us.id_usuario = alu.id_usuario
WHERE ins.id_ciclo_curso = id_ciclocur ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_inscri_curso` (IN `id_alumn` INT)  NO SQL BEGIN
# Listar todos los cursos isncritos por alumno
SELECT ins.id_inscrip, ins.id_alumno, cc.id_ciclo_curso, c.id_curso, cc.id_profesor , us.nombre as nameprof, us.photo, c.id_tipo_curso, tp.name as nametipocu, c.nombre , c.descripccion, c.alcance, cc.fecha_init, cc.fecha_fin, cc.dias_durac, cc.presio_inscri , c.content_video, c.photoport, cc.estado, ins.estado as estadoinscr 
FROM inscripcciones ins 
INNER JOIN ciclo_curso cc ON cc.id_ciclo_curso = ins.id_ciclo_curso 
INNER JOIN curso c ON c.id_curso = cc.id_curso 
INNER JOIN tipo_curso tp ON tp.id_tipocurso = c.id_tipo_curso 
INNER JOIN profesor p ON p.id_profesor = cc.id_profesor 
INNER JOIN usuario us ON us.id_usuario = p.id_usuario WHERE cc.estado <> 0 
AND c.estado <> 0 
AND ins.estado = 1 
AND ins.id_alumno = id_alumn ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_pointclas` (IN `id_prof` INT)   BEGIN
# Listar los puntos activos teniendo en cuenta a un profesor
IF id_prof <> 0 THEN
SELECT * FROM puntosclass pc WHERE pc.id_profesor = id_prof AND pc.stade <> 0;
END IF;
# Listar los puntos activos teniendo en cuenta a un profesor
IF id_prof = 0 THEN
SELECT * FROM puntosclass pc WHERE pc.stade <> 0;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_preinscrip` ()  NO SQL SELECT ins.id_inscrip, ins.fechainscri, usa.photo ,al.id_alumno, usa.nombre, cc.id_ciclo_curso, c.id_curso, c.nombre as namecurso, cc.presio_inscri, ins.url_voucher
FROM inscripcciones ins
INNER JOIN ciclo_curso cc ON cc.id_ciclo_curso = ins.id_ciclo_curso
INNER JOIN curso c ON c.id_curso = cc.id_curso
INNER JOIN alumno al ON al.id_alumno = ins.id_alumno
INNER JOIN usuario usa ON usa.id_usuario = al.id_usuario
WHERE ins.estado <> 0
AND ins.estado = 2$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_profe` (IN `name` VARCHAR(100))  NO SQL BEGIN
# LISTAR LOS PROFESORES
SELECT prof.id_profesor ,us.nombre, us.correo, us.telf, us.pass, us.photo,  prof.estudios
FROM profesor prof
INNER JOIN usuario us ON us.id_usuario = prof.id_usuario 
WHERE us.estado = 1
AND us.nombre LIKE CONCAT('%',name,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_sesion` (IN `id_ciclocurso` INT)  NO SQL BEGIN
# LISTAR LAS SESIONES DE UN CURSO
# -- lista todo cuando el id es 0
IF id_ciclocurso = 0 THEN
SELECT ss.id_sesion, ss.id_ciclocurso , ss.nombre FROM sesiones ss WHERE ss.estado = 1;
END IF;
# -- lista solo lo del id del curso
IF id_ciclocurso <> 0 THEN
SELECT ss.id_sesion , ss.id_ciclocurso , ss.nombre FROM sesiones ss WHERE ss.estado = 1 AND ss.id_ciclocurso = id_ciclocurso;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tareainscr` (IN `id_conttar` INT)  NO SQL BEGIN
# LISTAR A TODAS LAS RESOLUCIONES DE TAREAS
SELECT usu.id_usuario, alu.id_alumno, usu.nombre, tci.id_tarea_inscri, tci.id_inscrip, tci.id_conte_tarea, tci.urlconte, tci.puntos 
FROM tarea_conte_inscr tci 
INNER JOIN inscripcciones ins ON ins.id_inscrip = tci.id_inscrip 
INNER JOIN alumno alu ON alu.id_alumno = ins.id_alumno 
INNER JOIN usuario usu ON usu.id_usuario = alu.id_usuario 
WHERE tci.estado <> 0 
AND tci.id_conte_tarea = id_conttar ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tareainscr_ranking` (IN `id_ciclocurs` VARCHAR(100))   BEGIN
# LISTAR LOS PUNTOS EN FORMA DE RANKING DE TODOS LOS INSICRTOS
SELECT  
ins.id_inscrip,
al.id_alumno,
us.nombre,
us.photo,
ins.id_ciclo_curso,
IFNULL((SELECT SUM(tci.puntos) FROM tarea_conte_inscr tci INNER JOIN conte_tarea ct ON ct.id_conte_tarea = tci.id_conte_tarea INNER JOIN sesiones sess ON sess.id_sesion = ct.id_sesion INNER JOIN ciclo_curso cc ON cc.id_ciclo_curso = sess.id_ciclocurso WHERE cc.id_ciclo_curso = ins.id_ciclo_curso AND tci.id_inscrip = ins.id_inscrip GROUP BY tci.id_inscrip),0) as point 
FROM inscripcciones ins 
INNER JOIN alumno al ON al.id_alumno = ins.id_alumno
INNER JOIN usuario us ON us.id_usuario = al.id_usuario
WHERE ins.estado = 1 
AND ins.id_ciclo_curso = id_ciclocurs
ORDER BY point DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tipoconte` ()  NO SQL BEGIN
SELECT * FROM tipo_conte tc WHERE tc.estado = 1 ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tipocurso` ()  NO SQL BEGIN
# LISTAR LOS TIPOS DE TRABAJADORES
SELECT tc.id_tipocurso , tc.name FROM tipo_curso tc WHERE tc.estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tutAlumn` ()   BEGIN
# LISTAR LOS TUTORES DE UN ALUMNO
SELECT ta.id_tutor_alumno, us.id_usuario, us.nombre, us.correo, us.telf, us.pass, us.photo 
FROM tutor_alumno ta 
INNER JOIN usuario us ON us.id_usuario = ta.id_usuario 
WHERE us.estado = 1 ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_admin` (IN `id_admin` INT)  NO SQL BEGIN
# LEER EL ADMIN
SELECT ad.id_admin ,us.nombre, us.correo, us.telf, us.pass, us.photo,  ad.tipo_trabajador
FROM admin ad
INNER JOIN usuario us ON us.id_usuario = ad.id_usuario 
WHERE us.estado = 1
AND ad.id_admin = id_admin;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_alumno` (IN `id_alumno` INT)  NO SQL BEGIN
# LEER EL ALUMNO
SELECT al.id_alumno ,us.nombre, us.correo, us.telf, us.pass, us.photo, al.edad, al.name_tutor, al.id_tutor_alumno
FROM alumno al 
INNER JOIN usuario us ON us.id_usuario = al.id_usuario WHERE us.estado = 1
AND al.id_alumno = id_alumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_ciclocurso` (IN `id_curso` INT)  NO SQL BEGIN
# EXTRAER LA INFO DE UN CURSO CON SU ULTIMO CICLO
SELECT cc.id_ciclo_curso, c.id_curso, cc.id_profesor , us.nombre as nameprof, us.photo, c.id_tipo_curso, tp.name as nametipocu, c.nombre , c.descripccion, c.alcance, cc.fecha_init, cc.fecha_fin, cc.dias_durac, cc.presio_inscri , c.content_video, c.photoport, cc.estado FROM ciclo_curso cc INNER JOIN curso c ON c.id_curso = cc.id_curso INNER JOIN tipo_curso tp ON tp.id_tipocurso = c.id_tipo_curso INNER JOIN profesor p ON p.id_profesor = cc.id_profesor INNER JOIN usuario us ON us.id_usuario = p.id_usuario 
WHERE cc.estado <> 0 
AND c.estado <> 0 
AND cc.id_curso = id_curso
ORDER BY cc.estado 
ASC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_conttarea` (IN `id_conttar` INT)   BEGIN
# LEER LA INFORMACION DEL CONTENIDO DE TAREA
SELECT * FROM conte_tarea ct WHERE ct.id_conte_tarea = id_conttar ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_idinscripconttar` (IN `id_conttar` INT, IN `id_alum` INT)  NO SQL BEGIN
# Retorna la id de inscripccion desde un contenido de curso y el id del alumno
SELECT ins.id_inscrip 
FROM inscripcciones ins
INNER JOIN ciclo_curso cc ON cc.id_ciclo_curso = ins.id_ciclo_curso
INNER JOIN sesiones sen ON sen.id_ciclocurso = cc.id_ciclo_curso
INNER JOIN conte_tarea ct ON ct.id_sesion = sen.id_sesion
INNER JOIN alumno alu ON alu.id_alumno = ins.id_alumno
WHERE ct.id_conte_tarea = id_conttar
AND alu.id_alumno = id_alum ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_profe` (IN `id_profe` INT)  NO SQL BEGIN
# LISTAR LOS PROFESORES
SELECT prof.id_profesor ,us.nombre, us.correo, us.telf, us.pass, us.photo,  prof.estudios
FROM profesor prof
INNER JOIN usuario us ON us.id_usuario = prof.id_usuario 
WHERE us.estado = 1
AND prof.id_profesor = id_profe;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_admin` (IN `id_admin` INT, IN `name` VARCHAR(100), IN `correo` VARCHAR(100), IN `telf` INT(9), IN `pass` VARCHAR(15), IN `photo` VARCHAR(400), IN `tipo_trab` VARCHAR(100))  NO SQL BEGIN
#ACTUALIZAR LA INFO DEL PROFESOR
UPDATE admin adm SET adm.tipo_trabajador = tipo_trab WHERE adm.id_admin = id_admin ;
#ACTUALIZAR INFORMACION DEL USUARIO
SET @id_user = (SELECT ad.id_usuario FROM admin ad WHERE ad.id_admin = id_admin);
# -------------------------------------
UPDATE usuario us SET us.usser = correo , us.pass = pass , us.nombre = name , us.telf = telf , us.correo =  correo , us.photo = photo WHERE us.id_usuario = @id_user ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_alumno` (IN `id_alumno` INT, IN `name` VARCHAR(100), IN `correo` VARCHAR(100), IN `telf` INT(9), IN `pass` VARCHAR(15), IN `photo` VARCHAR(400), IN `edad` INT(3), IN `name_tutro` VARCHAR(100), IN `id_tutoralumno` INT)  NO SQL BEGIN
#ACTUALIZAR LA INFO DEL PROFESOR
UPDATE alumno al SET al.edad = edad, al.name_tutor = name_tutro, al.id_tutor_alumno = id_tutoralumno, al.telf_tutor = telf WHERE al.id_alumno = id_alumno ;
#ACTUALIZAR INFORMACION DEL USUARIO
SET @id_user = (SELECT a.id_usuario FROM alumno a WHERE a.id_alumno = id_alumno);
# -------------------------------------
UPDATE usuario us SET us.usser = correo , us.pass = pass , us.nombre = name , us.telf = telf , us.correo =  correo , us.photo = photo WHERE us.id_usuario = @id_user ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_ciclocourseStade` ()  NO SQL BEGIN
# ACTUALIZAR ESTADO DE LOS CURSOS
# -- Actualizar si el curso ya empeso
UPDATE `ciclo_curso`
SET `estado` = 2
WHERE (now() BETWEEN `ciclo_curso`.`fecha_init` AND `ciclo_curso`.`fecha_fin`);
# -- Actualizar si el curso ya termino
UPDATE `ciclo_curso`
SET `estado` = 3
WHERE (now() > `ciclo_curso`.`fecha_fin`);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_ciclocurso` (IN `idciclcur` INT, IN `idcurso` INT, IN `idprofe` INT, IN `fechini` DATE, IN `fechfin` DATE, IN `diasduc` INT, IN `presio` DECIMAL)  NO SQL BEGIN
# ACTUALIZAR EL CICLO DEL CURSO
UPDATE `ciclo_curso` SET `id_curso`= idcurso ,`id_profesor`= idprofe ,`fecha_init`= fechini ,`fecha_fin`= fechfin,`presio_inscri`= presio ,`dias_durac`= diasduc WHERE `ciclo_curso`.`id_ciclo_curso` = idciclcur;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_contsesion` (IN `id_conteses` INT, IN `id_tipoconte` INT, IN `name` VARCHAR(100), IN `descripcc` VARCHAR(300), IN `url_cont` VARCHAR(400))  NO SQL BEGIN
# ACTUALIZAR EL CONTENIDO DE LA SESSION
UPDATE `conte_sesion` SET `id_tipo_conte`= id_tipoconte,`nombre_conte`= name,`descripccion`= descripcc,`url_contenido`= url_cont WHERE `conte_sesion`.`id_conte_sesion` = id_conteses ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_conttarea` (IN `id_contacti` INT, IN `name` VARCHAR(100), IN `descripcc` VARCHAR(300), IN `url_cont` VARCHAR(400))  NO SQL BEGIN
# ACTUALIZAR EL CONTENIDO DE TAREA
UPDATE `conte_tarea` SET `nombre`= name , `descripc`= descripcc , `urlconte` = url_cont WHERE `conte_tarea`.`id_conte_tarea` = id_contacti ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_curso` (IN `id_curso` INT, IN `id_tipcur` INT, IN `name` VARCHAR(100), IN `descr` VARCHAR(500), IN `alcan` VARCHAR(500), IN `contvid` VARCHAR(2000), IN `photpo` VARCHAR(400))  NO SQL BEGIN
# ACTUALIZANDO TALLERES
UPDATE `curso` SET `id_tipo_curso`= id_tipcur ,`nombre`= name , `descripccion`= descr,`alcance`= alcan, `content_video`= contvid ,`photoport`= photpo WHERE `curso`.`id_curso` = id_curso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_pointclas` (IN `name` VARCHAR(100), IN `valpoint` INT, IN `photo` VARCHAR(400), IN `id_pointclass` INT, IN `isacumulado` INT)   BEGIN
# ACTUALIZAR LOS PUNTOS
UPDATE `puntosclass` SET `nombre`= name ,`value_point`= valpoint ,`photo`= photo , `isacumulado` = isacumulado WHERE id_tipo_puntos = id_pointclass;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_profesor` (IN `id_profe` INT, IN `name` VARCHAR(100), IN `telf` INT(9), IN `correo` VARCHAR(100), IN `pass` VARCHAR(15), IN `photo` VARCHAR(400), IN `estudios` VARCHAR(200))  NO SQL BEGIN
#ACTUALIZAR LA INFO DEL PROFESOR
UPDATE `profesor` SET `estudios`= estudios WHERE `id_profesor` = id_profe;
#ACTUALIZAR INFORMACION DEL USUARIO
SET @id_user = (SELECT p.id_usuario FROM profesor p WHERE p.id_profesor = id_profe);
# -------------------------------------
UPDATE `usuario` SET `usser`= correo ,`pass`= pass ,`nombre`= name ,`telf`= telf ,`correo`=  correo ,`photo`= photo WHERE `id_usuario` = @id_user;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_sesion` (IN `id_sesion` INT, IN `name` VARCHAR(100))  NO SQL BEGIN
# ACTUALIZAR LA SESION DEL CURSO
UPDATE `sesiones` SET `nombre`= name WHERE `sesiones`.`id_sesion` = id_sesion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_stadeinscrip` (IN `idinscrp` INT, IN `estade` INT)  NO SQL BEGIN
# ACTUALIZAR EL ESTADO DE LAS PRE-INSCRIPCCIONES
UPDATE `inscripcciones` SET `estado` = estade WHERE `inscripcciones`.`id_inscrip` = idinscrp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_stadoasisten` (IN `id_asisins` INT, IN `estade` INT)   BEGIN
# ACTUALIZAR EL ESTADO DE LA ASISTENCIA
UPDATE `asist_inscrip` 
SET `estado_asistenc`= estade
WHERE `asist_inscrip`.`id_asis_inscrip` = id_asisins ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_tareainsc` (IN `id_tarins` INT, IN `urlcont` VARCHAR(400))  NO SQL BEGIN
UPDATE `tarea_conte_inscr`
SET `urlconte`= urlcont
WHERE `tarea_conte_inscr`.`id_tarea_inscri` = id_tarins ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_tareainsc_ponint` (IN `id_tarinsc` INT, IN `point` INT)  NO SQL BEGIN
# ACTUALIZAR LOS PUNTOS DE UNA TAREA
UPDATE `tarea_conte_inscr` SET `puntos` = point  WHERE `tarea_conte_inscr`.`id_tarea_inscri` = id_tarinsc ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_tipocurso` (IN `id_tipocurso` INT, IN `name` VARCHAR(100))  NO SQL BEGIN
# ACTUALIZAR EL TIPO DE TRABAJO
UPDATE `tipo_curso` SET `name` = name WHERE `tipo_curso`.`id_tipocurso` = id_tipocurso ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valider_couse_ciclo` (IN `id_curso` INT)  NO SQL BEGIN
# ACTUALIZAR ESTADO DE LOS CURSOS
# -- Actualizar si el curso ya empeso
UPDATE `ciclo_curso`
SET `estado` = 2
WHERE (now() BETWEEN `ciclo_curso`.`fecha_init` AND `ciclo_curso`.`fecha_fin`);
# -- Actualizar si el curso ya termino
UPDATE `ciclo_curso`
SET `estado` = 3
WHERE (now() > `ciclo_curso`.`fecha_fin`);
# --------------------------------------------
# RETORNA EL ULTIMO CICLO DE UN CURSO
SELECT * FROM ciclo_curso cc WHERE cc.estado = 1 AND cc.id_curso = id_curso ORDER BY cc.id_curso DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valider_inscpointclas` (IN `id_sesion` INT, IN `id_inscrip` INT, IN `id_tipopunt` INT)   BEGIN
# VALIDAR SI UN PUNTO YA FUE INGRESADO AL USUARIO
SELECT ips.id_inscrip_p_sea
FROM inscrip_point_sesion ips
WHERE ips.id_inscrip = id_inscrip
AND ips.id_sesion =  id_sesion
AND ips.id_tipo_punto = id_tipopunt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valider_inscricurse` (IN `idalumno` INT, IN `idciclocur` INT)  NO SQL BEGIN
# VALIDA SI UN ALUMNO YA SE REGISTRO AL CICLO DE UN CURSO
SELECT * FROM inscripcciones icp WHERE icp.id_alumno = idalumno AND icp.id_ciclo_curso = idciclocur AND icp.estado <> 0 ;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `promedio_asisten_ciclo` (`id_ciclo` INT) RETURNS DECIMAL(10,0) UNSIGNED NO SQL BEGIN
DECLARE promedioasisten DECIMAL DEFAULT 0.0;
#-------------------------------------------
# ESTA CONSULTA EXTRAE LA CANTIDAD DE DIAS DE DURACION DE UN CICLO DE CURSO
SET @cantidat = (SELECT cc.dias_durac  FROM ciclo_curso cc WHERE cc.id_ciclo_curso = id_ciclo);
# ESTA CONSULTA EXTRAE LA CANTIDAD DE INSCRITOS EN EL CICLO
SET @cantiinsc = (SELECT COUNT(ins.id_inscrip) FROM inscripcciones ins WHERE ins.id_ciclo_curso = id_ciclo);
# ESTA CONSULTA EXTRAE EL PROMEDIO DE LAS ASISTENCIAS DE LOS INSCRITOS EN EL CURSO
SET @promedioasistetotal = (SELECT SUM(asin2.promasis)/@cantiinsc
FROM (SELECT asin.id_inscrip, asin.id_alumno, ((asin.cantiasisten * 100)/ @cantidat) AS promasis
FROM (SELECT ins2.id_inscrip, ins2.id_alumno, (SELECT COUNT(asis.id_asis_inscrip)  
FROM asist_inscrip asis 
INNER JOIN inscripcciones ins ON ins.id_inscrip = asis.id_inscrip
INNER JOIN ciclo_curso cc ON cc.id_ciclo_curso = ins.id_ciclo_curso  
WHERE asis.estado_asistenc = 1 
AND ins.id_inscrip = ins2.id_inscrip
AND cc.id_ciclo_curso = cc2.id_ciclo_curso) as cantiasisten
FROM inscripcciones ins2
INNER JOIN ciclo_curso cc2 ON cc2.id_ciclo_curso = ins2.id_ciclo_curso
WHERE cc2.id_ciclo_curso = id_ciclo) asin) as asin2);
# IMPRIMIR DEL EL PROMEDIO DE ASISTENCIAS DEL CICLO
SET promedioasisten = (SELECT @promedioasistetotal);
RETURN promedioasisten ;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `tipo_trabajador` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` VALUES
(15, 'A', 50),
(16, 'Administrador', 71);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `id_alumno` int(11) NOT NULL,
  `edad` int(3) NOT NULL,
  `name_tutor` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telf_tutor` int(9) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_tutor_alumno` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` VALUES
(19, 13, 'Carlos Alberto Guerrero Garcia.', 985796307, 49, 2),
(20, 13, 'Carlos Alberto Guerrero Garcia.', 985796307, 52, 2),
(21, 13, 'Carlos Alberto Guerrero Garcia.', 985796307, 55, 2),
(22, 18, 'desconocido', 969280255, 61, 0),
(23, 13, 'Carlos Alberto Guerrero Garcia.', 985796307, 62, 2),
(24, 13, 'Carlos Alberto Guerrero Garcia.', 985796307, 63, 2),
(25, 13, 'Carlos Alberto Guerrero Garcia.', 985796307, 64, 2),
(26, 13, 'Carlos Alberto Guerrero Garcia.', 985796307, 65, 3),
(27, 18, 'desconocido', 985796307, 67, 0),
(28, 18, 'desconocido', 969280255, 69, 0),
(29, 13, 'Carlos Alberto Guerrero Garcia.', 985796307, 70, 5),
(30, 18, 'desconocido', 959896301, 80, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `id_asisten` int(11) NOT NULL,
  `fecha_asist` date NOT NULL,
  `id_sesion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `asistencia`
--

INSERT INTO `asistencia` VALUES
(8, '2022-07-19', 0),
(9, '2022-11-03', 0),
(11, '2022-11-10', 44);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asist_inscrip`
--

CREATE TABLE `asist_inscrip` (
  `id_asis_inscrip` int(11) NOT NULL,
  `id_inscrip` int(11) NOT NULL,
  `id_asisten` int(11) NOT NULL,
  `estado_asistenc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `asist_inscrip`
--

INSERT INTO `asist_inscrip` VALUES
(19, 33, 8, 1),
(20, 41, 9, 1),
(24, 41, 11, 0),
(25, 43, 11, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciclo_curso`
--

CREATE TABLE `ciclo_curso` (
  `id_ciclo_curso` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `id_profesor` int(11) NOT NULL,
  `fecha_init` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `presio_inscri` decimal(10,0) NOT NULL,
  `dias_durac` int(11) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `ciclo_curso`
--

INSERT INTO `ciclo_curso` VALUES
(25, 14, 18, '2022-07-23', '2022-07-30', '0', 4, 3),
(26, 15, 19, '2022-07-29', '2022-08-20', '51', 6, 3),
(27, 14, 17, '2022-09-30', '2022-10-27', '0', 16, 3),
(28, 14, 17, '2022-10-13', '2022-10-31', '0', 16, 3),
(29, 15, 17, '2022-11-22', '2022-12-23', '0', 10, 1),
(30, 14, 19, '2022-11-22', '2022-12-23', '20', 10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conte_sesion`
--

CREATE TABLE `conte_sesion` (
  `id_conte_sesion` int(11) NOT NULL,
  `id_sesion` int(11) NOT NULL,
  `id_tipo_conte` int(11) NOT NULL,
  `nombre_conte` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `descripccion` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `url_contenido` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `conte_sesion`
--

INSERT INTO `conte_sesion` VALUES
(12, 31, 2, 'Documento introductorio al curso', 'Este contenido mostrara la información de lo que consistirá el curso, y como podrá llevarse.', 'https://docs.google.com/document/u/4/d/1Lz6KG0JnpZR_RrIWExop89zUeruIOGsF/edit?usp=drive_web&ouid=117600574556503796928&rtpof=true', 1),
(13, 31, 2, 'Documento introductorio al curso', 'Este contenido mostrara la información de lo que consistirá el curso, y como podrá llevarse.', 'https://docs.google.com/document/u/4/d/1Lz6KG0JnpZR_RrIWExop89zUeruIOGsF/edit?usp=drive_web&ouid=117600574556503796928&rtpof=true', 0),
(14, 31, 1, 'Video del curso interactivo', 'Este video explica en lo que va a tratar el curso y cual sera el primer tema a tocar', 'https://www.youtube.com/watch?v=kdE6ZmT_5MI', 0),
(15, 33, 2, 'Documento de prueba', 'Descripcciion del contenido de prueba', 'https://docs.google.com/document/d/1Lz6KG0JnpZR_RrIWExop89zUeruIOGsF/edit', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `conte_tarea`
--

CREATE TABLE `conte_tarea` (
  `id_conte_tarea` int(11) NOT NULL,
  `id_sesion` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `descripc` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `urlconte` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `point_max` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `conte_tarea`
--

INSERT INTO `conte_tarea` VALUES
(9, 32, 'Resolver un Biuyer Person', 'Resuelve la tarea', 'https://docs.google.com/document/d/1Lz6KG0JnpZR_RrIWExop89zUeruIOGsF/edit', 1, 5),
(10, 40, 'Ingresar una Imagen de una planta', 'La idea de la tarea es que puedas ingresar la imagen de una planta.', 'https://www.google.com.pe/', 1, 5),
(11, 42, 'tarea 1', 'descripccion de la tarea 1', 'https://www.youtube.com/watch?v=DdlQGnN0kEw', 1, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correoslp`
--

CREATE TABLE `correoslp` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `asunto` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mensaje` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `correoslp`
--

INSERT INTO `correoslp` VALUES
(144, 'Luther Hodkiewicz', 'Maryland', 'Krystel.Breitenberg@gmail.com', 'transmitter'),
(143, 'Ana', 'Padilla', 'alupa25@yahoo.com', 'Información '),
(142, 'Graciela Becker V', 'Table', 'kerry@naturafocusinc.com', 'Planner'),
(141, 'Ignatius Herman', 'Personal Loan Account', 'kenleahardware@aol.com', 'quantify'),
(140, 'Liam Murphy', 'Route', 'natehogan34@gmail.com', 'frictionless'),
(139, 'Clyde Mills', 'Shoes', 'condada02@comcast.net', 'installation'),
(138, 'Ambrose Little III', 'leading edge', 'admin@daniellecoccomo.com', 'facilitate'),
(137, 'Virgil Weimann', 'Mozambique', 'hunts.glad@outlook.com', 'Wyoming'),
(136, 'Clay DuBuque', 'panel', 'lawbisnesss777@gmail.com', 'New Jersey'),
(135, 'Lera Hand', 'technologies', 'gottliebixz05@gmail.com', 'Product'),
(134, 'Lillie Tremblay', 'harness', 'dplotsky@gmail.com', 'Auto Loan Account'),
(133, 'Josiah Hintz', 'Mobility', 'paul@mail.manti.com', 'Mouse'),
(132, 'Alanis Stroman', 'Metal', 'granadossal@yahoo.com', 'yellow'),
(131, 'Sofia Reinger', 'Wells', 'jsangell@msn.com', 'Bedfordshire'),
(130, 'Lucy Zboncak', 'matrix', 'kate.baumgartner@sequoyah.com', 'withdrawal'),
(129, 'Ben Kreiger', 'interfaces', 'nemesis56@orange.fr', 'Bulgaria'),
(128, 'Electa Pouros', 'Kentucky', 'alexisfeb8@msn.com', 'Money Market Account'),
(127, 'Green Crona MD', 'virtual', 'kdckids1@gmail.com', 'open-source'),
(126, 'OMULNR', 'CKEWBA', 'info@domainregistercorp.com', 'Notice#: 491343\r\nDate: 2021-02-11  \r\n\r\nYOUR IMMEDIATE ATTENTION TO THIS MESSAGE IS ABSOLUTELY NECESSARY!\r\n\r\nYOUR DOMAIN canvaritech.com WILL BE TERMINATED WITHIN 24 HOURS\r\n\r\nWe have not received your payment for the renewal of your domain canvaritech.com\r'),
(125, 'Shana Hayes', 'Decentralized', 'keepitgypsy@hotmail.com', 'Electronics'),
(124, 'Jasmin Balistreri', 'Savings Account', 'kylesteinmann@yahoo.com', 'Cordoba Oro'),
(123, 'Jordan Jacobi', 'Credit Card Account', 'helenandstewart@hotmail.com', 'Shore'),
(122, 'William Lockman', 'Ergonomic Granite Chicken', 'wilfriedmac@gmail.com', 'Shirt'),
(121, 'Tyree Zieme', 'Salad', 'mircidtra@gmail.com', 'wireless'),
(120, 'Ethan Nikolaus', 'Tanzanian Shilling', 'info@work-info.name', 'Automotive'),
(119, 'Amara Hagenes', 'Interactions', 'paulinecresp@gmail.com', 'sky blue'),
(118, 'Torrance Stanton', 'Unions', 'christopherlitherland@gmail.com', 'Nebraska'),
(117, 'Destiney Lubowitz', 'Michigan', 'josphine.chow@yahoo.com', 'override'),
(116, 'Anderson Waters', 'seize', 'mturek2016@gmail.com', 'Tasty Cotton Sausages'),
(115, 'Leonie Bode', 'Bedfordshire', 'Deanna.Ferry34@gmail.com', 'hacking'),
(114, 'Jermain Bernier', 'Licensed Granite Hat', 'cedeira@aol.com', 'out-of-the-box'),
(113, 'Raymundo Barrows', 'copying', 'rietman.iryna@gmail.com', 'Group'),
(112, 'Rosina Gutkowski', 'indexing', 'v.rosay42@gmail.com', 'redundant'),
(111, 'Carol Hayes', 'Unbranded Plastic Table', 'mckenzier@lamphereschools.org', 'SSL'),
(110, 'Kianna Jacobi', 'Fantastic Soft Tuna', 'kpitman2255@gmail.com', 'Buckinghamshire'),
(109, 'Aiden Torphy DDS', 'moratorium', 'sridharan.s@husky.neu.edu', 'Key'),
(108, 'Bobbie Hirthe', 'purple', 'onelovetyi@yahoo.com', 'Netherlands Antillian Guilder'),
(107, 'Emory Wuckert', 'invoice', 'kenpilot1976@aol.com', 'Enterprise-wide'),
(106, 'Bruce Kuphal', 'Investment Account', 'donnastrubel@yahoo.com', 'Producer'),
(105, 'Jasen Von', 'transmitter', 'leannhilton@hiltonmgmt.com', 'maroon'),
(104, 'Estell Monahan', 'Unbranded', 'colochel@hotmail.com', 'back-end'),
(103, 'Gardner Graham', 'Communications', 'gregglander@email.com', 'Awesome'),
(102, 'Jimmie Hagenes', 'capacitor', 'autumnlc20@gmail.com', 'synthesize'),
(101, 'Malcolm Reichel III', 'Checking Account', 'jaffe.maya@gmail.com', 'Bedfordshire'),
(100, 'Leon Braun', 'Assistant', 'freckles99@yahoo.com', 'Awesome'),
(99, 'Lionel Bartell', 'process improvement', 'interac226@protonmail.com', 'parsing'),
(98, 'Maribel Schmeler', 'Metal', 'ambouw@aol.com', 'Home Loan Account'),
(97, 'Anderson', 'Prueba desde produccion', 'andersongarciavarillas@gmail.com', 'Esto es una prueba desde canvaritech'),
(96, 'Anderson', 'Prueba desde produccion', 'andersongarciavarillas@gmail.com', 'Esto es una prueba desde canvaritech.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correossa`
--

CREATE TABLE `correossa` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `asunto` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `mensaje` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `correossa`
--

INSERT INTO `correossa` VALUES
(1, 'Anderson', 'Prueba desde produccion', 'andersongarciavarillas@gmail.com', 'Esto es una prueba desde super ada'),
(2, 'Ana padilla', 'Curso', 'alupa25@yahoo.com', 'Información ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL,
  `id_tipo_curso` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `descripccion` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `alcance` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `content_video` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photoport` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` VALUES
(10, 1, 'MODELO DE NEGOCIOS CANVAS PARA NIÑOS', 'El modelo de negocios Canvas para niños les permite aprender a definir y crear estructuras de empresas innovadoras donde podrán reconocer las áreas que componen una organización como son: Marketing, Finanzas y Administración, de una forma sencilla de tal manera que despierten su espíritu emprendedor.', 'Desconocido', '<div> No se encuentra ningun video </div>', 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg', 0),
(13, 1, 'MODELO DE NEGOCIOS CANVAS PARA NIÑOS', 'El modelo de negocios Canvas para niños les permite aprender a definir y crear estructuras de\nempresas innovadoras donde podrán reconocer las áreas que componen una organización como son: Marketing, Finanzas y Administración, de una forma sencilla de tal manera que despierten su espíritu emprendedor.', 'Desconocido', '<div> No se encuentra ningun video </div>', 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg', 0),
(14, 1, 'MODELO DE NEGOCIOS CANVAS PARA NIÑOS', 'El modelo de negocios Canvas para niños les permite aprender a definir y crear estructuras de empresas innovadoras donde podrán reconocer las áreas que componen una organización como son: Marketing, Finanzas y Administración, de una forma sencilla de tal manera que despierten su espíritu emprendedor.', 'Aprender a como poder usar la herramienta de canvas.', '<div> No se encuentra ningun video </div>', 'http://res.cloudinary.com/canvarith/image/upload/v1658091878/Images/i2u8br52lsmhxjhm9tqj.png', 1),
(15, 15, 'Minecraft Edu, Roblox y Scratch Programación y Creatividad para niñ@s', 'Aprenderán a programar, primero en Bloques, luego en LUA y finalmente en Python. Sin embargo, destacamos que el beneficio principal será el de incorporar el pensamiento lógico, que se ejercita con la programación. El mismo servirá tanto para seguir programando, como también para usar en situaciones de la vida cotidiana que requieran de un análisis para tomar la mejor decisión. Aprenderán adicionalmente a crear, a comunicarse y a trabajar en equipo.', 'Programación, pensamiento lógico, pensamiento computacional, creatividad, comunicación y colaboración', '<div> No se encuentra ningun video </div>', 'http://res.cloudinary.com/canvarith/image/upload/v1658263126/Images/wingoxutfblqxevyzreq.jpg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripcciones`
--

CREATE TABLE `inscripcciones` (
  `id_inscrip` int(11) NOT NULL,
  `id_alumno` int(11) NOT NULL,
  `id_ciclo_curso` int(11) NOT NULL,
  `id_tipo_inscrip` int(11) NOT NULL,
  `url_voucher` varchar(400) COLLATE utf8_unicode_ci DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `fechainscri` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `inscripcciones`
--

INSERT INTO `inscripcciones` VALUES
(33, 20, 25, 1, '', 1, '2022-07-19 15:26:21'),
(34, 20, 26, 2, 'http://res.cloudinary.com/canvarith/image/upload/v1658263480/Images/ctcv8xksr11334u2uhsc.jpg', 1, '2022-07-19 15:44:42'),
(35, 21, 25, 1, '', 1, '2022-07-19 20:44:32'),
(36, 21, 26, 2, 'http://res.cloudinary.com/canvarith/image/upload/v1658281750/Images/ksdojbk632lq1uknauhl.jpg', 1, '2022-07-19 20:49:11'),
(37, 21, 28, 1, '', 1, '2022-09-30 11:39:21'),
(38, 20, 28, 1, '', 1, '2022-10-02 23:17:08'),
(39, 19, 29, 1, '', 1, '2022-10-23 13:26:10'),
(40, 22, 29, 1, '', 1, '2022-11-02 20:35:57'),
(41, 28, 30, 2, 'http://res.cloudinary.com/canvarith/image/upload/v1667484937/Images/qlpzllc1z0ipqbaqhn8g.jpg', 1, '2022-11-03 09:15:37'),
(42, 28, 29, 1, '', 1, '2022-11-03 09:15:54'),
(43, 29, 30, 2, 'http://res.cloudinary.com/canvarith/image/upload/v1667505318/Images/jihfo5mkzdxsqm4jqwbj.jpg', 1, '2022-11-03 14:55:19'),
(44, 30, 30, 2, 'http://res.cloudinary.com/canvarith/image/upload/v1668272900/Images/qlhnbzv0ylwbrfc2nrdw.jpg', 2, '2022-11-12 12:08:19'),
(45, 25, 29, 1, '', 1, '2022-11-16 11:28:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscrip_point_sesion`
--

CREATE TABLE `inscrip_point_sesion` (
  `id_inscrip_p_sea` int(11) NOT NULL,
  `id_inscrip` int(11) NOT NULL,
  `id_tipo_punto` int(11) NOT NULL,
  `id_sesion` int(11) NOT NULL,
  `fecha_point` datetime NOT NULL,
  `stade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `inscrip_point_sesion`
--

INSERT INTO `inscrip_point_sesion` VALUES
(1, 37, 6, 41, '2022-10-01 18:08:24', 1),
(2, 37, 9, 40, '2022-10-01 18:08:39', 0),
(3, 37, 12, 40, '2022-10-01 18:09:09', 0),
(4, 37, 6, 40, '2022-10-01 18:14:28', 1),
(5, 37, 1, 40, '2022-10-01 18:15:32', 1),
(6, 37, 12, 40, '2022-10-01 19:34:40', 0),
(7, 37, 9, 40, '2022-10-01 20:27:59', 0),
(8, 37, 1, 40, '2022-10-02 01:07:07', 0),
(9, 38, 2, 41, '2022-10-02 23:20:28', 1),
(10, 37, 2, 40, '2022-10-03 19:28:55', 1),
(11, 37, 15, 40, '2022-10-04 11:12:41', 0),
(12, 37, 2, 40, '2022-10-04 11:14:42', 0),
(13, 0, 1, 40, '2022-10-04 11:15:04', 1),
(14, 37, 1, 40, '2022-10-04 11:15:12', 0),
(15, 0, 1, 40, '2022-10-04 11:17:21', 1),
(16, 37, 1, 40, '2022-10-04 11:17:31', 1),
(17, 37, 1, 40, '2022-10-04 11:17:38', 1),
(18, 37, 1, 40, '2022-10-04 11:17:53', 0),
(19, 37, 19, 40, '2022-10-06 10:19:54', 1),
(20, 37, 19, 40, '2022-10-06 10:20:37', 0),
(21, 37, 19, 40, '2022-10-06 10:57:54', 0),
(22, 37, 19, 40, '2022-10-06 11:00:54', 0),
(23, 37, 21, 40, '2022-10-06 11:19:19', 0),
(24, 37, 21, 40, '2022-10-06 11:21:33', 1),
(25, 37, 21, 40, '2022-10-06 11:21:55', 1),
(26, 37, 12, 40, '2022-10-06 11:23:18', 1),
(27, 37, 12, 40, '2022-10-06 11:23:24', 0),
(28, 39, 15, 42, '2022-10-23 13:32:09', 1),
(29, 0, 8, 43, '2022-10-23 13:33:23', 1),
(30, 0, 1, 42, '2022-10-23 13:33:31', 1),
(31, 39, 1, 42, '2022-10-23 13:37:38', 1),
(32, 39, 1, 42, '2022-10-23 13:40:20', 0),
(33, 41, 22, 44, '2022-11-03 10:30:14', 0),
(34, 41, 23, 44, '2022-11-03 10:30:50', 0),
(35, 41, 23, 44, '2022-11-03 10:31:06', 0),
(36, 41, 22, 45, '2022-11-03 10:31:42', 0),
(37, 41, 23, 45, '2022-11-03 10:32:03', 0),
(38, 41, 35, 44, '2022-11-09 12:17:14', 1),
(39, 41, 36, 44, '2022-11-09 12:17:29', 1),
(40, 41, 35, 44, '2022-11-09 12:18:00', 1),
(41, 41, 36, 45, '2022-11-09 12:19:26', 1),
(42, 41, 37, 45, '2022-11-09 12:20:28', 1),
(43, 41, 37, 45, '2022-11-09 12:20:43', 1),
(44, 41, 37, 44, '2022-11-09 21:43:34', 1),
(45, 41, 37, 44, '2022-11-09 21:43:40', 0),
(46, 43, 36, 44, '2022-11-09 21:46:27', 1),
(47, 43, 37, 44, '2022-11-09 21:46:32', 1),
(48, 43, 36, 45, '2022-11-09 21:46:41', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE `profesor` (
  `id_profesor` int(11) NOT NULL,
  `estudios` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` VALUES
(17, 'Universidad Privada de piura', 51),
(18, 'Universidad de Piura', 53),
(19, 'Universidad Privada de piura', 54),
(20, 'Universidad cesar vallejo', 56),
(21, 'Universidad Privada de piura', 72),
(22, 'Universidad Privada', 73),
(23, 'Universidad Cesar Vallejo', 74),
(24, 'Univercity Cesar', 75),
(25, 'Univercidad Cesar Vallejo', 76),
(26, 'UCV', 77),
(27, 'UNP', 78);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puntosclass`
--

CREATE TABLE `puntosclass` (
  `id_tipo_puntos` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `value_point` int(11) NOT NULL,
  `photo` varchar(400) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_profesor` int(11) NOT NULL,
  `stade` int(11) NOT NULL,
  `isacumulado` int(11) NOT NULL,
  `isdefault` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `puntosclass`
--

INSERT INTO `puntosclass` VALUES
(1, 'asistencia', 2, '4', 17, 1, 1, 0),
(2, 'realizo tarrr', 1, '6', 17, 1, 0, 0),
(3, 'no participo', -1, '', 20, 1, 1, 0),
(4, 'Participación grupal', 1, '5', 20, 1, 0, 0),
(5, 'participo', 1, '', 20, 1, 1, 0),
(6, 'participacion', 1, '3', 17, 0, 1, 0),
(7, 'no participa', -1, '', 17, 0, 1, 0),
(8, 'puntualidad', 1, '', 17, 1, 1, 0),
(9, 'no participo', -1, '2', 17, 1, 1, 0),
(10, 'Puntualidad', 1, '3', 17, 1, 1, 0),
(11, 'Puntualidad', 1, '3', 17, 0, 1, 0),
(12, 'inasistencia', -2, '2', 17, 1, 0, 0),
(13, 'Primero en responder', 2, '8', 17, 0, 1, 0),
(14, 'generico', 1, '7', 17, 0, 1, 0),
(15, 'participacion', 1, '6', 17, 1, 1, 0),
(16, 'No Participo', 1, '2', 17, 0, 1, 0),
(17, 'No Participo', -1, '2', 17, 1, 1, 0),
(18, 'participo', 1, '1', 20, 1, 1, 0),
(19, 'Participación grupal', 1, '5', 17, 1, 0, 0),
(20, 'Asistencia', 1, '6', 17, 0, 0, 0),
(21, 'Asistencia', 1, '6', 17, 1, 1, 0),
(22, 'Asistencia', 1, '1', 19, 0, 0, 0),
(23, 'Realizo Tarea', 1, '3', 19, 0, 1, 0),
(24, 'participo', 1, '1', 21, 1, 0, 0),
(25, 'Participación', 1, '3', 19, 0, 1, 0),
(26, 'Asistencia', 1, '1', 21, 0, 0, 1),
(27, 'Participacion', 1, '4', 21, 0, 1, 1),
(28, 'Resolvio Tarea', 1, '6', 21, 0, 1, 1),
(29, 'Asistencia', 1, '1', 21, 1, 0, 1),
(30, 'Participacion', 1, '4', 21, 1, 1, 1),
(31, 'Resolvio Tarea', 1, '6', 21, 1, 1, 1),
(32, 'Asistencia', 1, '1', 19, 0, 0, 1),
(33, 'Participacion', 1, '4', 19, 0, 1, 1),
(34, 'Resolvio Tarea', 1, '6', 19, 0, 1, 1),
(35, 'Da su Opinion', 1, '7', 19, 1, 1, 0),
(36, 'Asistencia', 1, '1', 19, 1, 0, 1),
(37, 'Participacion', 1, '4', 19, 1, 1, 1),
(38, 'Resolvio Tarea', 1, '6', 19, 1, 1, 1),
(39, 'Asistencia', 1, '1', 22, 1, 0, 1),
(40, 'Participacion', 1, '4', 22, 1, 1, 1),
(41, 'Resolvio Tarea', 1, '6', 22, 1, 1, 1),
(42, 'Asistencia', 1, '1', 26, 1, 0, 1),
(43, 'Participacion', 1, '4', 26, 1, 1, 1),
(44, 'Resolvio Tarea', 1, '6', 26, 1, 1, 1),
(45, 'Asistencia', 1, '1', 27, 0, 0, 1),
(46, 'Participacion', 1, '4', 27, 0, 1, 1),
(47, 'Resolvio Tarea', 1, '6', 27, 0, 1, 1),
(48, 'Asistencia', 1, '1', 27, 0, 0, 1),
(49, 'Participacion', 1, '4', 27, 0, 1, 1),
(50, 'Resolvio Tarea', 1, '6', 27, 0, 1, 1),
(51, 'Asistencia', 1, '1', 27, 0, 0, 1),
(52, 'Participacion', 1, '4', 27, 0, 1, 1),
(53, 'Resolvio Tarea', 1, '6', 27, 0, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sesiones`
--

CREATE TABLE `sesiones` (
  `id_sesion` int(11) NOT NULL,
  `id_ciclocurso` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `sesiones`
--

INSERT INTO `sesiones` VALUES
(31, 25, 'Introducción al curso', 1),
(32, 25, 'Buyer Person', 1),
(33, 25, ' Propuesta de Valor', 1),
(34, 25, 'Canales', 1),
(35, 25, 'Relación con Cliente', 1),
(36, 25, 'Cierre de Módulo', 1),
(37, 27, 'Sesion 1', 1),
(38, 27, 'Sesion 2', 1),
(39, 28, 'sesion 1', 0),
(40, 28, 'Sesion 2', 1),
(41, 28, 'sesion 3', 1),
(42, 29, 'Sesion 1', 1),
(43, 29, 'Sesion 2', 1),
(44, 30, 'sesion 1', 1),
(45, 30, 'sesion 2', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sing_log`
--

CREATE TABLE `sing_log` (
  `id_sing_log` int(11) NOT NULL,
  `seccion_key` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `api_key` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `fecha_peticion` datetime NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `sing_log`
--

INSERT INTO `sing_log` VALUES
(110, '20da75b4-d3e9-452b-bab1-5a08a3351035', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODA4MjY0MX0.WpyyjoUomyVab0weyXZzX1wicGMBp8kG_EiFWaAhFZ8', '2022-07-17 13:30:41', 49),
(111, '8c988140-9890-4bb0-835c-f0c36234060a', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODA4MzM2Mn0.Qdld8YUyQAcL_Or5z1hmxNurJg-2rsAuH3vXlTKtB0k', '2022-07-17 13:42:42', 50),
(112, '09d97ffb-25ec-440b-9ef5-7680820f4560', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODA5MjQwMH0.AG9GY5FKmSpfOLflBAs4Aq79HcEZyhfOJjqIvPqjN0Q', '2022-07-17 16:13:20', 51),
(113, '8f8d573b-9691-48c3-aa6b-bffb5334dcb7', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODA5MzYzNH0.LRJkCFH6xhjQTqlJhqbiG9wXK3RhV84gy3v9l4t3-uo', '2022-07-17 16:33:54', 50),
(114, '260d2b3a-f79f-480f-975e-77293c35791f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODA5MzczM30.zBoyq100Su46rA5Ih4tswlZoEt1h7rcWytuQHrcMDnE', '2022-07-17 16:35:33', 50),
(115, '270d2313-4ad2-4c74-bc9e-4f2352a8e479', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODEwMDIzM30.jea1s_JIJ5kDVcaWEnT1bSHZStnmZWkVkFMP2aGTPQs', '2022-07-17 18:23:54', 51),
(116, '83540371-1433-4dc4-ba06-180b7a3af165', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODEwMDIzNH0.VLQ533ydq0FNPWO_w_FL5H8o2d_tcbVgPlelyHAr__4', '2022-07-17 18:23:54', 51),
(117, 'a61bb1f7-6115-4e22-9651-3a0813071ad8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODEwMDI4OX0.yfsLuySlkSHOxbd56RKC03iqeOzzbqPGIkwQeqiaQhs', '2022-07-17 18:24:49', 50),
(118, 'df28b23f-5319-4163-85be-00e00f17a315', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODI2MTMwOH0.bPGOWWf8HXJMLdILkk-_LzOu-Fe-bKC4CVzJKG8IeGU', '2022-07-19 15:08:28', 53),
(119, '02d65d41-202d-42e5-ac53-5bc848779add', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODI2MjM1M30.tTNffZIOWl-PjpEOCGp9nLWRUPZe2Rn_Ccnsz4QxIPk', '2022-07-19 15:25:53', 52),
(120, 'd80117e3-d068-4397-8249-e05f52dd70ba', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODI2Mzk5M30.JGlZywEUuWVe84aIaVbyI3tzUCEIsmblt54ucIAYlV4', '2022-07-19 15:53:13', 52),
(121, '8d11edaf-cd8d-45de-90c6-6fbca8ba1d30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODI2NDAxM30.BjHC7fUQ_axEPuohriPhTyvSsT1TKOpObWN3znZNdYU', '2022-07-19 15:53:33', 50),
(122, 'ffe2c675-5d4c-4ebb-829e-7a226a94e3b1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODI4MTQzM30.VwCMlsFzzsCu0bxm4PNyL0tm-Iz-JtbzIlF-sVaoNd4', '2022-07-19 20:43:53', 55),
(123, '525041c1-05ee-4956-ab7a-1c9cca04aaa2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODI4MTkxM30.FrCvklddJTrw2Dnqae2ykMJkoBsJtc4zcdnZdgKLfBI', '2022-07-19 20:51:53', 53),
(124, '04cfc116-bbf2-4edb-9211-731eaabb0f6e', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2MzcxNDQxNH0.5i9mceZguXLxkyf5FAJTLnwOWhomEN4NoUFaD4oc_nc', '2022-09-20 17:53:34', 51),
(125, '4da2d99a-0f6e-424f-ae7b-ab445aae5982', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NDA4MjY3OX0.wweAQVlYPxcktDHQ456O5TW8FVbvKpfSCndIJgyejYE', '2022-09-25 00:11:19', 51),
(126, '0e3a1a10-b45d-4e59-9529-d375f7ff579f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NDU1MDMzOX0.8-48pDoKebFMFZY_1R2mL9AaiJMN4iHurBqpho6g7QI', '2022-09-30 10:05:39', 50),
(127, '605e8eea-c307-411e-b01c-dd947af9f440', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NDU1MDUyMX0.fCKqmoVPbkOpsQr3iLHPkiidjBzinPBHqXlEneb6LAA', '2022-09-30 10:08:41', 51),
(128, 'd31a6a3e-1d41-432f-8c20-aad16562a04f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NDU1Mzk5M30.uvH3Ro4xiDIHezA3sI3L8x-r7vSlOsNzOZgopGeyv64', '2022-09-30 11:06:33', 55),
(129, 'da336810-f78c-4766-a408-77ebd92d4ad1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NDU1NDg0OH0.cvHgTbxuBl7XZap6ufQ3YcBM910CNzJiUXd6yaxsCwY', '2022-09-30 11:20:48', 51),
(130, 'fd863671-2f8c-4c8a-ae26-a0799d3a9f2c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NDU1NTg0N30.Ey2wbBd4q0DmPX1tZ1kmQk4bilZBQnCei5ILC4WdYQ0', '2022-09-30 11:37:27', 50),
(131, 'e712a6d2-70a1-4414-88d7-d56fa34938d5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NDU1NjEzM30.YXVyj8isB4uJXcckJeViFRO2BJW-AEJXnm3iIxjey58', '2022-09-30 11:42:13', 51),
(132, '7e10b943-838c-46c1-8ce7-64606d8e2018', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NDc3MDYxOH0.flRrRUBVWwYx-8t4MAVbRCXpE6T9_dQJmXGOWDMa1UY', '2022-10-02 23:16:58', 52),
(133, 'be840284-68a7-4e1a-9624-754fdf4d0e17', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NTM2NDIzMH0.muuKkgS25axuA3Bhi27H82TL2LWQqJACxV_OI3MKibc', '2022-10-09 20:10:30', 50),
(134, '09b35032-519b-4985-b365-ed436375ada0', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NTc4MzQwNn0.au17aQoQ6n-qoy8UbhBCfxcMfnfZyRpFXD-gI5n3Yys', '2022-10-14 16:36:46', 63),
(135, 'd75a4d67-24f0-4851-85dd-8a2e18b070ac', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NTc4OTQ5MH0.c_SfYI0WizI6jJEDWw11uXaoqXV3y2Frb73FdQhu-tc', '2022-10-14 18:18:10', 64),
(136, '9901cbeb-3b33-460b-85b0-553975eecdd5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NTc5NzMwOH0.vUpfooZTFFTIC4wR7mVLxMW5wJk19HKBJQFQW5mS8KA', '2022-10-14 20:28:28', 64),
(137, 'e24b2124-2c93-460d-8149-71de5e3e3a90', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NjAyNTA2MH0.Gk-w2MSCqYk078w1nu9Uw6i4unDJhdhsjWbq044T_-Q', '2022-10-17 11:44:20', 61),
(138, '578b0a85-1a98-49b9-b5ba-4402069337b6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NjU0OTQ2Nn0.S7486auylwsPOu6_WfMByAZQtoCJMZcHg3pFR5BUQrs', '2022-10-23 13:24:26', 49),
(139, '38d4cc8f-2470-4c8e-b5cf-19142769f8b6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NjU0OTYyOX0.iwvIbbNifDU20OlUOdq-oFZWZ2Z1Uu8I9BB_6becVK0', '2022-10-23 13:27:09', 51),
(140, 'e464c0b4-47f9-471a-816b-851bab0a1f87', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NjU1MTAyOX0.ObgLUzZogLNe3K4mk9Kw0CXnr1W4wMaF6ROaEm882Fw', '2022-10-23 13:50:29', 65),
(141, '71e2fd6c-be30-4455-96d1-f78b990d541c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NjYyNTA2MX0.opW_Llqs9rYGYy_DHDFIflnVb0i2oDuHvLdS5M8i0tI', '2022-10-24 10:24:21', 50),
(142, '5fa562c2-d4df-4fc0-9eec-b2050228102a', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NzQzOTY2Nn0.ZbwkWXMBKTNRAFC2d0L_qkKWdG2r5R-27qqbqtARGPc', '2022-11-02 20:41:06', 69),
(143, '444154d6-967f-43b2-b13a-13cfc4d4807b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NzQ4MjI0MH0.SUX-dB57uT-4xha3N8KChfC6d8lbfFG3xtOSTOrnvss', '2022-11-03 08:30:40', 54),
(144, '1c96fa05-8648-486f-9e70-059accf65bcb', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NzQ4NDg0OH0.fKnZZ9gWQtlf2tz9Ll0vNnFhIMTOWMngQHxSzQ-nlmY', '2022-11-03 09:14:08', 69),
(145, 'a0ca1300-3827-4a6e-8e19-09c3fa2530ae', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NzUwNDU3N30.h4Pbl2kfVjjlrIOR4a37kH0U27FAziF98pzdhfBvH3E', '2022-11-03 14:42:57', 70),
(146, '8dc525e2-a753-4210-b73d-837a790af0d9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NzUwNTM2OX0.wiaZ8a53cLo8vrFD9RmHn91ktBqWiHSXmVIq2Eiazz0', '2022-11-03 14:56:09', 50),
(147, '68eabf37-b7fb-4b80-8bdf-172eba46c643', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NzUwNTQ0OX0.dJ_fwnQcEQf9LtFYkCODaFUhdIKE5lSv-ZuFQ_mM9a8', '2022-11-03 14:57:29', 54),
(148, 'a93f8fda-8a32-4eae-ac86-589ce67cd0bd', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NzU5MTU3Nn0.rNy2Jb3c3PGsWugIeB5YOhToL-2jiJmCjml_neilK8w', '2022-11-04 14:52:56', 54),
(149, '6cbba39f-d9b9-4d31-8b22-260225671857', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NzgzMTM2Nn0.pNlmFsJnvu4NQFyMJFKUrQ8SW7M7hd_EE8zNS6INjnw', '2022-11-07 09:29:26', 51),
(150, '7acf2763-dd6e-4590-989d-a26bb16db5b5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NzgzMTY3M30.ZOPSxYOFeeZtYgUFk5ooYJFR5HUGjoW46Z3gpSGdrZ4', '2022-11-07 09:34:33', 50),
(151, '7ace5569-68f8-468f-bf5e-1b27d5f10904', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2Nzg2ODk4N30.GbYrfNmnlCUUnmwznxK4UhnXlbsH_KxFp2VaSXzqlsg', '2022-11-07 19:56:27', 54),
(152, 'e1fe25f6-c2ac-412d-a503-4dcd94b7e463', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2Nzg2OTQ1Nn0.ycj5vL_7vXqyfulbaLudg32VCL9pc-u5vcT3i0KAnBQ', '2022-11-07 20:04:16', 50),
(153, '80d7a528-2288-44c8-bb17-0548b373241c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2NzkyMTU4Mn0.r9BeOhtgk43P7625HFR8EpzH-Jchh9r9m1FFxhAOPPA', '2022-11-08 10:33:02', 54),
(154, '0091492d-746a-4195-9edd-89316859f21f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAwMjc0Nn0.FACAGrSor3FK_x2LN2kaZRZt_Q-QP4exvZdkFD12QWE', '2022-11-09 09:05:46', 50),
(155, 'ea1c0071-4ec1-42ae-963c-f7777034ff7f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAwNjQ3Nn0.95qodVi8a35W8wTNW0s3_XwE-qLOEZMrVIq6JrpD4K4', '2022-11-09 10:07:56', 73),
(156, '1c443053-8abf-47c5-9777-7cb7694e869b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAwNzE2Mn0.nT8A6VuW4lDtkBTxVzKt8au7W5WjNcOEAKWjCYBGHM0', '2022-11-09 10:19:22', 73),
(157, '0a36e15c-3bf7-409d-ad6f-80e4f345ae7a', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAwNzE4OX0.Oebv0gVMh68-i_v9qpq5Pz-xTXJOF_1Jx9qr55opawc', '2022-11-09 10:19:49', 50),
(158, '09e22942-a24c-4917-8d85-15240ebe08fe', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAwNzM4MX0.31RRgAjHPXl50w6rkoFQoPi_16ML2uyJ-MdDPIVpJZw', '2022-11-09 10:23:01', 74),
(159, 'a25a8e3e-ff85-40cc-b19f-26277d4b328c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAwNzk4M30.VG-P_0-ATvQXEEhFFNxy3fgRVit6iwmuxYZIzy1jv3k', '2022-11-09 10:33:03', 50),
(160, 'd5a92ff4-5b9c-4933-93ef-398c638475eb', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAxMTIxN30.N6iERI1GHrNcQOVpXrfCt3ZFYdkTrljUPnAYPgRekJ4', '2022-11-09 11:26:57', 77),
(161, '4e698e2b-9b3b-4ceb-98d9-3076ba56ad74', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAxMTQyNn0.6vcdTPGJkcGgjLqWBcoZygxXLSITn9RPsXQLUbVh_1U', '2022-11-09 11:30:26', 50),
(162, 'fe0cec61-7665-4007-8b8d-74719806a03f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAxMTYzOH0.gsmZtN5PkCD1jHIiT2TAXoRRrJoyXKWzCwRzilAyR9Q', '2022-11-09 11:33:58', 78),
(163, 'f0ebe75a-106e-4f9f-9cf9-fa6ca2480a55', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAxMjM5MH0.jXjTP47SGA9kj63ulyi3fNNSFXmVI2NJZ4Ng5X3AN5M', '2022-11-09 11:46:30', 50),
(164, '7ee47338-8693-4277-a1d9-810b45d66fe3', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAxMzM0N30.OscfVd2vJMQlpSACZz_L0s2u4lM93GIyi3h5Jts8z1s', '2022-11-09 12:02:27', 78),
(165, '2cc890e2-fb41-4ea4-8268-d789eff47717', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODAxMzk4NH0.oI8rfjp6r3lqHnVc2WrK-3hQxaZaiBK9ZekOoUkNRCQ', '2022-11-09 12:13:04', 54),
(166, '57529473-43f3-41dd-9065-28aed06b4f7f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODA0ODk0Nn0.2VzapINM8njee7vG9CuXYEpfMdSwLtljqwB6zmn9CFU', '2022-11-09 21:55:46', 80),
(167, 'bca9564e-4f72-4dd2-bc8e-8ed8a11e48cd', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODEyNjQ0MX0.zbf3jefePizPgDkayW3dnp6CnPwQJs7iXBhWbGWq8Bw', '2022-11-10 19:27:21', 50),
(168, '21694840-039c-4735-ac7a-7012d5b8a0b0', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODE4MDc0N30.ANhiHAq2ZhE4GVhD7u9c-alkxiuR2qJhZo7isZYOnMo', '2022-11-11 10:32:27', 50),
(169, '53211fbb-6547-4b2f-bd6a-49d4ac2c3113', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODE5NzA3OX0.N1X1Tf8I9atJdkmmP_LMjiXY-fsXXfVI0z3P9rsAUYg', '2022-11-11 15:04:39', 50),
(170, '16fbe359-8a50-4977-b8a8-b087168876ac', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODI5MjY0Nn0.r27z9UtNRw1MpVuZMJyyLVwMePNtDoS1a70aozqAMzY', '2022-11-12 17:37:26', 50),
(171, 'ebf44ee7-fe8e-4a4e-9a8c-f9f92cc24511', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODUzMjcyMX0.eF4vo5cxq0xyRBuGCvSM2Tu6P8SOIbtP89p-AjYxNJk', '2022-11-15 12:18:41', 50),
(172, 'eb87e35b-157d-4887-898c-2ec3f7718d6e', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY2ODU0NjE5NX0.uQ-XOjP_2clyVYDsywLxsiTGGnt7UR9AvrU4ekUoAzU', '2022-11-15 16:03:15', 54);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarea_conte_inscr`
--

CREATE TABLE `tarea_conte_inscr` (
  `id_tarea_inscri` int(11) NOT NULL,
  `id_inscrip` int(11) NOT NULL,
  `id_conte_tarea` int(11) NOT NULL,
  `urlconte` varchar(400) COLLATE utf8_unicode_ci NOT NULL,
  `puntos` int(11) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tarea_conte_inscr`
--

INSERT INTO `tarea_conte_inscr` VALUES
(15, 33, 9, 'https://docs.google.com/document/d/1fy5GnD2_hk4CQ2U57v64BiWeaqRojGcprKZdpt02f7I/edit', 3, 1),
(16, 35, 9, 'https://docs.google.com/document/d/1fy5GnD2_hk4CQ2U57v64BiWeaqRojGcprKZdpt02f7I/edit', 3, 1),
(17, 38, 10, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEIcebFDwrUqOS6zazUiDs_7nXIZAJFGRQ5snyqCh_Dg&s', 4, 1),
(18, 39, 11, 'https://www.youtube.com/watch?v=DdlQGnN0kEw', 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_conte`
--

CREATE TABLE `tipo_conte` (
  `id_tipo_conte` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_conte`
--

INSERT INTO `tipo_conte` VALUES
(1, 'Video', 1),
(2, 'Documento', 1),
(3, 'Audio', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_curso`
--

CREATE TABLE `tipo_curso` (
  `id_tipocurso` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_curso`
--

INSERT INTO `tipo_curso` VALUES
(1, 'Todo', 1),
(14, 'Entretertaiment', 0),
(15, 'Minecraft', 1),
(16, 'Arte', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_inscripcion`
--

CREATE TABLE `tipo_inscripcion` (
  `id_tipo_inscrip` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_inscripcion`
--

INSERT INTO `tipo_inscripcion` VALUES
(1, 'Inscripción', 1),
(2, 'Pre-inscripción', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutor_alumno`
--

CREATE TABLE `tutor_alumno` (
  `id_tutor_alumno` int(11) NOT NULL,
  `nombre_tutAlum` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `tutor_alumno`
--

INSERT INTO `tutor_alumno` VALUES
(2, 'Carlos Alberto Guerrero Garcia.', 58),
(3, 'Carlos arturo Guerrero Castillo', 59),
(4, 'Carlos Arturo Guerrero Castillo', 60),
(5, 'pedro castillo', 66),
(6, 'Carlos Arturo Guerrero Castillo', 68),
(7, 'Carlos Garcia Hurtado', 79);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `tipo_user` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `usser` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pass` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `telf` int(9) NOT NULL,
  `correo` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `photo` varchar(400) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` VALUES
(49, 'C', 'caguerrerog@ucvvirtual.edu.pe', 'carlos12345', 'Carlos Arturo Guerrero Castillo', 969280255, 'caguerrerog@ucvvirtual.edu.pe', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658087231/Images/pqgzyyolwx14yeem0pcm.png'),
(50, 'A', 'Admincanvaritch@admin.com', '17072022devcanv', 'Julio Ancajima gerente', 978376948, 'Admincanvaritch@admin.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1667852090/Images/hnv5h0zz9tgrrj84nhy2.jpg'),
(51, 'P', 'canvaritech.gerente@gmail.com', 'UniversidadPri', 'ANCAJIMA MAURIOLA Julio Sergio Adolfo', 978376948, 'canvaritech.gerente@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(52, 'C', 'catrina142018@gmail.com', '1620anitacesi', 'Ana Hurtado Guerrero Castillo', 962526447, 'catrina142018@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658257036/Images/fygcuyxsbrzm4air9hca.jpg'),
(53, 'P', 'anamariacastillodelgado@gmail.com', 'anamar12346', 'Ana Maria Castillo Delgado', 947401880, 'anamariacastillodelgado@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658257718/Images/onzfvxweovtzjhgcu1g3.jpg'),
(54, 'P', 'torres45687@yopmail.com', 'tor123456', 'Eddy Rances Torres Cabellos', 969280255, 'torres45687@yopmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658261241/Images/ugpp6f3iactuyafwcsrg.jpg'),
(55, 'C', 'estefanyguer4@gmail.com', 'Estef12345', 'Estefany Guerrero Castilla', 969280255, 'estefanyguer4@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658281522/Images/j97h6v7sokwufmlm7jur.jpg'),
(56, 'P', 'estefanyguer4@gmail.com', 'Estef12345', 'Carlos Arturo Guerrero Castillo', 947401880, 'estefanyguer4@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658281855/Images/zbwjkvwe8qbyroveklyb.jpg'),
(58, 'PA', 'caguerrerog@ucvvirtual.edu.pe', 'car123456789', 'Carlos Alberto Guerrero Garcia.', 985796307, 'caguerrerog@ucvvirtual.edu.pe', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(59, 'PA', 'arturo14212004@gmail.com', 'univerlucia', 'Carlos arturo Guerrero Castillo', 969280255, 'arturo14212004@gmail.com', 1, 'http://ajkdajldkajsdklasjdlaskjdk'),
(60, 'PA', 'sploit4531@gmail.com', '123456789', 'Carlos Arturo Guerrero Castillo', 969280255, 'sploit4531@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(61, 'C', 'arturo14212004@gmail.com', 'univerlucia2', 'Carlos arturo Guerrero Castillo', 969280255, 'arturo14212004@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1666025247/Images/zheqtitdiaxku95fjj9z.jpg'),
(62, 'C', 'arturo14212004@gmail.com', 'univerlucia4', 'Carlos arturo Guerrero Castillo', 985796307, 'arturo14212004@gmail.com', 1, 'http://ajkdajldkajsdklasjdlaskjdk'),
(63, 'C', 'arturo14212004@gmail.com', 'univerluci3', 'Carlos arturo Guerrero Castillo', 985796307, 'arturo14212004@gmail.com', 1, 'http://ajkdajldkajsdklasjdlaskjdk'),
(64, 'C', 'carlgarcia@gmail.com', 'univerlucia', 'Carlos Guevara Garcia', 985796307, 'carlgarcia@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1665797551/Images/a8t1p7tmhltwixp4ryzh.jpg'),
(65, 'C', 'caro@gmail.com', '123456', 'carolina', 985796307, 'caro@gmail.com', 0, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(66, 'PA', 'pedcast@gmail.com', '123456', 'pedro castillo', 985796307, 'pedcast@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(67, 'C', 'estefanyguer4@gmail.com', '741852963a', 'Carlos Arturo Guerrero Castillo', 985796307, 'estefanyguer4@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(68, 'PA', 'estefanyguer4@gmail.com', '123456', 'Carlos Arturo Guerrero Castillo', 969280255, 'estefanyguer4@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(69, 'C', 'artu222000@gmail.com', '123456', 'Carlos Arturo Guerrero Garcia', 969280255, 'artu222000@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(70, 'C', 'alexgaar@gmail.com', '1234567', 'Alexander Garcia', 985796307, 'alexgaar@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1667439808/Images/dzd7tbr6mdj8aoynhcpg.jpg'),
(71, 'A', 'anamariacastillodelgado@gmail.com', '123456789', 'Ana Maria Castillo Delgado', 969280255, 'anamariacastillodelgado@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1667852139/Images/k9usn2eisjd3vhkgfmuf.jpg'),
(72, 'P', 'estefanyguer26@gmail.com', 'Universidad Pri', 'Estefany Castillo Delgado', 959630213, 'estefanyguer26@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1667917085/Images/ygt4byv6ww1nvgsnewtf.jpg'),
(73, 'P', 'joseloai20@gmail.com', '969280255', 'Juan José Loaiza', 985796307, 'joseloai20@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(74, 'P', 'joseluis456@gmail.com', '123456897', 'Jose Luis Garcia Cornejo', 985796307, 'joseluis456@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(75, 'P', 'tellus.non.magna@yahoo.couk', '1234567897', 'Elton Horto', 789546121, 'tellus.non.magna@yahoo.couk', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(76, 'P', 'SDFDS@gmail.com', '123456879878978', 'DSFDSFDSFSDFDS', 454654545, 'SDFDS@gmail.com', 0, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(77, 'P', 'sdfdfdsfsdfdsf@gmail.com', '147852369', 'sdfsdfdsfdsfdsf', 121354567, 'sdfdfdsfsdfdsf@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(78, 'P', 'fgdhgfdhfghf@gmail.com', '12315465879878', 'gfhghdghfdhdfg', 454562115, 'fgdhgfdhfghf@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(79, 'PA', 'Carlosgar@gmail.com', '123456', 'Carlos Garcia Hurtado', 969280255, 'Carlosgar@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(80, 'C', 'garger@gmail.com', '123456', 'Garcia Gevara', 959896301, 'garger@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`id_alumno`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id_asisten`);

--
-- Indices de la tabla `asist_inscrip`
--
ALTER TABLE `asist_inscrip`
  ADD PRIMARY KEY (`id_asis_inscrip`),
  ADD KEY `id_inscrip` (`id_inscrip`),
  ADD KEY `id_asisten` (`id_asisten`);

--
-- Indices de la tabla `ciclo_curso`
--
ALTER TABLE `ciclo_curso`
  ADD PRIMARY KEY (`id_ciclo_curso`),
  ADD KEY `id_curso` (`id_curso`),
  ADD KEY `id_profesor` (`id_profesor`);

--
-- Indices de la tabla `conte_sesion`
--
ALTER TABLE `conte_sesion`
  ADD PRIMARY KEY (`id_conte_sesion`),
  ADD KEY `id_tipo_conte` (`id_tipo_conte`),
  ADD KEY `id_sesion` (`id_sesion`);

--
-- Indices de la tabla `conte_tarea`
--
ALTER TABLE `conte_tarea`
  ADD PRIMARY KEY (`id_conte_tarea`),
  ADD KEY `id_sesion` (`id_sesion`);

--
-- Indices de la tabla `correoslp`
--
ALTER TABLE `correoslp`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `correossa`
--
ALTER TABLE `correossa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id_curso`),
  ADD KEY `id_tipo_curso` (`id_tipo_curso`);

--
-- Indices de la tabla `inscripcciones`
--
ALTER TABLE `inscripcciones`
  ADD PRIMARY KEY (`id_inscrip`),
  ADD KEY `id_alumno` (`id_alumno`),
  ADD KEY `id_tipo_inscrip` (`id_tipo_inscrip`),
  ADD KEY `id_ciclo_curso` (`id_ciclo_curso`);

--
-- Indices de la tabla `inscrip_point_sesion`
--
ALTER TABLE `inscrip_point_sesion`
  ADD PRIMARY KEY (`id_inscrip_p_sea`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`id_profesor`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `puntosclass`
--
ALTER TABLE `puntosclass`
  ADD PRIMARY KEY (`id_tipo_puntos`);

--
-- Indices de la tabla `sesiones`
--
ALTER TABLE `sesiones`
  ADD PRIMARY KEY (`id_sesion`),
  ADD KEY `id_ciclocurso` (`id_ciclocurso`);

--
-- Indices de la tabla `sing_log`
--
ALTER TABLE `sing_log`
  ADD PRIMARY KEY (`id_sing_log`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `tarea_conte_inscr`
--
ALTER TABLE `tarea_conte_inscr`
  ADD PRIMARY KEY (`id_tarea_inscri`),
  ADD KEY `id_inscrip` (`id_inscrip`),
  ADD KEY `id_conte_tarea` (`id_conte_tarea`);

--
-- Indices de la tabla `tipo_conte`
--
ALTER TABLE `tipo_conte`
  ADD PRIMARY KEY (`id_tipo_conte`);

--
-- Indices de la tabla `tipo_curso`
--
ALTER TABLE `tipo_curso`
  ADD PRIMARY KEY (`id_tipocurso`);

--
-- Indices de la tabla `tipo_inscripcion`
--
ALTER TABLE `tipo_inscripcion`
  ADD PRIMARY KEY (`id_tipo_inscrip`);

--
-- Indices de la tabla `tutor_alumno`
--
ALTER TABLE `tutor_alumno`
  ADD PRIMARY KEY (`id_tutor_alumno`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `id_alumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `id_asisten` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `asist_inscrip`
--
ALTER TABLE `asist_inscrip`
  MODIFY `id_asis_inscrip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `ciclo_curso`
--
ALTER TABLE `ciclo_curso`
  MODIFY `id_ciclo_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `conte_sesion`
--
ALTER TABLE `conte_sesion`
  MODIFY `id_conte_sesion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `conte_tarea`
--
ALTER TABLE `conte_tarea`
  MODIFY `id_conte_tarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `correoslp`
--
ALTER TABLE `correoslp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT de la tabla `correossa`
--
ALTER TABLE `correossa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `inscripcciones`
--
ALTER TABLE `inscripcciones`
  MODIFY `id_inscrip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `inscrip_point_sesion`
--
ALTER TABLE `inscrip_point_sesion`
  MODIFY `id_inscrip_p_sea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `profesor`
--
ALTER TABLE `profesor`
  MODIFY `id_profesor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `puntosclass`
--
ALTER TABLE `puntosclass`
  MODIFY `id_tipo_puntos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `sesiones`
--
ALTER TABLE `sesiones`
  MODIFY `id_sesion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `sing_log`
--
ALTER TABLE `sing_log`
  MODIFY `id_sing_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- AUTO_INCREMENT de la tabla `tarea_conte_inscr`
--
ALTER TABLE `tarea_conte_inscr`
  MODIFY `id_tarea_inscri` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `tipo_conte`
--
ALTER TABLE `tipo_conte`
  MODIFY `id_tipo_conte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_curso`
--
ALTER TABLE `tipo_curso`
  MODIFY `id_tipocurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `tipo_inscripcion`
--
ALTER TABLE `tipo_inscripcion`
  MODIFY `id_tipo_inscrip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tutor_alumno`
--
ALTER TABLE `tutor_alumno`
  MODIFY `id_tutor_alumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `asist_inscrip`
--
ALTER TABLE `asist_inscrip`
  ADD CONSTRAINT `asist_inscrip_ibfk_1` FOREIGN KEY (`id_inscrip`) REFERENCES `inscripcciones` (`id_inscrip`),
  ADD CONSTRAINT `asist_inscrip_ibfk_2` FOREIGN KEY (`id_asisten`) REFERENCES `asistencia` (`id_asisten`);

--
-- Filtros para la tabla `ciclo_curso`
--
ALTER TABLE `ciclo_curso`
  ADD CONSTRAINT `ciclo_curso_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`),
  ADD CONSTRAINT `ciclo_curso_ibfk_2` FOREIGN KEY (`id_profesor`) REFERENCES `profesor` (`id_profesor`);

--
-- Filtros para la tabla `conte_sesion`
--
ALTER TABLE `conte_sesion`
  ADD CONSTRAINT `conte_sesion_ibfk_1` FOREIGN KEY (`id_tipo_conte`) REFERENCES `tipo_conte` (`id_tipo_conte`),
  ADD CONSTRAINT `conte_sesion_ibfk_2` FOREIGN KEY (`id_sesion`) REFERENCES `sesiones` (`id_sesion`);

--
-- Filtros para la tabla `conte_tarea`
--
ALTER TABLE `conte_tarea`
  ADD CONSTRAINT `conte_tarea_ibfk_1` FOREIGN KEY (`id_sesion`) REFERENCES `sesiones` (`id_sesion`);

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_3` FOREIGN KEY (`id_tipo_curso`) REFERENCES `tipo_curso` (`id_tipocurso`);

--
-- Filtros para la tabla `inscripcciones`
--
ALTER TABLE `inscripcciones`
  ADD CONSTRAINT `inscripcciones_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`),
  ADD CONSTRAINT `inscripcciones_ibfk_2` FOREIGN KEY (`id_tipo_inscrip`) REFERENCES `tipo_inscripcion` (`id_tipo_inscrip`),
  ADD CONSTRAINT `inscripcciones_ibfk_3` FOREIGN KEY (`id_ciclo_curso`) REFERENCES `ciclo_curso` (`id_ciclo_curso`);

--
-- Filtros para la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD CONSTRAINT `profesor_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `sesiones`
--
ALTER TABLE `sesiones`
  ADD CONSTRAINT `sesiones_ibfk_1` FOREIGN KEY (`id_ciclocurso`) REFERENCES `ciclo_curso` (`id_ciclo_curso`);

--
-- Filtros para la tabla `sing_log`
--
ALTER TABLE `sing_log`
  ADD CONSTRAINT `sing_log_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `tarea_conte_inscr`
--
ALTER TABLE `tarea_conte_inscr`
  ADD CONSTRAINT `tarea_conte_inscr_ibfk_1` FOREIGN KEY (`id_inscrip`) REFERENCES `inscripcciones` (`id_inscrip`),
  ADD CONSTRAINT `tarea_conte_inscr_ibfk_2` FOREIGN KEY (`id_conte_tarea`) REFERENCES `conte_tarea` (`id_conte_tarea`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
