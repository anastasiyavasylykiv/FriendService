-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`holiday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`holiday` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`feedback` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rate` INT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL,
  `hours` INT NULL,
  `client_id` INT NOT NULL,
  `holiday_id` INT NOT NULL,
  `feedback_id` INT NOT NULL,
  `price` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_order_client1_idx` (`client_id` ASC),
  INDEX `fk_order_holiday1_idx` (`holiday_id` ASC),
  INDEX `fk_order_feedback1_idx` (`feedback_id` ASC),
  CONSTRAINT `fk_order_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `mydb`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_holiday1`
    FOREIGN KEY (`holiday_id`)
    REFERENCES `mydb`.`holiday` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_feedback1`
    FOREIGN KEY (`feedback_id`)
    REFERENCES `mydb`.`feedback` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`friend`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`friend` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surmame` VARCHAR(45) NULL,
  `price_for_hour` INT NULL,
  `is_free` TINYINT(1) NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_friend_order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_friend_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`vacation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`vacation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vacation_begin` DATE NOT NULL,
  `vacation_end` DATE NOT NULL,
  `friend_id` INT NOT NULL,
  `days_amount` INT GENERATED ALWAYS AS (Day(vacation_begin)-Day(vacation_end)) VIRTUAL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_vacation_friend1_idx` (`friend_id` ASC),
  CONSTRAINT `fk_vacation_friend1`
    FOREIGN KEY (`friend_id`)
    REFERENCES `mydb`.`friend` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`present`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`present` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` INT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`client_has_friend`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`client_has_friend` (
  `client_id` INT NOT NULL,
  `friend_id` INT NOT NULL,
  `is_good_present` TINYINT(1) NULL,
  `present_id` INT NOT NULL,
  INDEX `fk_client_has_friend_friend1_idx` (`friend_id` ASC),
  INDEX `fk_client_has_friend_client1_idx` (`client_id` ASC),
  INDEX `fk_client_has_friend_present1_idx` (`present_id` ASC),
  CONSTRAINT `fk_client_has_friend_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `mydb`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_has_friend_friend1`
    FOREIGN KEY (`friend_id`)
    REFERENCES `mydb`.`friend` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_has_friend_present1`
    FOREIGN KEY (`present_id`)
    REFERENCES `mydb`.`present` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
