-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Stored Procedures
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Stored Procedures
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Stored Procedures` DEFAULT CHARACTER SET utf8 ;
USE `Stored Procedures` ;

-- -----------------------------------------------------
-- Table `Stored Procedures`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stored Procedures`.`cursos` (
  `id_universidade` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  PRIMARY KEY (`id_universidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stored Procedures`.`alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stored Procedures`.`alunos` (
  `id_alunos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  `ra` VARCHAR(70) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_alunos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stored Procedures`.`professores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stored Procedures`.`professores` (
  `id_professores` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(70) NOT NULL,
  `salario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_professores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stored Procedures`.`alunos_has_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stored Procedures`.`alunos_has_cursos` (
  `alunos_id_alunos` INT NOT NULL,
  `cursos_id_universidade` INT NOT NULL,
  PRIMARY KEY (`alunos_id_alunos`, `cursos_id_universidade`),
  INDEX `fk_alunos_has_cursos_cursos1_idx` (`cursos_id_universidade` ASC) VISIBLE,
  INDEX `fk_alunos_has_cursos_alunos_idx` (`alunos_id_alunos` ASC) VISIBLE,
  CONSTRAINT `fk_alunos_has_cursos_alunos`
    FOREIGN KEY (`alunos_id_alunos`)
    REFERENCES `Stored Procedures`.`alunos` (`id_alunos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alunos_has_cursos_cursos1`
    FOREIGN KEY (`cursos_id_universidade`)
    REFERENCES `Stored Procedures`.`cursos` (`id_universidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Stored Procedures`.`professores_has_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Stored Procedures`.`professores_has_cursos` (
  `professores_id_professores` INT NOT NULL,
  `cursos_id_universidade` INT NOT NULL,
  PRIMARY KEY (`professores_id_professores`, `cursos_id_universidade`),
  INDEX `fk_professores_has_cursos_cursos1_idx` (`cursos_id_universidade` ASC) VISIBLE,
  INDEX `fk_professores_has_cursos_professores1_idx` (`professores_id_professores` ASC) VISIBLE,
  CONSTRAINT `fk_professores_has_cursos_professores1`
    FOREIGN KEY (`professores_id_professores`)
    REFERENCES `Stored Procedures`.`professores` (`id_professores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professores_has_cursos_cursos1`
    FOREIGN KEY (`cursos_id_universidade`)
    REFERENCES `Stored Procedures`.`cursos` (`id_universidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
