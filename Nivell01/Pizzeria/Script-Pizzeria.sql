-- MySQL Workbench Synchronization
-- Generated: 2022-12-01 12:29
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: formacio

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `mydb`.`Proveïdors` (
  `idProveïdor` INT(11) NOT NULL AUTO_INCREMENT,
  `TLF` INT(11) NOT NULL,
  `FAX` INT(11) NOT NULL,
  `NIF` CHAR(8) NOT NULL,
  PRIMARY KEY (`idProveïdor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`proveïdor_adreça` (
  `idProveïdor` INT(11) NOT NULL AUTO_INCREMENT,
  `carrer` VARCHAR(45) NOT NULL,
  `num_carrer` INT(11) NOT NULL,
  `pis` INT(11) NOT NULL,
  `porta` INT(11) NOT NULL,
  `ciutat` VARCHAR(45) NOT NULL,
  `codi_postal` VARCHAR(45) NOT NULL,
  `país` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProveïdor`),
  INDEX `idProveïdor` (`idProveïdor` ASC) VISIBLE,
  CONSTRAINT `fk_proveïdor_adreça_Proveïdor`
    FOREIGN KEY (`idProveïdor`)
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
  `Nom_montura` VARCHAR(45) NOT NULL,
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

CREATE TABLE IF NOT EXISTS `mydb`.`Clients` (
  `idClients` INT(11) NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NOT NULL,
  `Cognom` VARCHAR(45) NOT NULL,
  `Adreça` VARCHAR(45) NOT NULL,
  `Codi_postal` INT(11) NOT NULL,
  `Localitat` VARCHAR(45) NOT NULL,
  `Província` VARCHAR(45) NOT NULL,
  `TLF` INT(11) NOT NULL,
  `Clients_col` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idClients`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Comandes` (
  `idComandes` INT(11) NOT NULL,
  `Clients_idClients` INT(11) NOT NULL,
  `Data/Hora` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tipus_comanda_idTipus_comanda` INT(11) NOT NULL,
  `Preu` DOUBLE NOT NULL,
  `Productes_idProductes` INT(11) NOT NULL,
  `Botiga_idBotiga` INT(11) NOT NULL,
  `DOM_Empleats_idEmpleats` INT(11) NULL DEFAULT NULL,
  `Comandes_col` VARCHAR(45) NULL DEFAULT NULL,
  `Comandes_col1` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idComandes`, `Clients_idClients`, `Tipus_comanda_idTipus_comanda`, `Productes_idProductes`, `Botiga_idBotiga`, `DOM_Empleats_idEmpleats`),
  INDEX `fk_Comandes_Clients1_idx` (`Clients_idClients` ASC) VISIBLE,
  INDEX `fk_Comandes_Tipus_comanda1_idx` (`Tipus_comanda_idTipus_comanda` ASC) VISIBLE,
  INDEX `fk_Comandes_Productes1_idx` (`Productes_idProductes` ASC) VISIBLE,
  INDEX `fk_Comandes_Botiga1_idx` (`Botiga_idBotiga` ASC) VISIBLE,
  INDEX `fk_Comandes_Empleats1_idx` (`DOM_Empleats_idEmpleats` ASC) VISIBLE,
  CONSTRAINT `fk_Comandes_Clients1`
    FOREIGN KEY (`Clients_idClients`)
    REFERENCES `mydb`.`Clients` (`idClients`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Comandes_Tipus_comanda1`
    FOREIGN KEY (`Tipus_comanda_idTipus_comanda`)
    REFERENCES `mydb`.`Tipus_comanda` (`idTipus_comanda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Comandes_Productes1`
    FOREIGN KEY (`Productes_idProductes`)
    REFERENCES `mydb`.`Productes` (`idProductes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Comandes_Botiga1`
    FOREIGN KEY (`Botiga_idBotiga`)
    REFERENCES `mydb`.`Botiga` (`idBotiga`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Comandes_Empleats1`
    FOREIGN KEY (`DOM_Empleats_idEmpleats`)
    REFERENCES `mydb`.`Empleats` (`idEmpleats`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Productes` (
  `idProductes` INT(11) NOT NULL AUTO_INCREMENT,
  `Tipus_Producte_idTipus_Producte` INT(11) NOT NULL,
  `Nom_producte` VARCHAR(45) NOT NULL,
  `Descripció_producte` VARCHAR(45) NOT NULL,
  `Imatge` VARCHAR(75) NOT NULL,
  `Preu` DOUBLE NOT NULL,
  `Pizza_categories_idPizza_categories` INT(11) NOT NULL,
  PRIMARY KEY (`idProductes`, `Tipus_Producte_idTipus_Producte`, `Pizza_categories_idPizza_categories`),
  INDEX `fk_Productes_Tipus_Producte1_idx` (`Tipus_Producte_idTipus_Producte` ASC) VISIBLE,
  INDEX `fk_Productes_Pizza_categories1_idx` (`Pizza_categories_idPizza_categories` ASC) VISIBLE,
  CONSTRAINT `fk_Productes_Tipus_Producte1`
    FOREIGN KEY (`Tipus_Producte_idTipus_Producte`)
    REFERENCES `mydb`.`Tipus_Producte` (`idTipus_Producte`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Productes_Pizza_categories1`
    FOREIGN KEY (`Pizza_categories_idPizza_categories`)
    REFERENCES `mydb`.`Pizza_categories` (`idPizza_categories`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Pizza_categories` (
  `idPizza_categories` INT(11) NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idPizza_categories`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Botiga` (
  `idBotiga` INT(11) NOT NULL AUTO_INCREMENT,
  `Codi_postal` INT(11) NOT NULL,
  `Localitat` VARCHAR(45) NOT NULL,
  `Província` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBotiga`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Empleats` (
  `idEmpleats` INT(11) NOT NULL AUTO_INCREMENT,
  `Cognom1` VARCHAR(45) NOT NULL,
  `Cognom2` VARCHAR(45) NOT NULL,
  `Nom` VARCHAR(45) NOT NULL,
  `Botiga_idBotiga` INT(11) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `TLF` INT(9) NOT NULL,
  `Tipus_empleat_idTipus_empleat` INT(11) NOT NULL,
  PRIMARY KEY (`idEmpleats`, `Botiga_idBotiga`, `Tipus_empleat_idTipus_empleat`),
  INDEX `fk_Empleats_Botiga1_idx` (`Botiga_idBotiga` ASC) VISIBLE,
  INDEX `fk_Empleats_Tipus_empleat1_idx` (`Tipus_empleat_idTipus_empleat` ASC) VISIBLE,
  CONSTRAINT `fk_Empleats_Botiga1`
    FOREIGN KEY (`Botiga_idBotiga`)
    REFERENCES `mydb`.`Botiga` (`idBotiga`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Empleats_Tipus_empleat1`
    FOREIGN KEY (`Tipus_empleat_idTipus_empleat`)
    REFERENCES `mydb`.`Tipus_empleat` (`idTipus_empleat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Tipus_comanda` (
  `idTipus_comanda` INT(11) NOT NULL,
  `Nom_tipus` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipus_comanda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Tipus_Producte` (
  `idTipus_Producte` INT(11) NOT NULL AUTO_INCREMENT,
  `Tipus_producte` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipus_Producte`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Tipus_empleat` (
  `idTipus_empleat` INT(11) NOT NULL AUTO_INCREMENT,
  `Tipus_empleat` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipus_empleat`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
