-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-09-2022 a las 20:51:32
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_alumno` (IN `name` VARCHAR(100), IN `telf` INT(9), IN `correo` VARCHAR(100), IN `pass` VARCHAR(15), IN `photo` VARCHAR(400), IN `name_tutor` VARCHAR(100), IN `edad` INT(3))  NO SQL BEGIN 
# INSERTAR LOS DATOS AL USUARIO 
INSERT INTO `usuario`(`tipo_user`, `usser`, `pass`, `nombre`, `telf`, `correo`, `estado`, `photo`) VALUES ('C' , correo , pass , name , telf , correo , 1 , photo); 
# EXTRAER ULTIMO ADMIN INSERTADO 
set @id_user = (SELECT id_usuario FROM usuario WHERE tipo_user = 'C' AND estado = 1 ORDER BY id_usuario DESC LIMIT 1); 
# INSERTAR EN PROFESOR 
INSERT INTO `alumno`(`edad`, `name_tutor`, `telf_tutor`, `id_usuario`) VALUES ( edad , name_tutor , telf , @id_user);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_apertureasist` (IN `id_ciclo` INT)   BEGIN
# APERTURAR UNA ASISTENCIA
INSERT INTO `asistencia`(`fecha_asist`) VALUES (now()) ;
# SE INSERTAN A TODOS LOS ESTUDIANTES PARA EDITAR LAS ASISTENCIAS.
SET @id = (SELECT asis.id_asisten FROM asistencia asis ORDER BY asis.id_asisten DESC LIMIT 1 );
# INSERTAMOS LAS ASISTENCIAS DE LOS ALUMNOS
INSERT INTO `asist_inscrip`(`id_inscrip`, `id_asisten`, `estado_asistenc`) 
SELECT insp.id_inscrip, @id , 1
FROM inscripcciones insp
INNER JOIN ciclo_curso cc ON cc.id_ciclo_curso = insp.id_ciclo_curso
WHERE cc.id_ciclo_curso = id_ciclo ;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pointclas` (IN `name` VARCHAR(100), IN `valpoint` INT, IN `photo` VARCHAR(400), IN `id_prof` INT)   BEGIN
#INSERTAR UNOS PUNTOS
INSERT INTO `puntosclass`(`nombre`, `value_point`, `photo`, `id_profesor`, `stade`) VALUES (name  , valpoint , photo  , id_prof , 1);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_profe` (IN `name` VARCHAR(100), IN `telf` INT(9), IN `correo` VARCHAR(100), IN `pass` VARCHAR(15), IN `photo` VARCHAR(400), IN `estudios` VARCHAR(200))  NO SQL BEGIN 
# INSERTAR LOS DATOS AL USUARIO 
INSERT INTO `usuario`(`tipo_user`, `usser`, `pass`, `nombre`, `telf`, `correo`, `estado`, `photo`) VALUES ('P' , correo , pass , name , telf , correo , 1 , photo); 
# EXTRAER ULTIMO ADMIN INSERTADO 
set @id_user = (SELECT id_usuario FROM usuario WHERE tipo_user = 'P' AND estado = 1 ORDER BY id_usuario DESC LIMIT 1);
# INSERTAR EN PROFESOR 
INSERT INTO `profesor`(`estudios`, `id_usuario`) VALUES (estudios,@id_user);
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
SELECT al.id_alumno ,us.nombre, us.correo, us.telf, us.pass, us.photo, al.edad, al.name_tutor 
FROM alumno al 
INNER JOIN usuario us ON us.id_usuario = al.id_usuario WHERE us.estado = 1 
AND us.nombre LIKE CONCAT('%',name,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_apertureasis` (IN `id_ciclocurso` INT)   BEGIN
# LISTA TODAS LAS INSCRIPCCIONES DE UN USUARIO
SELECT ass.id_asisten , ass.fecha_asist
FROM asistencia ass 
INNER JOIN asist_inscrip assi ON assi.id_asisten = ass.id_asisten
INNER JOIN inscripcciones ins ON ins.id_inscrip = assi.id_inscrip
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_inscri_alumn` (IN `id_ciclocur` INT)  NO SQL BEGIN
# LISTAR LOS ALUMNOS INSCRITOS POR CURSO
SELECT ins.id_inscrip, alu.id_alumno, us.nombre 
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
SELECT * FROM puntosclass pc WHERE pc.id_profesor = id_prof AND pc.stade <> 0;
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
ins.id_ciclo_curso,
IFNULL((SELECT SUM(tci.puntos) FROM tarea_conte_inscr tci INNER JOIN conte_tarea ct ON ct.id_conte_tarea = tci.id_conte_tarea INNER JOIN sesiones sess ON sess.id_sesion = ct.id_sesion INNER JOIN ciclo_curso cc ON cc.id_ciclo_curso = sess.id_ciclocurso WHERE cc.id_ciclo_curso = ins.id_ciclo_curso AND tci.id_inscrip = ins.id_inscrip GROUP BY tci.id_inscrip),0) as point 
FROM inscripcciones ins 
INNER JOIN alumno al ON al.id_alumno = ins.id_alumno
INNER JOIN usuario us ON us.id_usuario = al.id_usuario
WHERE ins.estado = 1 
AND ins.id_ciclo_curso = id_ciclocurs ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tipoconte` ()  NO SQL BEGIN
SELECT * FROM tipo_conte tc WHERE tc.estado = 1 ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_tipocurso` ()  NO SQL BEGIN
# LISTAR LOS TIPOS DE TRABAJADORES
SELECT tc.id_tipocurso , tc.name FROM tipo_curso tc WHERE tc.estado = 1;
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
SELECT al.id_alumno ,us.nombre, us.correo, us.telf, us.pass, us.photo, al.edad, al.name_tutor 
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
UPDATE `admin` SET `tipo_trabajador`= tipo_trab WHERE `id_admin` = id_admin;
#ACTUALIZAR INFORMACION DEL USUARIO
SET @id_user = (SELECT ad.id_usuario FROM admin ad WHERE ad.id_admin = id_admin);
# -------------------------------------
UPDATE `usuario` SET `usser`= correo ,`pass`= pass ,`nombre`= name ,`telf`= telf ,`correo`=  correo ,`photo`= photo WHERE `id_usuario` = @id_user;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_alumno` (IN `id_alumno` INT, IN `name` VARCHAR(100), IN `correo` VARCHAR(100), IN `telf` INT(9), IN `pass` VARCHAR(15), IN `photo` VARCHAR(400), IN `edad` INT(3), IN `name_tutro` VARCHAR(100))  NO SQL BEGIN
#ACTUALIZAR LA INFO DEL PROFESOR
UPDATE `alumno` SET `edad`= edad ,`name_tutor`= name_tutro WHERE `id_alumno` = id_alumno ;
#ACTUALIZAR INFORMACION DEL USUARIO
SET @id_user = (SELECT a.id_usuario FROM alumno a WHERE a.id_alumno = id_alumno);
# -------------------------------------
UPDATE `usuario` SET `usser`= correo ,`pass`= pass ,`nombre`= name ,`telf`= telf ,`correo`=  correo ,`photo`= photo WHERE `id_usuario` = @id_user;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_pointclas` (IN `name` VARCHAR(100), IN `valpoint` INT, IN `photo` VARCHAR(400), IN `id_pointclass` INT)   BEGIN
# ACTUALIZAR LOS PUNTOS
UPDATE `puntosclass` SET `nombre`= name ,`value_point`= valpoint ,`photo`= photo WHERE id_tipo_puntos = id_pointclass;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `valider_inscricurse` (IN `idalumno` INT, IN `idciclocur` INT)  NO SQL BEGIN
# VALIDA SI UN ALUMNO YA SE REGISTRO AL CICLO DE UN CURSO
SELECT * FROM inscripcciones icp WHERE icp.id_alumno = idalumno AND icp.id_ciclo_curso = idciclocur AND icp.estado <> 0 ;
END$$

--
-- Funciones
--
CREATE DEFINER=`canvarit`@`localhost` FUNCTION `promedio_asisten_ciclo` (`id_ciclo` INT) RETURNS DECIMAL(10,0) UNSIGNED NO SQL BEGIN
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
(15, 'A', 50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `id_alumno` int(11) NOT NULL,
  `edad` int(3) NOT NULL,
  `name_tutor` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `telf_tutor` int(9) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` VALUES
(19, 16, 'Carlos Arturo Guerrero Garcia', 969280255, 49),
(20, 16, 'Carlos Arturo Guerrero Garcia', 962526447, 52),
(21, 16, 'Carlos Arturo Guerrero Garcia', 969280255, 55);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `id_asisten` int(11) NOT NULL,
  `fecha_asist` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `asistencia`
--

INSERT INTO `asistencia` VALUES
(8, '2022-07-19');

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
(19, 33, 8, 1);

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
(26, 15, 19, '2022-07-29', '2022-08-20', '51', 6, 3);

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
(9, 32, 'Resolver un Biuyer Person', 'Resuelve la tarea', 'https://docs.google.com/document/d/1Lz6KG0JnpZR_RrIWExop89zUeruIOGsF/edit', 1, 5);

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
(36, 21, 26, 2, 'http://res.cloudinary.com/canvarith/image/upload/v1658281750/Images/ksdojbk632lq1uknauhl.jpg', 1, '2022-07-19 20:49:11');

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
(17, 'Desconocido', 51),
(18, 'Universidad de Piura', 53),
(19, 'Universidad Privada de piura', 54),
(20, 'Universidad cesar vallejo', 56);

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
  `stade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `puntosclass`
--

INSERT INTO `puntosclass` VALUES
(1, 'asistencia', 2, '', 9, 1),
(2, 'realizo tarea', 1, '', 9, 1);

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
(36, 25, 'Cierre de Módulo', 1);

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
(123, '525041c1-05ee-4956-ab7a-1c9cca04aaa2', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo5NjkyODAyNTUsIm5vbWJyZSI6ImJyYWRjYXIiLCJlbWFpbCI6InVjdjIwMjFAZW1haWwuY29tIn0sImlhdCI6MTY1ODI4MTkxM30.FrCvklddJTrw2Dnqae2ykMJkoBsJtc4zcdnZdgKLfBI', '2022-07-19 20:51:53', 53);

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
(16, 35, 9, 'https://docs.google.com/document/d/1fy5GnD2_hk4CQ2U57v64BiWeaqRojGcprKZdpt02f7I/edit', 3, 1);

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
(15, 'Minecraft', 1);

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
(50, 'A', 'Admincanvaritch@admin.com', '17072022devcanv', 'Julio Ancajima', 978376948, 'Admincanvaritch@admin.com', 1, 'https://ouch-cdn2.icons8.com/zJlI7t_-lotebcVZBqe40dis_bc5f-uOJ4Fox-a1kZ0/rs:fit:715:456/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMjU5/LzY2NThkMjJkLWYz/MTItNDg2NC1hMjk1/LTc2OWE0NDJlZWRl/Ni5zdmc.png'),
(51, 'P', 'canvaritech.gerente@gmail.com', 'anca9783canva', 'ANCAJIMA MAURIOLA, Julio Sergio Adolfo', 978376948, 'canvaritech.gerente@gmail.com', 1, 'https://thumbs.dreamstime.com/b/icono-gris-de-perfil-usuario-s%C3%ADmbolo-empleado-avatar-web-y-dise%C3%B1o-ilustraci%C3%B3n-signo-aislado-en-fondo-blanco-191067342.jpg'),
(52, 'C', 'catrina142018@gmail.com', '1620anitacesi', 'Ana Hurtado Guerrero Castillo', 962526447, 'catrina142018@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658257036/Images/fygcuyxsbrzm4air9hca.jpg'),
(53, 'P', 'anamariacastillodelgado@gmail.com', 'anamar12346', 'Ana Maria Castillo Delgado', 947401880, 'anamariacastillodelgado@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658257718/Images/onzfvxweovtzjhgcu1g3.jpg'),
(54, 'P', 'torres45687@yopmail.com', 'tor123456', 'Eddy Rances Torres Cabellos', 969280255, 'torres45687@yopmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658261241/Images/ugpp6f3iactuyafwcsrg.jpg'),
(55, 'C', 'estefanyguer4@gmail.com', 'Estef12345', 'Estefany Guerrero Castilla', 969280255, 'estefanyguer4@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658281522/Images/j97h6v7sokwufmlm7jur.jpg'),
(56, 'P', 'estefanyguer4@gmail.com', 'Estef12345', 'Carlos Arturo Guerrero Castillo', 947401880, 'estefanyguer4@gmail.com', 1, 'http://res.cloudinary.com/canvarith/image/upload/v1658281855/Images/zbwjkvwe8qbyroveklyb.jpg');

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
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `id_alumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `id_asisten` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `asist_inscrip`
--
ALTER TABLE `asist_inscrip`
  MODIFY `id_asis_inscrip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `ciclo_curso`
--
ALTER TABLE `ciclo_curso`
  MODIFY `id_ciclo_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `conte_sesion`
--
ALTER TABLE `conte_sesion`
  MODIFY `id_conte_sesion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `conte_tarea`
--
ALTER TABLE `conte_tarea`
  MODIFY `id_conte_tarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
  MODIFY `id_inscrip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `profesor`
--
ALTER TABLE `profesor`
  MODIFY `id_profesor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `puntosclass`
--
ALTER TABLE `puntosclass`
  MODIFY `id_tipo_puntos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `sesiones`
--
ALTER TABLE `sesiones`
  MODIFY `id_sesion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `sing_log`
--
ALTER TABLE `sing_log`
  MODIFY `id_sing_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT de la tabla `tarea_conte_inscr`
--
ALTER TABLE `tarea_conte_inscr`
  MODIFY `id_tarea_inscri` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `tipo_conte`
--
ALTER TABLE `tipo_conte`
  MODIFY `id_tipo_conte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_curso`
--
ALTER TABLE `tipo_curso`
  MODIFY `id_tipocurso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tipo_inscripcion`
--
ALTER TABLE `tipo_inscripcion`
  MODIFY `id_tipo_inscrip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

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
