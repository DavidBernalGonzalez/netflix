-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema netflix
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `netflix` ;

-- -----------------------------------------------------
-- Schema netflix
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `netflix` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `netflix` ;

-- -----------------------------------------------------
-- Table `netflix`.`actors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `netflix`.`actors` ;

CREATE TABLE IF NOT EXISTS `netflix`.`actors` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`tv_shows`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `netflix`.`tv_shows` ;

CREATE TABLE IF NOT EXISTS `netflix`.`tv_shows` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(256) NOT NULL,
  `SHORT_DESC` VARCHAR(256) NULL DEFAULT NULL,
  `LONG_DESC` VARCHAR(2048) NULL DEFAULT NULL,
  `YEAR` YEAR(4) NOT NULL,
  `RECOMMENDED_AGE` TINYINT(4) NOT NULL,
  `ADVERTISING` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`seasons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `netflix`.`seasons` ;

CREATE TABLE IF NOT EXISTS `netflix`.`seasons` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `NUMBER` TINYINT(4) NOT NULL,
  `NAME` VARCHAR(256) NOT NULL,
  `TV_SHOW_ID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_SEASONS_TV_SHOW_ID` (`TV_SHOW_ID` ASC) VISIBLE,
  CONSTRAINT `FK_SEASONS_TV_SHOW_ID`
    FOREIGN KEY (`TV_SHOW_ID`)
    REFERENCES `netflix`.`tv_shows` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`chapters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `netflix`.`chapters` ;

CREATE TABLE IF NOT EXISTS `netflix`.`chapters` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `NUMBER` TINYINT(4) NOT NULL,
  `NAME` VARCHAR(256) NOT NULL,
  `DURATION` TINYINT(4) NOT NULL,
  `SEASON_ID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_CHAPTERS_SEASON_ID` (`SEASON_ID` ASC) VISIBLE,
  CONSTRAINT `FK_CHAPTERS_SEASON_ID`
    FOREIGN KEY (`SEASON_ID`)
    REFERENCES `netflix`.`seasons` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`actorschapters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `netflix`.`actorschapters` ;

CREATE TABLE IF NOT EXISTS `netflix`.`actorschapters` (
  `CHAPTER_ID` BIGINT(20) NOT NULL,
  `ACTOR_ID` INT(11) NOT NULL,
  PRIMARY KEY (`CHAPTER_ID`, `ACTOR_ID`),
  INDEX `fk_chapters_has_actors_actors1_idx` (`ACTOR_ID` ASC) VISIBLE,
  INDEX `fk_chapters_has_actors_chapters1_idx` (`CHAPTER_ID` ASC) VISIBLE,
  CONSTRAINT `fk_chapters_has_actors_actors1`
    FOREIGN KEY (`ACTOR_ID`)
    REFERENCES `netflix`.`actors` (`ID`),
  CONSTRAINT `fk_chapters_has_actors_chapters1`
    FOREIGN KEY (`CHAPTER_ID`)
    REFERENCES `netflix`.`chapters` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`awards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `netflix`.`awards` ;

CREATE TABLE IF NOT EXISTS `netflix`.`awards` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `netflix`.`categories` ;

CREATE TABLE IF NOT EXISTS `netflix`.`categories` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `NAME` (`NAME` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`tvshowsawards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `netflix`.`tvshowsawards` ;

CREATE TABLE IF NOT EXISTS `netflix`.`tvshowsawards` (
  `TV_SHOWS_ID` BIGINT(20) NOT NULL,
  `AWARDS_ID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`TV_SHOWS_ID`, `AWARDS_ID`),
  INDEX `fk_tv_shows_has_Awards_Awards1_idx` (`AWARDS_ID` ASC) VISIBLE,
  INDEX `fk_tv_shows_has_Awards_tv_shows1_idx` (`TV_SHOWS_ID` ASC) VISIBLE,
  CONSTRAINT `fk_tv_shows_has_Awards_Awards1`
    FOREIGN KEY (`AWARDS_ID`)
    REFERENCES `netflix`.`awards` (`ID`),
  CONSTRAINT `fk_tv_shows_has_Awards_tv_shows1`
    FOREIGN KEY (`TV_SHOWS_ID`)
    REFERENCES `netflix`.`tv_shows` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`tvshowsCategories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `netflix`.`tvshowsCategories` ;

CREATE TABLE IF NOT EXISTS `netflix`.`tvshowsCategories` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `TV_SHOWS_ID` BIGINT(20) NOT NULL,
  `CATEGORIES_ID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`, `TV_SHOWS_ID`, `CATEGORIES_ID`),
  INDEX `fk_tv_shows_has_categories_categories1_idx` (`CATEGORIES_ID` ASC) VISIBLE,
  INDEX `fk_tv_shows_has_categories_tv_shows1_idx` (`TV_SHOWS_ID` ASC) VISIBLE,
  CONSTRAINT `fk_tv_shows_has_categories_tv_shows1`
    FOREIGN KEY (`TV_SHOWS_ID`)
    REFERENCES `netflix`.`tv_shows` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tv_shows_has_categories_categories1`
    FOREIGN KEY (`CATEGORIES_ID`)
    REFERENCES `netflix`.`categories` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

# INSERTS
# -----------------------------------------
INSERT INTO actors (id, name) VALUES
(1, 'Jordi'), (2, 'Matias'), (3, 'Jaume');
select * from actors;

INSERT INTO categories (id, name) VALUES 
(1, 'Bélicas'), (2, 'Comedia'), (3, 'Dibujos');
select * from categories;

INSERT INTO awards (id, name)
VALUES (1, 'EMMY MEJOR SERIE DRAMÁTICA'), (2, 'EMMY MEJOR SERIE DRAMÁTICA');
select * from awards;

INSERT INTO tv_shows (id, name, short_desc, long_Desc, year, recommended_age, advertising) VALUES 
(1, 'Juego de Tronos', 'novela de fantasía', 'novela de fantasía escrita por el autor estadounidense George R. R. Martin', 2017, 18, 'amazon'),
(2, 'Prisión Break', 'Presos en una carcel', 'La trama de la serie gira en torno a un hombre que elaborada un plan para rescatar a su hermano Lincoln Burrow', 2007, 18, 'netflix'),
(3, 'Hijos de la anaquia', 'Mafia motera', 'Relata la vida en un club de moteros (MC) que opera ilegalmente en Charming (California)', 2015, 18, 'harley davidson'),
(4, 'Oliver y Benji', 'Futbol', 'Futbol', 2011, 13, '-'),
(5, 'Narcos', 'Narcotrafico', 'Narcotraficantes en colombia', 2018, 18, 'netflix'),
(6, 'Lo simpson', 'Familia', 'Familia y humor', 2015, 18, '-');
select * from tv_shows;

INSERT INTO seasons (id, number, name, tv_show_id) VALUES 
(1, 1, 'Llega el invierno', 1),
(2, 2, 'Lanisteando', 1),
(3, 1, 'Peligros de la carcel', 2);
select * from seasons;

INSERT INTO chapters (id, number, name, duration, season_id) VALUES
(1, 1, 'Nerd Stack y John nieve', 75, 1),
(2, 2, 'Norteños en guerra', 75, 1),
(3, 3, 'Entrada a prisión', 55, 2);
select * from chapters;

INSERT INTO tvshowsCategories (id, tv_shows_id, categories_Id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 3, 1),
(5, 2, 2),
(6, 3, 2),
(7, 6, 3);
select * from tvshowsCategories;