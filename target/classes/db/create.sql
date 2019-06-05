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
CREATE TABLE IF NOT EXISTS `netflix`.`actors` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`categories`
-- -----------------------------------------------------
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
-- Table `netflix`.`tv_shows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`tv_shows` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(256) NOT NULL,
  `SHORT_DESC` VARCHAR(256) NULL DEFAULT NULL,
  `LONG_DESC` VARCHAR(2048) NULL DEFAULT NULL,
  `YEAR` YEAR(4) NOT NULL,
  `RECOMMENDED_AGE` TINYINT(4) NOT NULL,
  `CATEGORY_ID` BIGINT(20) NOT NULL,
  `ADVERTISING` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_TV_SHOWS_CATEGORY_ID` (`CATEGORY_ID` ASC) VISIBLE,
  CONSTRAINT `FK_TV_SHOWS_CATEGORY_ID`
    FOREIGN KEY (`CATEGORY_ID`)
    REFERENCES `netflix`.`categories` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`seasons`
-- -----------------------------------------------------
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
CREATE TABLE IF NOT EXISTS `netflix`.`awards` (
  `ID` BIGINT(20) NOT NULL,
  `NAME` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`tvshowsawards`
-- -----------------------------------------------------
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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO actors (name)
VALUES ('Jordi'), ('Matias'), ('Jaume');
