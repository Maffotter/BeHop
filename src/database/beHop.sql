
-- MySQL Script generated by MySQL Workbench
-- Mon Jan  6 16:18:15 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BeHop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BeHop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BeHop` DEFAULT CHARACTER SET utf8 ;
USE `BeHop` ;

-- -----------------------------------------------------
-- Table `BeHop`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BeHop`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `city` VARCHAR(50) NOT NULL,
  `street` VARCHAR(100) NOT NULL,
  `number` VARCHAR(10) NOT NULL,
  `zip` VARCHAR(5) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `BeHop`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BeHop`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `email` VARCHAR(70) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `firstName` VARCHAR(50) NOT NULL,
  `lastName` VARCHAR(70) NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_user_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `BeHop`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE UNIQUE INDEX `email_UNIQUE` ON `BeHop`.`user` (`email` ASC);

CREATE INDEX `fk_user_address_idx` ON `BeHop`.`user` (`address_id` ASC);


-- -----------------------------------------------------
-- Table `BeHop`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BeHop`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_order_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `BeHop`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_order_user1_idx` ON `BeHop`.`order` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `BeHop`.`shoppingCart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BeHop`.`shoppingCart` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `totalAmount` DECIMAL(7,2) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_shoppingCart_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `BeHop`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_shoppingCart_user1_idx` ON `BeHop`.`shoppingCart` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `BeHop`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BeHop`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(7,2) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `BeHop`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BeHop`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `BeHop`.`shoppingCart_has_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BeHop`.`shoppingCart_has_product` (
  `shoppingCart_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`shoppingCart_id`, `product_id`),
  CONSTRAINT `fk_shoppingCart_has_product_shoppingCart1`
    FOREIGN KEY (`shoppingCart_id`)
    REFERENCES `BeHop`.`shoppingCart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shoppingCart_has_product_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `BeHop`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_shoppingCart_has_product_product1_idx` ON `BeHop`.`shoppingCart_has_product` (`product_id` ASC);

CREATE INDEX `fk_shoppingCart_has_product_shoppingCart1_idx` ON `BeHop`.`shoppingCart_has_product` (`shoppingCart_id` ASC);


-- -----------------------------------------------------
-- Table `BeHop`.`product_has_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BeHop`.`product_has_category` (
  `product_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  CONSTRAINT `fk_product_has_category_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `BeHop`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `BeHop`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_product_has_category_product1_idx` ON `BeHop`.`product_has_category` (`product_id` ASC);

CREATE INDEX `fk_product_has_category_category1_idx` ON `BeHop`.`product_has_category` (`category_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
