-- MySQL Workbench Synchronization
-- Generated: 2022-12-15 12:46
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: formacio

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `mydb`.`Usuaris` (
  `Email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `nom_usuari` VARCHAR(45) NOT NULL,
  `data_naixement` DATE NOT NULL,
  `sexe` VARCHAR(10) NOT NULL,
  `País` VARCHAR(45) NOT NULL,
  `Codi_postal` INT(11) NOT NULL,
  PRIMARY KEY (`Email`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Videos` (
  `idVideos` INT(11) NOT NULL AUTO_INCREMENT,
  `Titol` VARCHAR(45) NOT NULL,
  `Descripició` VARCHAR(240) NOT NULL,
  `GB` DOUBLE NOT NULL,
  `Nom_arxiu` VARCHAR(45) NOT NULL,
  `Durada` TIME NOT NULL,
  `Thumbnail` VARCHAR(45) NULL DEFAULT NULL,
  `Reproduccions` INT(11) NULL DEFAULT NULL,
  `Likes` INT(11) NULL DEFAULT NULL,
  `Dislikes` INT(11) NULL DEFAULT NULL,
  `Usuaris_Email` VARCHAR(45) NOT NULL,
  `idEstat Video` INT(11) NOT NULL,
  `Data_publicació` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idVideos`, `Usuaris_Email`, `idEstat Video`),
  UNIQUE INDEX `idVideos_UNIQUE` (`idVideos` ASC) VISIBLE,
  INDEX `fk_Videos_Estat Video_idx` (`idEstat Video` ASC) VISIBLE,
  INDEX `fk_Videos_Usuaris1_idx` (`Usuaris_Email` ASC) VISIBLE,
  UNIQUE INDEX `Titol_UNIQUE` (`Titol` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_Estat Video`
    FOREIGN KEY (`idEstat Video`)
    REFERENCES `mydb`.`Estat Video` (`idEstat Video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Videos_Usuaris1`
    FOREIGN KEY (`Usuaris_Email`)
    REFERENCES `mydb`.`Usuaris` (`Email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Estat Video` (
  `idEstat Video` INT(11) NOT NULL AUTO_INCREMENT,
  `Estat_Video` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstat Video`),
  UNIQUE INDEX `idEstat Video_UNIQUE` (`idEstat Video` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Etiquetes` (
  `idEtiquetes` INT(11) NOT NULL AUTO_INCREMENT,
  `Nom_etiqueta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEtiquetes`),
  UNIQUE INDEX `idEtiquetes_UNIQUE` (`idEtiquetes` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Videos_has_Etiquetes` (
  `Videos_idVideos` INT(11) NOT NULL,
  `Videos_idEstat Video` INT(11) NOT NULL,
  `Etiquetes_idEtiquetes` INT(11) NOT NULL,
  PRIMARY KEY (`Videos_idVideos`, `Videos_idEstat Video`, `Etiquetes_idEtiquetes`),
  INDEX `fk_Videos_has_Etiquetes_Etiquetes1_idx` (`Etiquetes_idEtiquetes` ASC) VISIBLE,
  INDEX `fk_Videos_has_Etiquetes_Videos1_idx` (`Videos_idVideos` ASC, `Videos_idEstat Video` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_has_Etiquetes_Videos1`
    FOREIGN KEY (`Videos_idVideos` , `Videos_idEstat Video`)
    REFERENCES `mydb`.`Videos` (`idVideos` , `idEstat Video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Videos_has_Etiquetes_Etiquetes1`
    FOREIGN KEY (`Etiquetes_idEtiquetes`)
    REFERENCES `mydb`.`Etiquetes` (`idEtiquetes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Canal` (
  `Nom_Canal` VARCHAR(45) NOT NULL,
  `Descripció` VARCHAR(45) NULL DEFAULT NULL,
  `Data_Creació` DATE NOT NULL,
  `Usuaris_Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nom_Canal`, `Usuaris_Email`),
  INDEX `fk_Canal_Usuaris1_idx` (`Usuaris_Email` ASC) VISIBLE,
  UNIQUE INDEX `Nom_Canal_UNIQUE` (`Nom_Canal` ASC) VISIBLE,
  CONSTRAINT `fk_Canal_Usuaris1`
    FOREIGN KEY (`Usuaris_Email`)
    REFERENCES `mydb`.`Usuaris` (`Email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Usuari_te_Likes` (
  `Usuaris_Email` VARCHAR(45) NOT NULL,
  `Videos_idVideos` INT(11) NOT NULL,
  `Videos_Usuaris_Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Usuaris_Email`, `Videos_idVideos`, `Videos_Usuaris_Email`),
  INDEX `fk_Usuaris_has_Videos_Videos1_idx` (`Videos_idVideos` ASC, `Videos_Usuaris_Email` ASC) VISIBLE,
  INDEX `fk_Usuaris_has_Videos_Usuaris1_idx` (`Usuaris_Email` ASC) VISIBLE,
  CONSTRAINT `fk_Usuaris_has_Videos_Usuaris1`
    FOREIGN KEY (`Usuaris_Email`)
    REFERENCES `mydb`.`Usuaris` (`Email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuaris_has_Videos_Videos1`
    FOREIGN KEY (`Videos_idVideos` , `Videos_Usuaris_Email`)
    REFERENCES `mydb`.`Videos` (`idVideos` , `Usuaris_Email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Usuaris_te_suscripcions_a_canal` (
  `Usuaris_Email` VARCHAR(45) NOT NULL,
  `Canal_Nom_Canal` VARCHAR(45) NOT NULL,
  `Canal_Usuaris_Email` VARCHAR(45) NOT NULL,
  `Data_Puntuació` TIMESTAMP NOT NULL,
  PRIMARY KEY (`Usuaris_Email`, `Canal_Nom_Canal`, `Canal_Usuaris_Email`),
  INDEX `fk_Usuaris_has_Canal_Canal1_idx` (`Canal_Nom_Canal` ASC, `Canal_Usuaris_Email` ASC) VISIBLE,
  INDEX `fk_Usuaris_has_Canal_Usuaris1_idx` (`Usuaris_Email` ASC) VISIBLE,
  CONSTRAINT `fk_Usuaris_has_Canal_Usuaris1`
    FOREIGN KEY (`Usuaris_Email`)
    REFERENCES `mydb`.`Usuaris` (`Email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuaris_has_Canal_Canal1`
    FOREIGN KEY (`Canal_Nom_Canal` , `Canal_Usuaris_Email`)
    REFERENCES `mydb`.`Canal` (`Nom_Canal` , `Usuaris_Email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Comentaris` (
  `idComentaris` INT(11) NOT NULL AUTO_INCREMENT,
  `Data_publicació` TIMESTAMP NOT NULL,
  `Usuaris_Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idComentaris`, `Usuaris_Email`),
  UNIQUE INDEX `idComentaris_UNIQUE` (`idComentaris` ASC) VISIBLE,
  INDEX `fk_Comentaris_Usuaris1_idx` (`Usuaris_Email` ASC) VISIBLE,
  CONSTRAINT `fk_Comentaris_Usuaris1`
    FOREIGN KEY (`Usuaris_Email`)
    REFERENCES `mydb`.`Usuaris` (`Email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Videos_has_Comentaris` (
  `Videos_idVideos` INT(11) NOT NULL,
  `Videos_Usuaris_Email` VARCHAR(45) NOT NULL,
  `Comentaris_idComentaris` INT(11) NOT NULL,
  `Comentaris_Usuaris_Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Videos_idVideos`, `Videos_Usuaris_Email`, `Comentaris_idComentaris`, `Comentaris_Usuaris_Email`),
  INDEX `fk_Videos_has_Comentaris_Comentaris1_idx` (`Comentaris_idComentaris` ASC, `Comentaris_Usuaris_Email` ASC) VISIBLE,
  INDEX `fk_Videos_has_Comentaris_Videos1_idx` (`Videos_idVideos` ASC, `Videos_Usuaris_Email` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_has_Comentaris_Videos1`
    FOREIGN KEY (`Videos_idVideos` , `Videos_Usuaris_Email`)
    REFERENCES `mydb`.`Videos` (`idVideos` , `Usuaris_Email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Videos_has_Comentaris_Comentaris1`
    FOREIGN KEY (`Comentaris_idComentaris` , `Comentaris_Usuaris_Email`)
    REFERENCES `mydb`.`Comentaris` (`idComentaris` , `Usuaris_Email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `mydb`.`proveïdors` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
