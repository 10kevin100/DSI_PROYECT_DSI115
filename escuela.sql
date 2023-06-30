-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               11.1.0-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for escuela
DROP DATABASE IF EXISTS `escuela`;
CREATE DATABASE IF NOT EXISTS `escuela` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `escuela`;

-- Dumping structure for table escuela.alumno
DROP TABLE IF EXISTS `alumno`;
CREATE TABLE IF NOT EXISTS `alumno` (
  `alumno_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `alumno_nombre` varchar(50) NOT NULL,
  `alumno_apellido` varchar(75) NOT NULL,
  `alumno_telefono` varchar(15) DEFAULT NULL,
  `alumno_encargado` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`alumno_id`),
  FULLTEXT KEY `alumno_nombre` (`alumno_nombre`),
  FULLTEXT KEY `alumno_apellido` (`alumno_apellido`)
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.alumno: ~5 rows (approximately)
INSERT INTO `alumno` (`alumno_id`, `alumno_nombre`, `alumno_apellido`, `alumno_telefono`, `alumno_encargado`) VALUES
	(293, 'Caleb', 'Alejandro', '33333333', NULL),
	(294, 'Lenny', 'Preza', '99999999', NULL),
	(295, 'Astro', 'bello', '22222222', NULL),
	(296, 'morilla', 'Bella', '99999999', NULL),
	(297, 'Kevin', 'moran', '32121133', NULL);

-- Dumping structure for table escuela.alumno_licencia
DROP TABLE IF EXISTS `alumno_licencia`;
CREATE TABLE IF NOT EXISTS `alumno_licencia` (
  `licencia_Id` smallint(5) unsigned NOT NULL,
  `alumno_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`licencia_Id`,`alumno_id`),
  KEY `FK_alumno_licencia2` (`alumno_id`),
  CONSTRAINT `FK_alumno_licencia` FOREIGN KEY (`licencia_Id`) REFERENCES `licencia` (`licencia_Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.alumno_licencia: ~3 rows (approximately)
INSERT INTO `alumno_licencia` (`licencia_Id`, `alumno_id`) VALUES
	(2, 293),
	(2, 295),
	(1, 297);

-- Dumping structure for table escuela.auth_group
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.auth_group: ~0 rows (approximately)

-- Dumping structure for table escuela.auth_group_permissions
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.auth_group_permissions: ~0 rows (approximately)

-- Dumping structure for table escuela.auth_permission
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.auth_permission: ~0 rows (approximately)

-- Dumping structure for table escuela.auth_user
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.auth_user: ~10 rows (approximately)
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(2, 'pbkdf2_sha256$600000$2wbnPGvIcIMz3uhMDwwzNI$JTleKk72qk/AoLsQ8sL5NkXgBsT0ZGs9WWT7vUwhXRU=', '2023-06-16 20:16:38.265118', 1, 'minerva', '', '', 'correo@correo.com', 1, 1, '2023-05-22 15:19:13.254119'),
	(3, 'pbkdf2_sha256$600000$n70cY03Wl13ZJyL0nWTB9w$9/mINdIJTM3RWqUqRz130kF/o7A2jK6LgIPXnjb8SOs=', '2023-05-25 03:45:06.286296', 0, 'Karen', '', '', '', 0, 1, '2023-05-25 03:44:16.279977'),
	(6, 'pbkdf2_sha256$600000$zbJ1Xk2hGPFDBh2lEgjV7t$/tKNsKhqX76XxNG9rDhJfK6Z6Jg70/riObljIVkIs6Q=', NULL, 0, 'eeliseo513', '', '', '', 0, 1, '2023-05-30 15:43:01.907810'),
	(7, 'pbkdf2_sha256$600000$iWRZQvGpDdWHhV6wEr9pXZ$S9hqg4mTm1J1obGqnMWyPwuxMiZJ/zroM4UiTQlSiX8=', NULL, 1, 'kpeñate353', '', '', '', 1, 1, '2023-05-31 15:33:13.719280'),
	(8, 'pbkdf2_sha256$600000$5GxRv2G7ta4SLeMTR240Mc$e6/NNGni9TKohTcUo1jLDnlr1THckmPjQrCKaRUVdro=', NULL, 0, 'apreza787', '', '', 'correo@gmail.com', 0, 1, '2023-06-04 02:44:51.133837'),
	(9, 'pbkdf2_sha256$600000$BR09Ga6xPLrQEyRaD4HgmF$EGmP06MtsYx0eN3QtHzk9DMze1Uf7uDYvZggP+avKEs=', '2023-06-21 02:47:24.452561', 1, 'Escuela', '', '', 'Escuela@gmail.com', 1, 1, '2023-06-21 02:47:14.858348'),
	(10, 'pbkdf2_sha256$600000$ELY1pqvkKUCXYoxE6widRU$+D4mtoSFG1Qf7HaUuBeRKBKhhyNjyfO/XR0YPDdTuYM=', NULL, 0, 'kmoran986', '', '', 'kevin@gmail.com', 0, 1, '2023-06-21 02:54:22.361961'),
	(11, 'pbkdf2_sha256$600000$Wh3NFMvNeraCyDcTMVmdLK$6upqvU5kB+T0E2D9yw1AkQ27SZUUZxVcGXVG7IcmZ24=', NULL, 0, 'czepeda745', '', '', 'dueñas@gmail.com', 1, 1, '2023-06-21 03:09:31.170811'),
	(12, 'pbkdf2_sha256$600000$oSqZsJ1vJqsuLFlipQSZ8M$hqLKh2VO9EzGfJ96mGR+F46yqta1bltU6T2SEjWSjhs=', NULL, 1, 'cpatrick938', '', '', 'dueñas@gmail.com', 1, 1, '2023-06-23 00:41:12.727795'),
	(13, 'pbkdf2_sha256$600000$X0eFtgB3dyEmWhPIeHuf91$s+Y14/zx/tlXbsKGgaEEjryPa3LiotdBXzclkXyog2s=', NULL, 0, 'kmoran661', '', '', '', 0, 1, '2023-06-23 03:03:30.466395');

-- Dumping structure for table escuela.auth_user_groups
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.auth_user_groups: ~0 rows (approximately)

-- Dumping structure for table escuela.auth_user_user_permissions
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.auth_user_user_permissions: ~0 rows (approximately)

-- Dumping structure for table escuela.catalogo_paquete
DROP TABLE IF EXISTS `catalogo_paquete`;
CREATE TABLE IF NOT EXISTS `catalogo_paquete` (
  `paquete_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `paquete_descripcion` varchar(255) NOT NULL,
  `paquete_costo` decimal(10,2) NOT NULL,
  `paquete_cantTeoricas` smallint(6) NOT NULL,
  `paquete_cantPracticas` smallint(6) NOT NULL,
  `paquete_fechaCreacion` date NOT NULL,
  `paquete_nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`paquete_id`),
  KEY `paquete_fechaCreacion` (`paquete_fechaCreacion`),
  FULLTEXT KEY `paquete_nombre` (`paquete_nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.catalogo_paquete: ~0 rows (approximately)

-- Dumping structure for table escuela.detalle_catalogo
DROP TABLE IF EXISTS `detalle_catalogo`;
CREATE TABLE IF NOT EXISTS `detalle_catalogo` (
  `paquete_id` int(10) unsigned NOT NULL,
  `detalle_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`paquete_id`,`detalle_id`),
  KEY `FK_detalle_catalogo2` (`detalle_id`),
  CONSTRAINT `FK_detalle_catalogo` FOREIGN KEY (`paquete_id`) REFERENCES `catalogo_paquete` (`paquete_id`),
  CONSTRAINT `FK_detalle_catalogo2` FOREIGN KEY (`detalle_id`) REFERENCES `detalle_compra` (`detalle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.detalle_catalogo: ~0 rows (approximately)

-- Dumping structure for table escuela.detalle_compra
DROP TABLE IF EXISTS `detalle_compra`;
CREATE TABLE IF NOT EXISTS `detalle_compra` (
  `detalle_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `alumno_id` int(10) unsigned NOT NULL,
  `detalle_fecha` date NOT NULL,
  PRIMARY KEY (`detalle_id`),
  KEY `FK_detalle_compra_alumno` (`alumno_id`),
  CONSTRAINT `FK_detalle_compra_alumno` FOREIGN KEY (`alumno_id`) REFERENCES `alumno` (`alumno_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.detalle_compra: ~0 rows (approximately)

-- Dumping structure for table escuela.detalle_movimiento
DROP TABLE IF EXISTS `detalle_movimiento`;
CREATE TABLE IF NOT EXISTS `detalle_movimiento` (
  `movimiento_id` int(10) unsigned NOT NULL,
  `detalle_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`movimiento_id`,`detalle_id`),
  KEY `FK_detalle_movimiento2` (`detalle_id`),
  CONSTRAINT `FK_detalle_movimiento` FOREIGN KEY (`movimiento_id`) REFERENCES `movimiento` (`movimiento_id`),
  CONSTRAINT `FK_detalle_movimiento2` FOREIGN KEY (`detalle_id`) REFERENCES `detalle_compra` (`detalle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.detalle_movimiento: ~0 rows (approximately)

-- Dumping structure for table escuela.django_admin_log
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.django_admin_log: ~1 rows (approximately)
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(8, '2023-05-22 15:45:40.389839', '3', 'caleb', 1, '[{"added": {}}]', 16, 2);

-- Dumping structure for table escuela.django_content_type
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.django_content_type: ~1 rows (approximately)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(16, 'core', 'empleado');

-- Dumping structure for table escuela.django_migrations
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.django_migrations: ~8 rows (approximately)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(21, 'core', '0001_initial', '2023-05-27 00:05:16.477085'),
	(22, 'Instructor', '0001_initial', '2023-05-27 20:53:07.190255'),
	(23, 'Instructor', '0002_alter_instructor_options', '2023-05-27 20:53:07.206867'),
	(24, 'Instructor', '0003_alter_instructor_options', '2023-05-27 20:53:07.206867'),
	(25, 'Vehiculo', '0001_initial', '2023-05-27 20:53:07.221873'),
	(26, 'Mantenimiento', '0001_initial', '2023-06-04 02:34:54.476021'),
	(27, 'Mantenimiento', '0002_alter_mantenimiento_table', '2023-06-04 02:34:54.487638'),
	(28, 'Vehiculo', '0002_alter_vehiculo_table', '2023-06-04 02:34:54.492671');

-- Dumping structure for table escuela.django_session
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.django_session: ~2 rows (approximately)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('qsgeiplqgl2v99sxzh8mrnv8uac3jtq3', '.eJxVjEEOgjAQRe_StWnaKWXApXvO0AydqUUNTSisjHcXEha6_e-9_1aBtjWHrcoSJlZXBeryu40UnzIfgB8034uOZV6XadSHok9a9VBYXrfT_TvIVPNe42iMpdhaZgMoLTedRwuxAxedl873rkFMtBPBvrUo3iRITJBM9JDU5wvOOjen:1qAFs6:u_BdmOntSQHTdEtwGFTXT0dk7rfbn_WjZ0bz5Kv4BHE', '2023-06-30 20:16:38.265118'),
	('ynh960zw26njhnwevr1h5qe9v45crj2b', '.eJxVjMsOwiAQRf-FtSHlZRiX7v0GMjOAVA0kpV01_ruSdKHLe8_J2UXAbS1h62kJcxQXAeL0-xHyM9UB4gPrvUludV1mkkORB-3y1mJ6XQ_3L1Cwl5GlqCdQbJOZjE72DMrb5KIhcgyISMrrzE6577CQQVulMJPmnL0HJ94f44k4Cg:1qBnsS:eukMwne_mALTuOEcC3BeJ3IlTxpjv9br-eQweCGuZ-Y', '2023-07-05 02:47:24.495477');

-- Dumping structure for table escuela.documentoidentidad
DROP TABLE IF EXISTS `documentoidentidad`;
CREATE TABLE IF NOT EXISTS `documentoidentidad` (
  `alumno_id` int(10) unsigned NOT NULL,
  `documento_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `documento_tipo` enum('DUI','Pasaporte','Permiso de residencia') NOT NULL DEFAULT 'DUI',
  `documento_num` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`documento_id`),
  UNIQUE KEY `documento_num` (`documento_num`),
  KEY `FK_documentoidentidad_alumno` (`alumno_id`),
  CONSTRAINT `FK_documentoidentidad_alumno` FOREIGN KEY (`alumno_id`) REFERENCES `alumno` (`alumno_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.documentoidentidad: ~5 rows (approximately)
INSERT INTO `documentoidentidad` (`alumno_id`, `documento_id`, `documento_tipo`, `documento_num`) VALUES
	(293, 36, 'DUI', '11'),
	(294, 37, 'DUI', '22'),
	(295, 38, 'DUI', '33'),
	(296, 39, 'DUI', '44'),
	(297, 40, 'DUI', '321232123');

-- Dumping structure for table escuela.empleado
DROP TABLE IF EXISTS `empleado`;
CREATE TABLE IF NOT EXISTS `empleado` (
  `usuario_id` int(10) unsigned NOT NULL,
  `empleado_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `empleado_nombre` varchar(25) NOT NULL,
  `empleado_apellido` varchar(50) NOT NULL,
  `empleado_telefono` varchar(20) NOT NULL,
  `empleado_fechaInicio` date NOT NULL,
  `empleado_fechaFin` date DEFAULT NULL,
  PRIMARY KEY (`empleado_id`),
  KEY `FK_tiene` (`usuario_id`),
  KEY `empleado_fechaInicio` (`empleado_fechaInicio`),
  FULLTEXT KEY `empleado_nombre` (`empleado_nombre`),
  CONSTRAINT `FK_tiene` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.empleado: ~4 rows (approximately)
INSERT INTO `empleado` (`usuario_id`, `empleado_id`, `empleado_nombre`, `empleado_apellido`, `empleado_telefono`, `empleado_fechaInicio`, `empleado_fechaFin`) VALUES
	(12, 11, 'Kevin', 'Moran', '32332123', '2023-06-30', NULL),
	(13, 12, 'Caleb', 'Zepeda', '32122323', '2023-06-30', NULL),
	(14, 13, 'Carlos', 'Patrick', '11112222', '2023-06-30', NULL),
	(15, 14, 'kevin', 'Moran', '12345', '2023-06-30', NULL);

-- Dumping structure for table escuela.encuesta
DROP TABLE IF EXISTS `encuesta`;
CREATE TABLE IF NOT EXISTS `encuesta` (
  `encuesta_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instructor_id` smallint(5) unsigned DEFAULT NULL,
  `encuesta_fecha` date NOT NULL,
  `encuesta_comentario` varchar(255) NOT NULL,
  `pregunta1` int(11) NOT NULL,
  `pregunta2` int(11) NOT NULL,
  `pregunta3` int(11) NOT NULL,
  `pregunta4` int(11) NOT NULL,
  `pregunta5` int(11) NOT NULL,
  `pregunta6` int(11) NOT NULL,
  `pregunta7` int(11) NOT NULL,
  PRIMARY KEY (`encuesta_id`),
  KEY `FK_encuesta_instructor` (`instructor_id`),
  KEY `encuesta_fecha` (`encuesta_fecha`),
  CONSTRAINT `FK_encuesta_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.encuesta: ~0 rows (approximately)

-- Dumping structure for table escuela.examen
DROP TABLE IF EXISTS `examen`;
CREATE TABLE IF NOT EXISTS `examen` (
  `examen_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `examen_nota` decimal(2,1) NOT NULL,
  `examen_fecha` date NOT NULL,
  PRIMARY KEY (`examen_id`),
  KEY `examen_fecha` (`examen_fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.examen: ~0 rows (approximately)

-- Dumping structure for table escuela.examen_detalle
DROP TABLE IF EXISTS `examen_detalle`;
CREATE TABLE IF NOT EXISTS `examen_detalle` (
  `detalle_id` int(10) unsigned NOT NULL,
  `examen_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`detalle_id`,`examen_id`),
  KEY `FK_examen_detalle2` (`examen_id`),
  CONSTRAINT `FK_examen_detalle` FOREIGN KEY (`detalle_id`) REFERENCES `detalle_compra` (`detalle_id`),
  CONSTRAINT `FK_examen_detalle2` FOREIGN KEY (`examen_id`) REFERENCES `examen` (`examen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.examen_detalle: ~0 rows (approximately)

-- Dumping structure for table escuela.horario
DROP TABLE IF EXISTS `horario`;
CREATE TABLE IF NOT EXISTS `horario` (
  `horario_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `movimiento_id` int(10) unsigned NOT NULL,
  `horario_horaInicio` time NOT NULL,
  `horario_horaFin` time NOT NULL,
  PRIMARY KEY (`horario_id`),
  KEY `FK_horario_movimiento` (`movimiento_id`),
  CONSTRAINT `FK_horario_movimiento` FOREIGN KEY (`movimiento_id`) REFERENCES `movimiento` (`movimiento_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.horario: ~0 rows (approximately)

-- Dumping structure for table escuela.instructor
DROP TABLE IF EXISTS `instructor`;
CREATE TABLE IF NOT EXISTS `instructor` (
  `instructor_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `empleado_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`instructor_id`),
  KEY `FK_instructor_empleado` (`empleado_id`),
  CONSTRAINT `FK_instructor_empleado` FOREIGN KEY (`empleado_id`) REFERENCES `empleado` (`empleado_id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.instructor: ~3 rows (approximately)
INSERT INTO `instructor` (`instructor_id`, `empleado_id`) VALUES
	(216, 11),
	(206, 12),
	(211, 14);

-- Dumping structure for table escuela.licencia
DROP TABLE IF EXISTS `licencia`;
CREATE TABLE IF NOT EXISTS `licencia` (
  `licencia_Id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `licencia_tipo` enum('Liviana','Pesada','Moto') NOT NULL DEFAULT 'Liviana',
  PRIMARY KEY (`licencia_Id`),
  KEY `licencia_tipo` (`licencia_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.licencia: ~3 rows (approximately)
INSERT INTO `licencia` (`licencia_Id`, `licencia_tipo`) VALUES
	(1, 'Liviana'),
	(2, 'Pesada'),
	(3, 'Moto');

-- Dumping structure for table escuela.mantenimiento
DROP TABLE IF EXISTS `mantenimiento`;
CREATE TABLE IF NOT EXISTS `mantenimiento` (
  `mantenimiento_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vehiculo_id` int(10) unsigned DEFAULT NULL,
  `mantenimiento_comentario` varchar(500) NOT NULL,
  `mantenimiento_fecha` date NOT NULL,
  `mantenimiento_costo` decimal(10,2) NOT NULL,
  PRIMARY KEY (`mantenimiento_id`),
  KEY `FK_mantenimiento_vehiculo` (`vehiculo_id`),
  KEY `mantenimiento_fecha` (`mantenimiento_fecha`),
  CONSTRAINT `FK_mantenimiento_vehiculo` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculo` (`vehiculo_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.mantenimiento: ~0 rows (approximately)
INSERT INTO `mantenimiento` (`mantenimiento_id`, `vehiculo_id`, `mantenimiento_comentario`, `mantenimiento_fecha`, `mantenimiento_costo`) VALUES
	(6, 83, 'llantas', '2023-06-30', 1500.00);

-- Dumping structure for table escuela.modificaempleado
DROP TABLE IF EXISTS `modificaempleado`;
CREATE TABLE IF NOT EXISTS `modificaempleado` (
  `modificaEmpleado_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `modifica_fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `modifica_usuario` varchar(50) NOT NULL,
  PRIMARY KEY (`modificaEmpleado_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.modificaempleado: ~10 rows (approximately)
INSERT INTO `modificaempleado` (`modificaEmpleado_id`, `modifica_fecha`, `modifica_usuario`) VALUES
	(1, '2023-05-30 14:30:02', 'root@localhost'),
	(2, '2023-05-30 15:43:12', 'root@localhost'),
	(3, '2023-05-30 15:47:08', 'root@localhost'),
	(4, '2023-05-30 15:47:16', 'root@localhost'),
	(5, '2023-06-21 03:20:29', 'root@localhost'),
	(6, '2023-06-21 03:22:51', 'root@localhost'),
	(7, '2023-06-21 03:23:54', 'root@localhost'),
	(8, '2023-06-21 03:23:57', 'root@localhost'),
	(9, '2023-06-23 00:00:58', 'root@localhost'),
	(10, '2023-06-23 00:39:59', 'root@localhost');

-- Dumping structure for table escuela.modulo
DROP TABLE IF EXISTS `modulo`;
CREATE TABLE IF NOT EXISTS `modulo` (
  `modulo_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `modulo_nombre` varchar(200) NOT NULL,
  PRIMARY KEY (`modulo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.modulo: ~0 rows (approximately)

-- Dumping structure for table escuela.modulo_operacion
DROP TABLE IF EXISTS `modulo_operacion`;
CREATE TABLE IF NOT EXISTS `modulo_operacion` (
  `operacion_id` int(10) unsigned NOT NULL,
  `modulo_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`operacion_id`,`modulo_id`),
  KEY `FK_modulo_operacion2` (`modulo_id`),
  CONSTRAINT `FK_modulo_operacion` FOREIGN KEY (`operacion_id`) REFERENCES `operacion` (`operacion_id`),
  CONSTRAINT `FK_modulo_operacion2` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`modulo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.modulo_operacion: ~0 rows (approximately)

-- Dumping structure for table escuela.movimiento
DROP TABLE IF EXISTS `movimiento`;
CREATE TABLE IF NOT EXISTS `movimiento` (
  `movimiento_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instructor_id` smallint(5) unsigned NOT NULL,
  `movimiento_tipo` varchar(255) NOT NULL,
  `movimiento_asistencia` tinyint(3) unsigned DEFAULT 0,
  `movimiento_fecha` date NOT NULL,
  PRIMARY KEY (`movimiento_id`),
  KEY `FK_movimiento_instructor` (`instructor_id`),
  CONSTRAINT `FK_movimiento_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.movimiento: ~0 rows (approximately)

-- Dumping structure for table escuela.operacion
DROP TABLE IF EXISTS `operacion`;
CREATE TABLE IF NOT EXISTS `operacion` (
  `operacion_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `operacion_nombre` varchar(200) NOT NULL,
  PRIMARY KEY (`operacion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.operacion: ~0 rows (approximately)

-- Dumping structure for table escuela.respuesta
DROP TABLE IF EXISTS `respuesta`;
CREATE TABLE IF NOT EXISTS `respuesta` (
  `respuesta_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `respuesta_nota` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`respuesta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.respuesta: ~0 rows (approximately)

-- Dumping structure for table escuela.rol
DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `rol_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rol_nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.rol: ~3 rows (approximately)
INSERT INTO `rol` (`rol_id`, `rol_nombre`) VALUES
	(1, 'administrador'),
	(2, 'instructor'),
	(3, 'encargado');

-- Dumping structure for table escuela.rol_modulo
DROP TABLE IF EXISTS `rol_modulo`;
CREATE TABLE IF NOT EXISTS `rol_modulo` (
  `modulo_id` int(10) unsigned NOT NULL,
  `rol_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`modulo_id`,`rol_id`),
  KEY `FK_rol_modulo2` (`rol_id`),
  CONSTRAINT `FK_rol_modulo` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`modulo_id`),
  CONSTRAINT `FK_rol_modulo2` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.rol_modulo: ~0 rows (approximately)

-- Dumping structure for table escuela.usuario
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `usuario_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rol_id` int(10) unsigned DEFAULT NULL,
  `usuario_nombre` varchar(50) NOT NULL,
  `usuario_fechaCreacion` date NOT NULL,
  `usuario_estado` tinyint(3) unsigned DEFAULT 0,
  `correo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`usuario_id`),
  KEY `FK_usuario_rol` (`rol_id`),
  KEY `usuario_fechaCreacion` (`usuario_fechaCreacion`),
  CONSTRAINT `FK_usuario_rol` FOREIGN KEY (`rol_id`) REFERENCES `rol` (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.usuario: ~4 rows (approximately)
INSERT INTO `usuario` (`usuario_id`, `rol_id`, `usuario_nombre`, `usuario_fechaCreacion`, `usuario_estado`, `correo`) VALUES
	(12, 2, 'kmoran986', '2023-06-30', 1, 'kevin@gmail.com'),
	(13, 2, 'czepeda745', '2023-06-30', 1, 'dueñas@gmail.com'),
	(14, 3, 'cpatrick938', '2023-06-30', 1, 'dueñas@gmail.com'),
	(15, 2, 'kmoran661', '2023-06-30', 1, '');

-- Dumping structure for table escuela.vehiculo
DROP TABLE IF EXISTS `vehiculo`;
CREATE TABLE IF NOT EXISTS `vehiculo` (
  `vehiculo_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instructor_id` smallint(5) unsigned DEFAULT NULL,
  `vehiculo_placa` varchar(25) NOT NULL,
  `vehiculo_marca` varchar(25) NOT NULL,
  `vehiculo_tipo` enum('sedan','pick-up','convertible') NOT NULL DEFAULT 'sedan',
  `vehiculo_transmision` enum('Automatico','estandar') NOT NULL DEFAULT 'estandar',
  PRIMARY KEY (`vehiculo_id`),
  UNIQUE KEY `vehiculo_placa` (`vehiculo_placa`),
  KEY `FK_vehiculo_instructor` (`instructor_id`),
  KEY `vehiculo_marca` (`vehiculo_marca`),
  CONSTRAINT `FK_vehiculo_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table escuela.vehiculo: ~1 rows (approximately)
INSERT INTO `vehiculo` (`vehiculo_id`, `instructor_id`, `vehiculo_placa`, `vehiculo_marca`, `vehiculo_tipo`, `vehiculo_transmision`) VALUES
	(83, 206, 'P132-321', 'Mazda', 'sedan', 'estandar');

-- Dumping structure for trigger escuela.catalogo_paquete_before_insert
DROP TRIGGER IF EXISTS `catalogo_paquete_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `catalogo_paquete_before_insert` BEFORE INSERT ON `catalogo_paquete` FOR EACH ROW BEGIN

SET NEW.paquete_fechaCreacion=CURRENT_DATE();

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger escuela.detalle_compra_before_insert
DROP TRIGGER IF EXISTS `detalle_compra_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `detalle_compra_before_insert` BEFORE INSERT ON `detalle_compra` FOR EACH ROW BEGIN

SET NEW.detalle_fecha=CURRENT_DATE();

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger escuela.empleado_after_update
DROP TRIGGER IF EXISTS `empleado_after_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `empleado_after_update` AFTER UPDATE ON `empleado` FOR EACH ROW BEGIN


INSERT INTO modificaempleado(modifica_usuario)VALUES(CURRENT_USER());


END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger escuela.empleado_before_insert
DROP TRIGGER IF EXISTS `empleado_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `empleado_before_insert` BEFORE INSERT ON `empleado` FOR EACH ROW BEGIN

SET NEW.empleado_fechaInicio=CURRENT_DATE();

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger escuela.encuesta_before_insert
DROP TRIGGER IF EXISTS `encuesta_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `encuesta_before_insert` BEFORE INSERT ON `encuesta` FOR EACH ROW BEGIN

SET NEW.encuesta_fecha=CURRENT_DATE();

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger escuela.examen_before_insert
DROP TRIGGER IF EXISTS `examen_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `examen_before_insert` BEFORE INSERT ON `examen` FOR EACH ROW BEGIN

SET NEW.examen_fecha=CURRENT_DATE();

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger escuela.mantenimiento_before_insert
DROP TRIGGER IF EXISTS `mantenimiento_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `mantenimiento_before_insert` BEFORE INSERT ON `mantenimiento` FOR EACH ROW BEGIN

SET NEW.mantenimiento_fecha=CURRENT_DATE();

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger escuela.usuario_before_insert
DROP TRIGGER IF EXISTS `usuario_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `usuario_before_insert` BEFORE INSERT ON `usuario` FOR EACH ROW BEGIN

SET NEW.usuario_fechaCreacion=CURRENT_DATE();

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
