-- MySQL Workbench Synchronization
-- Generated: 2023-01-09 12:12
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: formacio

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `mydb`.`adreça` (
  `idAdreça` INT(11) NOT NULL AUTO_INCREMENT,
  `carrer` VARCHAR(45) NOT NULL,
  `num_carrer` INT(11) NOT NULL,
  `pis` VARCHAR(10) NOT NULL,
  `porta` VARCHAR(10) NOT NULL,
  `ciutat` VARCHAR(45) NOT NULL,
  `codi_postal` VARCHAR(45) NOT NULL,
  `país` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdreça`),
  INDEX `idProveïdor` (`idAdreça` ASC) VISIBLE,
  CONSTRAINT `fk_proveïdor_adreça_Proveïdor`
    FOREIGN KEY (`idAdreça`)
    REFERENCES `mydb`.`Proveïdors` (`idProveïdor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Marques` (
  `idMarca` INT(11) NOT NULL AUTO_INCREMENT,
  `nom_marca` VARCHAR(45) NOT NULL,
  `Proveïdor_idProveïdor` INT(11) NOT NULL,
  PRIMARY KEY (`idMarca`, `Proveïdor_idProveïdor`),
  INDEX `fk_Marca_Proveïdor1_idx` (`Proveïdor_idProveïdor` ASC) VISIBLE,
  CONSTRAINT `fk_Marca_Proveïdor1`
    FOREIGN KEY (`Proveïdor_idProveïdor`)
    REFERENCES `mydb`.`Proveïdors` (`idProveïdor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Ulleres` (
  `idUlleres` INT(11) NOT NULL AUTO_INCREMENT,
  `Marca_idMarca` INT(11) NOT NULL,
  `garduacio_ESQ` DOUBLE NOT NULL,
  `graduacio_DRE` DOUBLE NOT NULL,
  `Tipus_montura_idTipus_montura` INT(11) NOT NULL,
  `color_montura` VARCHAR(45) NOT NULL,
  `color_ESQ` VARCHAR(45) NOT NULL,
  `color_DRE` VARCHAR(45) NOT NULL,
  `preu` DOUBLE NOT NULL,
  PRIMARY KEY (`idUlleres`, `Marca_idMarca`, `Tipus_montura_idTipus_montura`),
  INDEX `fk_Ulleres_Marca1_idx` (`Marca_idMarca` ASC) VISIBLE,
  INDEX `fk_Ulleres_Tipus_montura1_idx` (`Tipus_montura_idTipus_montura` ASC) VISIBLE,
  CONSTRAINT `fk_Ulleres_Marca1`
    FOREIGN KEY (`Marca_idMarca`)
    REFERENCES `mydb`.`Marques` (`idMarca`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ulleres_Tipus_montura1`
    FOREIGN KEY (`Tipus_montura_idTipus_montura`)
    REFERENCES `mydb`.`Tipus_montura` (`idTipus_montura`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Tipus_montura` (
  `idTipus_montura` INT(11) NOT NULL AUTO_INCREMENT,
  `Nom_montura` ENUM('METÀLICA', 'PASTA') NOT NULL,
  PRIMARY KEY (`idTipus_montura`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Clients` (
  `idClients` INT(11) NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Codi_postal` INT(11) NOT NULL,
  `TLF` INT(11) NOT NULL,
  `Correu_electrònic` VARCHAR(45) NOT NULL,
  `data_registre` DATE NOT NULL,
  `Client_referència_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idClients`, `Client_referència_id`),
  INDEX `fk_Clients_Clients1_idx` (`Client_referència_id` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_Clients1`
    FOREIGN KEY (`Client_referència_id`)
    REFERENCES `mydb`.`Clients` (`idClients`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Ventes` (
  `idVentes` INT(11) NOT NULL AUTO_INCREMENT,
  `Ulleres_idUlleres` INT(11) NOT NULL,
  `Clients_idClients` INT(11) NOT NULL,
  `Empleats_idEmpleats` INT(11) NOT NULL,
  `Data_venta` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVentes`, `Ulleres_idUlleres`, `Clients_idClients`, `Empleats_idEmpleats`),
  INDEX `fk_Ventes_Ulleres1_idx` (`Ulleres_idUlleres` ASC) VISIBLE,
  INDEX `fk_Ventes_Clients1_idx` (`Clients_idClients` ASC) VISIBLE,
  INDEX `fk_Ventes_Empleats1_idx` (`Empleats_idEmpleats` ASC) VISIBLE,
  CONSTRAINT `fk_Ventes_Ulleres1`
    FOREIGN KEY (`Ulleres_idUlleres`)
    REFERENCES `mydb`.`Ulleres` (`idUlleres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ventes_Clients1`
    FOREIGN KEY (`Clients_idClients`)
    REFERENCES `mydb`.`Clients` (`idClients`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ventes_Empleats1`
    FOREIGN KEY (`Empleats_idEmpleats`)
    REFERENCES `mydb`.`Empleats` (`idEmpleats`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Empleats` (
  `idEmpleats` INT(11) NOT NULL AUTO_INCREMENT,
  `Cognom1` VARCHAR(45) NOT NULL,
  `Cognom2` VARCHAR(45) NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmpleats`),
  INDEX `index` (`Cognom1` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
