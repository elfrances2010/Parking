-- =============================================
-- BASE DE DATOS: parking-backend
-- Proyecto: API REST Node.js + Express + MySQL + JWT
-- Ficha: 3186583 - SENA
-- Autor: Samuel Enrique Burbano Castro
-- =============================================

CREATE DATABASE IF NOT EXISTS `parking-frontend`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `parking-frontend`;

-- =============================================
-- TABLA: usuarios
-- =============================================
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `nombre`     VARCHAR(100)  NOT NULL,
  `email`      VARCHAR(100)  NOT NULL UNIQUE,
  `password`   VARCHAR(255)  NOT NULL,
  `rol`        ENUM('admin','gestor','dependencia') NOT NULL DEFAULT 'dependencia',
  `activo`     TINYINT(1)    NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- TABLA: vehiculos
-- =============================================
CREATE TABLE IF NOT EXISTS `vehiculos` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `placa`      VARCHAR(20)   NOT NULL UNIQUE,
  `tipo`       ENUM('carro','moto','bicicleta','otro') NOT NULL DEFAULT 'carro',
  `propietario` VARCHAR(150) NULL,
  `created_at` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- TABLA: puestos
-- =============================================
CREATE TABLE IF NOT EXISTS `puestos` (
  `id`         INT AUTO_INCREMENT PRIMARY KEY,
  `codigo`     VARCHAR(20)   NOT NULL UNIQUE,
  `tipo`       ENUM('carro','moto','bicicleta') NOT NULL DEFAULT 'carro',
  `disponible` TINYINT(1)    NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- TABLA: registros
-- =============================================
CREATE TABLE IF NOT EXISTS `registros` (
  `id`           INT AUTO_INCREMENT PRIMARY KEY,
  `vehiculo_id`  INT           NOT NULL,
  `puesto_id`    INT           NOT NULL,
  `usuario_id`   INT           NOT NULL,
  `entrada`      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `salida`       DATETIME      NULL,
  `tarifa`       DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `total`        DECIMAL(10,2) NULL,
  `estado`       ENUM('activo','finalizado') NOT NULL DEFAULT 'activo',
  CONSTRAINT `fk_reg_vehiculo` FOREIGN KEY (`vehiculo_id`) REFERENCES `vehiculos`(`id`),
  CONSTRAINT `fk_reg_puesto`   FOREIGN KEY (`puesto_id`)   REFERENCES `puestos`(`id`),
  CONSTRAINT `fk_reg_usuario`  FOREIGN KEY (`usuario_id`)  REFERENCES `usuarios`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- TABLA: tarifas
-- =============================================
CREATE TABLE IF NOT EXISTS `tarifas` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `tipo`        ENUM('carro','moto','bicicleta') NOT NULL UNIQUE,
  `valor_hora`  DECIMAL(10,2) NOT NULL,
  `updated_at`  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- TABLA: auditoria
-- =============================================
CREATE TABLE IF NOT EXISTS `auditoria` (
  `id`          INT AUTO_INCREMENT PRIMARY KEY,
  `usuario_id`  INT           NULL,
  `accion`      VARCHAR(100)  NOT NULL,
  `tabla`       VARCHAR(50)   NULL,
  `registro_id` INT           NULL,
  `detalle`     TEXT          NULL,
  `ip`          VARCHAR(45)   NULL,
  `created_at`  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `fk_aud_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================================
-- DATOS INICIALES
-- =============================================

INSERT INTO `tarifas` (`tipo`, `valor_hora`) VALUES
  ('carro',      3500.00),
  ('moto',       2000.00),
  ('bicicleta',   500.00);

INSERT INTO `puestos` (`codigo`, `tipo`) VALUES
  ('C-01','carro'), ('C-02','carro'), ('C-03','carro'), ('C-04','carro'), ('C-05','carro'),
  ('C-06','carro'), ('C-07','carro'), ('C-08','carro'), ('C-09','carro'), ('C-10','carro'),
  ('M-01','moto'),  ('M-02','moto'),  ('M-03','moto'),  ('M-04','moto'),  ('M-05','moto'),
  ('B-01','bicicleta'), ('B-02','bicicleta'), ('B-03','bicicleta'),
  ('B-04','bicicleta'), ('B-05','bicicleta');

INSERT INTO `usuarios` (`nombre`, `email`, `password`, `rol`) VALUES
  ('Administrador', 'admin@parking.com', '123456', 'admin');